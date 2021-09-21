;;; TODO: graphics4.scm
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
;      (void kinc_g4_set_texture_addressing ((symbol "struct kinc_g4_texture_unit") (kinc_g4_texture_direction_t int) (kinc_g4_texture_addressing_t int)))
;      (void kinc_g4_set_texture3d_addressing ((symbol "struct kinc_g4_texture_unit") (kinc_g4_texture_direction_t int) (kinc_g4_texture_addressing_t int)))
;      (void kinc_g4_set_pipeline ((symbol "struct kinc_g4_pipeline*")))
      (void kinc_g4_set_stencil_reference_value (int))
      (void kinc_g4_set_texture_operation ((kinc_g4_texture_operation_t int) (kinc_g4_texture_argument_t int) (kinc_g4_texture_argument_t int)))
;      (void kinc_g4_set_int ((symbol "struct kinc_g4_constant_location") int))
;      (void kinc_g4_set_int2 ((symbol "struct kinc_g4_constant_location") int int))
;      (void kinc_g4_set_int3 ((symbol "struct kinc_g4_constant_location") int int int))
;      (void kinc_g4_set_int4 ((symbol "struct kinc_g4_constant_location") int int int int))
;      (void kinc_g4_set_ints ((symbol "struct kinc_g4_constant_location") int* int))
;      (void kinc_g4_set_float ((symbol "struct kinc_g4_constant_location") float))
;      (void kinc_g4_set_float2 ((symbol "struct kinc_g4_constant_location") float float))
;      (void kinc_g4_set_float3 ((symbol "struct kinc_g4_constant_location") float float float))
;      (void kinc_g4_set_float4 ((symbol "struct kinc_g4_constant_location") float float float float))
;      (void kinc_g4_set_floats ((symbol "struct kinc_g4_constant_location") float* int))
;      (void kinc_g4_set_bool ((symbol "struct kinc_g4_constant_location") bool))
;      (void kinc_g4_set_matrix3 ((symbol "struct kinc_g4_constant_location") kinc_matrix3x3_t*))
;      (void kinc_g4_set_matrix4 ((symbol "struct kinc_g4_constant_location") kinc_matrix4x4_t*))
;      (void kinc_g4_set_texture_magnification_filter ((symbol "struct kinc_g4_texture_unit") kinc_g4_texture_filter_t))
;      (void kinc_g4_set_texture3d_magnification_filter ((symbol "struct kinc_g4_texture_unit") kinc_g4_texture_filter_t))
;      (void kinc_g4_set_texture_minification_filter ((symbol "struct kinc_g4_texture_unit") kinc_g4_texture_filter_t))
;      (void kinc_g4_set_texture3d_minification_filter ((symbol "struct kinc_g4_texture_unit") kinc_g4_texture_filter_t))
;      (void kinc_g4_set_texture_mipmap_filter ((symbol "struct kinc_g4_texture_unit") kinc_g4_mipmap_filter_t))
;      (void kinc_g4_set_texture3d_mipmap_filter ((symbol "struct kinc_g4_texture_unit") kinc_g4_mipmap_filter_t))
;      (void kinc_g4_set_texture_compare_mode ((symbol "struct kinc_g4_texture_unit") bool))
;      (void kinc_g4_set_cubemap_compare_mode ((symbol "struct kinc_g4_texture_unit") bool))
       (int kinc_g4_max_bound_textures (void))
      (bool kinc_g4_render_targets_inverted_y (void))
      (bool kinc_g4_non_pow2_textures_supported (void))
      (void kinc_g4_restore_render_target (void))
;      (void kinc_g4_set_render_targets ((symbol "struct kinc_g4_render_target**") int))
;      (void kinc_g4_set_render_target_face ((symbol "struct kinc_g4_render_target*") int))
;      (void kinc_g4_set_texture ((symbol "struct kinc_g4_texture_unit") (symbol "struct kinc_g4_texture*")))
;      (void kinc_g4_set_image_texture ((symbol "struct kinc_g4_texture_unit") (symbol "struct kinc_g4_texture *")))
      (bool kinc_g4_init_occlusion_query (int*))
      (void kinc_g4_delete_occlusion_query (int))
      ;; (void kinc_g4_start_occlusion_query (int)) ; NOTE: Only for Direct3D
      ;; (void kinc_g4_end_occlusion_query (int)) ; NOTE: Only for Direct3D
      (bool kinc_g4_are_query_results_available (int))
      (void kinc_g4_get_query_results (int int*))
;      (void kinc_g4_set_texture_array ((symbol "struct kinc_g4_texture_unit") (symbol "struct kinc_g4_texture_array*")))
       (int kinc_g4_antialiasing_samples (void))
      (void kinc_g4_set_antialiasing_samples (int))

    )
  )

(curlet))
