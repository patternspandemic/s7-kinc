#ifndef S7KINC_CORE_H_
#define S7KINC_CORE_H_


#include <stdbool.h>
#include <string.h>
#include <unistd.h>

#include <kinc/color.h>
#include <kinc/error.h>
#include <kinc/graphics4/graphics.h>
#include <kinc/io/filereader.h>
#include <kinc/log.h>
#include <kinc/system.h>
#include <kinc/window.h>

#include "../lib/s7/s7.h"
#include "../lib/sds/sds.h" // Simple Dynamic Strings
#include "../lib/util/s7ctypes.h"
#include "repl.h"

/* S7KINC PATHS INJECTED HERE */
#define S7KINC_S7_PATH
#define S7KINC_CLOAD_PATH
#define S7KINC_SCHEME_PATH

/* TODO: TEMPORARY */
#define KINC_COLOR_KINC 0x4B696E63

/* s7 Scheme interpreter instance */
s7_scheme *sc;

void s7kinc_init(void);


#endif // S7KINC_CORE_H_
