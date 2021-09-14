;;; color.scm
;;;
;;; kinc/color.h

(provide 'kinc/color)

(require 'cload.scm)
(load (reader-cond ((provided? 'kinc.scm) "kinc/util.scm") (else "util.scm")))


(with-let (unlet)

  (bind-kinc color
    :c-info (
      (C-macro (uint32_t (KINC_COLOR_BLACK
                          KINC_COLOR_WHITE
                          KINC_COLOR_RED
                          KINC_COLOR_BLUE
                          KINC_COLOR_GREEN
                          KINC_COLOR_MAGENTA
                          KINC_COLOR_YELLOW
                          KINC_COLOR_CYAN)))

      (in-C "
static s7_pointer g_kinc_color_components(s7_scheme *sc, s7_pointer args) {
    if (s7_is_integer(s7_car(args))) {
        s7_int color = s7_integer(s7_car(args));
        if (color < 0)
            return(s7_out_of_range_error(sc, \"kinc_color_components\", 1, s7_car(args), \">= 0\"));
        float r, g, b, a;
        kinc_color_components((uint32_t)color, &r, &g, &b, &a);
        return(s7_list(sc, 4, s7_make_real(sc, a), s7_make_real(sc, r), s7_make_real(sc, g), s7_make_real(sc, b)));
    }
    return(s7_wrong_type_arg_error(sc, \"kinc_color_components\", 1, s7_car(args), \"an integer\"));
}
")

      (C-function ("kinc_color_components" g_kinc_color_components "(kinc_color_components 32bit-ARGB-color) returns a list: (a r g b)" 1))

    )
  )

  (define KINC_COLOR_KINC #x4B696E63)

(curlet))
