#include "s7ctypes.h"

int s7ctypes_name_to_s7tag(s7_scheme *sc, const char *name) {
    s7_pointer s7let, c_types, c_type, iter;
    int type = -1;

    s7let = s7_let_ref(sc, s7_rootlet(sc), s7_make_symbol(sc, "*s7*"));
    c_types = s7_let_ref(sc, s7let, s7_make_symbol(sc, "c-types"));
    iter = s7_make_iterator(sc, c_types);
    if (s7_iterator_is_at_end(sc, iter))
        return -1; // No c-types.

    // As c-types are assigned sequentially, run through whole list to capture
    // type of most recent duplicate name in the case of develop mode duplicates.
    for(int i = 0; !s7_iterator_is_at_end(sc, iter); i++) {
        c_type = s7_iterate(sc, iter);
        if (0 == strcmp(s7_string(c_type), name))
            type = i;
    }
    return(type);
}
