#include "core.h"


/* TODO: When the Linux backend implements multiple windows, support multiple
 * windows and the data parameter for resize and ppi_changed callback hooks. It
 * may be better to move these hooks out of core.c */

/* TODO: Temporary */
static uint32_t clear_color = KINC_COLOR_KINC;

/* Scheme side hooks to extend Kinc system callbacks. */
static s7_pointer update_hook;
static s7_pointer foreground_hook;
static s7_pointer resume_hook;
static s7_pointer pause_hook;
static s7_pointer background_hook;
static s7_pointer shutdown_hook;
static s7_pointer drop_files_hook;
static s7_pointer cut_hook;
static s7_pointer copy_hook;
static s7_pointer paste_hook;
static s7_pointer login_hook;
static s7_pointer logout_hook;
static s7_pointer resize_hook;
static s7_pointer ppi_changed_hook;


/* TODO: Temporary */
static s7_pointer change_color(s7_scheme *sc, s7_pointer args) {
  if (s7_is_integer(s7_car(args))) {
    clear_color = s7_integer(s7_car(args));
    return(s7_make_integer(sc, clear_color));
  }
  return(s7_wrong_type_arg_error(sc, "add1", 1, s7_car(args), "an integer"));
}

static void s7kinc_cleanup(void) {
  s7kinc_repl_cleanup();
  free(sc);
}

/* TODO: Maybe wrap constant names in asterisks? */
static void make_hooks(void) {
  update_hook = s7_eval_c_string(sc, "(make-hook)");
  s7_define_constant(sc, "s7kinc-update-hook", update_hook);
  foreground_hook = s7_eval_c_string(sc, "(make-hook)");
  s7_define_constant(sc, "s7kinc-foreground-hook", foreground_hook);
  resume_hook = s7_eval_c_string(sc, "(make-hook)");
  s7_define_constant(sc, "s7kinc-resume-hook", resume_hook);
  pause_hook = s7_eval_c_string(sc, "(make-hook)");
  s7_define_constant(sc, "s7kinc-pause-hook", pause_hook);
  background_hook = s7_eval_c_string(sc, "(make-hook)");
  s7_define_constant(sc, "s7kinc-background-hook", background_hook);
  shutdown_hook = s7_eval_c_string(sc, "(make-hook)");
  s7_define_constant(sc, "s7kinc-shutdown-hook", shutdown_hook);
  drop_files_hook = s7_eval_c_string(sc, "(make-hook 'file)"); // FIXME: file or files?
  s7_define_constant(sc, "s7kinc-drop-files-hook", drop_files_hook);
  cut_hook = s7_eval_c_string(sc, "(make-hook)");
  s7_define_constant(sc, "s7kinc-cut-hook", cut_hook);
  copy_hook = s7_eval_c_string(sc, "(make-hook)");
  s7_define_constant(sc, "s7kinc-copy-hook", copy_hook);
  paste_hook = s7_eval_c_string(sc, "(make-hook 'paste)");
  s7_define_constant(sc, "s7kinc-paste-hook", paste_hook);
  login_hook = s7_eval_c_string(sc, "(make-hook)");
  s7_define_constant(sc, "s7kinc-login-hook", login_hook);
  logout_hook = s7_eval_c_string(sc, "(make-hook)");
  s7_define_constant(sc, "s7kinc-logout-hook", logout_hook);
  resize_hook = s7_eval_c_string(sc, "(make-hook 'width 'height)"); // FIXME: What about data, multiple windows?
  s7_define_constant(sc, "s7kinc-resize-hook", resize_hook);
  ppi_changed_hook = s7_eval_c_string(sc, "(make-hook 'ppi)"); // FIXME: What about data, multiple windows?
  s7_define_constant(sc, "s7kinc-ppi-changed-hook", ppi_changed_hook);
}

static void s7kinc_update_cb(void) {
  s7kinc_repl_listen(); // TODO: Don't listen every frame..
  s7_call(sc, update_hook, s7_nil(sc));

  /* TODO: Temporary */
  kinc_g4_begin(0);
  kinc_g4_clear(KINC_G4_CLEAR_COLOR, clear_color, 0.0f, 0);
  // Draw stuff ...
  kinc_g4_end(0);
  kinc_g4_swap_buffers();
}

static void s7kinc_foreground_cb(void) { s7_call(sc, foreground_hook, s7_nil(sc)); }
static void s7kinc_resume_cb(void) { s7_call(sc, resume_hook, s7_nil(sc)); }
static void s7kinc_pause_cb(void) { s7_call(sc, pause_hook, s7_nil(sc)); }
static void s7kinc_background_cb(void) { s7_call(sc, background_hook, s7_nil(sc)); }

static void s7kinc_shutdown_cb(void) {
  kinc_log(KINC_LOG_LEVEL_INFO, "Shutting down ...");
  s7_call(sc, shutdown_hook, s7_nil(sc));
  s7kinc_cleanup();
}

static void s7kinc_drop_files_cb(wchar_t * file) {
  kinc_log(KINC_LOG_LEVEL_ERROR, "Drop Files Not Implemented.");
  // FIXME: file or files? Pass to the called hook
  //s7_call(sc, drop_files_hook, s7_nil(sc));
}

static char *s7kinc_cut_cb(void) {
  s7_pointer cut = s7_call(sc, cut_hook, s7_nil(sc));
  return (char *)s7_string(cut);
}

static char *s7kinc_copy_cb(void) {
  s7_pointer cpy = s7_call(sc, copy_hook, s7_nil(sc));
  return (char *)s7_string(cpy);
}

static void s7kinc_paste_cb(char *paste) {
  s7_call(sc, paste_hook, s7_list(sc, 1, s7_make_string(sc, paste)));
}

static void s7kinc_login_cb(void) { s7_call(sc, login_hook, s7_nil(sc)); }
static void s7kinc_logout_cb(void) { s7_call(sc, logout_hook, s7_nil(sc)); }

static void s7kinc_resize_cb(int width, int height, void *data) {
  s7_call(sc, resize_hook, s7_list(sc, 2, s7_make_integer(sc, width), s7_make_integer(sc, height)));
}

static void s7kinc_ppi_changed_cb(int ppi, void *data) {
  s7_call(sc, ppi_changed_hook, s7_list(sc, 1, s7_make_integer(sc, ppi)));
}

static void set_callbacks(void) {
  kinc_set_update_callback(s7kinc_update_cb);
  kinc_set_foreground_callback(s7kinc_foreground_cb);
  kinc_set_resume_callback(s7kinc_resume_cb);
  kinc_set_pause_callback(s7kinc_pause_cb);
  kinc_set_background_callback(s7kinc_background_cb);
  kinc_set_shutdown_callback(s7kinc_shutdown_cb);
  kinc_set_drop_files_callback(s7kinc_drop_files_cb);
  kinc_set_cut_callback(s7kinc_cut_cb);
  kinc_set_copy_callback(s7kinc_copy_cb);
  kinc_set_paste_callback(s7kinc_paste_cb);
  kinc_set_login_callback(s7kinc_login_cb);
  kinc_set_logout_callback(s7kinc_logout_cb);
  kinc_window_set_resize_callback(0, s7kinc_resize_cb, NULL); // NOTE: Supports only main window, ignores 'data' param
  kinc_window_set_ppi_changed_callback(0, s7kinc_ppi_changed_cb, NULL); // NOTE: Supports only main window, ignores 'data' param
}

static void load_scm(s7_scheme *sc, const char *name) {
  /* kinc_log(KINC_LOG_LEVEL_INFO, "Loading %s", name); */
  if (!s7_load(sc, name)) {
    kinc_error_message("Failed to load %s", name);
  }
}

static void add_dev_load_paths(char *dev_root) {
  kinc_log(KINC_LOG_LEVEL_INFO, "    > development root: %s", dev_root);
  /* load paths */
  sds root_path = sdscatprintf(sdsempty(), "%s%s", dev_root, (dev_root[strlen(dev_root) - 1] == '/') ? "" : "/");
  sds dev_s7_path = sdscatprintf(sdsempty(), "%s%s", root_path, "source/lib/s7");
  sds dev_scheme_path = sdscatprintf(sdsempty(), "%s%s", root_path, "source/scheme");
  /* cload directory */
  sds dev_cload_path = sdscatprintf(sdsempty(), "%s%s", root_path, "source/lib/cload");
  sds set_cload_dir = sdscatprintf(sdsempty(), "(set! *cload-directory* \"%s\")", dev_cload_path);

  /* These paths will occur before the injected build paths in s7's *load-path*,
   * and therefore when in develop mode, a search for a scheme file will first
   * succeed by way of a dev path. */
  s7_add_to_load_path(sc, dev_s7_path);
  s7_add_to_load_path(sc, dev_scheme_path);

  /* Set the cload-directory. */
  kinc_log(KINC_LOG_LEVEL_INFO, "    > cload directory: %s\n", dev_cload_path);
  s7_eval_c_string(sc, set_cload_dir);

  sdsfree(dev_s7_path);
  sdsfree(dev_scheme_path);
  sdsfree(dev_cload_path);
  sdsfree(set_cload_dir);
  sdsfree(root_path);
}

void s7kinc_init(void) {
  /* Initialize s7 */
  sc = s7_init();

  /* Whether s7-kinc is running inside a development shell. */
  bool in_dev_mode = getenv("S7KINC_DEV_SHELL") ? true : false;

  /* Define a scheme side constant which flags whether s7-kinc is being
   * run inside a dev shell. */
  s7_define_constant_with_documentation(
    sc, "*s7kinc-develop-mode*", s7_make_boolean(sc, in_dev_mode),
    "Whether s7-kinc is running inside a development shell.");

  /* Add build paths to s7's load-path. These were injected at build time. See s7kinc.nix
   * Setting the cload directory also adds it to the load path. */
  s7_add_to_load_path(sc, S7KINC_S7_PATH);
  s7_add_to_load_path(sc, S7KINC_SCHEME_PATH);
  sds set_cload_path = sdscatprintf(sdsempty(), "(set! *cload-directory* \"%s\")", S7KINC_CLOAD_PATH);
  s7_eval_c_string(sc, set_cload_path);
  sdsfree(set_cload_path);

  /* Develop mode additions. */
  if (in_dev_mode) {
    kinc_log(KINC_LOG_LEVEL_INFO, "Running in develop mode,");
    /* Add local develop paths to s7's load-path when s7-kinc is run inside a
     * development shell. If the env variable "S7KINC_DEV_ROOT" defines a path
     * use it as the root, otherwise use the current working dir. */
    char *dev_root = getenv("S7KINC_DEV_ROOT");
    if(dev_root) {
      sds test = sdscatprintf(sdsempty(), "(directory? \"%s\")", dev_root);
      if(s7_boolean(sc, s7_eval_c_string(sc, test))) {
        add_dev_load_paths(dev_root);
      }
      sdsfree(test);
    } else { /* Use current working dir as the dev root. */
      char *cwd = getcwd(NULL, 0);
      add_dev_load_paths(cwd);
      free(cwd);
    }
  }

  /* Setup REPL socket server */
  /* TODO: Should REPL be run only in DEV mode?
   *       Run it in all modes for now. */
  s7kinc_repl_init();

  /* Add hooks to various Kinc system callbacks. */
  make_hooks();
  set_callbacks();

  /* TODO: Temporary */
  s7_define_function(sc, "change-color", change_color, 1, 0, false, "(change-color color) change the clear color");

  /* Initialize autoloads to Kinc s7 shared library bindings. */
  load_scm(sc, "kinc.scm");

  /* Load the main driver. */
  load_scm(sc, "main.scm");

  /* Required definitions if main.scm didn't take care of them. */
  s7_eval_c_string(sc, "(unless (defined? 'application-name) (define application-name \"s7 Kinc Default\"))");
  s7_eval_c_string(sc, "(unless (member 'window (map (lambda(p) (car p)) (let->list *libkinc*))) (require 'kinc/window))");
  s7_eval_c_string(sc, "(unless (defined? 'framebuffer-options) (define framebuffer-options (with-let (*libkinc* 'window) (make-kinc_framebuffer_options_t))))");
  s7_eval_c_string(sc, "(unless (defined? 'window-options) (define window-options (with-let (*libkinc* 'window) (make-kinc_window_options_t :title application-name))))");

  s7_pointer name, framebuffer_opts, window_opts;
  name = s7_eval_c_string(sc, "application-name");
  framebuffer_opts = s7_eval_c_string(sc, "framebuffer-options");
  window_opts = s7_eval_c_string(sc, "window-options");

  // TODO: error when name, framebuffer_opts, or window_opts are wrong types.

  /* Initialize and start Kinc */
  kinc_window_options_t *wo = s7_c_object_value(window_opts);
  kinc_framebuffer_options_t *fo = s7_c_object_value(framebuffer_opts);
  kinc_init(s7_string(name), wo->width, wo->height, wo, fo);
  kinc_start();
}
