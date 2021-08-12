;;; TODO: display.scm
;;;
;;; kinc/display.h

(require cload.scm)
(provide 'kinc/display)

(c-define
 '((void kinc_display_init (void))
   (int kinc_primary_display (void))
   (int kinc_count_displays (void))
   (bool kinc_display_available (int))
   (char* kinc_display_name (int))
   (kinc_display_mode_t kinc_display_current_mode (int))
   (int kinc_display_count_available_modes (int))
   (kinc_display_mode_t kinc_display_available_mode (int int))

   (in-C "

static int kinc_display_mode_t_tag = 0;


")
   ;(C-function ...)

   (C-init "kinc_display_mode_t_tag = s7_make_c_type(sc, \"<kinc_display_mode_t>\")")
  )
 "" "kinc/display.h" "" "-lKinc" "kinc_display_s7")
