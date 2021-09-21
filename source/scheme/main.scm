;; main.scm
;;
;; s7-kinc's main entry point.

(reqlet kinc system
             window
             color
             graphics4)

(define application-name "s7 Kinc")
(define framebuffer-options (make-kinc_framebuffer_options_t))
(define window-options (make-kinc_window_options_t
                        :title application-name
                        :width 300 :height 300))

(define clear-color #x4B696E63)

(define (change-color color)
  (set! clear-color color))

(set! (hook-functions s7kinc-update-hook)
      (list (lambda (hook)
              (kinc_g4_begin 0)
              (kinc_g4_clear KINC_G4_CLEAR_COLOR clear-color 0.0 0)
              (kinc_g4_end 0)
              (kinc_g4_swap_buffers)
              )))

#t
