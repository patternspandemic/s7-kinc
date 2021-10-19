;;; vertexstructure.scm
;;;
;;; kinc/graphics4/vertexstructure.h

(provide 'kinc/graphics4/vertexstructure)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/vertexstructure
    :ctypes (; NOTE: kinc_g4_vertex_element_t excluded, as it's not used on its own (kinc_g4_vertex_structure_add is used to add elements).
             ; ;(:name kinc_g4_vertex_element_t
             ; :fields (
             ;  (char* name "pos")
             ;  ((enum kinc_g4_vertex_data_t) data 3))) ; KINC_G4_VERTEX_DATA_FLOAT3 = 3

             ; NOTE: elements field is left unexposed. Perhaps the type should be readonly/opaque, with other fields exposed via procs?
             (:name kinc_g4_vertex_structure_t
              :fields (
               ;(? elements ?) ; FIXME: How to expose kinc_g4_vertex_element_t elements[]?
               (int size 0)
               (bool instanced #f))))

    :c-info (
      (C-macro (int (KINC_G4_MAX_VERTEX_ELEMENTS)))

      ((kinc_g4_vertex_data_t int) (KINC_G4_VERTEX_DATA_NONE
                                    KINC_G4_VERTEX_DATA_FLOAT1
                                    KINC_G4_VERTEX_DATA_FLOAT2
                                    KINC_G4_VERTEX_DATA_FLOAT3
                                    KINC_G4_VERTEX_DATA_FLOAT4
                                    KINC_G4_VERTEX_DATA_FLOAT4X4
                                    KINC_G4_VERTEX_DATA_SHORT2_NORM
                                    KINC_G4_VERTEX_DATA_SHORT4_NORM
                                    KINC_G4_VERTEX_DATA_COLOR))

      ;; Functions requiring special C-object conversion
      (in-C "

static s7_pointer g_kinc_g4_vertex_structure_init(s7_scheme *sc, s7_pointer args) {
    s7_pointer obj;
    s7_int obj_type;
    kinc_g4_vertex_structure_t *ko;

    if (s7_list_length(sc, args) != 1)
        return(s7_wrong_number_of_args_error(sc, \"kinc_g4_vertex_structure_init takes 1 argument: ~S\", args));

    obj = s7_car(args);
    obj_type = s7_c_object_type(obj);
    if (obj_type != kinc_g4_vertex_structure_t_s7tag)
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_vertex_structure_init\", 0, obj, \"a kinc_g4_vertex_structure_t\"));
    ko = (kinc_g4_vertex_structure_t *)s7_c_object_value(obj);

    kinc_g4_vertex_structure_init(ko);
    return(s7_unspecified(sc));
}

static s7_pointer g_kinc_g4_vertex_structure_add(s7_scheme *sc, s7_pointer args) {
    s7_pointer obj, p, arg;
    s7_int obj_type, data;
    char *name;
    kinc_g4_vertex_structure_t *ko;

    if (s7_list_length(sc, args) != 3)
        return(s7_wrong_number_of_args_error(sc, \"kinc_g4_vertex_structure_add takes 3 arguments: ~S\", args));

    p = args;
    obj = s7_car(p);
    obj_type = s7_c_object_type(obj);
    if (obj_type != kinc_g4_vertex_structure_t_s7tag)
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_vertex_structure_add\", 1, obj, \"a kinc_g4_vertex_structure_t\"));
    ko = (kinc_g4_vertex_structure_t *)s7_c_object_value(obj);

    p = s7_cdr(p);
    arg = s7_car(p);
    if (!s7_is_string(arg))
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_vertex_structure_add\", 2, arg, \"a string\"));
    name = (char *)s7_string(arg);

    p = s7_cdr(p);
    arg = s7_car(p);
    if (!s7_is_integer(arg))
        return(s7_wrong_type_arg_error(sc, \"kinc_g4_vertex_structure_add\", 3, arg, \"an integer (kinc_g4_vertex_data_t)\"));
    data = s7_integer(arg);

    kinc_g4_vertex_structure_add(ko, name, data);
    return(s7_unspecified(sc));
}

") ;; end special C-object conversion

      (C-function ("kinc_g4_vertex_structure_init" g_kinc_g4_vertex_structure_init "void kinc_g4_vertex_structure_init (kinc_g4_vertex_structure_t *structure)" 1))
      (C-function ("kinc_g4_vertex_structure_add" g_kinc_g4_vertex_structure_add "void kinc_g4_vertex_structure_add (kinc_g4_vertex_structure_t *structure, const char *name, kinc_g4_vertex_data_t data)" 3))
    )
  )

  (define new-g4-vertex-structure
    (let ((+documentation+ "(new-g4-vertex-structure): Returns an initialized <kinc_g4_vertex_structure_t>."))
      (lambda ()
        (let ((structure (make-kinc_g4_vertex_structure_t)))
          (kinc_g4_vertex_structure_init structure)
          structure))))

(curlet))
