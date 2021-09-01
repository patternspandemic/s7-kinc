;;; TODO: system.scm
;;;
;;; kinc/system.h

(provide 'kinc/system)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (c-define
   '()
   "" "kinc/system.h" "" "-lKinc" (maybe-output-name system))

(curlet))
