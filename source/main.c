#include <stdlib.h>

#include <kinc/color.h>
#include <kinc/error.h>
#include <kinc/graphics4/graphics.h>
#include <kinc/log.h>
#include <kinc/system.h>

#include "lib/s7/s7.h"

#include "s7kinc/core.h"
#include "s7kinc/repl.h"

#define KINC_COLOR_KINC 0x4B696E63
uint32_t clear_color = KINC_COLOR_KINC;

/* s7 Scheme interpreter instance */
s7_scheme *sc = 0;

static void update(void) {
  s7kinc_repl_listen(); // TODO: Don't listen every frame..
  s7kinc_update();

  kinc_g4_begin(0);
  kinc_g4_clear(KINC_G4_CLEAR_COLOR, clear_color, 0.0f, 0);
  // Draw stuff ...
  kinc_g4_end(0);
  kinc_g4_swap_buffers();
}

static void shutdown(void) {
  kinc_log(KINC_LOG_LEVEL_INFO, "Shutting down ...");
  s7kinc_shutdown();
  s7kinc_repl_cleanup();
  free(sc);
}

int kickstart(int argc, char **argv) {
  /* Initialize s7 */
  sc = s7_init();
  s7kinc_init(sc);

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
