;;; util.scm
;;;
;;; Helpers for binding kinc items with cload.

(define *s7kinc-dev-shell-detected*
  (string=? "1" (getenv "S7KINC_DEV_SHELL")))

(define (slashed-symbol->underscored-string sym)
  (let loop ((str (symbol->string sym)))
    (let ((pos (char-position #\/ str)))
      (if pos
          (begin (string-set! str pos #\_) (loop str))
          str))))

;; (define-expansion (maybe-output-name name)
;;   (if *s7kinc-dev-shell-detected*
;;       (values) ; no output-name
;;       (let ((output-name-string (string-append
;;                                  "kinc_"
;;                                  (slashed-symbol->underscored-string name)
;;                                  "_s7")))
;;         output-name-string)))

(define-expansion* (bind-kinc lib-sym (prefix "") (headers ()) (cflags "") (ldflags "") (ctypes ()) (c-info ()))
  (let* ((lib-str (symbol->string lib-sym))
         (lib-hdr (string-append "kinc/" lib-str ".h"))
         (lib-headers (append (list "sds/sds.h" lib-hdr) headers))
         (lib-include-path (if (provided? 'kinc.scm) "-Isource/lib/" "-I../../lib/"))
         (lib-cflags (string-append lib-include-path " " cflags))
         (lib-ldflags (string-append "-lKinc " ldflags))
         (lib-output-name (string-append "kinc_" (slashed-symbol->underscored-string lib-sym) "_s7"))
         (lib-c-types '()))

  ; TODO: generate c-type bits, preprend to c-info?

    `(c-define ,c-info ,prefix ',lib-headers ,lib-cflags ,lib-ldflags ,(if *s7kinc-dev-shell-detected* (values) lib-output-name))))
