;;; usage.scm
;;;
;;; kinc/graphics4/usage.h

(provide 'kinc/graphics4/usage)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/usage
    :c-info (
      ((kinc_g4_usage_t int) (KINC_G4_USAGE_STATIC
                              KINC_G4_USAGE_DYNAMIC
                              KINC_G4_USAGE_READABLE))
    )
  )

(curlet))
