;;; TODO: pipeline.scm
;;;
;;; kinc/graphics4/pipeline.h

(provide 'kinc/graphics4/pipeline)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/pipeline
    :ctypes ((:name kinc_g4_pipeline_t :destroy kinc_g4_pipeline_destroy
              :fields (
               ;((struct kinc_g4_vertex_structure_t*) input_layout [16]) ; FIXME
               ((struct kinc_g4_shader_t*) vertex_shader (c-pointer 0)) ; FIXME
               ((struct kinc_g4_shader_t*) fragment_shader (c-pointer 0)) ; FIXME
               ((struct kinc_g4_shader_t*) geometry_shader (c-pointer 0)) ; FIXME
               ((struct kinc_g4_shader_t*) tessellation_control_shader (c-pointer 0)) ; FIXME
               ((struct kinc_g4_shader_t*) tessellation_evaluation_shader (c-pointer 0)) ; FIXME
               ((enum kinc_g4_cull_mode_t) cull_mode 2) ; KINC_G4_CULL_NOTHING = 2
               (bool depth_write #f)
               ((enum kinc_g4_compare_mode_t) depth_mode 0) ; KINC_G4_COMPARE_ALWAYS = 0
               ((enum kinc_g4_compare_mode_t) stencil_mode 0) ; KINC_G4_COMPARE_ALWAYS = 0
               ((enum kinc_g4_stencil_action_t) stencil_both_pass 0) ; KINC_G4_STENCIL_KEEP = 0
               ((enum kinc_g4_stencil_action_t) stencil_depth_fail 0) ; KINC_G4_STENCIL_KEEP = 0
               ((enum kinc_g4_stencil_action_t) stencil_fail 0) ; KINC_G4_STENCIL_KEEP = 0
               (int stencil_reference_value 0)
               (int stencil_read_mask #xff)
               (int stencil_write_mask #xff)
               ((enum kinc_g4_blending_operation_t) blend_source 0) ; KINC_G4_BLEND_ONE = 0
               ((enum kinc_g4_blending_operation_t) blend_destination 1) ;KINC_G4_BLEND_ZERO = 1
               ((enum kinc_g4_blending_operation_t) alpha_blend_source 0) ; KINC_G4_BLEND_ONE = 0
               ((enum kinc_g4_blending_operation_t) alpha_blend_destination 1) ; KINC_G4_BLEND_ZERO = 1
               (bool color_write_mask_red [8]) ; FIXME
               (bool color_write_mask_green [8]) ; FIXME
               (bool color_write_mask_blue [8]) ; FIXME
               (bool color_write_mask_alpha [8]) ; FIXME
               (int color_attachment_count 1)
               ((enum kinc_g4_render_target_format_t) color_attachment [8]) ; FIXME
               (int depth_attachment_bits 0)
               (int stencil_attachment_bits 0)
               (bool conservative_rasterization #f)
               ;(kinc_g4_pipeline_impl_t impl) ; not neede
               )))

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

      ;; TODO: Functions requiring special C-object conversion
      (in-C "

static s7_pointer g_kinc_g4_pipeline_init(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_pipeline_init (kinc_g4_pipeline_t *pipeline)

}

static s7_pointer g_kinc_g4_pipeline_destroy(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_pipeline_destroy (kinc_g4_pipeline_t *pipeline)

}

static s7_pointer g_kinc_g4_pipeline_compile(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_pipeline_compile (kinc_g4_pipeline_t *pipeline)

}

static s7_pointer g_kinc_g4_pipeline_get_constant_location(s7_scheme *sc, s7_pointer args) {
// kinc_g4_constant_location_t kinc_g4_pipeline_get_constant_location (kinc_g4_pipeline_t *pipeline, const char *name)

}

static s7_pointer g_kinc_g4_pipeline_get_texture_unit(s7_scheme *sc, s7_pointer args) {
// kinc_g4_texture_unit_t kinc_g4_pipeline_get_texture_unit (kinc_g4_pipeline_t *pipeline, const char *name)

}

static s7_pointer g_kinc_g4_internal_set_pipeline(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_internal_set_pipeline (kinc_g4_pipeline_t *pipeline)

}

static s7_pointer g_kinc_g4_internal_pipeline_set_defaults(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_internal_pipeline_set_defaults (kinc_g4_pipeline_t *pipeline)

}

") ;; end special C-object conversion

      (C-function ("kinc_g4_pipeline_init" g_kinc_g4_pipeline_init "void kinc_g4_pipeline_init (kinc_g4_pipeline_t *pipeline)" 1))
      (C-function ("kinc_g4_pipeline_destroy" g_kinc_g4_pipeline_destroy "void kinc_g4_pipeline_destroy (kinc_g4_pipeline_t *pipeline)" 1))
      (C-function ("kinc_g4_pipeline_compile" g_kinc_g4_pipeline_compile "void kinc_g4_pipeline_compile (kinc_g4_pipeline_t *pipeline)" 1))
      (C-function ("kinc_g4_pipeline_get_constant_location" g_kinc_g4_pipeline_get_constant_location "kinc_g4_constant_location_t kinc_g4_pipeline_get_constant_location (kinc_g4_pipeline_t *pipeline, const char *name)" 2))
      (C-function ("kinc_g4_pipeline_get_texture_unit" g_kinc_g4_pipeline_get_texture_unit "kinc_g4_texture_unit_t kinc_g4_pipeline_get_texture_unit (kinc_g4_pipeline_t *pipeline, const char *name)" 2))
      (C-function ("kinc_g4_internal_set_pipeline" g_kinc_g4_internal_set_pipeline "void kinc_g4_internal_set_pipeline (kinc_g4_pipeline_t *pipeline)" 1))
      (C-function ("kinc_g4_internal_pipeline_set_defaults" g_kinc_g4_internal_pipeline_set_defaults "void kinc_g4_internal_pipeline_set_defaults (kinc_g4_pipeline_t *pipeline)" 1))
    )
  )

(curlet))
