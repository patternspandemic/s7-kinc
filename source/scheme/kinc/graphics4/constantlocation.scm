; TODO: Remove
;;; constantlocation.scm
;;;
;;; kinc/graphics4/constantlocation.h

(provide 'kinc/graphics4/constantlocation)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/constantlocation
    :ctypes ((:name kinc_g4_constant_location_t))
  )

(curlet))
