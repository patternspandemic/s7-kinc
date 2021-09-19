;; (format () "Hello from the main driver!~%")
;; (format () "Hello from the CHANGED driver!~%")

;; (set! (hook-functions s7kinc-resize-hook)
;;       (list (lambda (hook)
;;               (format *stderr* "Resized to ~D x ~D~%" (hook 'width) (hook 'height)))))

(require 'kinc/system
         'kinc/window
         'kinc/graphics1)


(define application-name "s7 Kinc")
(define framebuffer-options (make-kinc_framebuffer_options_t))
(define window-options (make-kinc_window_options_t
                        :title application-name
                        :width 300 :height 300))


(with-let (sublet () (*libkinc* 'graphics1))

  (kinc_g1_init 300 300)
  (set! (hook-functions s7kinc-update-hook)
        (list (lambda (hook)
                (kinc_g1_begin)
                (kinc_g1_set_pixel 100 100 0.0 1.0 0.0)
                (kinc_g1_end)
                )))

)

#t
