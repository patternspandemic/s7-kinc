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

             ; Declarations and functions
             (type-tag-decl (string-append "static int " type-tag-str " = 0;\n"))

             ; TODO: etc.

             (type-config-func (string-append "static void configure_" type-str "(s7_scheme *sc) {\n"
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
