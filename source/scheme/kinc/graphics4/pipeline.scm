;;; TODO: pipeline.scm
;;;
;;; kinc/graphics4/pipeline.h

(provide 'kinc/graphics4/pipeline)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/pipeline
    :ctypes ((kinc_g4_pipeline_t #|TODO|#))

    :c-info (
      ((kinc_g4_blending_operation_t int) (KINC_G4_BLEND_ONE
                                           KINC_G4_BLEND_ZERO
                                           KINC_G4_BLEND_SOURCE_ALPHA
                                           KINC_G4_BLEND_DEST_ALPHA
                                           KINC_G4_BLEND_INV_SOURCE_ALPHA
                                           KINC_G4_BLEND_INV_DEST_ALPHA
                                           KINC_G4_BLEND_SOURCE_COLOR
                                           KINC_G4_BLEND_DEST_COLOR
                                           KINC_G4_BLEND_INV_SOURCE_COLOR
                                           KINC_G4_BLEND_INV_DEST_COLOR))

      ((kinc_g4_compare_mode_t int) (KINC_G4_COMPARE_ALWAYS
                                     KINC_G4_COMPARE_NEVER
                                     KINC_G4_COMPARE_EQUAL
                                     KINC_G4_COMPARE_NOT_EQUAL
                                     KINC_G4_COMPARE_LESS
                                     KINC_G4_COMPARE_LESS_EQUAL
                                     KINC_G4_COMPARE_GREATER
                                     KINC_G4_COMPARE_GREATER_EQUAL))

      ((kinc_g4_cull_mode_t int) (KINC_G4_CULL_CLOCKWISE
                                  KINC_G4_CULL_COUNTER_CLOCKWISE
                                  KINC_G4_CULL_NOTHING))

      ((kinc_g4_stencil_action_t int) (KINC_G4_STENCIL_KEEP
                                       KINC_G4_STENCIL_ZERO
                                       KINC_G4_STENCIL_REPLACE
                                       KINC_G4_STENCIL_INCREMENT
                                       KINC_G4_STENCIL_INCREMENT_WRAP
                                       KINC_G4_STENCIL_DECREMENT
                                       KINC_G4_STENCIL_DECREMENT_WRAP
                                       KINC_G4_STENCIL_INVERT))

;; void kinc_g4_pipeline_init (kinc_g4_pipeline_t *pipeline)
;; void kinc_g4_pipeline_destroy (kinc_g4_pipeline_t *pipeline)
;; void kinc_g4_pipeline_compile (kinc_g4_pipeline_t *pipeline)
;; kinc_g4_constant_location_t kinc_g4_pipeline_get_constant_location (kinc_g4_pipeline_t *pipeline, const char *name)
;; kinc_g4_texture_unit_t kinc_g4_pipeline_get_texture_unit (kinc_g4_pipeline_t *pipeline, const char *name)
;; void kinc_g4_internal_set_pipeline (kinc_g4_pipeline_t *pipeline)
;; void kinc_g4_internal_pipeline_set_defaults (kinc_g4_pipeline_t *pipeline)

    )
  )

(curlet))
