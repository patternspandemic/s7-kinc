;;; TODO: vertexstructure.scm
;;;
;;; kinc/graphics4/vertexstructure.h

(provide 'kinc/graphics4/vertexstructure)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/vertexstructure
    :ctypes ((kinc_g4_vertex_element_t #|TODO|#)
             (kinc_g4_vertex_structure_t #|TODO|# ))

    :c-info (

      ((kinc_g4_vertex_data_t int) (KINC_G4_VERTEX_DATA_NONE
                                    KINC_G4_VERTEX_DATA_FLOAT1
                                    KINC_G4_VERTEX_DATA_FLOAT2
                                    KINC_G4_VERTEX_DATA_FLOAT3
                                    KINC_G4_VERTEX_DATA_FLOAT4
                                    KINC_G4_VERTEX_DATA_FLOAT4X4
                                    KINC_G4_VERTEX_DATA_SHORT2_NORM
                                    KINC_G4_VERTEX_DATA_SHORT4_NORM
                                    KINC_G4_VERTEX_DATA_COLOR))

      ;; TODO: Functions requiring special C-object conversion
      (in-C "

static s7_pointer g_kinc_g4_vertex_structure_init(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_vertex_structure_init (kinc_g4_vertex_structure_t *structure)

}

static s7_pointer g_kinc_g4_vertex_structure_add(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_vertex_structure_add (kinc_g4_vertex_structure_t *structure, const char *name, kinc_g4_vertex_data_t data)

}

") ;; end special C-object conversion

      (C-function ("kinc_g4_vertex_structure_init" g_kinc_g4_vertex_structure_init "void kinc_g4_vertex_structure_init (kinc_g4_vertex_structure_t *structure)" 1))
      (C-function ("kinc_g4_vertex_structure_add" g_kinc_g4_vertex_structure_add "void kinc_g4_vertex_structure_add (kinc_g4_vertex_structure_t *structure, const char *name, kinc_g4_vertex_data_t data)" 3))
    )
  )

(curlet))
