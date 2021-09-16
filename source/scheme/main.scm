;; (format () "Hello from the main driver!~%")
;; (format () "Hello from the CHANGED driver!~%")

;; (set! (hook-functions s7kinc-resize-hook)
;;       (list (lambda (hook)
;;               (format *stderr* "Resized to ~D x ~D~%" (hook 'width) (hook 'height)))))

; TODO: Create a kinclet macro which requires and with-let sublets all-in-one?
(require 'kinc/system
         'kinc/window)

(with-let (sublet () (*libkinc* 'system)
                     (*libkinc* 'window))

  (let ((framebuffer-options (make-kinc_framebuffer_options_t))
        (window-options      (make-kinc_window_options_t
                              :title "s7 Kinc"
                              :x 50 :y 50 :width 300 :height 300)))

    (kinc_init "s7 Kinc" 300 300 window-options framebuffer-options)
    (kinc_start)

))

#t
