;;; TODO: image.scm
;;;
;;; kinc/image.h

(provide 'kinc/image)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc image
    :ctypes '()
    :c-info '(

    )
  )

(curlet))
