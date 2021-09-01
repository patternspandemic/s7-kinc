;;; util.scm
;;;
;;; Helpers for binding items with cload.

(define *s7kinc-dev-shell-detected*
  (string=? "1" (getenv "S7KINC_DEV_SHELL")))

(define (slashed-symbol->underscored-string sym)
  (let loop ((str (symbol->string sym)))
    (let ((pos (char-position #\/ str)))
      (if pos
          (begin (string-set! str pos #\_) (loop str))
          str))))

(define-expansion (maybe-output-name name)
  (if *s7kinc-dev-shell-detected*
      (values) ; no output-name
      (let ((output-name-string (string-append
                                 "kinc_"
                                 (slashed-symbol->underscored-string name)
                                 "_s7")))
        output-name-string)))
