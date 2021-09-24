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

      ;; TODO: Functions requiring special C-object conversion
      (in-C "

static s7_pointer g_kinc_g4_render_target_init(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_render_target_init (kinc_g4_render_target_t *renderTarget, int width, int height, int depthBufferBits, bool antialiasing, kinc_g4_render_target_format_t format, int stencilBufferBits, int contextId)

}

static s7_pointer g_kinc_g4_render_target_init_cube(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_render_target_init_cube (kinc_g4_render_target_t *renderTarget, int cubeMapSize, int depthBufferBits, bool antialiasing, kinc_g4_render_target_format_t format, int stencilBufferBits, int contextId)

}

static s7_pointer g_kinc_g4_render_target_destroy(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_render_target_destroy (kinc_g4_render_target_t *renderTarget)

}

static s7_pointer g_kinc_g4_render_target_use_color_as_texture(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_render_target_use_color_as_texture (kinc_g4_render_target_t *renderTarget, kinc_g4_texture_unit_t unit)

}

static s7_pointer g_kinc_g4_render_target_use_depth_as_texture(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_render_target_use_depth_as_texture (kinc_g4_render_target_t *renderTarget, kinc_g4_texture_unit_t unit)

}

static s7_pointer g_kinc_g4_render_target_set_depth_stencil_from(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_render_target_set_depth_stencil_from (kinc_g4_render_target_t *renderTarget, kinc_g4_render_target_t *source)

}

static s7_pointer g_kinc_g4_render_target_get_pixels(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_render_target_get_pixels (kinc_g4_render_target_t *renderTarget, uint8_t *data)

}

static s7_pointer g_kinc_g4_render_target_generate_mipmaps(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_render_target_generate_mipmaps (kinc_g4_render_target_t *renderTarget, int levels)

}

") ;; end special C-object conversion

      (C-function ("kinc_g4_render_target_init" g_kinc_g4_render_target_init "void kinc_g4_render_target_init (kinc_g4_render_target_t *renderTarget, int width, int height, int depthBufferBits, bool antialiasing, kinc_g4_render_target_format_t format, int stencilBufferBits, int contextId)" 8))
      (C-function ("kinc_g4_render_target_init_cube" g_kinc_g4_render_target_init_cube "void kinc_g4_render_target_init_cube (kinc_g4_render_target_t *renderTarget, int cubeMapSize, int depthBufferBits, bool antialiasing, kinc_g4_render_target_format_t format, int stencilBufferBits, int contextId)" 7))
      (C-function ("kinc_g4_render_target_destroy" g_kinc_g4_render_target_destroy "void kinc_g4_render_target_destroy (kinc_g4_render_target_t *renderTarget)" 1))
      (C-function ("kinc_g4_render_target_use_color_as_texture" g_kinc_g4_render_target_use_color_as_texture "void kinc_g4_render_target_use_color_as_texture (kinc_g4_render_target_t *renderTarget, kinc_g4_texture_unit_t unit)" 2))
      (C-function ("kinc_g4_render_target_use_depth_as_texture" g_kinc_g4_render_target_use_depth_as_texture "void kinc_g4_render_target_use_depth_as_texture (kinc_g4_render_target_t *renderTarget, kinc_g4_texture_unit_t unit)" 2))
      (C-function ("kinc_g4_render_target_set_depth_stencil_from" g_kinc_g4_render_target_set_depth_stencil_from "void kinc_g4_render_target_set_depth_stencil_from (kinc_g4_render_target_t *renderTarget, kinc_g4_render_target_t *source)" 2))
      (C-function ("kinc_g4_render_target_get_pixels" g_kinc_g4_render_target_get_pixels "void kinc_g4_render_target_get_pixels (kinc_g4_render_target_t *renderTarget, uint8_t *data)" 2))
      (C-function ("kinc_g4_render_target_generate_mipmaps" g_kinc_g4_render_target_generate_mipmaps "void kinc_g4_render_target_generate_mipmaps (kinc_g4_render_target_t *renderTarget, int levels)" 2))
    )
  )

(curlet))
