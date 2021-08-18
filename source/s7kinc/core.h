#ifndef S7KINC_CORE_H_
#define S7KINC_CORE_H_


#include <kinc/color.h>
#include <kinc/error.h>
#include <kinc/graphics4/graphics.h>
#include <kinc/log.h>
#include <kinc/system.h>

#include "../lib/s7/s7.h"

#include "repl.h"

/* S7KINC PATHS INJECTED HERE */
#define S7KINC_S7_PATH
#define S7KINC_KINC_PATH
#define S7KINC_SCHEME_PATH

/* s7 Scheme interpreter instance */
s7_scheme *sc;

/* TODO: TEMPORARY */
#define KINC_COLOR_KINC 0x4B696E63
static uint32_t clear_color = KINC_COLOR_KINC;

/* Scheme side hooks to extend Kinc system callbacks. */
static s7_pointer update_hook = 0;
static s7_pointer foreground_hook = 0;
static s7_pointer resume_hook = 0;
static s7_pointer pause_hook = 0;
static s7_pointer background_hook = 0;
static s7_pointer shutdown_hook = 0;
static s7_pointer drop_files_hook = 0;
static s7_pointer cut_hook = 0;
static s7_pointer copy_hook = 0;
static s7_pointer paste_hook = 0;
static s7_pointer login_hook = 0;
static s7_pointer logout_hook = 0;

/* TODO: Temporary */
static s7_pointer change_color(s7_scheme *sc, s7_pointer args);

static void s7kinc_update(void);
static void s7kinc_foreground(void);
static void s7kinc_resume(void);
static void s7kinc_pause(void);
static void s7kinc_background(void);
static void s7kinc_shutdown(void);
static void s7kinc_drop_files(void);
static void s7kinc_cut(void);
static void s7kinc_copy(void);
static void s7kinc_paste(void);
static void s7kinc_login(void);
static void s7kinc_logout(void);
void s7kinc_init(void);


#endif // S7KINC_CORE_H_
