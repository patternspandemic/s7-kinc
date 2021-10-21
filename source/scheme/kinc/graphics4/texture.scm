;;; TODO: texture.scm
;;;
;;; kinc/graphics4/texture.h

(provide 'kinc/graphics4/texture)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/texture
    :headers ("kinc/image.h")
    :ctypes ((:name kinc_g4_texture_t :destroy kinc_g4_texture_destroy
              :fields (
               (int tex_width 0)
               (int tex_height 0)
               (int tex_depth 0)
               ((enum kinc_image_format_t) format 0) ; KINC_IMAGE_FORMAT_RGBA32 = 0
               ;(kinc_g4_texture_impl_t impl) ; not needed
               )))

    :c-info (

      ;; TODO: Functions requiring special C-object conversion
      (in-C "

static s7_pointer g_kinc_g4_texture_init(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_texture_init (kinc_g4_texture_t *texture, int width, int height, kinc_image_format_t format)

}

static s7_pointer g_kinc_g4_texture_init3d(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_texture_init3d (kinc_g4_texture_t *texture, int width, int height, int depth, kinc_image_format_t format)

}

static s7_pointer g_kinc_g4_texture_init_from_image(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_texture_init_from_image (kinc_g4_texture_t *texture, kinc_image_t *image)

}

static s7_pointer g_kinc_g4_texture_init_from_image3d(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_texture_init_from_image3d (kinc_g4_texture_t *texture, kinc_image_t *image)

}

static s7_pointer g_kinc_g4_texture_destroy(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_texture_destroy (kinc_g4_texture_t *texture)

}

static s7_pointer g_kinc_g4_texture_lock(s7_scheme *sc, s7_pointer args) {
// unsigned char* kinc_g4_texture_lock (kinc_g4_texture_t *texture)

}

static s7_pointer g_kinc_g4_texture_unlock(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_texture_unlock (kinc_g4_texture_t *texture)

}

static s7_pointer g_kinc_g4_texture_clear(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_texture_clear (kinc_g4_texture_t *texture, int x, int y, int z, int width, int height, int depth, unsigned color)

}

static s7_pointer g_kinc_g4_texture_generate_mipmaps(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_texture_generate_mipmaps (kinc_g4_texture_t *texture, int levels)

}

static s7_pointer g_kinc_g4_texture_set_mipmap(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_texture_set_mipmap (kinc_g4_texture_t *texture, kinc_image_t *mipmap, int level)

}

static s7_pointer g_kinc_g4_texture_stride(s7_scheme *sc, s7_pointer args) {
// int kinc_g4_texture_stride (kinc_g4_texture_t *texture)

}


") ;; end special C-object conversion

      (C-function ("kinc_g4_texture_init" g_kinc_g4_texture_init "void kinc_g4_texture_init (kinc_g4_texture_t *texture, int width, int height, kinc_image_format_t format)" 4))
      (C-function ("kinc_g4_texture_init3d" g_kinc_g4_texture_init3d "void kinc_g4_texture_init3d (kinc_g4_texture_t *texture, int width, int height, int depth, kinc_image_format_t format)" 5))
      (C-function ("kinc_g4_texture_init_from_image" g_kinc_g4_texture_init_from_image "void kinc_g4_texture_init_from_image (kinc_g4_texture_t *texture, kinc_image_t *image)" 2))
      (C-function ("kinc_g4_texture_init_from_image3d" g_kinc_g4_texture_init_from_image3d "void kinc_g4_texture_init_from_image3d (kinc_g4_texture_t *texture, kinc_image_t *image)" 2))
      (C-function ("kinc_g4_texture_destroy" g_kinc_g4_texture_destroy "void kinc_g4_texture_destroy (kinc_g4_texture_t *texture)" 1))
      (C-function ("kinc_g4_texture_lock" g_kinc_g4_texture_lock "unsigned char* kinc_g4_texture_lock (kinc_g4_texture_t *texture)" 1))
      (C-function ("kinc_g4_texture_unlock" g_kinc_g4_texture_unlock "void kinc_g4_texture_unlock (kinc_g4_texture_t *texture)" 1))
      (C-function ("kinc_g4_texture_clear" g_kinc_g4_texture_clear "void kinc_g4_texture_clear (kinc_g4_texture_t *texture, int x, int y, int z, int width, int height, int depth, unsigned color)" 8))
      (C-function ("kinc_g4_texture_generate_mipmaps" g_kinc_g4_texture_generate_mipmaps "void kinc_g4_texture_generate_mipmaps (kinc_g4_texture_t *texture, int levels)" 2))
      (C-function ("kinc_g4_texture_set_mipmap" g_kinc_g4_texture_set_mipmap "void kinc_g4_texture_set_mipmap (kinc_g4_texture_t *texture, kinc_image_t *mipmap, int level)" 3))
      (C-function ("kinc_g4_texture_stride" g_kinc_g4_texture_stride "int kinc_g4_texture_stride (kinc_g4_texture_t *texture)" 1))
    )
  )

(curlet))
