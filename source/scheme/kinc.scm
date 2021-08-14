(require 'cload.scm)
(provide 'kinc.scm)

;; TODO: Create a *kinc* environment to store in *libraries*, which will have sublets storing each
;;       part of the s7-kinc library, autoloaded from its .so?
;;  or
;;       Just dump everything into the rootlet/curlet?

(autoload 'kinc/color   (lambda (e) (load "kinc_color_s7.so" (varlet (rootlet) 'init_func 'kinc_color_s7_init))))
(autoload 'kinc/display "display.scm")
;;(autoload 'kinc/error   "error.scm")
;;(autoload 'kinc/global  "global.scm")
(autoload 'kinc/image   "image.scm")
;;(autoload 'kinc/log     "log.scm")
(autoload 'kinc/system  "system.scm")
;(autoload 'kinc/video   "video.scm")
(autoload 'kinc/window  "window.scm")

#t
