;;; TODO: system.scm
;;;
;;; kinc/system.h

(require 'cload.scm)
(provide 'kinc/system)


(with-let (unlet)

  (c-define
   '()
   "" "kinc/system.h" "" "-lKinc" (reader-cond ((not (string=? "1" (getenv "S7KINC_DEV_SHELL"))) "kinc_system_s7")))

(curlet))
