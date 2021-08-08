#include <stdlib.h>

#include <kinc/color.h>
#include <kinc/error.h>
#include <kinc/graphics4/graphics.h>
#include <kinc/log.h>
#include <kinc/system.h>

#include <s7.h>

#include "s7kinc/repl.h"

#define KINC_COLOR_KINC 0x4B696E63
static uint32_t clear_color = KINC_COLOR_KINC;

/* s7 Scheme interpreter instance */
s7_scheme *sc = 0;

static s7_pointer change_color(s7_scheme *sc, s7_pointer args) {
  if (s7_is_integer(s7_car(args))) {
    clear_color = s7_integer(s7_car(args));
    return(s7_make_integer(sc, clear_color));
  }
  return(s7_wrong_type_arg_error(sc, "add1", 1, s7_car(args), "an integer"));
}

static void update(void) {
  s7kinc_repl_listen(); // TODO: Don't listen every frame..

  kinc_g4_begin(0);
  kinc_g4_clear(KINC_G4_CLEAR_COLOR, clear_color, 0.0f, 0);
  // Draw stuff ...
  kinc_g4_end(0);
  kinc_g4_swap_buffers();
}

static void shutdown(void) {
  kinc_log(KINC_LOG_LEVEL_INFO, "Shutting down ...");
  free(sc);
  s7kinc_repl_cleanup();
}

int kickstart(int argc, char **argv) {
  /* Initialize s7 */
  sc = s7_init();
  s7_define_function(sc, "change-color", change_color, 1, 0, false, "(change-color color) change the clear color");

  /* Setup REPL socket server */
  s7kinc_repl_init();

  /* Initialize Kinc */
  kinc_init("s7 Kinc", 720, 480, NULL, NULL);
  kinc_set_update_callback(update);
  kinc_set_shutdown_callback(shutdown);

  kinc_start();
  return 0;
}

int main(int argc, char** argv) {
  return kickstart(argc, argv);
}
