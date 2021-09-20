;;; graphics4.scm
;;;
;;; kinc/graphics4/graphics.h

(provide 'kinc/graphics4)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/graphics
    :c-info (
      (C-macro (int (KINC_G4_CLEAR_COLOR
                     KINC_G4_CLEAR_DEPTH
                     KINC_G4_CLEAR_STENCIL)))

      ((kinc_g4_texture_addressing_t int) (KINC_G4_TEXTURE_ADDRESSING_REPEAT
                                           KINC_G4_TEXTURE_ADDRESSING_MIRROR
                                           KINC_G4_TEXTURE_ADDRESSING_CLAMP
                                           KINC_G4_TEXTURE_ADDRESSING_BORDER))

      ((kinc_g4_texture_direction_t int) (KINC_G4_TEXTURE_DIRECTION_U
                                          KINC_G4_TEXTURE_DIRECTION_V
                                          KINC_G4_TEXTURE_DIRECTION_W))

      ((kinc_g4_texture_operation_t int) (KINC_G4_TEXTURE_OPERATION_MODULATE
                                          KINC_G4_TEXTURE_OPERATION_SELECT_FIRST
                                          KINC_G4_TEXTURE_OPERATION_SELECT_SECOND))

      ((kinc_g4_texture_argument_t int) (KINC_G4_TEXTURE_ARGUMENT_CURRENT_COLOR
                                         KINC_G4_TEXTURE_ARGUMENT_TEXTURE_COLOR))

      ((kinc_g4_texture_filter_t int) (KINC_G4_TEXTURE_FILTER_POINT
                                       KINC_G4_TEXTURE_FILTER_LINEAR
                                       KINC_G4_TEXTURE_FILTER_ANISOTROPIC))

      ((kinc_g4_mipmap_filter_t int) (KINC_G4_MIPMAP_FILTER_NONE
                                      KINC_G4_MIPMAP_FILTER_POINT
                                      KINC_G4_MIPMAP_FILTER_LINEAR))

      (void kinc_g4_begin (int))
      (void kinc_g4_end (int))
      (bool kinc_g4_swap_buffers (void))
      (void kinc_g4_clear (uint32_t uint32_t float int))
    )
  )

(curlet))
