#include <mruby.h>
#include <mruby/array.h>
#include <mruby/data.h>
#include <mruby/value.h>

/*
 *  mruby.h
 */

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
struct mrb_context *mrb_state_get_context(mrb_state *mrb) {
    return mrb->c;
}
struct mrb_context *mrb_state_get_root_context(mrb_state *mrb) {
    return mrb->root_c;
}

struct mrb_context *mrb_context_prev(struct mrb_context *cxt) {
    return cxt->prev;
}
mrb_callinfo *mrb_context_callinfo(struct mrb_context *cxt) {
    return cxt->ci;
}
enum mrb_fiber_state mrb_context_fiber_state(struct mrb_context *cxt) {
    return cxt->status;
}
struct RFiber *mrb_context_fiber(struct mrb_context *cxt) {
    return cxt->fib;
}

uint8_t mrb_callinfo_n(mrb_callinfo *ci) {
    return ci->n;
}
uint8_t mrb_callinfo_nk(mrb_callinfo *ci) {
    return ci->nk;
}
uint8_t mrb_callinfo_cci(mrb_callinfo *ci) {
    return ci->cci;
}
mrb_sym mrb_callinfo_mid(mrb_callinfo *ci) {
    return ci->mid;
}
mrb_value *mrb_callinfo_stack(mrb_callinfo *ci) {
    return ci->stack;
}
const struct RProc *mrb_callinfo_proc(mrb_callinfo *ci) {
    return ci->proc;
}


/*
 *   mruby/array.h
 */

struct RArray *mrb_ary_get_ptr(mrb_value val) {
    return mrb_ary_ptr(val);
}
mrb_value mrb_ary_get_value(struct RArray *p) {
    return mrb_ary_value(p);
}
mrb_int mrb_ary_len(struct RArray *p) {
    return ARY_LEN(p);
}

/*
 *  mruby/<boxing>.h
 */

void *mrb_get_ptr(mrb_value v) {
    return mrb_ptr(v);
}
void *mrb_get_cptr(mrb_value v) {
    return mrb_cptr(v);
}
mrb_float mrb_get_float(mrb_value v) {
    return mrb_float(v);
}
mrb_int mrb_get_integer(mrb_value v) {
    return mrb_integer(v);
}
mrb_sym mrb_get_sym(mrb_value v) {
    return mrb_symbol(v);
}
mrb_bool mrb_get_bool(mrb_value v) {
    return mrb_bool(v);
}

/*
 *  mruby/data.h
 */

void *mrb_rdata_data(struct RData *data) {
    return data->data;
}
void *mrb_rdata_type(struct RData *data) {
    return data->type;
}

/*
 *  mruby/value.h
 */

mrb_value mrb_get_float_value(struct mrb_state *mrb, mrb_float f) {
    return mrb_float_value(mrb, f);
}
mrb_value mrb_get_cptr_value(struct mrb_state *mrb, void *p) {
    return mrb_cptr_value(mrb, p);
}
mrb_value mrb_get_int_value(struct mrb_state *mrb, mrb_int i) {
    return mrb_int_value(mrb, i);
}
mrb_value mrb_get_fixnum_value(mrb_int i) {
    return mrb_fixnum_value(i);
}
mrb_value mrb_get_symbol_value(mrb_sym i) {
    return mrb_symbol_value(i);
}
mrb_value mrb_get_obj_value(void *p) {
    return mrb_obj_value(p);
}
mrb_value mrb_get_nil_value(void) {
    return mrb_nil_value();
}
mrb_value mrb_get_false_value(void) {
    return mrb_false_value();
}
mrb_value mrb_get_true_value(void) {
    return mrb_true_value();
}
mrb_value mrb_get_bool_value(mrb_bool boolean) {
    return mrb_bool_value(boolean);
}
mrb_value mrb_get_undef_value(void) {
    return mrb_undef_value();
}
