#include "s7ctypes.h"


/* A wrapped int array c-type
 * TODO: to_string, to_list, support return of references ala s7_make_c_pointer? */

static s7_int wrapped_int_array_s7tag = -1;

static s7_pointer wrapped_int_array__ref(s7_scheme *sc, s7_pointer args) {
    s7_pointer obj, arg;
    s7_int obj_type;
    int *array;
    int index;

    if (s7_list_length(sc, args) != 2)
        return(s7_wrong_number_of_args_error(sc, "wrapped_int_array__ref takes 2 arguments: ~S", args));

    obj = s7_car(args);
    obj_type = s7_c_object_type(obj);
    if (obj_type != wrapped_int_array_s7tag)
        return(s7_wrong_type_arg_error(sc, "wrapped_int_array__ref", 1, obj, "a <wrapped_int_array>"));
    array = (int *)s7_c_object_value(s7_car(args));

    arg = s7_cadr(args);
    if (!s7_is_integer(arg))
        return(s7_wrong_type_arg_error(sc, "wrapped_int_array__ref", 2, arg, "an integer"));

    index = (int)s7_integer(arg);
    return(s7_make_integer(sc, array[index]));
}

static s7_pointer wrapped_int_array__set(s7_scheme *sc, s7_pointer args) {
    s7_pointer obj, arg;
    s7_int obj_type;
    int *array;
    int index, new_int;

    if (s7_list_length(sc, args) != 3)
        return(s7_wrong_number_of_args_error(sc, "wrapped_int_array__set takes 3 arguments: ~S", args));

    obj = s7_car(args);
    obj_type = s7_c_object_type(obj);
    if (obj_type != wrapped_int_array_s7tag)
        return(s7_wrong_type_arg_error(sc, "wrapped_int_array__set", 1, obj, "a <wrapped_int_array>"));
    array = (int *)s7_c_object_value(s7_car(args));

    arg = s7_cadr(args);
    if (!s7_is_integer(arg))
        return(s7_wrong_type_arg_error(sc, "wrapped_int_array__set", 2, arg, "an integer"));
    index = (int)s7_integer(arg);

    arg = s7_caddr(args);
    if (!s7_is_integer(arg))
        return(s7_wrong_type_arg_error(sc, "wrapped_int_array__set", 3, arg, "an integer"));
    new_int = (int)s7_integer(arg);

    array[index] = new_int;
    return(s7_cadr(args));
}

static s7_pointer wrapped_int_array__make(s7_scheme *sc, int *array) {
    return(s7_make_c_object(sc, wrapped_int_array_s7tag, (void *)array));
}


/* Utility functions */

void s7ctypes_configure_primitives(s7_scheme *sc) {
    // NOTE: wrapped_int_array
    //       There is no __free func as this type only wraps.
    wrapped_int_array_s7tag = s7_make_c_type(sc, "<wrapped_int_array>");
    s7_define_variable_with_documentation(sc, "<wrapped_int_array>", s7_make_integer(sc, wrapped_int_array_s7tag), "The internal type tag (an integer) for the wrapped_int_array C type.");
    s7_c_type_set_ref(sc, wrapped_int_array_s7tag, wrapped_int_array__ref);
    s7_c_type_set_set(sc, wrapped_int_array_s7tag, wrapped_int_array__set);

    // TODO: wrapped_float_array
}

s7_int s7ctypes_name_to_s7tag(s7_scheme *sc, const char *name) {
    s7_pointer s7let, c_types, c_type, iter;
    s7_int type = -1;

    s7let = s7_let_ref(sc, s7_rootlet(sc), s7_make_symbol(sc, "*s7*"));
    c_types = s7_let_ref(sc, s7let, s7_make_symbol(sc, "c-types"));
    iter = s7_make_iterator(sc, c_types);
    if (s7_iterator_is_at_end(sc, iter))
        return -1; // No c-types.

    // As c-types are assigned sequentially, run through whole list to capture
    // type of most recent duplicate name in the case of develop mode duplicates.
    s7_int index = 0;
    c_type = s7_iterate(sc, iter);
    while (!s7_iterator_is_at_end(sc, iter)) {
        if (0 == strcmp(s7_string(c_type), name))
            type = index;
        index++;
        c_type = s7_iterate(sc, iter);
    }

    return(type);
}

s7_pointer s7ctypes_wrap_int_array(s7_scheme *sc, int *array) {
    return(wrapped_int_array__make(sc, array));
}
