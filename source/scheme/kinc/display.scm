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
   (kinc_display_mode_t kinc_display_current_mode (int))
                   (int kinc_display_count_available_modes (int))
   (kinc_display_mode_t kinc_display_available_mode (int int))

   (in-C "

static int kinc_display_mode_t_s7tag = 0;

static s7_pointer display_mode__free(s7_scheme *sc, s7_pointer obj) {
    free(s7_c_object_value(obj));
    return(NULL);
}

static s7_pointer display_mode__is_equal(s7_scheme *sc, s7_pointer args) {
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

static s7_pointer display_mode__field_by_kw(s7_scheme *sc, kinc_display_mode_t *kt, s7_pointer kw) {
    if(s7_make_keyword(sc, \"x\") == kw)
        return s7_make_integer(sc, kt->x);
    if(s7_make_keyword(sc, \"y\") == kw)
        return s7_make_integer(sc, kt->y);
    if(s7_make_keyword(sc, \"width\") == kw)
        return s7_make_integer(sc, kt->width);
    if(s7_make_keyword(sc, \"height\") == kw)
        return s7_make_integer(sc, kt->height);
    if(s7_make_keyword(sc, \"pixels_per_inch\") == kw)
        return s7_make_integer(sc, kt->pixels_per_inch);
    if(s7_make_keyword(sc, \"frequency\") == kw)
        return s7_make_integer(sc, kt->frequency);
    if(s7_make_keyword(sc, \"bits_per_pixel\") == kw)
        return s7_make_integer(sc, kt->bits_per_pixel);

    return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-ref\", 2, kw,
        \"one of :x, :y, :width, :height, :pixels_per_inch, :frequency, :bits_per_pixel\"));
}

static s7_pointer display_mode__set_field_by_kw(s7_scheme *sc, kinc_display_mode_t *kt, s7_pointer kw, s7_pointer val) {
    if (s7_make_keyword(sc, \"x\") == kw) {
        if (!s7_is_integer(val))
            return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-set!\", 3, val, \"an integer\"));
        kt->x = s7_integer(val);
        return val;
    }
    if (s7_make_keyword(sc, \"y\") == kw) {
        if (!s7_is_integer(val))
            return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-set!\", 3, val, \"an integer\"));
        kt->y = s7_integer(val);
        return val;
    }
    if (s7_make_keyword(sc, \"width\") == kw) {
        if (!s7_is_integer(val))
            return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-set!\", 3, val, \"an integer\"));
        kt->width = s7_integer(val);
        return val;
    }
    if (s7_make_keyword(sc, \"height\") == kw) {
        if (!s7_is_integer(val))
            return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-set!\", 3, val, \"an integer\"));
        kt->height = s7_integer(val);
        return val;
    }
    if (s7_make_keyword(sc, \"pixels_per_inch\") == kw) {
        if (!s7_is_integer(val))
            return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-set!\", 3, val, \"an integer\"));
        kt->pixels_per_inch = s7_integer(val);
        return val;
    }
    if (s7_make_keyword(sc, \"frequency\") == kw) {
        if (!s7_is_integer(val))
            return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-set!\", 3, val, \"an integer\"));
        kt->frequency = s7_integer(val);
        return val;
    }
    if (s7_make_keyword(sc, \"bits_per_pixel\") == kw) {
        if (!s7_is_integer(val))
            return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-set!\", 3, val, \"an integer\"));
        kt->bits_per_pixel = s7_integer(val);
        return val;
    }

    return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-set!\", 2, kw,
        \"one of :x, :y, :width, :height, :pixels_per_inch, :frequency, :bits_per_pixel\"));
}

static s7_pointer g_display_mode__ref(s7_scheme *sc, s7_pointer args) {
    #define G_DISPLAY_MODE__REF_HELP \"(kinc_display_mode_t-ref o f) returns field f from object o.\"
    #define G_DISPLAY_MODE__REF_SIG s7_make_signature(sc, 3, s7_make_symbol(sc, \"integer?\"), s7_make_symbol(sc, \"kinc_display_mode_t?\"), s7_make_symbol(sc, \"keyword?\"))

    s7_pointer obj;
    s7_int obj_type;
    kinc_display_mode_t *kt;

    if (s7_list_length(sc, args) != 2)
        return(s7_wrong_number_of_args_error(sc, \"kinc_display_mode_t-ref takes 2 arguments: ~S\", args));

    obj = s7_car(args);
    obj_type = s7_c_object_type(obj);
    if (obj_type != kinc_display_mode_t_s7tag)
        return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-ref\", 1, obj, \"a kinc_display_mode_t\"));
    kt  = (kinc_display_mode_t *)s7_c_object_value(obj);

    if (s7_is_null(sc, s7_cdr(args))) /* this is for an (obj) test */
        return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-ref\", 1, obj, \"missing keyword arg\"));

    s7_pointer arg = s7_cadr(args);
    if (s7_is_keyword(arg))
        return display_mode__field_by_kw(sc, kt, arg);
    else {
        return(s7_wrong_type_arg_error(sc, \"kinc_display_mode_t-ref\",
                                       2, arg, \"a keyword\"));
    }
}

static s7_pointer g_display_mode__set(s7_scheme *sc, s7_pointer args) {
    #define G_DISPLAY_MODE__SET_HELP \"(kinc_display_mode_t-set! o f v) sets field f of object o to value v.\"
    #define G_DISPLAY_MODE__SET_SIG s7_make_signature(sc, 4, s7_make_symbol(sc, \"integer?\"), s7_make_symbol(sc, \"kinc_display_mode_t?\"), s7_make_symbol(sc, \"keyword?\"), s7_make_symbol(sc, \"integer?\"))

    s7_pointer obj, kw;
    s7_int obj_type;
    kinc_display_mode_t *kt;

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

    kt  = (kinc_display_mode_t *)s7_c_object_value(obj);
    return display_mode__set_field_by_kw(sc, kt, kw, s7_caddr(args));
}

// TODO: A display rep
static sds display_mode__display(s7_scheme *sc, void *value) {
    kinc_display_mode_t *kt = (kinc_display_mode_t *)value;
    sds rep = sdscatprintf(sdsempty(), \"#<kinc_display_mode_t %d %d %d %d %d %d %d>\",
        kt->x, kt->y, kt->width, kt->height, kt->pixels_per_inch, kt->frequency, kt->bits_per_pixel);
    return rep;
}

// TODO: A readable rep
static sds display_mode__display_readably(s7_scheme *sc, void *value) {
    kinc_display_mode_t *kt = (kinc_display_mode_t *)value;
    sds rep = sdscatprintf(sdsempty(), \"(kinc_display_mode_t %d %d %d %d %d %d %d)\",
        kt->x, kt->y, kt->width, kt->height, kt->pixels_per_inch, kt->frequency, kt->bits_per_pixel);
    return rep;
}

static s7_pointer display_mode__to_string(s7_scheme *sc, s7_pointer args) {
    s7_pointer obj, choice;
    sds str_rep;

    obj = s7_car(args);
    if (s7_is_pair(s7_cdr(args)))
        choice = s7_cadr(args);
    else choice = s7_t(sc);

    if (choice == s7_make_keyword(sc, \"readable\"))
        str_rep = display_mode__display_readably(sc, s7_c_object_value(obj));
    else str_rep = display_mode__display(sc, s7_c_object_value(obj));

    obj = s7_make_string(sc, str_rep);

    sdsfree(str_rep);
    return(obj);
}

static int configure_kinc_display_mode_t(s7_scheme *sc) {
    kinc_display_mode_t_s7tag = s7_make_c_type(sc, \"<kinc_display_mode_t>\");
    s7_c_type_set_gc_free(sc, kinc_display_mode_t_s7tag, display_mode__free);
  //s7_c_type_set_gc_mark(sc, kinc_display_mode_t_s7tag, display_mode__mark); // nothing to mark
    s7_c_type_set_is_equal(sc, kinc_display_mode_t_s7tag, display_mode__is_equal);
  //s7_c_type_set_is_equivalent(sc, kinc_display_mode_t_s7tag, display_mode__is_equivalent);
    s7_c_type_set_ref(sc, kinc_display_mode_t_s7tag, g_display_mode__ref);
    s7_c_type_set_set(sc, kinc_display_mode_t_s7tag, g_display_mode__set);
  //s7_c_type_set_length(sc, kinc_display_mode_t_s7tag, display_mode__length);
  //s7_c_type_set_copy(sc, kinc_display_mode_t_s7tag, display_mode__copy);
  //s7_c_type_set_fill(sc, kinc_display_mode_t_s7tag, display_mode__fill);
  //s7_c_type_set_reverse(sc, kinc_display_mode_t_s7tag, display_mode__reverse);
  //s7_c_type_set_to_list(sc, kinc_display_mode_t_s7tag, display_mode__to_list);
    s7_c_type_set_to_string(sc, kinc_display_mode_t_s7tag, display_mode__to_string);
    s7_define_typed_function(sc, \"kinc_display_mode_t-ref\", g_display_mode__ref, 2, 0, false, G_DISPLAY_MODE__REF_HELP, G_DISPLAY_MODE__REF_SIG);
    s7_c_type_set_getter(sc, kinc_display_mode_t_s7tag, s7_name_to_value(sc, \"kinc_display_mode_t-ref\"));
    s7_define_typed_function(sc, \"kinc_display_mode_t-set!\", g_display_mode__set, 3, 0, false, G_DISPLAY_MODE__SET_HELP, G_DISPLAY_MODE__SET_SIG);
    s7_c_type_set_setter(sc, kinc_display_mode_t_s7tag, s7_name_to_value(sc, \"kinc_display_mode_t-set!\"));

    // make-kinc_display_mode_t
    // kinc_display_mode_t
    // kinc_display_mode_t?
}

")
   ;(C-function ...)

   (C-init "configure_kinc_display_mode_t(sc);")
  )
 "" '("sds.h" "kinc/display.h") "-Isource/lib/sds/" "-lKinc" "kinc_display_s7")

#t
