#include "core.h"


static s7_pointer change_color(s7_scheme *sc, s7_pointer args) {
  if (s7_is_integer(s7_car(args))) {
    clear_color = s7_integer(s7_car(args));
    return(s7_make_integer(sc, clear_color));
  }
  return(s7_wrong_type_arg_error(sc, "add1", 1, s7_car(args), "an integer"));
}

static void make_hooks(void) {
  update_hook = s7_eval_c_string(sc, "(make-hook)");
  s7_define_constant(sc, "kinc-update-hook", update_hook);
  shutdown_hook = s7_eval_c_string(sc, "(make-hook)");
  s7_define_constant(sc, "kinc-shutdown-hook", shutdown_hook);
  /* TODO: Make the other hooks. */
}

static void set_callbacks(void) {
  kinc_set_update_callback(s7kinc_update);
  kinc_set_shutdown_callback(s7kinc_shutdown);
  /* TODO: Set the other callbacks. */
}

static void load_scm(s7_scheme *sc, const char *name) {
  /* kinc_log(KINC_LOG_LEVEL_INFO, "Loading %s", name); */
  if (!s7_load(sc, name)) {
    kinc_error_message("Failed to load %s", name);
  }
}

static void s7kinc_update(void) {
  s7kinc_repl_listen(); // TODO: Don't listen every frame..
  s7_call(sc, update_hook, s7_nil(sc));

  /* TODO: Temporary */
  kinc_g4_begin(0);
  kinc_g4_clear(KINC_G4_CLEAR_COLOR, clear_color, 0.0f, 0);
  // Draw stuff ...
  kinc_g4_end(0);
  kinc_g4_swap_buffers();
}

static void s7kinc_foreground(void) {}
static void s7kinc_resume(void) {}
static void s7kinc_pause(void) {}
static void s7kinc_background(void) {}

static void s7kinc_shutdown(void) {
  kinc_log(KINC_LOG_LEVEL_INFO, "Shutting down ...");
  s7_call(sc, shutdown_hook, s7_nil(sc));
  s7kinc_repl_cleanup();
  free(sc);
}

static void s7kinc_drop_files(void) {}
static void s7kinc_cut(void) {}
static void s7kinc_copy(void) {}
static void s7kinc_paste(void) {}
static void s7kinc_login(void) {}
static void s7kinc_logout(void) {}

void s7kinc_init(void) {
  /* Initialize s7 */
  sc = s7_init();

  /* Setup REPL socket server */
  s7kinc_repl_init();

  /* Add hooks to various Kinc system callbacks. */
  make_hooks();
  set_callbacks();

  /* The following paths were injected at build time. See s7kinc.nix */
  s7_add_to_load_path(sc, S7KINC_S7_PATH);
  s7_add_to_load_path(sc, S7KINC_KINC_PATH);
  s7_add_to_load_path(sc, S7KINC_SCHEME_PATH);

  /* Initialize autoloads to Kinc s7 shared library bindings. */
  load_scm(sc, "kinc.scm");

  /* Load the main driver. */
  load_scm(sc, "main.scm");

  /* TODO: Temporary */
  s7_define_function(sc, "change-color", change_color, 1, 0, false, "(change-color color) change the clear color");
}
