;;; TODO: texture.scm
;;;
;;; kinc/graphics4/texture.h

(provide 'kinc/graphics4/texture)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/texture
    :headers ("kinc/image.h")
    :ctypes ((kinc_g4_texture_t #|TODO|#))

    :c-info (

;; void kinc_g4_texture_init (kinc_g4_texture_t *texture, int width, int height, kinc_image_format_t format)
;; void kinc_g4_texture_init3d (kinc_g4_texture_t *texture, int width, int height, int depth, kinc_image_format_t format)
;; void kinc_g4_texture_init_from_image (kinc_g4_texture_t *texture, kinc_image_t *image)
;; void kinc_g4_texture_init_from_image3d (kinc_g4_texture_t *texture, kinc_image_t *image)
;; void kinc_g4_texture_destroy (kinc_g4_texture_t *texture)
;; unsigned char* kinc_g4_texture_lock (kinc_g4_texture_t *texture)
;; void kinc_g4_texture_unlock (kinc_g4_texture_t *texture)
;; void kinc_g4_texture_clear (kinc_g4_texture_t *texture, int x, int y, int z, int width, int height, int depth, unsigned color)
;; void kinc_g4_texture_generate_mipmaps (kinc_g4_texture_t *texture, int levels)
;; void kinc_g4_texture_set_mipmap (kinc_g4_texture_t *texture, kinc_image_t *mipmap, int level)
;; int kinc_g4_texture_stride (kinc_g4_texture_t *texture)

    )
  )

(curlet))
