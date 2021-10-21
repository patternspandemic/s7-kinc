;;; TODO: image.scm
;;;
;;; kinc/image.h

(provide 'kinc/image)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc image
    :ctypes ((:name kinc_image_t
              :fields (
               (int width 0)
               (int height 0)
               (int depth 0)
               ((enum kinc_image_format_t) format 0)
               (unsigned internal_format 0)
               ((enum kinc_image_compression_t) compression 0)
               (void* data (c-pointer 0))
               (int data_size 0)))

              ;; TODO: Probably just use local 'in-C', or implement scheme side?
             ;; (:name kinc_image_read_callbacks_t
             ;;  :fields (
             ;;  //int(* read )(void *user_data, void *data, size_t size)
             ;;  //void(* seek )(void *user_data, int pos)
             ;;  //int(* pos )(void *user_data)
             ;;  //size_t(* size )(void *user_data)
             ;;  ))
            )

    :c-info (
      ((kinc_image_compression_t int) (KINC_IMAGE_COMPRESSION_NONE
                                       KINC_IMAGE_COMPRESSION_DXT5
                                       KINC_IMAGE_COMPRESSION_ASTC
                                       KINC_IMAGE_COMPRESSION_PVRTC))

      ((kinc_image_format_t int) (KINC_IMAGE_FORMAT_RGBA32
                                  KINC_IMAGE_FORMAT_GREY8
                                  KINC_IMAGE_FORMAT_RGB24
                                  KINC_IMAGE_FORMAT_RGBA128
                                  KINC_IMAGE_FORMAT_RGBA64
                                  KINC_IMAGE_FORMAT_A32
                                  KINC_IMAGE_FORMAT_BGRA32
                                  KINC_IMAGE_FORMAT_A16))

      (size_t kinc_image_size_from_file (char*))
      (size_t kinc_image_size_from_encoded_bytes (void* size_t char*))
         (int kinc_image_format_sizeof ((kinc_image_format_t int)))

      ;; TODO: Functions requiring special C-object conversion
      (in-C "
/*
static s7_pointer g_kinc_image_size_from_callbacks(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_image_init_from_callbacks(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_image_init_from_bytes(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_image_destroy(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_image_at(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_image_init_from_bytes3d(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_image_init_from_encoded_bytes(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_image_init_from_file(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_image_init3d(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_image_init(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_image_get_pixels(s7_scheme *sc, s7_pointer args) {

}
*/
") ;; end special C-object conversion

      ;; (C-function ("kinc_image_init" g_kinc_image_init "size_t kinc_image_init (kinc_image_t *image, void *memory, int width, int height, kinc_image_format_t format)" 5))
      ;; (C-function ("kinc_image_init3d" g_kinc_image_init3d "size_t kinc_image_init3d (kinc_image_t *image, void *memory, int width, int height, int depth, kinc_image_format_t format)" 6))
      ;; ;; (C-function ("kinc_image_size_from_callbacks" g_kinc_image_size_from_callbacks "size_t kinc_image_size_from_callbacks (kinc_image_read_callbacks_t callbacks, void *user_data, const char *format)" 3))
      ;; (C-function ("kinc_image_init_from_file" g_kinc_image_init_from_file "size_t kinc_image_init_from_file (kinc_image_t *image, void *memory, const char *filename)" 3))
      ;; ;; (C-function ("kinc_image_init_from_callbacks" g_kinc_image_init_from_callbacks "size_t kinc_image_init_from_callbacks (kinc_image_t *image, void *memory, kinc_image_read_callbacks_t callbacks, void *user_data, const char *format)" 5))
      ;; (C-function ("kinc_image_init_from_encoded_bytes" g_kinc_image_init_from_encoded_bytes "size_t kinc_image_init_from_encoded_bytes (kinc_image_t *image, void *memory, void *data, size_t data_size, const char *format)" 5))
      ;; (C-function ("kinc_image_init_from_bytes" g_kinc_image_init_from_bytes "void kinc_image_init_from_bytes (kinc_image_t *image, void *data, int width, int height, kinc_image_format_t format)" 5))
      ;; (C-function ("kinc_image_init_from_bytes3d" g_kinc_image_init_from_bytes3d "void kinc_image_init_from_bytes3d (kinc_image_t *image, void *data, int width, int height, int depth, kinc_image_format_t format)" 6))
      ;; (C-function ("kinc_image_destroy" g_kinc_image_destroy "void kinc_image_destroy (kinc_image_t *image)" 1))
      ;; (C-function ("kinc_image_at" g_kinc_image_at "uint32_t kinc_image_at (kinc_image_t *image, int x, int y)" 3))
      ;; (C-function ("kinc_image_get_pixels" g_kinc_image_get_pixels "uint8_t * kinc_image_get_pixels (kinc_image_t *image)" 1))
    )
  )

(curlet))
