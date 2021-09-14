;;; TODO: image.scm
;;;
;;; kinc/image.h

(provide 'kinc/image)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc image
    :ctypes ((kinc_image_t
              (int width)
              (int height)
              (int depth)
              ((enum kinc_image_format_t) format)
              (unsigned internal_format)
              ((enum kinc_image_compression_t) compression)
              (void* data)
              (int data_size))

              ;; TODO: Probably just use 'in-C'
             ;; (kinc_image_read_callbacks_t
             ;;  //int(* read )(void *user_data, void *data, size_t size)
             ;;  //void(* seek )(void *user_data, int pos)
             ;;  //int(* pos )(void *user_data)
             ;;  //size_t(* size )(void *user_data)
             ;;  )
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

      ;; Functions requiring special C-object conversion
;;       (in-C "
;;       ;; TODO: Special functions

;; static s7_pointer g_(s7_scheme *sc, s7_pointer args) {

;; }

;; ") ;; end special C-object conversion

        ;(size_t kinc_image_init (kinc_image_t* void* int int kinc_image_format_t))
        ;(size_t kinc_image_init3d (kinc_image_t* void* int int int kinc_image_format_t))
        ;(size_t kinc_image_size_from_callbacks (kinc_image_read_callbacks_t void* char*))
        ;(size_t kinc_image_init_from_file (kinc_image_t* void* char*))
        ;(size_t kinc_image_init_from_callbacks (kinc_image_t* void* kinc_image_read_callbacks_t void* char*))
        ;(size_t kinc_image_init_from_encoded_bytes (kinc_image_t* void* void* size_t char*))
          ;(void kinc_image_init_from_bytes (kinc_image_t* void* int int kinc_image_format_t))
          ;(void kinc_image_init_from_bytes3d (kinc_image_t* void* int int int kinc_image_format_t))
          ;(void kinc_image_destroy (kinc_image_t*))
      ;(uint32_t kinc_image_at (kinc_image_t* int int))
      ;(uint8_t* kinc_image_get_pixels (kinc_image_t*))

      ;; (C-function ("kinc_image_init" g_kinc_image_init "size_t kinc_image_init()"))
      ;; (C-function ("kinc_image_init3d" g_kinc_image_init3d "size_t kinc_image_init3d()"))
      ;; (C-function ("kinc_image_size_from_callbacks" g_kinc_image_size_from_callbacks "size_t kinc_image_size_from_callbacks()"))
      ;; (C-function ("kinc_image_init_from_file" g_kinc_image_init_from_file "size_t kinc_image_init_from_file()"))
      ;; (C-function ("kinc_image_init_from_callbacks" g_kinc_image_init_from_callbacks "size_t kinc_image_init_from_callbacks()"))
      ;; (C-function ("kinc_image_init_from_encoded_bytes" g_kinc_image_init_from_encoded_bytes "size_t kinc_image_init_from_encoded_bytes()"))
      ;; (C-function ("kinc_image_init_from_bytes" g_kinc_image_init_from_bytes "void kinc_image_init_from_bytes()"))
      ;; (C-function ("kinc_image_init_from_bytes3d" g_kinc_image_init_from_bytes3d "void kinc_image_init_from_bytes3d()"))
      ;; (C-function ("kinc_image_destroy" g_kinc_image_destroy "void kinc_image_destroy()"))
      ;; (C-function ("kinc_image_at" g_kinc_image_at "uint32_t kinc_image_at()"))
      ;; (C-function ("kinc_image_get_pixels" g_kinc_image_get_pixels "uint8_t* kinc_image_get_pixels()"))
    )
  )

(curlet))
