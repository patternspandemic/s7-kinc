;;; shader.scm
;;;
;;; kinc/graphics4/shader.h

(provide 'kinc/graphics4/shader)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/shader
    :ctypes ()
    :c-info ()
  )

(curlet))
