#include <mruby.h>

struct RObject *mrb_state_get_exc(mrb_state *mrb) {
    return mrb->exc;
}
struct RObject *mrb_state_get_top_self(mrb_state *mrb) {
    return mrb->top_self;
}
struct RClass *mrb_state_get_object_class(mrb_state *mrb) {
    return mrb->object_class;
}
struct RClass *mrb_state_get_class_class(mrb_state *mrb) {
    return mrb->class_class;
}
struct RClass *mrb_state_get_module_class(mrb_state *mrb) {
    return mrb->module_class;
}
struct RClass *mrb_state_get_proc_class(mrb_state *mrb) {
    return mrb->proc_class;
}
struct RClass *mrb_state_get_string_class(mrb_state *mrb) {
    return mrb->string_class;
}
struct RClass *mrb_state_get_array_class(mrb_state *mrb) {
    return mrb->array_class;
}
struct RClass *mrb_state_get_hash_class(mrb_state *mrb) {
    return mrb->hash_class;
}
struct RClass *mrb_state_get_range_class(mrb_state *mrb) {
    return mrb->range_class;
}
struct RClass *mrb_state_get_float_class(mrb_state *mrb) {
    return mrb->float_class;
}
struct RClass *mrb_state_get_integer_class(mrb_state *mrb) {
    return mrb->integer_class;
}
struct RClass *mrb_state_get_true_class(mrb_state *mrb) {
    return mrb->true_class;
}
struct RClass *mrb_state_get_false_class(mrb_state *mrb) {
    return mrb->false_class;
}
struct RClass *mrb_state_get_nil_class(mrb_state *mrb) {
    return mrb->nil_class;
}
struct RClass *mrb_state_get_symbol_class(mrb_state *mrb) {
    return mrb->symbol_class;
}
struct RClass *mrb_state_get_kernel_module(mrb_state *mrb) {
    return mrb->kernel_module;
}
