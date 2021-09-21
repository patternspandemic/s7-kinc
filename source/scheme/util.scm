(provide 'util.scm)


;; reqlet is a combination of require and varlet (curlet) used for s7kinc bindings.
(define-expansion (reqlet root sym . syms)
  (let* ((root-str (symbol->string root))
         (lib-sym (string->symbol (string-append "*lib" root-str "*")))
         (all-syms (cons sym syms))
         (requires (map (lambda(s) (string->symbol (string-append root-str "/" (symbol->string s)))) (cons sym syms)))
         (quoted-requires (apply append (map (lambda(r) `(',r)) requires)))
         (quoted-environs (apply append (map (lambda(e) `((,lib-sym ',e))) all-syms))))

    `(with-let (curlet)
               (require ,(apply-values quoted-requires))
               (varlet (curlet) ,(apply-values quoted-environs)))))
