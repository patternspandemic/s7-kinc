;;; TODO: system.scm
;;;
;;; kinc/system.h

(require cload.scm)
(provide 'kinc/system)

(c-define
 '()
 "" "kinc/system.h" "" "-lKinc" "kinc_system_s7")
