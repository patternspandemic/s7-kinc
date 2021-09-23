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

      ;; TODO: Functions requiring special C-object conversion
      (in-C "

static s7_pointer g_kinc_g4_index_buffer_init(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_index_buffer_init (kinc_g4_index_buffer_t *buffer, int count, kinc_g4_index_buffer_format_t format, kinc_g4_usage_t usage)

}

static s7_pointer g_kinc_g4_index_buffer_destroy(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_index_buffer_destroy (kinc_g4_index_buffer_t *buffer)

}

static s7_pointer g_kinc_g4_index_buffer_lock(s7_scheme *sc, s7_pointer args) {
// int* kinc_g4_index_buffer_lock (kinc_g4_index_buffer_t *buffer)

}

static s7_pointer g_kinc_g4_index_buffer_unlock(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_index_buffer_unlock (kinc_g4_index_buffer_t *buffer)

}

static s7_pointer g_kinc_g4_index_buffer_count(s7_scheme *sc, s7_pointer args) {
//  int kinc_g4_index_buffer_count (kinc_g4_index_buffer_t *buffer)

}

static s7_pointer g_kinc_g4_set_index_buffer(s7_scheme *sc, s7_pointer args) {
// void kinc_g4_set_index_buffer (kinc_g4_index_buffer_t *buffer)

}

") ;; end special C-object conversion

      (C-function ("kinc_g4_index_buffer_init" g_kinc_g4_index_buffer_init "void kinc_g4_index_buffer_init (kinc_g4_index_buffer_t *buffer, int count, kinc_g4_index_buffer_format_t format, kinc_g4_usage_t usage)" 4))
      (C-function ("kinc_g4_index_buffer_destroy" g_kinc_g4_index_buffer_destroy "void kinc_g4_index_buffer_destroy (kinc_g4_index_buffer_t *buffer)" 1))
      (C-function ("kinc_g4_index_buffer_lock" g_kinc_g4_index_buffer_lock "int* kinc_g4_index_buffer_lock (kinc_g4_index_buffer_t *buffer)" 1))
      (C-function ("kinc_g4_index_buffer_unlock" g_kinc_g4_index_buffer_unlock "void kinc_g4_index_buffer_unlock (kinc_g4_index_buffer_t *buffer)" 1))
      (C-function ("kinc_g4_index_buffer_count" g_kinc_g4_index_buffer_count "int kinc_g4_index_buffer_count (kinc_g4_index_buffer_t *buffer)" 1))
      (C-function ("kinc_g4_set_index_buffer" g_kinc_g4_set_index_buffer "void kinc_g4_set_index_buffer (kinc_g4_index_buffer_t *buffer)" 1))
    )
  )

(curlet))

#|

(kinc_g4_index_buffer_init ibuffer 3 KINC_G4_INDEX_BUFFER_FORMAT_32BIT KINC_G4_USAGE_STATIC)
(with-g4-index-buffer ibuffer
  (set! I #i(0 1 2))
;      or
  (set! (I 0) 0)
  (set! (I 1) 1)
  (set! (I 2) 2))

|#
