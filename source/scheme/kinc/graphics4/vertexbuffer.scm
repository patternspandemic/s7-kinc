;;; TODO: vertexbuffer.scm
;;;
;;; kinc/graphics4/vertexbuffer.h

(provide 'kinc/graphics4/vertexbuffer)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/vertexbuffer
    :ctypes ((:name kinc_g4_vertex_buffer_t :destroy kinc_g4_vertex_buffer_destroy))

    :c-info (

;;   void kinc_g4_vertex_buffer_init (kinc_g4_vertex_buffer_t *buffer, int count, kinc_g4_vertex_structure_t *structure, kinc_g4_usage_t usage, int instance_data_step_rate)
;;   void kinc_g4_vertex_buffer_destroy (kinc_g4_vertex_buffer_t *buffer)
;; float* kinc_g4_vertex_buffer_lock_all (kinc_g4_vertex_buffer_t *buffer)
;; float* kinc_g4_vertex_buffer_lock (kinc_g4_vertex_buffer_t *buffer, int start, int count)
;;   void kinc_g4_vertex_buffer_unlock_all (kinc_g4_vertex_buffer_t *buffer)
;;   void kinc_g4_vertex_buffer_unlock (kinc_g4_vertex_buffer_t *buffer, int count)
;;    int kinc_g4_vertex_buffer_count (kinc_g4_vertex_buffer_t *buffer)
;;    int kinc_g4_vertex_buffer_stride (kinc_g4_vertex_buffer_t *buffer)
;;   void kinc_g4_set_vertex_buffers (kinc_g4_vertex_buffer_t **buffers, int count)
;;   void kinc_g4_set_vertex_buffer (kinc_g4_vertex_buffer_t *buffer)

      ;; TODO: Functions requiring special C-object conversion
      (in-C "

static s7_pointer g_kinc_g4_vertex_buffer_init(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_vertex_buffer_destroy(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_vertex_buffer_lock_all(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_vertex_buffer_lock(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_vertex_buffer_unlock_all(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_vertex_buffer_unlock(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_vertex_buffer_count(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_vertex_buffer_stride(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_vertex_buffers(s7_scheme *sc, s7_pointer args) {

}

static s7_pointer g_kinc_g4_set_vertex_buffer(s7_scheme *sc, s7_pointer args) {

}

") ;; end special C-object conversion

      (C-function ("kinc_g4_vertex_buffer_init" g_kinc_g4_vertex_buffer_init "void kinc_g4_vertex_buffer_init (kinc_g4_vertex_buffer_t *buffer, int count, kinc_g4_vertex_structure_t *structure, kinc_g4_usage_t usage, int instance_data_step_rate)" 5))
      (C-function ("kinc_g4_vertex_buffer_destroy" g_kinc_g4_vertex_buffer_destroy "void kinc_g4_vertex_buffer_destroy (kinc_g4_vertex_buffer_t *buffer)" 1))
      (C-function ("kinc_g4_vertex_buffer_lock_all" g_kinc_g4_vertex_buffer_lock_all "float* kinc_g4_vertex_buffer_lock_all (kinc_g4_vertex_buffer_t *buffer)" 1))
      (C-function ("kinc_g4_vertex_buffer_lock" g_kinc_g4_vertex_buffer_lock "float* kinc_g4_vertex_buffer_lock (kinc_g4_vertex_buffer_t *buffer, int start, int count)" 3))
      (C-function ("kinc_g4_vertex_buffer_unlock_all" g_kinc_g4_vertex_buffer_unlock_all "void kinc_g4_vertex_buffer_unlock_all (kinc_g4_vertex_buffer_t *buffer)" 1))
      (C-function ("kinc_g4_vertex_buffer_unlock" g_kinc_g4_vertex_buffer_unlock "void kinc_g4_vertex_buffer_unlock (kinc_g4_vertex_buffer_t *buffer, int count)" 2))
      (C-function ("kinc_g4_vertex_buffer_count" g_kinc_g4_vertex_buffer_count "int kinc_g4_vertex_buffer_count (kinc_g4_vertex_buffer_t *buffer)" 1))
      (C-function ("kinc_g4_vertex_buffer_stride" g_kinc_g4_vertex_buffer_stride "int kinc_g4_vertex_buffer_stride (kinc_g4_vertex_buffer_t *buffer)" 1))
      (C-function ("kinc_g4_set_vertex_buffers" g_kinc_g4_set_vertex_buffers "void kinc_g4_set_vertex_buffers (kinc_g4_vertex_buffer_t **buffers, int count)" 2))
      (C-function ("kinc_g4_set_vertex_buffer" g_kinc_g4_set_vertex_buffer "void kinc_g4_set_vertex_buffer (kinc_g4_vertex_buffer_t *buffer)" 1))
    )
  )

(curlet))

#|

(kinc_g4_vertex_buffer_init vbuffer 3 vstructure KINC_G4_USAGE_STATIC 0)
(with-g4-vertex-buffer vbuffer
  (set! V #r(-1 -1 .5
              1 -1 .5
             -1  1 .5)))

|#
