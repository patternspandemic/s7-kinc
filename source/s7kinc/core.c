#include "core.h"


static s7_pointer change_color(s7_scheme *sc, s7_pointer args) {
  if (s7_is_integer(s7_car(args))) {
    clear_color = s7_integer(s7_car(args));
    return(s7_make_integer(sc, clear_color));
  }
  return(s7_wrong_type_arg_error(sc, "add1", 1, s7_car(args), "an integer"));
}

/* TODO: Create and call s7 hooks for update, shutdown, etc. */
void s7kinc_update(void) {}
void s7kinc_shutdown(void) {}

void s7kinc_init(s7_scheme *sc) {
  /* TODO: load libc, libdl?, cload. (? case, debug, lint, profile, r7rs, reactive, write, etc)
   * TODO: Create various s7 hooks to kinc callbacks
   * TODO: load kinc scm bits here */
  s7_define_function(sc, "change-color", change_color, 1, 0, false, "(change-color color) change the clear color");
}
