#ifndef S7KINC_CORE_H_
#define S7KINC_CORE_H_


#include "../lib/s7/s7.h"

extern uint32_t clear_color;

static s7_pointer change_color(s7_scheme *sc, s7_pointer args);

void s7kinc_update(void);
void s7kinc_shutdown(void);
void s7kinc_init(s7_scheme *sc);


#endif // S7KINC_CORE_H_
