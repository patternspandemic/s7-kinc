;;; TODO: window.scm
;;;
;;; kinc/window.h

(provide 'kinc/window)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc window
    :ctypes ((kinc_framebuffer_options_t ; TODO: Add field defaults
              (int frequency)
              (bool vertical_sync)
              (int color_bits)
              (int depth_bits)
              (int stencil_bits)
              (int samples_per_pixel))

             (kinc_window_options_t ; TODO: Add field defaults
              (char* title)
              (int x)
              (int y)
              (int width)
              (int height)
              (int display_index)
              (bool visible)
              (int window_features)
              ((enum kinc_window_mode_t) mode)))

    :c-info (
      (C-macro (int (KINC_WINDOW_FEATURE_RESIZEABLE
                     KINC_WINDOW_FEATURE_MINIMIZABLE
                     KINC_WINDOW_FEATURE_MAXIMIZABLE
                     KINC_WINDOW_FEATURE_BORDERLESS
                     KINC_WINDOW_FEATURE_ON_TOP)))

      ((kinc_window_mode_t int) (KINC_WINDOW_MODE_WINDOW
                                 KINC_WINDOW_MODE_FULLSCREEN
                                 KINC_WINDOW_MODE_EXCLUSIVE_FULLSCREEN))

                          (void kinc_window_destroy (int))
                           (int kinc_count_windows (void))
                          (void kinc_window_resize (int int int))
                          (void kinc_window_move (int int int))
                          (void kinc_window_change_mode (int (kinc_window_mode_t int)))
                          (void kinc_window_change_features (int int))
                           (int kinc_window_x (int))
                           (int kinc_window_y (int))
                           (int kinc_window_width (int))
                           (int kinc_window_height (int))
                           (int kinc_window_display (int))
      ((kinc_window_mode_t int) kinc_window_get_mode (int))
                          (void kinc_window_show (int))
                          (void kinc_window_hide (int))
                          (void kinc_window_set_title (int char*))
                          (bool kinc_window_vsynced (int))

      ;; NOTE: Basic hooks for these callbacks are set in core.c
      ;void kinc_window_set_resize_callback (int window, void(*callback)(int x, int y, void *data), void *data)
      ;void kinc_window_set_ppi_changed_callback (int window, void(*callback)(int ppi, void *data), void *data) ; NOTE: Backend Not Implemented


      ;; Functions requiring special C-object conversion
      (in-C "

static s7_pointer g_kinc_window_options_set_defaults(s7_scheme *sc, s7_pointer args) {
    s7_pointer obj;
    s7_int obj_type;
    kinc_window_options_t *ko;

    if (s7_list_length(sc, args) != 1)
        return(s7_wrong_number_of_args_error(sc, \"kinc_window_options_set_defaults takes 1 argument: ~S\", args));

    obj = s7_car(args);
    obj_type = s7_c_object_type(obj);
    if (obj_type != kinc_window_options_t_s7tag)
        return(s7_wrong_type_arg_error(sc, \"kinc_window_options_set_defaults\", 1, obj, \"a kinc_window_options_t\"));
    ko = (kinc_window_options_t *)s7_c_object_value(obj);

    kinc_window_options_set_defaults(ko);
    return(s7_unspecified(sc));
}

static s7_pointer g_kinc_framebuffer_options_set_defaults(s7_scheme *sc, s7_pointer args) {
    s7_pointer obj;
    s7_int obj_type;
    kinc_framebuffer_options_t *ko;

    if (s7_list_length(sc, args) != 1)
        return(s7_wrong_number_of_args_error(sc, \"kinc_framebuffer_options_set_defaults takes 1 argument: ~S\", args));

    obj = s7_car(args);
    obj_type = s7_c_object_type(obj);
    if (obj_type != kinc_framebuffer_options_t_s7tag)
        return(s7_wrong_type_arg_error(sc, \"kinc_framebuffer_options_set_defaults\", 1, obj, \"a kinc_framebuffer_options_t\"));
    ko = (kinc_framebuffer_options_t *)s7_c_object_value(obj);

    kinc_framebuffer_options_set_defaults(ko);
    return(s7_unspecified(sc));
}

static s7_pointer g_kinc_window_create(s7_scheme *sc, s7_pointer args) {
    s7_pointer p, wo, fo;
    s7_int obj_type;

    if (s7_list_length(sc, args) != 2)
        return(s7_wrong_number_of_args_error(sc, \"kinc_window_create takes 2 arguments: ~S\", args));

    p = args;
    wo = s7_car(p);
    obj_type = s7_c_object_type(wo);
    if (obj_type != kinc_window_options_t_s7tag)
        return(s7_wrong_type_arg_error(sc, \"kinc_window_create\", 1, wo, \"a kinc_window_options_t\"));
    p = s7_cdr(p);
    fo = s7_car(p);
    obj_type = s7_c_object_type(fo);
    if (obj_type != kinc_framebuffer_options_t_s7tag)
        return(s7_wrong_type_arg_error(sc, \"kinc_window_create\", 2, fo, \"a kinc_framebuffer_options_t\"));

    return(s7_make_integer(sc, kinc_window_create((kinc_window_options_t *)s7_c_object_value(wo),
                                                  (kinc_framebuffer_options_t *)s7_c_object_value(fo))));
}

static s7_pointer g_kinc_window_change_framebuffer(s7_scheme *sc, s7_pointer args) {
    s7_pointer p, i, fo;
    s7_int obj_type;

    if (s7_list_length(sc, args) != 2)
        return(s7_wrong_number_of_args_error(sc, \"kinc_window_change_framebuffer takes 2 arguments: ~S\", args));

    p = args;
    i = s7_car(p);
    if (!s7_is_integer(i))
        return(s7_wrong_type_arg_error(sc, \"kinc_window_change_framebuffer\", 1, i, \"an integer\"));
    p = s7_cdr(p);
    fo = s7_car(p);
    obj_type = s7_c_object_type(fo);
    if (obj_type != kinc_framebuffer_options_t_s7tag)
        return(s7_wrong_type_arg_error(sc, \"kinc_window_change_framebuffer\", 2, fo, \"a kinc_framebuffer_options_t\"));

    kinc_window_change_framebuffer(s7_integer(i), (kinc_framebuffer_options_t *)s7_c_object_value(fo));
    return(s7_unspecified(sc));
}

") ;; end special C-object conversion

      (C-function ("kinc_window_options_set_defaults" g_kinc_window_options_set_defaults "void kinc_window_options_set_defaults(kinc_window_options_t)" 1))
      (C-function ("kinc_framebuffer_options_set_defaults" g_kinc_framebuffer_options_set_defaults "void kinc_framebuffer_options_set_defaults(kinc_framebuffer_options_t)" 1))
      (C-function ("kinc_window_create" g_kinc_window_create "int kinc_window_create(kinc_window_options_t kinc_framebuffer_options_t)" 2))
      (C-function ("kinc_window_change_framebuffer" g_kinc_window_change_framebuffer "void kinc_window_change_framebuffer(int kinc_framebuffer_options_t)" 2))
    )
  )

(curlet))
