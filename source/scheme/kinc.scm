(require 'cload.scm)
(provide 'kinc.scm)


;; TODO: Guard against reloads.

;(format *stderr* "Running in ~A mode.~%" (if *s7kinc-develop-mode* "DEV" "BUILD"))

;; The list of requirable kinc libraries.
(define kinc-libs
  '(color
    display
    image
    system
    window))

;; Top level environment to hold required bindings.
(define *libkinc* (inlet))

;; Add autoloads for each of the `kinc-libs`
(for-each (lambda (lib-sym)
            (let* ((lib-string (symbol->string lib-sym))
                   (autoload-sym (string->symbol (string-append "kinc/" lib-string)))
                   (scm-load-path (string-append "kinc/" lib-string ".scm")))
              ;; (autoload autoload-sym scm-load-path)))
              (autoload autoload-sym (lambda (e) (cutlet *libkinc* lib-sym) (varlet *libkinc* lib-sym (with-let (unlet) (load scm-load-path (curlet))))))))
          kinc-libs)

#t
