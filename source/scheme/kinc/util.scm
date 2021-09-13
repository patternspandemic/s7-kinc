;;; util.scm
;;;
;;; Helpers for binding kinc items with cload.

(define *s7kinc-dev-shell-detected*
  (string=? "1" (getenv "S7KINC_DEV_SHELL")))

(define (slashed-symbol->underscored-string sym)
  (let loop ((str (symbol->string sym)))
    (let ((pos (char-position #\/ str)))
      (if pos
          (begin (string-set! str pos #\_) (loop str))
          str))))


;; NOTE: C --> s7 --> C
;;       How to get specific preceision out of mp types?
;; ====================================
;; int,(enum kinc_*_t) -> s7_make_integer     -> s7_integer     -> int64_t
;; unsigned,uint64_t   -> s7_make_big_integer -> s7_big_integer -> mpz_t*

;; float,double -> s7_make_real     -> s7_real     -> double
;;              -> s7_make_big_real -> s7_big_real -> mpfr_t*

;; bool  -> s7_make_boolean -> s7_boolean -> bool

;; char* -> s7_make_string -> s7_string -> char*
;;       -> s7_make_string_wrapper ->
;;       -> s7_make_permanent_string ->

;; (struct kinc_*_t) -> s7_make_c_object              -> s7_c_object_value        -> void*
;; void*    -> s7_make_c_pointer[_with_type] -> s7_c_pointer[_with_type] -> void*
(define (field-type->make-func field-type)
  (case* field-type
         ; TODO: Handle pointer versions ? int16_t*,  uint8_t*
         ; TODO: Handle arrays as pointers ? Maybe Treat them as applicable objects! Also arrays of pointers.. How s7 vectors fit in?
         ((int (enum #<>) int16_t uint8_t uint16_t uint32_t) 's7_make_integer)
         ((float double) 's7_make_real)
         ((bool) 's7_make_boolean)
         ((char*) 's7_make_string)
         ((unsigned kinc_ticks_t uint64_t) 's7_make_big_integer) ; TODO Confirm & add others
        ;((...) 's7_make_big_real) ; TODO: Confirm & add others
         (((struct #<>)) 's7_make_c_object) ; TODO: Will also need to lookup the s7tag at runtime (see system)
         ((void*) 's7_make_c_pointer)
         ; TODO: Function pointers possible?
         (else 'make_function_not_supported))) ; TODO: Error instead? (rather than in C)

;; FIXME
;; (define (field-type->specifier field-type)
;;   (case (symbol->string field-type)
;;     (("int") "%d")
;;     (("bool") "%d")
;;     (("float") "%f")
;;     (("char*") "%s")
;;     (("wchar_t*") "%s")
;;     (("kinc_..._t*") "????")
;;     (("kinc_..._t") "????")
;;     ; uint8_t *
;;     ; void *
;;     ; unsigned
;;     ; arrays?
;;     (else )
;;     )
;;   )

;; (define-expansion (maybe-output-name name)
;;   (if *s7kinc-dev-shell-detected*
;;       (values) ; no output-name
;;       (let ((output-name-string (string-append
;;                                  "kinc_"
;;                                  (slashed-symbol->underscored-string name)
;;                                  "_s7")))
;;         output-name-string)))

(define-expansion* (bind-kinc lib-sym (prefix "") (headers ()) (cflags "") (ldflags "") (ctypes ()) (c-info ()))
  (let* ((lib-str (symbol->string lib-sym))
         (lib-hdr (string-append "kinc/" lib-str ".h"))
         (lib-headers (append (list "sds/sds.h" lib-hdr) headers))
         (lib-include-path (if (provided? 'kinc.scm) "-Isource/lib/" "-I../../lib/"))
         (lib-cflags (string-append lib-include-path " " cflags))
         (lib-ldflags (string-append "-lKinc " ldflags))
         (lib-output-name (string-append "kinc_" (slashed-symbol->underscored-string lib-sym) "_s7"))
         (ctypes-c '())
         (ctypes-init '()))

    ; Generate the definitions and initialization needed for a c-type.
    ; TODO: Might an open-output-string save some memory?
    (define (expand-bindings-for-c-type type-sym type-fields)
      (let* (; Some helper values
             (type-str (symbol->string type-sym))
             (type-str-cap (string-upcase type-str))
             (type-tag-str (format #f "~A_s7tag" type-sym))
             (type-names (map (lambda (p) (cadr p)) type-fields))

             ; Declarations and functions
             (type-tag-decl (string-append "static int " type-tag-str " = 0;\n"))

             (type-free-func
              (string-append "static s7_pointer " type-str "__free(s7_scheme *sc, s7_pointer obj) {\n"
                "    free(s7_c_object_value(obj));\n"
                "    return(NULL);\n"
                "}\n"))

             ;;;(type-mark-func (string-append)) ; TODO?

             (type-is-equal-func
              (string-append "static s7_pointer " type-str "__is_equal(s7_scheme *sc, s7_pointer args) {\n"
                "    s7_pointer p1, p2;\n"
                "    " type-str " *a, *b;\n"
                "    p1 = s7_car(args);\n"
                "    p2 = s7_cadr(args);\n"
                "    if (p1 == p2)\n"
                "        return(s7_t(sc));\n"
                "    if ((!s7_is_c_object(p2)) ||\n"
                "        (s7_c_object_type(p2) != " type-tag-str "))\n"
                "        return(s7_f(sc));\n"
                "    a = (" type-str " *)s7_c_object_value(p1);\n"
                "    b = (" type-str " *)s7_c_object_value(p2);\n"
                "    return(s7_make_boolean(sc, " (format #f "~{(a->~A == b->~A)~^ &&~%~32T~}));\n" (map (lambda (n) (values n n)) type-names))
                "}\n"))

             ;;;(type-equivalent-func (string-append)) ; TODO?

             ; FIXME: Work in progress.
             ;        - Make work with struct types, require s7tag lookup (see system)
             (type-field-by-kw-func
              (string-append "static s7_pointer " type-str "__field_by_kw(s7_scheme *sc, " type-str " *ko, s7_pointer kw) {\n"
             ;; (format #f "~{~4Tif(s7_make_keyword(sc, \"~A\") == kw)~%~8Treturn s7_make_integer(sc, ko->~A);~^~%~}\n\n" (map (lambda (n) (values n n)) type-names))

                (format #f "~{~4Tif(s7_make_keyword(sc, \"~A\") == kw)~%~8Treturn ~A(sc, ko->~A);~^~%~}\n\n"
                        (map (lambda (tf)
                               (let ((name (cadr tf))
                                     (make-func (field-type->make-func (car tf))))
                                 (values name make-func name)))
                             type-fields))

                "    return(s7_wrong_type_arg_error(sc, \"" type-str "-ref\", 2, kw,\n"
                "        \"one of " (format #f "~{:~A~^, ~}" type-names) "\"));\n"
                "}\n"))

             ; TODO:
             (type-set-field-by-kw-func
              (string-append "static s7_pointer " type-str "__set_field_by_kw(s7_scheme *sc, " type-str " *ko, s7_pointer kw, s7_pointer val) {\n"

                "    if (s7_make_keyword(sc, \"x\") == kw) {\n"
                "        if (!s7_is_integer(val))\n"
                "            return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-set!\", 3, val, \"an integer\"));\n"
                "        ko->x = s7_integer(val);\n"
                "        return val;\n"
                "    }\n"



                "    if (s7_make_keyword(sc, \"y\") == kw) {\n"
                "        if (!s7_is_integer(val))\n"
                "            return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-set!\", 3, val, \"an integer\"));\n"
                "        ko->y = s7_integer(val);\n"
                "        return val;\n"
                "    }\n"
                "    if (s7_make_keyword(sc, \"width\") == kw) {\n"
                "        if (!s7_is_integer(val))\n"
                "            return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-set!\", 3, val, \"an integer\"));\n"
                "        ko->width = s7_integer(val);\n"
                "        return val;\n"
                "    }\n"
                "    if (s7_make_keyword(sc, \"height\") == kw) {\n"
                "        if (!s7_is_integer(val))\n"
                "            return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-set!\", 3, val, \"an integer\"));\n"
                "        ko->height = s7_integer(val);\n"
                "        return val;\n"
                "    }\n"
                "    if (s7_make_keyword(sc, \"pixels_per_inch\") == kw) {\n"
                "        if (!s7_is_integer(val))\n"
                "            return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-set!\", 3, val, \"an integer\"));\n"
                "        ko->pixels_per_inch = s7_integer(val);\n"
                "        return val;\n"
                "    }\n"
                "    if (s7_make_keyword(sc, \"frequency\") == kw) {\n"
                "        if (!s7_is_integer(val))\n"
                "            return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-set!\", 3, val, \"an integer\"));\n"
                "        ko->frequency = s7_integer(val);\n"
                "        return val;\n"
                "    }\n"
                "    if (s7_make_keyword(sc, \"bits_per_pixel\") == kw) {\n"
                "        if (!s7_is_integer(val))\n"
                "            return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-set!\", 3, val, \"an integer\"));\n"
                "        ko->bits_per_pixel = s7_integer(val);\n"
                "        return val;\n"
                "    }\n"

                "\n"
                "    return(s7_wrong_type_arg_error(sc, \"" type-str "-set!\", 2, kw,\n"
                "        \"one of " (format #f "~{:~A~^, ~}" type-names) "\"));\n"
                "}\n"))

             (type-ref-func
              (string-append "static s7_pointer g_" type-str "__ref(s7_scheme *sc, s7_pointer args) {\n"
                "    #define G_" type-str-cap "__REF_HELP \"(" type-str "-ref o f) returns field f from object o.\"\n"
                "    #define G_" type-str-cap "__REF_SIG s7_make_signature(sc, 3, s7_t(sc), s7_make_symbol(sc, \"" type-str "?\"), s7_make_symbol(sc, \"keyword?\"))\n"
                "\n"
                "    s7_pointer obj;\n"
                "    s7_int obj_type;\n"
                "    " type-str " *ko;\n"
                "\n"
                "    if (s7_list_length(sc, args) != 2)\n"
                "        return(s7_wrong_number_of_args_error(sc, \"" type-str "-ref takes 2 arguments: ~S\", args));\n"
                "\n"
                "    obj = s7_car(args);\n"
                "    obj_type = s7_c_object_type(obj);\n"
                "    if (obj_type != " type-tag-str ")\n"
                "        return(s7_wrong_type_arg_error(sc, \"" type-str "-ref\", 1, obj, \"a " type-str "\"));\n"
                "    ko = (" type-str " *)s7_c_object_value(obj);\n"
                "\n"
                "    if (s7_is_null(sc, s7_cdr(args))) /* this is for an (obj) test */\n"
                "        return(s7_wrong_type_arg_error(sc, \"" type-str "-ref\", 1, obj, \"missing keyword arg\"));\n"
                "\n"
                "    s7_pointer arg = s7_cadr(args);\n"
                "    if (s7_is_keyword(arg))\n"
                "        return " type-str "__field_by_kw(sc, ko, arg);\n"
                "    else {\n"
                "        return(s7_wrong_type_arg_error(sc, \"" type-str "-ref\",\n"
                "                                       2, arg, \"a keyword\"));\n"
                "    }\n"
                "}\n"))

             (type-set-func
              (string-append "static s7_pointer g_" type-str "__set(s7_scheme *sc, s7_pointer args) {\n"
                "    #define G_" type-str-cap "__SET_HELP \"(" type-str "-set! o f v) sets field f of object o to value v.\"\n"
                "    #define G_" type-str-cap "__SET_SIG s7_make_signature(sc, 4, s7_t(sc), s7_make_symbol(sc, \"" type-str "?\"), s7_make_symbol(sc, \"keyword?\"), s7_t(sc))\n"
                "\n"
                "    s7_pointer obj, kw;\n"
                "    s7_int obj_type;\n"
                "    " type-str " *ko;\n"
                "\n"
                "    if (s7_list_length(sc, args) != 3)\n"
                "        return(s7_wrong_number_of_args_error(sc, \"" type-str "-set! takes 3 arguments: ~S\", args));\n"
                "\n"
                "    obj = s7_car(args);\n"
                "    obj_type = s7_c_object_type(obj);\n"
                "\n"
                "    if (s7_is_immutable(obj))\n"
                "        return(s7_wrong_type_arg_error(sc, \"" type-str "-set!\", 1, obj, \"a mutable " type-str "\"));\n"
                "\n"
                "    if (obj_type != " type-tag-str ")\n"
                "        return(s7_wrong_type_arg_error(sc, \"" type-str "-set!\", 1, obj, \"a " type-str "\"));\n"
                "\n"
                "    kw = s7_cadr(args);\n"
                "    if (!s7_is_keyword(kw))\n"
                "        return(s7_wrong_type_arg_error(sc, \"" type-str "-set!\", 2, kw, \"a keyword\"));\n"
                "\n"
                "    ko = (" type-str " *)s7_c_object_value(obj);\n"
                "    return " type-str "__set_field_by_kw(sc, ko, kw, s7_caddr(args));\n"
                "}\n"))

             ;;;(type-length-func (string-append)) ; TODO?
             ;;;(type-copy-func (string-append)) ; TODO?
             ;;;(type-fill-func (string-append)) ; TODO?
             ;;;(type-reverse-func (string-append)) ; TODO?
             ;;;(type-to-list-func (string-append)) ; TODO?

             (type-display-func ; TODO: Use a better display format, handle fields at depth.
              (string-append "static sds " type-str "__display(s7_scheme *sc, void *value) {\n"
                "    sds rep = sdsnew(\"[" type-str "]\");\n"
                "    return rep;\n"
                "}\n"))
              ;; (string-append "static sds " type-str "__display(s7_scheme *sc, void *value) {\n"
              ;;   "    " type-str " *ko = (" type-str " *)value;\n"
              ;;   "    sds rep = sdscatprintf(sdsempty(), \"<" type-str ">\\n"
              ;;                    (format #f "~{:~A ~A\\n~}" (map (lambda(tf) (values (cadr tf) (field-type->specifier (car tf)))) type-fields)) "\",\n"
              ;;                    (format #f "~20T~{ko->~A~^, ~}" type-names) ");\n"
              ;;   "    return rep;\n"
              ;;   "}\n")) ; FIXME

             (type-display-readably-func ; TODO: Use a better display_readably format, handle fields at depth.
              (string-append "static sds " type-str "__display_readably(s7_scheme *sc, void *value) {\n"
                "    sds rep = sdsnew(\"(" type-str ")\");\n"
                "    return rep;\n"
                "}\n"))
              ;; (string-append "static sds " type-str "__display_readably(s7_scheme *sc, void *value) {\n"
              ;;   "    " type-str " *ko = (" type-str " *)value;\n"
              ;;   "    sds rep = sdscatprintf(sdsempty(), \"(:x %d :y %d :width %d :height %d :pixels_per_inch %d :frequency %d :bits_per_pixel %d)\",\n"
              ;;   "                  ko->x, ko->y, ko->width, ko->height, ko->pixels_per_inch, ko->frequency, ko->bits_per_pixel);\n"
              ;;   "    return rep;\n"
              ;;   "}\n")) ; FIXME

             (type-to-string-func
              (string-append "static s7_pointer " type-str "__to_string(s7_scheme *sc, s7_pointer args) {\n"
                "    s7_pointer obj, choice;\n"
                "    sds str_rep;\n"
                "\n"
                "    obj = s7_car(args);\n"
                "    if (s7_is_pair(s7_cdr(args)))\n"
                "        choice = s7_cadr(args);\n"
                "    else choice = s7_t(sc);\n"
                "\n"
                "    if (choice == s7_make_keyword(sc, \"readable\"))\n"
                "        str_rep = " type-str "__display_readably(sc, s7_c_object_value(obj));\n"
                "    else str_rep = " type-str "__display(sc, s7_c_object_value(obj));\n"
                "\n"
                "    obj = s7_make_string(sc, str_rep);\n"
                "\n"
                "    sdsfree(str_rep);\n"
                "    return(obj);\n"
                "}\n"))

             (type-is-func
              (string-append "static s7_pointer g_" type-str "__is(s7_scheme *sc, s7_pointer args) {\n"
                "    #define G_" type-str-cap "__IS_HELP \"(" type-str "? obj) returns #t if obj is a " type-str ".\"\n"
                "    #define G_" type-str-cap "__IS_SIG s7_make_signature(sc, 2, s7_make_symbol(sc, \"boolean?\"), s7_t(sc))\n"
                "    return(s7_make_boolean(sc, s7_c_object_type(s7_car(args)) == " type-tag-str "));\n"
                "}\n"))

             (type-make-func (string-append)) ; TODO

             (type-config-func
              (string-append "static void configure_" type-str "(s7_scheme *sc) {\n"
                "    " type-tag-str " = s7_make_c_type(sc, \"<" type-str ">\");\n"
                "    s7_define_safe_function_star(sc, \"make-" type-str "\", g_" type-str "__make, MAKE_" type-str-cap "__ARGLIST, G_" type-str-cap "__MAKE_HELP);\n"
                "    s7_define_typed_function(sc,     \"" type-str "?\",     g_" type-str "__is, 1, 0, false, G_" type-str-cap "__IS_HELP, G_" type-str-cap "__IS_SIG);\n"
                "    s7_define_typed_function(sc,     \"" type-str "-ref\",  g_" type-str "__ref, 2, 0, false, G_" type-str-cap "__REF_HELP, G_" type-str-cap "__REF_SIG);\n"
                "    s7_define_typed_function(sc,     \"" type-str "-set!\", g_" type-str "__set, 3, 0, false, G_" type-str-cap "__SET_HELP, G_" type-str-cap "__SET_SIG);\n"
                "    s7_c_type_set_gc_free(sc,       " type-tag-str ", " type-str "__free);\n"
                "  //s7_c_type_set_gc_mark(sc,       " type-tag-str ", " type-str "__mark); // nothing to mark\n"
                "    s7_c_type_set_is_equal(sc,      " type-tag-str ", " type-str "__is_equal);\n"
                "  //s7_c_type_set_is_equivalent(sc, " type-tag-str ", " type-str "__is_equivalent);\n"
                "    s7_c_type_set_ref(sc,           " type-tag-str ", g_" type-str "__ref);\n"
                "    s7_c_type_set_set(sc,           " type-tag-str ", g_" type-str "__set);\n"
                "  //s7_c_type_set_length(sc,        " type-tag-str ", " type-str "__length);\n"
                "  //s7_c_type_set_copy(sc,          " type-tag-str ", " type-str "__copy);\n"
                "  //s7_c_type_set_fill(sc,          " type-tag-str ", " type-str "__fill);\n"
                "  //s7_c_type_set_reverse(sc,       " type-tag-str ", " type-str "__reverse);\n"
                "  //s7_c_type_set_to_list(sc,       " type-tag-str ", " type-str "__to_list);\n"
                "    s7_c_type_set_to_string(sc,     " type-tag-str ", " type-str "__to_string);\n"
                "    s7_c_type_set_getter(sc,        " type-tag-str ", s7_name_to_value(sc, \"" type-str "-ref\"));\n"
                "    s7_c_type_set_setter(sc,        " type-tag-str ", s7_name_to_value(sc, \"" type-str "-set!\"));\n"
                "}\n"))

             ; Compile everything together
             (c-code (format #f "~{~A~^~%~}"
                             `(,type-tag-decl
                               ,type-free-func
                               ;;;,type-mark-func
                               ,type-is-equal-func
                               ;;;,type-equivalent-func
                               ,type-field-by-kw-func
                               ,type-set-field-by-kw-func
                               ,type-ref-func
                               ,type-set-func
                               ;;;,type-length-func
                               ;;;,type-copy-func
                               ;;;,type-fill-func
                               ;;;,type-reverse-func
                               ;;;,type-to-list-func
                               ,type-display-func
                               ,type-display-readably-func
                               ,type-to-string-func
                               ,type-is-func
                               ,type-make-func
                               ,type-config-func))))

        ; Prepend the c-code to the ctypes-c list.
        (set! ctypes-c (cons `(in-C ,c-code) ctypes-c))))

    ; Add a call to the c-type's configuration function in the module's init function.
    (define (call-configure-for-c-type type-str)
      (let ((call-str (string-append "configure_" type-str "(sc);")))
        (set! ctypes-init (cons `(C-init ,call-str) ctypes-init))))

    ; Generate the bindings necessary for a single c-type.
    (define (handle-c-type type)
      (let ((type-sym (car type))
            (type-fields (cdr type)))
        (expand-bindings-for-c-type type-sym type-fields)
        (call-configure-for-c-type (symbol->string type-sym))))

    ; Generate code for each of the c-types.
    (for-each (lambda(t) (handle-c-type t)) ctypes)

    ; Finally the expansion:
    `(c-define ',(append ctypes-c c-info ctypes-init) ,prefix ',lib-headers ,lib-cflags ,lib-ldflags ,(if *s7kinc-dev-shell-detected* (values) lib-output-name))))
