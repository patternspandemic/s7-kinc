;;; TODO: window.scm
;;;
;;; kinc/window.h

(provide 'kinc/window)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (c-define
   '()
   "" "kinc/window.h" "" "-lKinc" (maybe-output-name window))

(curlet))
