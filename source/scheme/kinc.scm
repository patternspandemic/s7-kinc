(require 'cload.scm)
(provide 'kinc.scm)


;; TODO: Guard against reloads.

;; The list of requirable kinc libraries.
(define kinc-libs
  '(color
    display
    graphics1
    graphics4
    graphics4/constantlocation
    graphics4/indexbuffer
    graphics4/pipeline
    graphics4/rendertarget
    graphics4/shader
    graphics4/texture
    graphics4/texturearray
    graphics4/textureunit
    graphics4/usage
    graphics4/vertexbuffer
    graphics4/vertexstructure
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
