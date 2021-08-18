#ifndef S7KINC_REPL_H_
#define S7KINC_REPL_H_


#include <stdlib.h>
#include <string.h>

#include <kinc/error.h>
#include <kinc/log.h>
#include <kinc/network/socket.h>

#include "../lib/s7/s7.h"
#include "../lib/sds/sds.h" // Simple Dynamic Strings


/* TODO: Make REPL port configurable. */
#define REPL_BUFFER_PORT 1337
#define REPL_BUFFER_SIZE 512

extern s7_scheme *sc;

void s7kinc_repl_listen(void);
void s7kinc_repl_init(void);
void s7kinc_repl_cleanup(void);


#endif // S7KINC_REPL_H_
