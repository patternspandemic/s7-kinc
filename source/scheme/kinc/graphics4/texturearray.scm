;;; TODO: texturearray.scm
;;;
;;; kinc/graphics4/texturearray.h

(provide 'kinc/graphics4/texturearray)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/texturearray
    :ctypes ((kinc_g4_texture_array_t))

    :c-info (

;; void kinc_g4_texture_array_init (kinc_g4_texture_array_t *array, kinc_image_t *images, int count)
;; void kinc_g4_texture_array_destroy (kinc_g4_texture_array_t *array)

    )
  )

(curlet))
