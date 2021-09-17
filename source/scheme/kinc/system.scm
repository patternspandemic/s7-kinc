;;; system.scm
;;;
;;; kinc/system.h

(provide 'kinc/system)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc system
    :headers ("kinc/window.h")
    :c-info (
                        (char* kinc_application_name (void))
                         (void kinc_set_application_name (char*))
                          (int kinc_width (void))
                          (int kinc_height (void))
                         (void kinc_load_url (char*))
                        (char* kinc_system_id (void))
                        (char* kinc_language (void))
                         (void kinc_vibrate (int))
                        (float kinc_safe_zone (void))
                         (bool kinc_automatic_safe_zone (void))
                         (void kinc_set_safe_zone (float))
                       (double kinc_frequency (void))
      ;((kinc_ticks_t uint64_t) kinc_timestamp (void)) ; FIXME: Requires use of bignums, as uint64_t wont fit in int64_t. NOTE: Not needed with avilability of kinc_time?
                       (double kinc_time (void))
                         (void kinc_start (void))
                         (void kinc_stop (void))
                         (void kinc_login (void))
                         (bool kinc_waiting_for_login (void))
                         (void kinc_unlock_achievement (int))
                         (void kinc_disallow_user_change (void))
                         (void kinc_allow_user_change (void))
                         (void kinc_set_keep_screen_on (bool))
                         (void kinc_copy_to_clipboard (char*))

      ;; NOTE: Various callbacks from system.h are set in core.c to allow scheme side hooks.

      ;; Functions requiring special C-object conversion
      (in-C "

static s7_pointer g_kinc_init(s7_scheme *sc, s7_pointer args) {
    s7_pointer p, name, width, height, wo, fo;
    s7_int obj_type, wo_s7tag, fo_s7tag;

    if (s7_list_length(sc, args) != 3)
        return(s7_wrong_number_of_args_error(sc, \"kinc_init takes 3 arguments: ~S\", args));

    p = args;
    name = s7_car(p);
    if (!s7_is_string(name))
        return(s7_wrong_type_arg_error(sc, \"kinc_init\", 1, name, \"a string\"));
    p = s7_cdr(p);
    width = s7_car(p);
    if (!s7_is_integer(width))
        return(s7_wrong_type_arg_error(sc, \"kinc_init\", 2, width, \"an integer\"));
    p = s7_cdr(p);
    height = s7_car(p);
    if (!s7_is_integer(height))
        return(s7_wrong_type_arg_error(sc, \"kinc_init\", 3, height, \"an integer\"));

    /* Optional window options */
    p = s7_cdr(p);
    if (s7_nil(sc) != p) {
        wo = s7_car(p);
        obj_type = s7_c_object_type(wo);
        wo_s7tag = s7ctypes_name_to_s7tag(sc, \"<kinc_window_options_t>\");
        if (obj_type != wo_s7tag)
            return(s7_wrong_type_arg_error(sc, \"kinc_init\", 4, wo, \"a kinc_window_options_t\"));
    }

    /* Optional framebuffer opitons */
    p = s7_cdr(p);
    if (s7_nil(sc) != p) {
        fo = s7_car(p);
        obj_type = s7_c_object_type(fo);
        fo_s7tag = s7ctypes_name_to_s7tag(sc, \"<kinc_framebuffer_options_t>\");
        if (obj_type != fo_s7tag)
            return(s7_wrong_type_arg_error(sc, \"kinc_init\", 5, fo, \"a kinc_framebuffer_options_t\"));
    }

    return(s7_make_integer(sc, kinc_init(s7_string(name), s7_integer(width), s7_integer(height),
                                         s7_is_null(sc, wo) ? NULL : (kinc_window_options_t *)s7_c_object_value(wo),
                                         s7_is_null(sc, fo) ? NULL : (kinc_framebuffer_options_t *)s7_c_object_value(fo))));
}

") ;; end special C-object conversion

      (C-function ("kinc_init" g_kinc_init "int kinc_init(char* int int kinc_window_options_t kinc_framebuffer_options_t)" 3 2))
    )
  )

(curlet))
