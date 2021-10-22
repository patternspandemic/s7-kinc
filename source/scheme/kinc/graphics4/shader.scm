;;; shader.scm
;;;
;;; kinc/graphics4/shader.h

(provide 'kinc/graphics4/shader)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/shader
    :ctypes ((:name kinc_g4_shader_t :destroy kinc_g4_shader_destroy))

    :c-info (
      ((kinc_g4_shader_type_t int) (KINC_G4_SHADER_TYPE_FRAGMENT
                                    KINC_G4_SHADER_TYPE_VERTEX
                                    KINC_G4_SHADER_TYPE_GEOMETRY
                                    KINC_G4_SHADER_TYPE_TESSELLATION_CONTROL
                                    KINC_G4_SHADER_TYPE_TESSELLATION_EVALUATION))

      ;; Functions requiring special C-object conversion
      (in-C "

static s7_pointer g_kinc_g4_shader_init(s7_scheme *sc, s7_pointer args) {
    s7_pointer obj, p, arg;
    s7_int obj_type, length, type;
    void *data;
    kinc_g4_shader_t *ko;

    if (s7_list_length(sc, args) != 4)
        return(s7_wrong_number_of_args_error(sc, \"kinc_g4_shader_init takes 4 arguments: ~S\", args));

    p = args;
    obj = s7_car(p);
    obj_type = s7_c_object_type(obj);
    if (obj_type != kinc_g4_shader_t_s7tag)
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_shader_init\", 1, obj, \"a kinc_g4_shader_t\"));
    ko = (kinc_g4_shader_t *)s7_c_object_value(obj);

    p = s7_cdr(p);
    arg = s7_car(p);
    if (!s7_is_string(arg))
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_shader_init\", 2, arg, \"a string (shader data)\"));
    data = (void *)s7_string(arg);

    p = s7_cdr(p);
    arg = s7_car(p);
    if (!s7_is_integer(arg))
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_shader_init\", 3, arg, \"an integer\"));
    length = s7_integer(arg);

    p = s7_cdr(p);
    arg = s7_car(p);
    if (!s7_is_integer(arg))
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_shader_init\", 4, arg, \"an integer\"));
    type = s7_integer(arg);

    kinc_g4_shader_init(ko, data, length, type);
    return(s7_unspecified(sc));
}

/* Only available under certain platforms
static s7_pointer g_kinc_g4_shader_init_from_source(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_shader_init_from_source (kinc_g4_shader_t *shader, const char *source, kinc_g4_shader_type_t type)

}
*/

/* kinc_g4_shader_destroy is called directly from the opaque ctype's free proc.
static s7_pointer g_kinc_g4_shader_destroy(s7_scheme *sc, s7_pointer args) {
    s7_pointer obj;
    s7_int obj_type;
    kinc_g4_shader_t *ko;

    if (s7_list_length(sc, args) != 1)
        return(s7_wrong_number_of_args_error(sc, \"kinc_g4_shader_destroy takes 1 argument: ~S\", args));

    obj = s7_car(args);
    obj_type = s7_c_object_type(obj);
    if (obj_type != kinc_g4_shader_t_s7tag)
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_shader_destroy\", 0, obj, \"a kinc_g4_shader_t\"));
    ko = (kinc_g4_shader_t *)s7_c_object_value(obj);

    kinc_g4_shader_destroy(ko);
    return(s7_unspecified(sc));
}
*/

") ;; end special C-object conversion

      (C-function ("kinc_g4_shader_init" g_kinc_g4_shader_init "void kinc_g4_shader_init (kinc_g4_shader_t *shader, void *data, size_t length, kinc_g4_shader_type_t type)" 4))
      ;(C-function ("kinc_g4_shader_init_from_source" g_kinc_g4_shader_init_from_source "void kinc_g4_shader_init_from_source (kinc_g4_shader_t *shader, const char *source, kinc_g4_shader_type_t type)" 3)) ; NOTE: Only available under certain platforms.
      ;(C-function ("kinc_g4_shader_destroy" g_kinc_g4_shader_destroy "void kinc_g4_shader_destroy (kinc_g4_shader_t *shader)" 1)) ; automatically called
    )
  )

  ; TODO: Make robust
  (define new-g4-shader-from-file
    (let ((+documentation+ "..."))
      (lambda (filename shader-type)
        (let ((shader-obj (make-kinc_g4_shader_t))
              (shader-src (with-input-from-file filename
                            (lambda ()
                              (read-string (length (current-input-port)))))))
          (kinc_g4_shader_init shader-obj shader-src (length shader-src) shader-type)
          shader-obj))))

(curlet))
