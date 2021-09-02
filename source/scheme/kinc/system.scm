;;; TODO: system.scm
;;;
;;; kinc/system.h

(provide 'kinc/system)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc system
    :ctypes '()
    :c-info '(

    )
  )

(curlet))
