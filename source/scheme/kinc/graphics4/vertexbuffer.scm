;;; TODO: vertexbuffer.scm
;;;
;;; kinc/graphics4/vertexbuffer.h

(provide 'kinc/graphics4/vertexbuffer)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/vertexbuffer
    :ctypes ((:name kinc_g4_vertex_buffer_t :destroy kinc_g4_vertex_buffer_destroy))

    :c-info (

      ;; TODO: Functions requiring special C-object conversion
      (in-C "

static s7_pointer g_kinc_g4_vertex_buffer_init(s7_scheme *sc, s7_pointer args) {
    s7_pointer obj, p, arg;
    s7_int obj_type, vs_s7tag, count, usage, step;
    kinc_g4_vertex_buffer_t *vb_ko;
    kinc_g4_vertex_structure_t *vs_ko;

    if (s7_list_length(sc, args) != 5)
        return(s7_wrong_number_of_args_error(sc, \"kinc_g4_vertex_buffer_init takes 5 arguments: ~S\", args));

    p = args;
    obj = s7_car(p);
    obj_type = s7_c_object_type(obj);
    if (obj_type != kinc_g4_vertex_buffer_t_s7tag)
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_vertex_buffer_init\", 1, obj, \"a kinc_g4_vertex_buffer_t\"));
    vb_ko = (kinc_g4_vertex_buffer_t *)s7_c_object_value(obj);

    p = s7_cdr(p);
    arg = s7_car(p);
    if (!s7_is_integer(arg))
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_vertex_buffer_init\", 2, arg, \"an integer\"));
    count = s7_integer(arg);

    p = s7_cdr(p);
    obj = s7_car(p);
    obj_type = s7_c_object_type(obj);
    vs_s7tag = s7ctypes_name_to_s7tag(sc, \"<kinc_g4_vertex_structure_t>\");
    if (obj_type != vs_s7tag)
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_vertex_buffer_init\", 3, obj, \"a kinc_g4_vertex_structure_t\"));
    vs_ko = (kinc_g4_vertex_structure_t *)s7_c_object_value(obj);

    p = s7_cdr(p);
    arg = s7_car(p);
    if (!s7_is_integer(arg))
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_vertex_buffer_init\", 4, arg, \"an integer\"));
    usage = s7_integer(arg);

    p = s7_cdr(p);
    arg = s7_car(p);
    if (!s7_is_integer(arg))
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_vertex_buffer_init\", 5, arg, \"an integer\"));
    step = s7_integer(arg);

    kinc_g4_vertex_buffer_init(vb_ko, count, vs_ko, usage, step);
    return(s7_unspecified(sc));
}

/* kinc_g4_vertex_buffer_destroy is called directly from the opaque ctype's free proc.
static s7_pointer g_kinc_g4_vertex_buffer_destroy(s7_scheme *sc, s7_pointer args) {
    s7_pointer obj;
    s7_int obj_type;
    kinc_g4_vertex_buffer_t *ko;

    if (s7_list_length(sc, args) != 1)
        return(s7_wrong_number_of_args_error(sc, \"kinc_g4_vertex_buffer_destroy takes 1 argument: ~S\", args));

    obj = s7_car(args);
    obj_type = s7_c_object_type(obj);
    if (obj_type != kinc_g4_vertex_buffer_t_s7tag)
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_vertex_buffer_destroy\", 0, obj, \"a kinc_g4_vertex_buffer_t\"));
    ko = (kinc_g4_vertex_buffer_t *)s7_c_object_value(obj);

    kinc_g4_vertex_buffer_destroy(ko);
    return(s7_unspecified(sc));
}
*/

static s7_pointer g_kinc_g4_vertex_buffer_lock_all(s7_scheme *sc, s7_pointer args) {
    s7_pointer obj, wrapped_buffer;
    s7_int obj_type;
    kinc_g4_vertex_buffer_t *ko;
    float *buffer;

    if (s7_list_length(sc, args) != 1)
        return(s7_wrong_number_of_args_error(sc, \"kinc_g4_vertex_buffer_lock_all takes 1 argument: ~S\", args));

    obj = s7_car(args);
    obj_type = s7_c_object_type(obj);
    if (obj_type != kinc_g4_vertex_buffer_t_s7tag)
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_vertex_buffer_lock_all\", 0, obj, \"a kinc_g4_vertex_buffer_t\"));
    ko = (kinc_g4_vertex_buffer_t *)s7_c_object_value(obj);

    buffer = kinc_g4_vertex_buffer_lock_all(ko);
    wrapped_buffer = s7ctypes_wrap_float_array(sc, buffer);
    return(wrapped_buffer);
}

static s7_pointer g_kinc_g4_vertex_buffer_lock(s7_scheme *sc, s7_pointer args) {
// TODO: float *kinc_g4_vertex_buffer_lock (kinc_g4_vertex_buffer_t *buffer, int start, int count)
}

static s7_pointer g_kinc_g4_vertex_buffer_unlock_all(s7_scheme *sc, s7_pointer args) {
    s7_pointer obj;
    s7_int obj_type;
    kinc_g4_vertex_buffer_t *ko;

    if (s7_list_length(sc, args) != 1)
        return(s7_wrong_number_of_args_error(sc, \"kinc_g4_vertex_buffer_unlock_all takes 1 argument: ~S\", args));

    obj = s7_car(args);
    obj_type = s7_c_object_type(obj);
    if (obj_type != kinc_g4_vertex_buffer_t_s7tag)
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_vertex_buffer_unlock_all\", 0, obj, \"a kinc_g4_vertex_buffer_t\"));
    ko = (kinc_g4_vertex_buffer_t *)s7_c_object_value(obj);

    kinc_g4_vertex_buffer_unlock_all(ko);
    return(s7_unspecified(sc));
}

static s7_pointer g_kinc_g4_vertex_buffer_unlock(s7_scheme *sc, s7_pointer args) {
// TODO: void kinc_g4_vertex_buffer_unlock (kinc_g4_vertex_buffer_t *buffer, int count)
}

static s7_pointer g_kinc_g4_vertex_buffer_count(s7_scheme *sc, s7_pointer args) {
    s7_pointer obj;
    s7_int obj_type;
    kinc_g4_vertex_buffer_t *ko;

    if (s7_list_length(sc, args) != 1)
        return(s7_wrong_number_of_args_error(sc, \"kinc_g4_vertex_buffer_count takes 1 argument: ~S\", args));

    obj = s7_car(args);
    obj_type = s7_c_object_type(obj);
    if (obj_type != kinc_g4_vertex_buffer_t_s7tag)
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_vertex_buffer_count\", 0, obj, \"a kinc_g4_vertex_buffer_t\"));
    ko = (kinc_g4_vertex_buffer_t *)s7_c_object_value(obj);

    return(s7_make_integer(sc, kinc_g4_vertex_buffer_count(ko)));
}

static s7_pointer g_kinc_g4_vertex_buffer_stride(s7_scheme *sc, s7_pointer args) {
    s7_pointer obj;
    s7_int obj_type;
    kinc_g4_vertex_buffer_t *ko;

    if (s7_list_length(sc, args) != 1)
        return(s7_wrong_number_of_args_error(sc, \"kinc_g4_vertex_buffer_stride takes 1 argument: ~S\", args));

    obj = s7_car(args);
    obj_type = s7_c_object_type(obj);
    if (obj_type != kinc_g4_vertex_buffer_t_s7tag)
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_vertex_buffer_stride\", 0, obj, \"a kinc_g4_vertex_buffer_t\"));
    ko = (kinc_g4_vertex_buffer_t *)s7_c_object_value(obj);

    return(s7_make_integer(sc, kinc_g4_vertex_buffer_stride(ko)));
}

static s7_pointer g_kinc_g4_set_vertex_buffers(s7_scheme *sc, s7_pointer args) {
// TODO: void kinc_g4_set_vertex_buffers (kinc_g4_vertex_buffer_t **buffers, int count)
}

static s7_pointer g_kinc_g4_set_vertex_buffer(s7_scheme *sc, s7_pointer args) {
    s7_pointer obj;
    s7_int obj_type;
    kinc_g4_vertex_buffer_t *ko;

    if (s7_list_length(sc, args) != 1)
        return(s7_wrong_number_of_args_error(sc, \"kinc_g4_set_vertex_buffer takes 1 argument: ~S\", args));

    obj = s7_car(args);
    obj_type = s7_c_object_type(obj);
    if (obj_type != kinc_g4_vertex_buffer_t_s7tag)
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_set_vertex_buffer\", 0, obj, \"a kinc_g4_vertex_buffer_t\"));
    ko = (kinc_g4_vertex_buffer_t *)s7_c_object_value(obj);

    kinc_g4_set_vertex_buffer(ko);
    return(s7_unspecified(sc));
}

") ;; end special C-object conversion

      (C-function ("kinc_g4_vertex_buffer_init" g_kinc_g4_vertex_buffer_init "void kinc_g4_vertex_buffer_init (kinc_g4_vertex_buffer_t *buffer, int count, kinc_g4_vertex_structure_t *structure, kinc_g4_usage_t usage, int instance_data_step_rate)" 5))
     ;(C-function ("kinc_g4_vertex_buffer_destroy" g_kinc_g4_vertex_buffer_destroy "void kinc_g4_vertex_buffer_destroy (kinc_g4_vertex_buffer_t *buffer)" 1)) ; automatically called
      (C-function ("kinc_g4_vertex_buffer_lock_all" g_kinc_g4_vertex_buffer_lock_all "float* kinc_g4_vertex_buffer_lock_all (kinc_g4_vertex_buffer_t *buffer)" 1))
;TODO (C-function ("kinc_g4_vertex_buffer_lock" g_kinc_g4_vertex_buffer_lock "float* kinc_g4_vertex_buffer_lock (kinc_g4_vertex_buffer_t *buffer, int start, int count)" 3))
      (C-function ("kinc_g4_vertex_buffer_unlock_all" g_kinc_g4_vertex_buffer_unlock_all "void kinc_g4_vertex_buffer_unlock_all (kinc_g4_vertex_buffer_t *buffer)" 1))
;TODO (C-function ("kinc_g4_vertex_buffer_unlock" g_kinc_g4_vertex_buffer_unlock "void kinc_g4_vertex_buffer_unlock (kinc_g4_vertex_buffer_t *buffer, int count)" 2))
      (C-function ("kinc_g4_vertex_buffer_count" g_kinc_g4_vertex_buffer_count "int kinc_g4_vertex_buffer_count (kinc_g4_vertex_buffer_t *buffer)" 1))
      (C-function ("kinc_g4_vertex_buffer_stride" g_kinc_g4_vertex_buffer_stride "int kinc_g4_vertex_buffer_stride (kinc_g4_vertex_buffer_t *buffer)" 1))
;TODO (C-function ("kinc_g4_set_vertex_buffers" g_kinc_g4_set_vertex_buffers "void kinc_g4_set_vertex_buffers (kinc_g4_vertex_buffer_t **buffers, int count)" 2))
      (C-function ("kinc_g4_set_vertex_buffer" g_kinc_g4_set_vertex_buffer "void kinc_g4_set_vertex_buffer (kinc_g4_vertex_buffer_t *buffer)" 1))
    )
  )

  (define new-g4-vertex-buffer
    (let ((+documentation+ "(new-g4-vertex-buffer count structure (usage KINC_G4_USAGE_STATIC) (instance-data-step-rate 0)): Returns an initialized <kinc_g4_vertex_buffer_t> with `count` vertices, the specified vertex `structure`, `usage` hint, and `instance-data-step-rate`."))
      (lambda* (count structure (usage 0 #|KINC_G4_USAGE_STATIC|#) (instance-data-step-rate 0))
        (let ((buffer (make-kinc_g4_vertex_buffer_t)))
          (kinc_g4_vertex_buffer_init buffer count structure usage instance-data-step-rate)
          buffer))))

  ; TODO: Add selective lock/unlock? or separate convenience macro?
  (define with-g4-vertex-buffer
    (let ((+documentation+ "(with-g4-vertex-buffer vertex-buffer body ...): A convenience macro which exposes the underlying array of `vertex-buffer` for modification under the name 'V', which is an applicable/settable <wrapped_float_array>. The names 'count' and 'stride' are also made available, specifying the number of vertices and size of one vertex of the buffer in bytes respectively."))
      (macro (vertex-buffer . body)
        `(with-let (sublet (curlet)
                           :count (kinc_g4_vertex_buffer_count ,vertex-buffer)
                           :stride (kinc_g4_vertex_buffer_stride ,vertex-buffer)
                           :V (kinc_g4_vertex_buffer_lock_all ,vertex-buffer))
           ,@body
           (kinc_g4_vertex_buffer_unlock_all ,vertex-buffer)))))

(curlet))
