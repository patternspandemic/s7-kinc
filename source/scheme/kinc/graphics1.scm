;;; graphics1.scm
;;;
;;; kinc/graphics1/graphics.h

(provide 'kinc/graphics1)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc graphics1/graphics
    :c-info (
      (void kinc_g1_init (int int))
      (void kinc_g1_begin (void))
      (void kinc_g1_end (void))
      (void kinc_g1_set_pixel (int int float float float))
       (int kinc_g1_width (void))
       (int kinc_g1_height (void))
    )
  )

(curlet))
