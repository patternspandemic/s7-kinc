;;; TODO: display.scm
;;;
;;; kinc/display.h

(require 'cload.scm)
(provide 'kinc/display)


(c-define
 '(               (void kinc_display_init (void))
                   (int kinc_primary_display (void))
                   (int kinc_count_displays (void))
                  (bool kinc_display_available (int))
                 (char* kinc_display_name (int))
   (kinc_display_mode_t kinc_display_current_mode (int)) ; TODO: Move to In-C / C-function to capture return to scheme
                   (int kinc_display_count_available_modes (int))
   (kinc_display_mode_t kinc_display_available_mode (int int)) ; TODO: Move to In-C / C-function to capture return to scheme)

   (in-C "

static int kinc_display_mode_t_s7tag = 0;

static s7_pointer kinc_display_mode_t__free(s7_scheme *sc, s7_pointer obj) {
    free(s7_c_object_value(obj));
    return(NULL);
}

static s7_pointer kinc_display_mode_t__is_equal(s7_scheme *sc, s7_pointer args) {
    s7_pointer p1, p2;
    kinc_display_mode_t *a, *b;
    p1 = s7_car(args);
    p2 = s7_cadr(args);
    if (p1 == p2)
        return(s7_t(sc));
    if ((!s7_is_c_object(p2)) ||
        (s7_c_object_type(p2) != kinc_display_mode_t_s7tag))
        return(s7_f(sc));
    a = (kinc_display_mode_t *)s7_c_object_value(p1);
    b = (kinc_display_mode_t *)s7_c_object_value(p2);
    return(s7_make_boolean(sc, (a->x == b->x) &&
                               (a->y == b->y) &&
                               (a->width == b->width) &&
                               (a->height == b->height) &&
                               (a->pixels_per_inch == b->pixels_per_inch) &&
                               (a->frequency == b->frequency) &&
                               (a->bits_per_pixel == b->bits_per_pixel)));
}

static s7_pointer kinc_display_mode_t__field_by_kw(s7_scheme *sc, kinc_display_mode_t *ko, s7_pointer kw) {
    if(s7_make_keyword(sc, \"x\") == kw)
        return s7_make_integer(sc, ko->x);
    if(s7_make_keyword(sc, \"y\") == kw)
        return s7_make_integer(sc, ko->y);
    if(s7_make_keyword(sc, \"width\") == kw)
        return s7_make_integer(sc, ko->width);
    if(s7_make_keyword(sc, \"height\") == kw)
        return s7_make_integer(sc, ko->height);
    if(s7_make_keyword(sc, \"pixels_per_inch\") == kw)
        return s7_make_integer(sc, ko->pixels_per_inch);
    if(s7_make_keyword(sc, \"frequency\") == kw)
        return s7_make_integer(sc, ko->frequency);
    if(s7_make_keyword(sc, \"bits_per_pixel\") == kw)
        return s7_make_integer(sc, ko->bits_per_pixel);

    return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-ref\", 2, kw,
        \"one of :x, :y, :width, :height, :pixels_per_inch, :frequency, :bits_per_pixel\"));
}

static s7_pointer kinc_display_mode_t__set_field_by_kw(s7_scheme *sc, kinc_display_mode_t *ko, s7_pointer kw, s7_pointer val) {
    if (s7_make_keyword(sc, \"x\") == kw) {
        if (!s7_is_integer(val))
            return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-set!\", 3, val, \"an integer\"));
        ko->x = s7_integer(val);
        return val;
    }
    if (s7_make_keyword(sc, \"y\") == kw) {
        if (!s7_is_integer(val))
            return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-set!\", 3, val, \"an integer\"));
        ko->y = s7_integer(val);
        return val;
    }
    if (s7_make_keyword(sc, \"width\") == kw) {
        if (!s7_is_integer(val))
            return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-set!\", 3, val, \"an integer\"));
        ko->width = s7_integer(val);
        return val;
    }
    if (s7_make_keyword(sc, \"height\") == kw) {
        if (!s7_is_integer(val))
            return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-set!\", 3, val, \"an integer\"));
        ko->height = s7_integer(val);
        return val;
    }
    if (s7_make_keyword(sc, \"pixels_per_inch\") == kw) {
        if (!s7_is_integer(val))
            return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-set!\", 3, val, \"an integer\"));
        ko->pixels_per_inch = s7_integer(val);
        return val;
    }
    if (s7_make_keyword(sc, \"frequency\") == kw) {
        if (!s7_is_integer(val))
            return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-set!\", 3, val, \"an integer\"));
        ko->frequency = s7_integer(val);
        return val;
    }
    if (s7_make_keyword(sc, \"bits_per_pixel\") == kw) {
        if (!s7_is_integer(val))
            return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-set!\", 3, val, \"an integer\"));
        ko->bits_per_pixel = s7_integer(val);
        return val;
    }

    return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-set!\", 2, kw,
        \"one of :x, :y, :width, :height, :pixels_per_inch, :frequency, :bits_per_pixel\"));
}

static s7_pointer g_kinc_display_mode_t__ref(s7_scheme *sc, s7_pointer args) {
    #define G_KINC_DISPLAY_MODE_T__REF_HELP \"(kinc_display_mode_t-ref o f) returns field f from object o.\"
    #define G_KINC_DISPLAY_MODE_T__REF_SIG s7_make_signature(sc, 3, s7_make_symbol(sc, \"integer?\"), s7_make_symbol(sc, \"kinc_display_mode_t?\"), s7_make_symbol(sc, \"keyword?\"))

    s7_pointer obj;
    s7_int obj_type;
    kinc_display_mode_t *ko;

    if (s7_list_length(sc, args) != 2)
        return(s7_wrong_number_of_args_error(sc, \"kinc_display_mode_t-ref takes 2 arguments: ~S\", args));

    obj = s7_car(args);
    obj_type = s7_c_object_type(obj);
    if (obj_type != kinc_display_mode_t_s7tag)
        return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-ref\", 1, obj, \"a kinc_display_mode_t\"));
    ko = (kinc_display_mode_t *)s7_c_object_value(obj);

    if (s7_is_null(sc, s7_cdr(args))) /* this is for an (obj) test */
        return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-ref\", 1, obj, \"missing keyword arg\"));

    s7_pointer arg = s7_cadr(args);
    if (s7_is_keyword(arg))
        return kinc_display_mode_t__field_by_kw(sc, ko, arg);
    else {
        return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-ref\",
                                       2, arg, \"a keyword\"));
    }
}

static s7_pointer g_kinc_display_mode_t__set(s7_scheme *sc, s7_pointer args) {
    #define G_KINC_DISPLAY_MODE_T__SET_HELP \"(kinc_display_mode_t-set! o f v) sets field f of object o to value v.\"
    #define G_KINC_DISPLAY_MODE_T__SET_SIG s7_make_signature(sc, 4, s7_make_symbol(sc, \"integer?\"), s7_make_symbol(sc, \"kinc_display_mode_t?\"), s7_make_symbol(sc, \"keyword?\"), s7_make_symbol(sc, \"integer?\"))

    s7_pointer obj, kw;
    s7_int obj_type;
    kinc_display_mode_t *ko;

    if (s7_list_length(sc, args) != 3)
        return(s7_wrong_number_of_args_error(sc, \"kinc_display_mode_t-set! takes 3 arguments: ~S\", args));

    obj = s7_car(args);
    obj_type = s7_c_object_type(obj);
    if (obj_type != kinc_display_mode_t_s7tag)
        return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-set!\", 1, obj, \"a kinc_display_mode_t\"));

    if (s7_is_immutable(obj))
        return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-set!\", 1, obj, \"a mutable cstruct\"));

    kw = s7_cadr(args);
    if (!s7_is_keyword(kw))
        return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-set!\", 2, kw, \"a keyword\"));

    ko = (kinc_display_mode_t *)s7_c_object_value(obj);
    return kinc_display_mode_t__set_field_by_kw(sc, ko, kw, s7_caddr(args));
}

static sds kinc_display_mode_t__display(s7_scheme *sc, void *value) {
    kinc_display_mode_t *ko = (kinc_display_mode_t *)value;
    sds rep = sdscatprintf(sdsempty(), \"<kinc_display_mode_t\\n    :x %d\\n    :y %d\\n    :width %d\\n    :height %d\\n    :pixels_per_inch %d\\n    :frequency %d\\n    :bits_per_pixel %d\\n>\\n\",
                  ko->x, ko->y, ko->width, ko->height, ko->pixels_per_inch, ko->frequency, ko->bits_per_pixel);
    return rep;
}

static sds kinc_display_mode_t__display_readably(s7_scheme *sc, void *value) {
    kinc_display_mode_t *ko = (kinc_display_mode_t *)value;
    sds rep = sdscatprintf(sdsempty(), \"(:x %d :y %d :width %d :height %d :pixels_per_inch %d :frequency %d :bits_per_pixel %d)\",
                  ko->x, ko->y, ko->width, ko->height, ko->pixels_per_inch, ko->frequency, ko->bits_per_pixel);
    return rep;
}

static s7_pointer kinc_display_mode_t__to_string(s7_scheme *sc, s7_pointer args) {
    s7_pointer obj, choice;
    sds str_rep;

    obj = s7_car(args);
    if (s7_is_pair(s7_cdr(args)))
        choice = s7_cadr(args);
    else choice = s7_t(sc);

    if (choice == s7_make_keyword(sc, \"readable\"))
        str_rep = kinc_display_mode_t__display_readably(sc, s7_c_object_value(obj));
    else str_rep = kinc_display_mode_t__display(sc, s7_c_object_value(obj));

    obj = s7_make_string(sc, str_rep);

    sdsfree(str_rep);
    return(obj);
}

static s7_pointer g_kinc_display_mode_t__is(s7_scheme *sc, s7_pointer args) {
    #define G_KINC_DISPLAY_MODE_T__IS_HELP \"(kinc_display_mode_t? obj) returns #t if obj is a kinc_display_mode_t.\"
    #define G_KINC_DISPLAY_MODE_T__IS_SIG s7_make_signature(sc, 2, s7_make_symbol(sc, \"boolean?\"), s7_t(sc))
    return(s7_make_boolean(sc, s7_c_object_type(s7_car(args)) == kinc_display_mode_t_s7tag));
}

static s7_pointer g_kinc_display_mode_t__make(s7_scheme *sc, s7_pointer args) {
    #define G_KINC_DISPLAY_MODE_T__MAKE_HELP \"(make-kinc_display_mode_t) returns a new kinc_display_mode_t.\"
    #define MAKE_KINC_DISPLAY_MODE_T__ARGLIST \"(x 0) (y 0) (width 0) (height 0) (pixels_per_inch 0) (frequency 0) (bits_per_pixel 0)\"
    kinc_display_mode_t *ko = (kinc_display_mode_t *)calloc(1, sizeof(kinc_display_mode_t));

    s7_pointer arg;

    arg = s7_list_ref(sc, args, 0); // x
    if(!s7_is_integer(arg))
        return(s7_wrong_type_arg_error(sc, \"make-kinc_display_mode_t\", 0, arg, \"an integer\"));
    ko->x = s7_integer(arg);

    arg = s7_list_ref(sc, args, 1); // y
    if(!s7_is_integer(arg))
        return(s7_wrong_type_arg_error(sc, \"make-kinc_display_mode_t\", 1, arg, \"an integer\"));
    ko->y = s7_integer(arg);

    arg = s7_list_ref(sc, args, 2); // width
    if(!s7_is_integer(arg))
        return(s7_wrong_type_arg_error(sc, \"make-kinc_display_mode_t\", 2, arg, \"an integer\"));
    ko->width = s7_integer(arg);

    arg = s7_list_ref(sc, args, 3); // height
    if(!s7_is_integer(arg))
        return(s7_wrong_type_arg_error(sc, \"make-kinc_display_mode_t\", 3, arg, \"an integer\"));
    ko->height = s7_integer(arg);

    arg = s7_list_ref(sc, args, 4); // pixels_per_inch
    if(!s7_is_integer(arg))
        return(s7_wrong_type_arg_error(sc, \"make-kinc_display_mode_t\", 4, arg, \"an integer\"));
    ko->pixels_per_inch = s7_integer(arg);

    arg = s7_list_ref(sc, args, 5); // frequency
    if(!s7_is_integer(arg))
        return(s7_wrong_type_arg_error(sc, \"make-kinc_display_mode_t\", 5, arg, \"an integer\"));
    ko->frequency = s7_integer(arg);

    arg = s7_list_ref(sc, args, 6); // bits_per_pixel
    if(!s7_is_integer(arg))
        return(s7_wrong_type_arg_error(sc, \"make-kinc_display_mode_t\", 6, arg, \"an integer\"));
    ko->bits_per_pixel = s7_integer(arg);

    s7_pointer s7_ko = s7_make_c_object(sc, kinc_display_mode_t_s7tag, (void *)ko);
    return(s7_ko);
}

static void configure_kinc_display_mode_t(s7_scheme *sc) {
    kinc_display_mode_t_s7tag = s7_make_c_type(sc, \"<kinc_display_mode_t>\");
    s7_define_safe_function_star(sc, \"make-kinc_display_mode_t\", g_kinc_display_mode_t__make, MAKE_KINC_DISPLAY_MODE_T__ARGLIST, G_KINC_DISPLAY_MODE_T__MAKE_HELP);
    s7_define_typed_function(sc,     \"kinc_display_mode_t?\",     g_kinc_display_mode_t__is, 1, 0, false, G_KINC_DISPLAY_MODE_T__IS_HELP, G_KINC_DISPLAY_MODE_T__IS_SIG);
    s7_define_typed_function(sc,     \"kinc_display_mode_t-ref\",  g_kinc_display_mode_t__ref, 2, 0, false, G_KINC_DISPLAY_MODE_T__REF_HELP, G_KINC_DISPLAY_MODE_T__REF_SIG);
    s7_define_typed_function(sc,     \"kinc_display_mode_t-set!\", g_kinc_display_mode_t__set, 3, 0, false, G_KINC_DISPLAY_MODE_T__SET_HELP, G_KINC_DISPLAY_MODE_T__SET_SIG);
    s7_c_type_set_gc_free(sc,       kinc_display_mode_t_s7tag, kinc_display_mode_t__free);
  //s7_c_type_set_gc_mark(sc,       kinc_display_mode_t_s7tag, kinc_display_mode_t__mark); // nothing to mark
    s7_c_type_set_is_equal(sc,      kinc_display_mode_t_s7tag, kinc_display_mode_t__is_equal);
  //s7_c_type_set_is_equivalent(sc, kinc_display_mode_t_s7tag, kinc_display_mode_t__is_equivalent);
    s7_c_type_set_ref(sc,           kinc_display_mode_t_s7tag, g_kinc_display_mode_t__ref);
    s7_c_type_set_set(sc,           kinc_display_mode_t_s7tag, g_kinc_display_mode_t__set);
  //s7_c_type_set_length(sc,        kinc_display_mode_t_s7tag, kinc_display_mode_t__length);
  //s7_c_type_set_copy(sc,          kinc_display_mode_t_s7tag, kinc_display_mode_t__copy);
  //s7_c_type_set_fill(sc,          kinc_display_mode_t_s7tag, kinc_display_mode_t__fill);
  //s7_c_type_set_reverse(sc,       kinc_display_mode_t_s7tag, kinc_display_mode_t__reverse);
  //s7_c_type_set_to_list(sc,       kinc_display_mode_t_s7tag, kinc_display_mode_t__to_list);
    s7_c_type_set_to_string(sc,     kinc_display_mode_t_s7tag, kinc_display_mode_t__to_string);
    s7_c_type_set_getter(sc,        kinc_display_mode_t_s7tag, s7_name_to_value(sc, \"kinc_display_mode_t-ref\"));
    s7_c_type_set_setter(sc,        kinc_display_mode_t_s7tag, s7_name_to_value(sc, \"kinc_display_mode_t-set!\"));

    // kinc_display_mode_t, from keywords or symbols or an environment. Define outside c-define?
}

")
   ;(C-function ...)

   (C-init "configure_kinc_display_mode_t(sc);")
  )
 "" '("sds.h" "kinc/display.h") "-Isource/lib/sds/" "-lKinc" "kinc_display_s7")

#t
