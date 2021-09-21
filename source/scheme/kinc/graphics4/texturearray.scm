;;; texturearray.scm
;;;
;;; kinc/graphics4/texturearray.h

(provide 'kinc/graphics4/texturearray)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/texturearray
    :ctypes ()
    :c-info ()
  )

(curlet))
