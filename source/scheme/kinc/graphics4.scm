;;; TODO: graphics4.scm
;;;
;;; kinc/graphics4/graphics.h

(provide 'kinc/graphics4)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/graphics
    :headers ("kinc/graphics4/pipeline.h"
              "kinc/graphics4/rendertarget.h"
              "kinc/graphics4/textureunit.h"
              "kinc/graphics4/texture.h"
              "kinc/graphics4/texturearray.h")

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

      (void kinc_g4_init (int int int bool))
      (void kinc_g4_destroy (int))
      (void kinc_g4_flush (void))
      (void kinc_g4_begin (int))
      (void kinc_g4_end (int))
      (bool kinc_g4_swap_buffers (void))
      (void kinc_g4_clear (uint32_t uint32_t float int))
      (void kinc_g4_viewport (int int int int))
      (void kinc_g4_scissor (int int int int))
      (void kinc_g4_disable_scissor (void))
      (void kinc_g4_draw_indexed_vertices (void))
      (void kinc_g4_draw_indexed_vertices_from_to (int int))
      (void kinc_g4_draw_indexed_vertices_from_to_from (int int int))
      (void kinc_g4_draw_indexed_vertices_instanced (int))
      (void kinc_g4_draw_indexed_vertices_instanced_from_to (int int int))
      (void kinc_g4_set_stencil_reference_value (int))
      (void kinc_g4_set_texture_operation ((kinc_g4_texture_operation_t int) (kinc_g4_texture_argument_t int) (kinc_g4_texture_argument_t int)))
       (int kinc_g4_max_bound_textures (void))
      (bool kinc_g4_render_targets_inverted_y (void))
      (bool kinc_g4_non_pow2_textures_supported (void))
      (void kinc_g4_restore_render_target (void))
      (bool kinc_g4_init_occlusion_query (int*))
      (void kinc_g4_delete_occlusion_query (int))
      ;; (void kinc_g4_start_occlusion_query (int)) ; NOTE: Only for Direct3D
      ;; (void kinc_g4_end_occlusion_query (int)) ; NOTE: Only for Direct3D
      (bool kinc_g4_are_query_results_available (int))
      (void kinc_g4_get_query_results (int int*))
       (int kinc_g4_antialiasing_samples (void))
      (void kinc_g4_set_antialiasing_samples (int))

      ;; TODO: Functions requiring special C-object conversion
      (in-C "
/*
static s7_pointer g_kinc_g4_set_pipeline(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_int2(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_int4(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_float(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_float3(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_floats(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_matrix3(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_texture_magnification_filter(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_texture_minification_filter(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_texture_mipmap_filter(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_texture_compare_mode(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_render_targets(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_texture(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_image_texture(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_render_target_face(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_cubemap_compare_mode(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_texture3d_mipmap_filter(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_texture3d_minification_filter(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_texture3d_magnification_filter(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_matrix4(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_bool(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_float4(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_float2(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_ints(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_int3(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_int(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_texture3d_addressing(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_texture_addressing(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_texture_array(s7_scheme *sc, s7_pointer args) {

}
*/
") ;; end special C-object conversion

      ;; (C-function ("kinc_g4_set_texture_addressing" g_kinc_g4_set_texture_addressing "void kinc_g4_set_texture_addressing (kinc_g4_texture_unit_t unit, kinc_g4_texture_direction_t dir, kinc_g4_texture_addressing_t addressing)" 3))
      ;; (C-function ("kinc_g4_set_texture3d_addressing" g_kinc_g4_set_texture3d_addressing "void kinc_g4_set_texture3d_addressing (kinc_g4_texture_unit_t unit, kinc_g4_texture_direction_t dir, kinc_g4_texture_addressing_t addressing)" 3))
      ;; (C-function ("kinc_g4_set_pipeline" g_kinc_g4_set_pipeline "void kinc_g4_set_pipeline (struct kinc_g4_pipeline *pipeline)" 1))
      ;; (C-function ("kinc_g4_set_int" g_kinc_g4_set_int "void kinc_g4_set_int (kinc_g4_constant_location_t location, int value)" 2))
      ;; (C-function ("kinc_g4_set_int2" g_kinc_g4_set_int2 "void kinc_g4_set_int2 (kinc_g4_constant_location_t location, int value1, int value2)" 3))
      ;; (C-function ("kinc_g4_set_int3" g_kinc_g4_set_int3 "void kinc_g4_set_int3 (kinc_g4_constant_location_t location, int value1, int value2, int value3)" 4))
      ;; (C-function ("kinc_g4_set_int4" g_kinc_g4_set_int4 "void kinc_g4_set_int4 (kinc_g4_constant_location_t location, int value1, int value2, int value3, int value4)" 5))
      ;; (C-function ("kinc_g4_set_ints" g_kinc_g4_set_ints "void kinc_g4_set_ints (kinc_g4_constant_location_t location, int *values, int count)" 3))
      ;; (C-function ("kinc_g4_set_float" g_kinc_g4_set_float "void kinc_g4_set_float (kinc_g4_constant_location_t location, float value)" 2))
      ;; (C-function ("kinc_g4_set_float2" g_kinc_g4_set_float2 "void kinc_g4_set_float2 (kinc_g4_constant_location_t location, float value1, float value2)" 3))
      ;; (C-function ("kinc_g4_set_float3" g_kinc_g4_set_float3 "void kinc_g4_set_float3 (kinc_g4_constant_location_t location, float value1, float value2, float value3)" 4))
      ;; (C-function ("kinc_g4_set_float4" g_kinc_g4_set_float4 "void kinc_g4_set_float4 (kinc_g4_constant_location_t location, float value1, float value2, float value3, float value4)" 5))
      ;; (C-function ("kinc_g4_set_floats" g_kinc_g4_set_floats "void kinc_g4_set_floats (kinc_g4_constant_location_t location, float *values, int count)" 3))
      ;; (C-function ("kinc_g4_set_bool" g_kinc_g4_set_bool "void kinc_g4_set_bool (kinc_g4_constant_location_t location, bool value)" 2))
      ;; (C-function ("kinc_g4_set_matrix3" g_kinc_g4_set_matrix3 "void kinc_g4_set_matrix3 (kinc_g4_constant_location_t location, kinc_matrix3x3_t *value)" 2))
      ;; (C-function ("kinc_g4_set_matrix4" g_kinc_g4_set_matrix4 "void kinc_g4_set_matrix4 (kinc_g4_constant_location_t location, kinc_matrix4x4_t *value)" 2))
      ;; (C-function ("kinc_g4_set_texture_magnification_filter" g_kinc_g4_set_texture_magnification_filter "void kinc_g4_set_texture_magnification_filter (kinc_g4_texture_unit_t unit, kinc_g4_texture_filter_t filter)" 2))
      ;; (C-function ("kinc_g4_set_texture3d_magnification_filter" g_kinc_g4_set_texture3d_magnification_filter "void kinc_g4_set_texture3d_magnification_filter (kinc_g4_texture_unit_t texunit, kinc_g4_texture_filter_t filter)" 2))
      ;; (C-function ("kinc_g4_set_texture_minification_filter" g_kinc_g4_set_texture_minification_filter "void kinc_g4_set_texture_minification_filter (kinc_g4_texture_unit_t unit, kinc_g4_texture_filter_t filter)" 2))
      ;; (C-function ("kinc_g4_set_texture3d_minification_filter" g_kinc_g4_set_texture3d_minification_filter "void kinc_g4_set_texture3d_minification_filter (kinc_g4_texture_unit_t texunit, kinc_g4_texture_filter_t filter)" 2))
      ;; (C-function ("kinc_g4_set_texture_mipmap_filter" g_kinc_g4_set_texture_mipmap_filter "void kinc_g4_set_texture_mipmap_filter (kinc_g4_texture_unit_t unit, kinc_g4_mipmap_filter_t filter)" 2))
      ;; (C-function ("kinc_g4_set_texture3d_mipmap_filter" g_kinc_g4_set_texture3d_mipmap_filter "void kinc_g4_set_texture3d_mipmap_filter (kinc_g4_texture_unit_t texunit, kinc_g4_mipmap_filter_t filter)" 2))
      ;; (C-function ("kinc_g4_set_texture_compare_mode" g_kinc_g4_set_texture_compare_mode "void kinc_g4_set_texture_compare_mode (kinc_g4_texture_unit_t unit, bool enabled)" 2))
      ;; (C-function ("kinc_g4_set_cubemap_compare_mode" g_kinc_g4_set_cubemap_compare_mode "void kinc_g4_set_cubemap_compare_mode (kinc_g4_texture_unit_t unit, bool enabled)" 2))
      ;; (C-function ("kinc_g4_set_render_targets" g_kinc_g4_set_render_targets "void kinc_g4_set_render_targets (struct kinc_g4_render_target **targets, int count)" 2))
      ;; (C-function ("kinc_g4_set_render_target_face" g_kinc_g4_set_render_target_face "void kinc_g4_set_render_target_face (struct kinc_g4_render_target *texture, int face)" 2))
      ;; (C-function ("kinc_g4_set_texture" g_kinc_g4_set_texture "void kinc_g4_set_texture (kinc_g4_texture_unit_t unit, struct kinc_g4_texture *texture)" 2))
      ;; (C-function ("kinc_g4_set_image_texture" g_kinc_g4_set_image_texture "void kinc_g4_set_image_texture (kinc_g4_texture_unit_t unit, struct kinc_g4_texture *texture)" 2))
      ;; (C-function ("kinc_g4_set_texture_array" g_kinc_g4_set_texture_array "void kinc_g4_set_texture_array (kinc_g4_texture_unit_t unit, struct kinc_g4_texture_array *array)" 2))
    )
  )

(curlet))
