;;; TODO: vertexbuffer.scm
;;;
;;; kinc/graphics4/vertexbuffer.h

(provide 'kinc/graphics4/vertexbuffer)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/vertexbuffer
    :ctypes ((kinc_g4_vertex_buffer_t))

    :c-info (

;; void kinc_g4_vertex_buffer_init (kinc_g4_vertex_buffer_t *buffer, int count, kinc_g4_vertex_structure_t *structure, kinc_g4_usage_t usage, int instance_data_step_rate)
;; void kinc_g4_vertex_buffer_destroy (kinc_g4_vertex_buffer_t *buffer)
;; float* kinc_g4_vertex_buffer_lock_all (kinc_g4_vertex_buffer_t *buffer)
;; float* kinc_g4_vertex_buffer_lock (kinc_g4_vertex_buffer_t *buffer, int start, int count)
;; void kinc_g4_vertex_buffer_unlock_all (kinc_g4_vertex_buffer_t *buffer)
;; void kinc_g4_vertex_buffer_unlock (kinc_g4_vertex_buffer_t *buffer, int count)
;; int kinc_g4_vertex_buffer_count (kinc_g4_vertex_buffer_t *buffer)
;; int kinc_g4_vertex_buffer_stride (kinc_g4_vertex_buffer_t *buffer)
;; void kinc_g4_set_vertex_buffers (kinc_g4_vertex_buffer_t **buffers, int count)
;; void kinc_g4_set_vertex_buffer (kinc_g4_vertex_buffer_t *buffer)

    )
  )

(curlet))
