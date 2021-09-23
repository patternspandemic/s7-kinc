;;; TODO: shader.scm
;;;
;;; kinc/graphics4/shader.h

(provide 'kinc/graphics4/shader)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/shader
    :ctypes ((kinc_g4_shader_t))

    :c-info (
      ((kinc_g4_shader_type_t int) (KINC_G4_SHADER_TYPE_FRAGMENT
                                    KINC_G4_SHADER_TYPE_VERTEX
                                    KINC_G4_SHADER_TYPE_GEOMETRY
                                    KINC_G4_SHADER_TYPE_TESSELLATION_CONTROL
                                    KINC_G4_SHADER_TYPE_TESSELLATION_EVALUATION))

      ;; TODO: Functions requiring special C-object conversion
      (in-C "

static s7_pointer g_kinc_g4_shader_init(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_shader_init (kinc_g4_shader_t *shader, void *data, size_t length, kinc_g4_shader_type_t type)

}

static s7_pointer g_kinc_g4_shader_init_from_source(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_shader_init_from_source (kinc_g4_shader_t *shader, const char *source, kinc_g4_shader_type_t type)

}

static s7_pointer g_kinc_g4_shader_destroy(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_shader_destroy (kinc_g4_shader_t *shader)

}

") ;; end special C-object conversion

      (C-function ("kinc_g4_shader_init" g_kinc_g4_shader_init "void kinc_g4_shader_init (kinc_g4_shader_t *shader, void *data, size_t length, kinc_g4_shader_type_t type)" 4))
      (C-function ("kinc_g4_shader_init_from_source" g_kinc_g4_shader_init_from_source "void kinc_g4_shader_init_from_source (kinc_g4_shader_t *shader, const char *source, kinc_g4_shader_type_t type)" 3))
      (C-function ("kinc_g4_shader_destroy" g_kinc_g4_shader_destroy "void kinc_g4_shader_destroy (kinc_g4_shader_t *shader)" 1))
    )
  )

(curlet))
