;;; TODO: window.scm
;;;
;;; kinc/window.h

(provide 'kinc/window)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc window
    :ctypes '()
    :c-info '(

    )
  )

(curlet))
