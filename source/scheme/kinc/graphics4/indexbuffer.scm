;;; indexbuffer.scm
;;;
;;; kinc/graphics4/indexbuffer.h

(provide 'kinc/graphics4/indexbuffer)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/indexbuffer
    :ctypes ()
    :c-info ()
  )

(curlet))
