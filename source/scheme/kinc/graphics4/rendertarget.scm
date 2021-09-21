;;; rendertarget.scm
;;;
;;; kinc/graphics4/rendertarget.h

(provide 'kinc/graphics4/rendertarget)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/rendertarget
    :ctypes ()
    :c-info ()
  )

(curlet))
