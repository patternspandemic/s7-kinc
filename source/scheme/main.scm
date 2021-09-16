;; (format () "Hello from the main driver!~%")
;; (format () "Hello from the CHANGED driver!~%")

;; (set! (hook-functions s7kinc-resize-hook)
;;       (list (lambda (hook)
;;               (format *stderr* "Resized to ~D x ~D~%" (hook 'width) (hook 'height)))))

(require 'kinc/system
         'kinc/window)

(define application-name "s7 Kinc Main")
(define framebuffer-options (make-kinc_framebuffer_options_t))
(define window-options (make-kinc_window_options_t
                        :title application-name
                        :width 300 :height 300))

(with-let (sublet () (*libkinc* 'system)
                     (*libkinc* 'window))

  ; Do cool stuff here.
  (+ 1 2 3 4 5)

)

#t
