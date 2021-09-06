(format () "Hello from the main driver!~%")
;; (format () "Hello from the CHANGED driver!~%")

;; (set! (hook-functions s7kinc-resize-hook)
;;       (list (lambda (hook)
;;               (format *stderr* "Resized to ~D x ~D~%" (hook 'width) (hook 'height)))))

#t
