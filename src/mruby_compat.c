/* Copyright (c) 2022 Dante Catalfamo */
/* SPDX-License-Identifier: MIT */

#include <mruby.h>
#include <mruby/array.h>
#include <mruby/data.h>
#include <mruby/value.h>
#include <mruby/error.h>
#include <mruby/range.h>
#include <mruby/class.h>

/*
 *  mruby.h
 */

struct RObject *mrb_state_get_exc(mrb_state *mrb) {
    return mrb->exc;
}
void mrb_state_set_exc(mrb_state *mrb, struct RObject *exc) {
    mrb->exc = exc;
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

int mrb_gc_arena_save1(mrb_state *mrb) {
    return mrb_gc_arena_save(mrb);
}
void mrb_gc_arena_restore1(mrb_state *mrb, int idx) {
    mrb->gc.arena_idx = idx;
}

char *mrb_utf8_from_locale1(p, l) {
    return mrb_utf8_from_locale(p, l);
}
char *mrb_locale_from_utf81(p, l) {
    return mrb_locale_from_utf8(p, l);
}
void mrb_locale_free1(p) {
    mrb_locale_free(p);
}
void mrb_utf8_free1(p) {
    mrb_utf8_free(p);
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
mrb_int mrb_ary_capa(struct RArray *p) {
    return ARY_CAPA(p);
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

mrb_bool mrb_get_immediate_p(mrb_value v) {
    return mrb_immediate_p(v);
}
mrb_bool mrb_get_fixnum_p(mrb_value o) {
    return mrb_fixnum_p(o);
}
mrb_bool mrb_get_integer_p(mrb_value o) {
    return mrb_integer_p(o);
}
mrb_bool mrb_get_symbol_p(mrb_value o) {
    return mrb_symbol_p(o);
}
mrb_bool mrb_get_undef_p(mrb_value o) {
    return mrb_undef_p(o);
}
mrb_bool mrb_get_nil_p(mrb_value o) {
    return mrb_nil_p(o);
}
mrb_bool mrb_get_false_p(mrb_value o) {
    return mrb_false_p(o);
}
mrb_bool mrb_get_true_p(mrb_value o) {
    return mrb_true_p(o);
}
mrb_bool mrb_get_float_p(mrb_value o) {
    return mrb_float_p(o);
}
mrb_bool mrb_get_array_p(mrb_value o) {
    return mrb_array_p(o);
}
mrb_bool mrb_get_string_p(mrb_value o) {
    return mrb_string_p(o);
}
mrb_bool mrb_get_hash_p(mrb_value o) {
    return mrb_hash_p(o);
}
mrb_bool mrb_get_cptr_p(mrb_value o) {
    return mrb_cptr_p(o);
}
mrb_bool mrb_get_exception_p(mrb_value o) {
    return mrb_exception_p(o);
}
mrb_bool mrb_get_free_p(mrb_value o) {
    return mrb_free_p(o);
}
mrb_bool mrb_get_object_p(mrb_value o) {
    return mrb_object_p(o);
}
mrb_bool mrb_get_class_p(mrb_value o) {
    return mrb_class_p(o);
}
mrb_bool mrb_get_module_p(mrb_value o) {
    return mrb_module_p(o);
}
mrb_bool mrb_get_iclass_p(mrb_value o) {
    return mrb_iclass_p(o);
}
mrb_bool mrb_get_sclass_p(mrb_value o) {
    return mrb_sclass_p(o);
}
mrb_bool mrb_get_proc_p(mrb_value o) {
    return mrb_proc_p(o);
}
mrb_bool mrb_get_range_p(mrb_value o) {
    return mrb_range_p(o);
}
mrb_bool mrb_get_env_p(mrb_value o) {
    return mrb_env_p(o);
}
mrb_bool mrb_get_data_p(mrb_value o) {
    return mrb_data_p(o);
}
mrb_bool mrb_get_fiber_p(mrb_value o) {
    return mrb_fiber_p(o);
}
mrb_bool mrb_get_istruct_p(mrb_value o) {
    return mrb_istruct_p(o);
}
mrb_bool mrb_get_break_p(mrb_value o) {
    return mrb_break_p(o);
}

enum mrb_vtype mrb_get_type(mrb_value o) {
    return mrb_type(o);
}

/*
 * mruby/class.h
 */

struct RClass* mrb_get_class(mrb_state *mrb, mrb_value v) {
    return mrb_class(mrb, v);
}

/*
 *  mruby/data.h
 */

void mrb_data_init1(mrb_value v, void *ptr, const mrb_data_type *type) {
    mrb_data_init(v, ptr, type);
}
void *mrb_rdata_data(struct RData *data) {
    return data->data;
}
const struct mrb_data_type *mrb_rdata_type(struct RData *data) {
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

/*
 * mruby/error.h
 */

mrb_value mrb_break_value_get1(struct RBreak *brk) {
    return mrb_break_value_get(brk);
}
void mrb_break_value_set1(struct RBreak *brk, mrb_value val) {
    mrb_break_value_set(brk, val);
}
const struct RProc *mrb_break_proc_get1(struct RBreak *brk) {
    return mrb_break_proc_get(brk);
}
void mrb_break_proc_set1(struct RBreak *brk, struct RProc *proc) {
    mrb_break_proc_set(brk, proc);
}
uint32_t mrb_break_tag_get1(struct RBreak *brk) {
    return mrb_break_tag_get(brk);
}
void mrb_break_tag_set1(struct RBreak *brk, uint32_t tag) {
    return mrb_break_tag_set(brk, tag);
}

/*
 * mruby/object.h
 */

mrb_bool mrb_get_frozen_p(void *o) {
    return mrb_frozen_p((struct RBasic*)o);
}
void mrb_set_frozen(void *o) {
    MRB_SET_FROZEN_FLAG((struct RBasic*)o);
}
void mrb_unset_frozen(void *o) {
    MRB_UNSET_FROZEN_FLAG((struct RBasic*)o);
}

/*
 * mruby/range.h
 */

mrb_value mrb_range_beg1(mrb_state *mrb, mrb_value range) {
    return mrb_range_beg(mrb, range);
}
mrb_value mrb_range_end1(mrb_state *mrb, mrb_value range) {
    return mrb_range_end(mrb, range);
}
mrb_bool mrb_range_excl_p1(mrb_state *mrb, mrb_value range) {
    return mrb_range_excl_p(mrb, range);
}
