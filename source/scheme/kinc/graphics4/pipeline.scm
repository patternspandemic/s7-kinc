;;; pipeline.scm
;;;
;;; kinc/graphics4/pipeline.h

(provide 'kinc/graphics4/pipeline)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/pipeline
    :ctypes ()
    :c-info ()
  )

(curlet))
