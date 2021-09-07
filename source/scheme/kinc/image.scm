;;; TODO: image.scm
;;;
;;; kinc/image.h

(provide 'kinc/image)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc image
    :ctypes '((kinc_image_t
               (int width)
               (int height)
               (int depth)
               (kinc_image_format_t format)
               (unsigned internal_format)
               (kinc_image_compression_t compression)
               (void* data)
               (int data_size))

              ;; TODO: Probably just use 'in-C'
              ;; (kinc_image_read_callbacks_t
              ;; //int(* read )(void *user_data, void *data, size_t size)
              ;; //void(* seek )(void *user_data, int pos)
              ;; //int(* pos )(void *user_data)
              ;; //size_t(* size )(void *user_data)
              ;; )
              )

    :c-info '(
      (int (KINC_IMAGE_COMPRESSION_NONE
            KINC_IMAGE_COMPRESSION_DXT5
            KINC_IMAGE_COMPRESSION_ASTC
            KINC_IMAGE_COMPRESSION_PVRTC))

      (int (KINC_IMAGE_FORMAT_RGBA32
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

      ;; TODO: Special functions
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
    )
  )

(curlet))
