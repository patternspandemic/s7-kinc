;;; textureunit.scm
;;;
;;; kinc/graphics4/textureunit.h

(provide 'kinc/graphics4/textureunit)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics4/textureunit
    :ctypes ((kinc_g4_texture_unit_t))
  )

(curlet))
