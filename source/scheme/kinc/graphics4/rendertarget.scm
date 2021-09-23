;;; TODO: rendertarget.scm
;;;
;;; kinc/graphics4/rendertarget.h

(provide 'kinc/graphics4/rendertarget)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/rendertarget
    :ctypes ((kinc_g4_render_target_t #|TODO|#))

    :c-info (
      ((kinc_g4_render_target_format_t int) (KINC_G4_RENDER_TARGET_FORMAT_32BIT
                                             KINC_G4_RENDER_TARGET_FORMAT_64BIT_FLOAT
                                             KINC_G4_RENDER_TARGET_FORMAT_32BIT_RED_FLOAT
                                             KINC_G4_RENDER_TARGET_FORMAT_128BIT_FLOAT
                                             KINC_G4_RENDER_TARGET_FORMAT_16BIT_DEPTH
                                             KINC_G4_RENDER_TARGET_FORMAT_8BIT_RED
                                             KINC_G4_RENDER_TARGET_FORMAT_16BIT_RED_FLOAT))

;; void kinc_g4_render_target_init (kinc_g4_render_target_t *renderTarget, int width, int height, int depthBufferBits, bool antialiasing, kinc_g4_render_target_format_t format, int stencilBufferBits, int contextId)
;; void kinc_g4_render_target_init_cube (kinc_g4_render_target_t *renderTarget, int cubeMapSize, int depthBufferBits, bool antialiasing, kinc_g4_render_target_format_t format, int stencilBufferBits, int contextId)
;; void kinc_g4_render_target_destroy (kinc_g4_render_target_t *renderTarget)
;; void kinc_g4_render_target_use_color_as_texture (kinc_g4_render_target_t *renderTarget, kinc_g4_texture_unit_t unit)
;; void kinc_g4_render_target_use_depth_as_texture (kinc_g4_render_target_t *renderTarget, kinc_g4_texture_unit_t unit)
;; void kinc_g4_render_target_set_depth_stencil_from (kinc_g4_render_target_t *renderTarget, kinc_g4_render_target_t *source)
;; void kinc_g4_render_target_get_pixels (kinc_g4_render_target_t *renderTarget, uint8_t *data)
;; void kinc_g4_render_target_generate_mipmaps (kinc_g4_render_target_t *renderTarget, int levels)

    )
  )

(curlet))
