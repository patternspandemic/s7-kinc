;;; TODO: image.scm
;;;
;;; kinc/image.h

(require 'cload.scm)
(provide 'kinc/image)


(with-let (unlet)

  (c-define
   '()
   "" "kinc/image.h" "" "-lKinc" (reader-cond ((not (string=? "1" (getenv "S7KINC_DEV_SHELL"))) "kinc_image_s7")))

(curlet))
