(require 'cload.scm)
(provide 'kinc.scm)

(autoload 'kinc/color   (lambda (e) (load "kinc_color_s7.so" (inlet 'init_func 'kinc_color_s7_init))))
(autoload 'kinc/display "display.scm")
;;(autoload 'kinc/error   "error.scm")
;;(autoload 'kinc/global  "global.scm")
(autoload 'kinc/image   "image.scm")
;;(autoload 'kinc/log     "log.scm")
(autoload 'kinc/system  "system.scm")
;(autoload 'kinc/video   "video.scm")
(autoload 'kinc/window  "window.scm")

#t
