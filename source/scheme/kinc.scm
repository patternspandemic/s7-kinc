(require 'cload.scm)
(provide 'kinc.scm)


;(format *stderr* "Running in ~A mode.~%" (if *s7kinc-develop-mode* "DEV" "BUILD"))

;; The list of requirable kinc libraries.
(define kinc-libs
  '(color
    display
    image
    system
    window))

;; Add autoloads for each of the `kinc-libs`
(for-each (lambda (lib-sym)
            (let* ((lib-string (symbol->string lib-sym))
                   (autoload-sym (string->symbol (string-append "kinc/" lib-string)))
                   (scm-load-path (string-append "kinc/" lib-string ".scm")))
              (autoload autoload-sym scm-load-path)))
          kinc-libs)

#t
