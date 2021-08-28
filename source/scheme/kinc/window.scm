;;; TODO: window.scm
;;;
;;; kinc/window.h

(require 'cload.scm)
(provide 'kinc/window)


(with-let (unlet)

  (c-define
   '()
   "" "kinc/window.h" "" "-lKinc" (reader-cond ((not (string=? "1" (getenv "S7KINC_DEV_SHELL"))) "kinc_window_s7")))

(curlet))
