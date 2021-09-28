;;; TODO: texturearray.scm
;;;
;;; kinc/graphics4/texturearray.h

(provide 'kinc/graphics4/texturearray)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/texturearray
    :ctypes ((:name kinc_g4_texture_array_t :destroy kinc_g4_texture_array_destroy))

    :c-info (

      ;; TODO: Functions requiring special C-object conversion
      (in-C "

static s7_pointer g_kinc_g4_texture_array_init(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_texture_array_init (kinc_g4_texture_array_t *array, kinc_image_t *images, int count)

}

static s7_pointer g_kinc_g4_texture_array_destroy(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_texture_array_destroy (kinc_g4_texture_array_t *array)

}

") ;; end special C-object conversion

      (C-function ("kinc_g4_texture_array_init" g_kinc_g4_texture_array_init "void kinc_g4_texture_array_init (kinc_g4_texture_array_t *array, kinc_image_t *images, int count)" 3))
      (C-function ("kinc_g4_texture_array_destroy" g_kinc_g4_texture_array_destroy "void kinc_g4_texture_array_destroy (kinc_g4_texture_array_t *array)" 1))
    )
  )

(curlet))
