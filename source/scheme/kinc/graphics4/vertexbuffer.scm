;;; vertexbuffer.scm
;;;
;;; kinc/graphics4/vertexbuffer.h

(provide 'kinc/graphics4/vertexbuffer)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/vertexbuffer
    :ctypes ()
    :c-info ()
  )

(curlet))
