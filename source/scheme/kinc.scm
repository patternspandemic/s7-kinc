(require 'cload.scm)
(provide 'kinc.scm)


(format *stderr* "Running in ~A mode.~%" (if *s7kinc-develop-mode* "DEV" "BUILD"))

;; The list of requirable kinc libraries.
(define kinc-libs
  '(color
    display
    image
    system
    window))

;; Generate the neccessary autoload call to load the respective shared library.
;; TODO: Support load of local dev env libs from .scm files.
(define-macro (kinc-load lib-sym)
  `(let* ((lib-string (symbol->string ,lib-sym))
          (autoload-sym (string->symbol (string-append "kinc/" lib-string)))
          (long-name (string-append "kinc_" lib-string "_s7"))
          (init-func-name (string->symbol (string-append long-name "_init")))
          (so-name-string (string-append long-name ".so")))
     (autoload autoload-sym
               (lambda (e) (varlet (rootlet)
                                   (let ((load-space (inlet (unlet) 'init_func init-func-name)))
                                     (load so-name-string load-space)
                                     load-space))))))

;; Add autoloads for each of the `kinc-libs`
(let ((iter (make-iterator kinc-libs)))
  (do ((lib (iter) (iter)))
      ((eof-object? lib))
    (kinc-load lib)))

;;; Old notes...
;; (autoload 'kinc/color   (lambda (e) (load "kinc_color_s7.so" (varlet (rootlet) 'init_func 'kinc_color_s7_init)))) ; Basic load into rootlet
;; (autoload 'kinc/color
;;   (lambda (e) (varlet (rootlet)
;;                       (let ((load-space (inlet (unlet) 'init_func 'kinc_color_s7_init))) ; Ensure use of builtins with unlet
;;                         (load "kinc_color_s7.so" load-space)
;;                         load-space))))

#t
