;;; usage.scm
;;;
;;; kinc/graphics4/usage.h

(provide 'kinc/graphics4/usage)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/usage
    :ctypes ()
    :c-info ()
  )

(curlet))
