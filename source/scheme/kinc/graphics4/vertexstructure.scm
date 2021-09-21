;;; vertexstructure.scm
;;;
;;; kinc/graphics4/vertexstructure.h

(provide 'kinc/graphics4/vertexstructure)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/vertexstructure
    :ctypes ()
    :c-info ()
  )

(curlet))
