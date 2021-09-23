;;; TODO: indexbuffer.scm
;;;
;;; kinc/graphics4/indexbuffer.h

(provide 'kinc/graphics4/indexbuffer)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/indexbuffer
    :ctypes ((kinc_g4_index_buffer_t))

    :c-info (
      ((kinc_g4_index_buffer_format_t int) (KINC_G4_INDEX_BUFFER_FORMAT_32BIT
                                            KINC_G4_INDEX_BUFFER_FORMAT_16BIT))

;; void kinc_g4_index_buffer_init (kinc_g4_index_buffer_t *buffer, int count, kinc_g4_index_buffer_format_t format, kinc_g4_usage_t usage)
;; void kinc_g4_index_buffer_destroy (kinc_g4_index_buffer_t *buffer)
;; int* kinc_g4_index_buffer_lock (kinc_g4_index_buffer_t *buffer)
;; void kinc_g4_index_buffer_unlock (kinc_g4_index_buffer_t *buffer)
;; int kinc_g4_index_buffer_count (kinc_g4_index_buffer_t *buffer)
;; void kinc_g4_set_index_buffer (kinc_g4_index_buffer_t *buffer)

    )
  )

(curlet))
