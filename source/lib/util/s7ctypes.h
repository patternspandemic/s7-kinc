#ifndef S7CTYPES_H_
#define S7CTYPES_H_


#include <stdio.h>
#include <string.h>

#include "../s7/s7.h"

void s7ctypes_configure_primitives(s7_scheme *sc);
s7_int s7ctypes_name_to_s7tag(s7_scheme *sc, const char *name);
s7_pointer s7ctypes_wrap_int_array(s7_scheme *sc, int *array);
s7_pointer s7ctypes_wrap_float_array(s7_scheme *sc, float *array);


#endif // S7CTYPES_H_
