;;; TODO: image.scm
;;;
;;; kinc/image.h

(provide 'kinc/image)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (c-define
   '()
   "" "kinc/image.h" "" "-lKinc" (maybe-output-name image))

(curlet))
