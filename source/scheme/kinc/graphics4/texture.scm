;;; texture.scm
;;;
;;; kinc/graphics4/texture.h

(provide 'kinc/graphics4/texture)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/texture
    :ctypes ()
    :c-info ()
  )

(curlet))
