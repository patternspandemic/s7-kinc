;;; indexbuffer.scm
;;;
;;; kinc/graphics4/indexbuffer.h

(provide 'kinc/graphics4/indexbuffer)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/indexbuffer
    :ctypes ((:name kinc_g4_index_buffer_t :destroy kinc_g4_index_buffer_destroy))

    :c-info (
      ((kinc_g4_index_buffer_format_t int) (KINC_G4_INDEX_BUFFER_FORMAT_32BIT
                                            KINC_G4_INDEX_BUFFER_FORMAT_16BIT))

      ;; Functions requiring special C-object conversion
      (in-C "

static s7_pointer g_kinc_g4_index_buffer_init(s7_scheme *sc, s7_pointer args) {
    s7_pointer obj, p, arg;
    s7_int obj_type, count, format, usage;
    kinc_g4_index_buffer_t *ko;

    if (s7_list_length(sc, args) != 4)
        return(s7_wrong_number_of_args_error(sc, \"kinc_g4_index_buffer_init takes 4 arguments: ~S\", args));

    p = args;
    obj = s7_car(p);
    obj_type = s7_c_object_type(obj);
    if (obj_type != kinc_g4_index_buffer_t_s7tag)
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_index_buffer_init\", 1, obj, \"a kinc_g4_index_buffer_t\"));
    ko = (kinc_g4_index_buffer_t *)s7_c_object_value(obj);

    p = s7_cdr(p);
    arg = s7_car(p);
    if (!s7_is_integer(arg))
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_index_buffer_init\", 2, arg, \"an integer\"));
    count = s7_integer(arg);

    p = s7_cdr(p);
    arg = s7_car(p);
    if (!s7_is_integer(arg))
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_index_buffer_init\", 3, arg, \"an integer\"));
    format = s7_integer(arg);

    p = s7_cdr(p);
    arg = s7_car(p);
    if (!s7_is_integer(arg))
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_index_buffer_init\", 4, arg, \"an integer\"));
    usage = s7_integer(arg);

    kinc_g4_index_buffer_init(ko, count, format, usage);
    return(s7_unspecified(sc));
}

/* kinc_g4_index_buffer_destroy is called directly from the opaque ctype's free proc.
static s7_pointer g_kinc_g4_index_buffer_destroy(s7_scheme *sc, s7_pointer args) {
    s7_pointer obj;
    s7_int obj_type;
    kinc_g4_index_buffer_t *ko;

    if (s7_list_length(sc, args) != 1)
        return(s7_wrong_number_of_args_error(sc, \"kinc_g4_index_buffer_destroy takes 1 argument: ~S\", args));

    obj = s7_car(args);
    obj_type = s7_c_object_type(obj);
    if (obj_type != kinc_g4_index_buffer_t_s7tag)
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_index_buffer_destroy\", 0, obj, \"a kinc_g4_index_buffer_t\"));
    ko = (kinc_g4_index_buffer_t *)s7_c_object_value(obj);

    kinc_g4_index_buffer_destroy(ko);
    return(s7_unspecified(sc));
}
*/

static s7_pointer g_kinc_g4_index_buffer_lock(s7_scheme *sc, s7_pointer args) {
    s7_pointer obj, wrapped_buffer;
    s7_int obj_type;
    kinc_g4_index_buffer_t *ko;
    int *buffer;

    if (s7_list_length(sc, args) != 1)
        return(s7_wrong_number_of_args_error(sc, \"kinc_g4_index_buffer_lock takes 1 argument: ~S\", args));

    obj = s7_car(args);
    obj_type = s7_c_object_type(obj);
    if (obj_type != kinc_g4_index_buffer_t_s7tag)
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_index_buffer_lock\", 0, obj, \"a kinc_g4_index_buffer_t\"));
    ko = (kinc_g4_index_buffer_t *)s7_c_object_value(obj);

    buffer = kinc_g4_index_buffer_lock(ko);
    wrapped_buffer = s7ctypes_wrap_int_array(sc, buffer);
    return(wrapped_buffer);
}

static s7_pointer g_kinc_g4_index_buffer_unlock(s7_scheme *sc, s7_pointer args) {
    s7_pointer obj;
    s7_int obj_type;
    kinc_g4_index_buffer_t *ko;

    if (s7_list_length(sc, args) != 1)
        return(s7_wrong_number_of_args_error(sc, \"kinc_g4_index_buffer_unlock takes 1 argument: ~S\", args));

    obj = s7_car(args);
    obj_type = s7_c_object_type(obj);
    if (obj_type != kinc_g4_index_buffer_t_s7tag)
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_index_buffer_unlock\", 0, obj, \"a kinc_g4_index_buffer_t\"));
    ko = (kinc_g4_index_buffer_t *)s7_c_object_value(obj);

    kinc_g4_index_buffer_unlock(ko);
    return(s7_unspecified(sc));
}

static s7_pointer g_kinc_g4_index_buffer_count(s7_scheme *sc, s7_pointer args) {
    s7_pointer obj;
    s7_int obj_type;
    kinc_g4_index_buffer_t *ko;

    if (s7_list_length(sc, args) != 1)
        return(s7_wrong_number_of_args_error(sc, \"kinc_g4_index_buffer_count takes 1 argument: ~S\", args));

    obj = s7_car(args);
    obj_type = s7_c_object_type(obj);
    if (obj_type != kinc_g4_index_buffer_t_s7tag)
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_index_buffer_count\", 0, obj, \"a kinc_g4_index_buffer_t\"));
    ko = (kinc_g4_index_buffer_t *)s7_c_object_value(obj);

    return(s7_make_integer(sc, kinc_g4_index_buffer_count(ko)));
}

static s7_pointer g_kinc_g4_set_index_buffer(s7_scheme *sc, s7_pointer args) {
    s7_pointer obj;
    s7_int obj_type;
    kinc_g4_index_buffer_t *ko;

    if (s7_list_length(sc, args) != 1)
        return(s7_wrong_number_of_args_error(sc, \"kinc_g4_set_index_buffer takes 1 argument: ~S\", args));

    obj = s7_car(args);
    obj_type = s7_c_object_type(obj);
    if (obj_type != kinc_g4_index_buffer_t_s7tag)
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_set_index_buffer\", 0, obj, \"a kinc_g4_index_buffer_t\"));
    ko = (kinc_g4_index_buffer_t *)s7_c_object_value(obj);

    kinc_g4_set_index_buffer(ko);
    return(s7_unspecified(sc));
}

") ;; end special C-object conversion

      (C-function ("kinc_g4_index_buffer_init" g_kinc_g4_index_buffer_init "void kinc_g4_index_buffer_init (kinc_g4_index_buffer_t *buffer, int count, kinc_g4_index_buffer_format_t format, kinc_g4_usage_t usage)" 4))
     ;(C-function ("kinc_g4_index_buffer_destroy" g_kinc_g4_index_buffer_destroy "void kinc_g4_index_buffer_destroy (kinc_g4_index_buffer_t *buffer)" 1)) ; automatically called
      (C-function ("kinc_g4_index_buffer_lock" g_kinc_g4_index_buffer_lock "int* kinc_g4_index_buffer_lock (kinc_g4_index_buffer_t *buffer)" 1))
      (C-function ("kinc_g4_index_buffer_unlock" g_kinc_g4_index_buffer_unlock "void kinc_g4_index_buffer_unlock (kinc_g4_index_buffer_t *buffer)" 1))
      (C-function ("kinc_g4_index_buffer_count" g_kinc_g4_index_buffer_count "int kinc_g4_index_buffer_count (kinc_g4_index_buffer_t *buffer)" 1))
      (C-function ("kinc_g4_set_index_buffer" g_kinc_g4_set_index_buffer "void kinc_g4_set_index_buffer (kinc_g4_index_buffer_t *buffer)" 1))
    )
  )

  (define make-g4-index-buffer
    (let ((+documentation+ "(make-g4-index-buffer count (format KINC_G4_INDEX_BUFFER_FORMAT_32BIT) (usage KINC_G4_USAGE_STATIC)): Returns an initialized <kinc_g4_index_buffer_t> with `count` indices, the specified integer `format` and `usage` hint."))
      (lambda* (count (format KINC_G4_INDEX_BUFFER_FORMAT_32BIT) (usage 0 #|KINC_G4_USAGE_STATIC|#))
        (let ((buffer (make-kinc_g4_index_buffer_t)))
          (kinc_g4_index_buffer_init buffer count format usage)
          buffer))))

  (define with-g4-index-buffer
    (let ((+documentation+ "(with-g4-index-buffer index-buffer body ...): A convenience macro which exposes the underlying array of `index-buffer` for modification under the name 'I', which is an applicable/settable <wrapped_int_array>. The name 'count' is also made available, specifying the number of indices."))
      (macro (index-buffer . body)
        `(with-let (sublet (curlet)
                           :count (kinc_g4_index_buffer_count ,index-buffer)
                           :I (kinc_g4_index_buffer_lock ,index-buffer))
           ,@body
           (kinc_g4_index_buffer_unlock ,index-buffer)))))

(curlet))
