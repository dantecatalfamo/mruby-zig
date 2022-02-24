const std = @import("std");
const FILE = std.c.FILE;

test "ref all decls" {
    std.testing.refAllDecls(@This());
}

// Struct hacks

pub extern fn mrb_state_get_exc(mrb: *mrb_state) ?*RObject;
pub extern fn mrb_state_get_top_self(mrb: *mrb_state) ?*RObject;
pub extern fn mrb_state_get_object_class(mrb: *mrb_state) ?*RClass;
pub extern fn mrb_state_get_class_class(mrb: *mrb_state) ?*RClass;
pub extern fn mrb_state_get_module_class(mrb: *mrb_state) ?*RClass;
pub extern fn mrb_state_get_proc_class(mrb: *mrb_state) ?*RClass;
pub extern fn mrb_state_get_string_class(mrb: *mrb_state) ?*RClass;
pub extern fn mrb_state_get_array_class(mrb: *mrb_state) ?*RClass;
pub extern fn mrb_state_get_hash_class(mrb: *mrb_state) ?*RClass;
pub extern fn mrb_state_get_range_class(mrb: *mrb_state) ?*RClass;
pub extern fn mrb_state_get_float_class(mrb: *mrb_state) ?*RClass;
pub extern fn mrb_state_get_integer_class(mrb: *mrb_state) ?*RClass;
pub extern fn mrb_state_get_true_class(mrb: *mrb_state) ?*RClass;
pub extern fn mrb_state_get_false_class(mrb: *mrb_state) ?*RClass;
pub extern fn mrb_state_get_nil_class(mrb: *mrb_state) ?*RClass;
pub extern fn mrb_state_get_symbol_class(mrb: *mrb_state) ?*RClass;
pub extern fn mrb_state_get_kernel_module(mrb: *mrb_state) ?*RClass;
pub extern fn mrb_gc_arena_save(mrb: *mrb_state) c_int;
pub extern fn mrb_gc_arena_restore(mrb: *mrb_state) void;


///////////////////////////////////
//            mruby.h            //
///////////////////////////////////

pub const mrb_gc = opaque {};
// TODO: mrb_gc and mrb_state can only be opaque until the bitfield
// situation is figured out

// pub const mrb_gc = extern struct {
//     heaps: ?*mrb_heap_page,
//     sweeps: ?*mrb_heap_page,
//     free_heaps: ?*mrb_heap_page,
//     live: usize,
//     arena_idx: i32,
//     state: mrb_gc_state,
//     current_white_part: i32,
//     gray_list: ?*RBasic,
//     atomic_gray_list: ?*RBasic,
//     live_after_mark: usize,
//     threshold: usize,
//     interval_ratio: i32,
//     step_ratio: i32,
//     iterating: u1,
//     disabled: u1,
//     full: u1,
//     generational: u1,
//     majorgc_old_threshold: usize
// };
pub const mrb_irep = opaque {};
pub const mrb_jmpbuf = opaque {};
pub const mrb_context = opaque {};
pub const mrb_state = opaque {};
// TODO: Figure out if zero-width types can be used when fields are disabled
// pub const mrb_state = extern struct {
//     jmp: *mrb_jmpbuf,

//     /// memory allocation function
//     allocf: mrb_allocf,
//     /// auxiliary data of allocf
//     allocf_ud: *anyopaque,

//     ctx: *mrb_context,
//     root_ctx: *mrb_context,
//     /// global variable table
//     globals: *iv_tbl,

//     /// exception
//     exc: *RObject,

//     top_self: *RObject,
//     /// Object class
//     object_class: *RClass,
//     class_class:  *RClass,
//     module_class: *RClass,
//     proc_class:   *RClass,
//     string_class: *RClass,
//     array_class:  *RClass,
//     hash_class:   *RClass,
//     range_class:  *RClass,

//     // HACK: Assume floats are enabled for now
//     // #ifndef MRB_NO_FLOAT
//     float_class: *RClass,
//     // #endif
//     integer_class: *RClass,
//     true_class:    *RClass,
//     false_class:   *RClass,
//     nil_class:     *RClass,
//     symbol_class:  *RClass,
//     kernel_module: *RClass,

//     gc: mrb_gc,

//     // HACK: assume method cache for now
//     // #ifndef MRB_NO_METHOD_CACHE
//     // HACK: MRB_METHOD_CACHE_SIZE is based on profile, assume main profile for now
//     cache: [1<<10]mrb_cache_entry,
//     // #endif

//     symidx: mrb_sym,
//     symtbl: [*][*:0]const u8,
//     symlink: *u8,
//     symflags: *u8,
//     symhash: [256]mrb_sym,
//     symcapa: usize,
//     // HACK: assume not using all_symbols for now
//     // #ifndef MRB_USE_ALL_SYMBOLS
//     /// buffer for small symbol names
//     symbuf: [8]u8,
//     //     #endif

//     // HACK: assume no debug hook for now
//     // #ifdef MRB_USE_DEBUG_HOOK
//     // void (*code_fetch_hook)(struct mrb_state* mrb, const struct mrb_irep *irep, const mrb_code *pc, mrb_value *regs);
//     // void (*debug_op_hook)(struct mrb_state* mrb, const struct mrb_irep *irep, const mrb_code *pc, mrb_value *regs);
//     // #endif

//     // HACK: assume bytecode decoder not used
//     //#ifdef MRB_BYTECODE_DECODE_OPTION
//     // mrb_code (*bytecode_decoder)(struct mrb_state* mrb, mrb_code code);
//     // #endif

//     eException_class: *RClass,
//     eStandardError_class: *RClass,
//     /// pre-allocated NoMemoryError
//     nomem_err: *RObject,
//     /// pre-allocated SysStackError
//     stack_err: *RObject,

//     // HACK: assume not fixed arena for now
//     // #ifdef MRB_GC_FIXED_ARENA
//     // struct RObject *arena_err;              /* pre-allocated arena overflow error */
//     // #endif

//     /// auxiliary data
//     ud: *anyopaque,

//     // HACK: assume not fixed atexit stack for now
//     // #ifdef MRB_FIXED_STATE_ATEXIT_STACK
//     // mrb_atexit_func atexit_stack[MRB_FIXED_STATE_ATEXIT_STACK_SIZE];
//     // #else
//     atexit_stack: [*]mrb_atexit_func,
//     // #endif
//     atexit_stack_len: u16,
// };

pub const mrb_callinfo = opaque {};
pub const mrb_jumpbuf = opaque {};
pub const mrb_pool = opaque {};
pub const mrb_method_t = opaque {};
pub const mrb_cache_entry = opaque {};
pub const mrb_code = u8;
pub const mrb_aspec = u32;
pub const mrb_sym = u32;
pub const mrb_bool = bool;
pub const mrb_noreturn = noreturn;
pub const mrb_ssize = isize;
pub const mrb_int = isize;
pub const mrb_uint = usize;
pub const mrb_float = f64; // HACK: assume 64-bit float for now
pub const mrb_value = extern struct { w: usize }; // HACK: assume word boxing for now

pub const iv_tbl = opaque {};

pub const mrb_fiber_state = enum(c_int) {
  MRB_FIBER_CREATED,
  MRB_FIBER_RUNNING,
  MRB_FIBER_RESUMED,
  MRB_FIBER_SUSPENDED,
  MRB_FIBER_TRANSFERRED,
  MRB_FIBER_TERMINATED,
};

pub const RClass = opaque {};
pub const RObject = opaque {};
pub const RBasic = opaque {};
pub const RProc = opaque {};

/// Function pointer type for a function callable by mruby.
///
/// The arguments to the function are stored on the mrb_state. To get them see mrb_get_args
///
/// @param mrb The mruby state
/// @param self The self object
/// @return [mrb_value] The function's return value
pub const mrb_func_t = fn (mrb: *mrb_state, self: mrb_value) callconv(.C) mrb_value;
pub const mrb_atexit_func = fn (mrb: *mrb_state) callconv(.C) void;

/// Function pointer type of custom allocator used in @see mrb_open_allocf.
///
/// The function pointing it must behave similarly as realloc except:
/// - If ptr is NULL it must allocate new space.
/// - If s is NULL, ptr must be freed.
///
/// See @see mrb_default_allocf for the default implementation.
pub const mrb_allocf = fn (mrb: *mrb_state, ptr: *anyopaque, size: usize, ud: *anyopaque) callconv(.C) *anyopaque;

// TODO: make this work
// #define MRB_VTYPE_FOREACH(f) \
//     /* mrb_vtype */     /* c type */        /* ruby class */ \
//   f(MRB_TT_FALSE,       void,               "false") \
//   f(MRB_TT_TRUE,        void,               "true") \
//   f(MRB_TT_SYMBOL,      void,               "Symbol") \
//   f(MRB_TT_UNDEF,       void,               "undefined") \
//   f(MRB_TT_FREE,        void,               "free") \
//   f(MRB_TT_FLOAT,       struct RFloat,      "Float") \
//   f(MRB_TT_INTEGER,     struct RInteger,    "Integer") \
//   f(MRB_TT_CPTR,        struct RCptr,       "cptr") \
//   f(MRB_TT_OBJECT,      struct RObject,     "Object") \
//   f(MRB_TT_CLASS,       struct RClass,      "Class") \
//   f(MRB_TT_MODULE,      struct RClass,      "Module") \
//   f(MRB_TT_ICLASS,      struct RClass,      "iClass") \
//   f(MRB_TT_SCLASS,      struct RClass,      "SClass") \
//   f(MRB_TT_PROC,        struct RProc,       "Proc") \
//   f(MRB_TT_ARRAY,       struct RArray,      "Array") \
//   f(MRB_TT_HASH,        struct RHash,       "Hash") \
//   f(MRB_TT_STRING,      struct RString,     "String") \
//   f(MRB_TT_RANGE,       struct RRange,      "Range") \
//   f(MRB_TT_EXCEPTION,   struct RException,  "Exception") \
//   f(MRB_TT_ENV,         struct REnv,        "env") \
//   f(MRB_TT_DATA,        struct RData,       "Data") \
//   f(MRB_TT_FIBER,       struct RFiber,      "Fiber") \
//   f(MRB_TT_STRUCT,      struct RArray,      "Struct") \
//   f(MRB_TT_ISTRUCT,     struct RIStruct,    "istruct") \
//   f(MRB_TT_BREAK,       struct RBreak,      "break") \
//   f(MRB_TT_COMPLEX,     struct RComplex,    "Complex") \
//   f(MRB_TT_RATIONAL,    struct RRational,   "Rational")

pub const mrb_vtype = enum(c_int) {
  MRB_TT_FALSE,
  MRB_TT_TRUE,
  MRB_TT_SYMBOL,
  MRB_TT_UNDEF,
  MRB_TT_FREE,
  MRB_TT_FLOAT,
  MRB_TT_INTEGER,
  MRB_TT_CPTR,
  MRB_TT_OBJECT,
  MRB_TT_CLASS,
  MRB_TT_MODULE,
  MRB_TT_ICLASS,
  MRB_TT_SCLASS,
  MRB_TT_PROC,
  MRB_TT_ARRAY,
  MRB_TT_HASH,
  MRB_TT_STRING,
  MRB_TT_RANGE,
  MRB_TT_EXCEPTION,
  MRB_TT_ENV,
  MRB_TT_DATA,
  MRB_TT_FIBER,
  MRB_TT_STRUCT,
  MRB_TT_ISTRUCT,
  MRB_TT_BREAK,
  MRB_TT_COMPLEX,
  MRB_TT_RATIONAL,
};

/// Defines a new class.
///
/// If you're creating a gem it may look something like this:
///
///      !!!c
///      void mrb_example_gem_init(mrb_state* mrb) {
///          struct RClass *example_class;
///          example_class = mrb_define_class(mrb, "Example_Class", mrb->object_class);
///      }
///
///      void mrb_example_gem_final(mrb_state* mrb) {
///          //free(TheAnimals);
///      }
///
/// @param mrb The current mruby state.
/// @param name The name of the defined class.
/// @param super The new class parent.
/// @return [struct RClass *] Reference to the newly defined class.
/// @see mrb_define_class_under
pub extern fn mrb_define_class(mrb: *mrb_state, name: [*:0]const u8, super: *RClass) ?*RClass;
pub extern fn mrb_define_class_id(mrb: *mrb_state, name: mrb_sym, super: *RClass) ?*RClass;

/// Defines a new module.
///
/// @param mrb The current mruby state.
/// @param name The name of the module.
/// @return [struct RClass *] Reference to the newly defined module.
pub extern fn mrb_define_module(mrb: *mrb_state, name: [*:0]const u8) ?*RClass;
pub extern fn mrb_define_module_id(mrb: *mrb_state, name: mrb_sym) ?*RClass;

pub extern fn mrb_singleton_class(mrb: *mrb_state, val: mrb_value) mrb_value;
pub extern fn mrb_singleton_class_ptr(mrb: *mrb_state, val: mrb_value) ?*RClass;

/// Include a module in another class or module.
/// Equivalent to:
///
///   module B
///     include A
///   end
/// @param mrb The current mruby state.
/// @param cla A reference to module or a class.
/// @param included A reference to the module to be included.
pub extern fn mrb_include_module(mrb: *mrb_state, cla: *RClass, included: *RClass) void;

/// Prepends a module in another class or module.
///
/// Equivalent to:
///  module B
///    prepend A
///  end
/// @param mrb The current mruby state.
/// @param cla A reference to module or a class.
/// @param prepended A reference to the module to be prepended.
pub extern fn mrb_prepend_module(mrb: *mrb_state, cla: *RClass, prepended: *RClass) void;

/// Defines a global function in ruby.
///
/// If you're creating a gem it may look something like this
///
/// Example:
///
///     mrb_value example_method(mrb_state* mrb, mrb_value self)
///     {
///          puts("Executing example command!");
///          return self;
///     }
///
///     void mrb_example_gem_init(mrb_state* mrb)
///     {
///           mrb_define_method(mrb, mrb->kernel_module, "example_method", example_method, MRB_ARGS_NONE());
///     }
///
/// @param mrb The MRuby state reference.
/// @param cla The class pointer where the method will be defined.
/// @param name The name of the method being defined.
/// @param func The function pointer to the method definition.
/// @param aspec The method parameters declaration.
pub extern fn mrb_define_method(mrb: *mrb_state, cla: *RClass, name: [*:0]const u8, func: mrb_func_t, aspec: mrb_aspec) void;
pub extern fn mrb_define_method_id(mrb: *mrb_state, cla: *RClass, mid: mrb_sym, func: mrb_func_t, aspec: mrb_aspec) void;

/// Defines a class method.
///
/// Example:
///
///     # Ruby style
///     class Foo
///       def Foo.bar
///       end
///     end
///     // C style
///     mrb_value bar_method(mrb_state* mrb, mrb_value self){
///       return mrb_nil_value();
///     }
///     void mrb_example_gem_init(mrb_state* mrb){
///       struct RClass *foo;
///       foo = mrb_define_class(mrb, "Foo", mrb->object_class);
///       mrb_define_class_method(mrb, foo, "bar", bar_method, MRB_ARGS_NONE());
///     }
/// @param mrb The MRuby state reference.
/// @param cla The class where the class method will be defined.
/// @param name The name of the class method being defined.
/// @param fun The function pointer to the class method definition.
/// @param aspec The method parameters declaration.
pub extern fn mrb_define_class_method(mrb: *mrb_state, cla: *RClass, name: [*:0]const u8, fun: mrb_func_t, aspec: mrb_aspec) void;
pub extern fn mrb_define_class_method_id(mrb: *mrb_state, cla: *RClass, name: mrb_sym, fun: mrb_func_t, aspec: mrb_aspec) void;

/// Defines a singleton method
///
/// @see mrb_define_class_method
pub extern fn mrb_define_singleton_method(mrb: *mrb_state, cla: *RObject, name: [*:0]const u8, fun: mrb_func_t, aspec: mrb_aspec) void;
pub extern fn mrb_define_singleton_method_id(mrb: *mrb_state, cla: *RObject, name: mrb_sym, fun: mrb_func_t, aspec: mrb_aspec) void;

///  Defines a module function.
///
/// Example:
///
///        # Ruby style
///        module Foo
///          def Foo.bar
///          end
///        end
///        // C style
///        mrb_value bar_method(mrb_state* mrb, mrb_value self){
///          return mrb_nil_value();
///        }
///        void mrb_example_gem_init(mrb_state* mrb){
///          struct RClass *foo;
///          foo = mrb_define_module(mrb, "Foo");
///          mrb_define_module_function(mrb, foo, "bar", bar_method, MRB_ARGS_NONE());
///        }
///  @param mrb The MRuby state reference.
///  @param cla The module where the module function will be defined.
///  @param name The name of the module function being defined.
///  @param fun The function pointer to the module function definition.
///  @param aspec The method parameters declaration.
pub extern fn mrb_define_module_function(mrb: *mrb_state, cla: *RClass, name: [*:0]const u8, fun: mrb_func_t, aspec: mrb_aspec) void;
pub extern fn mrb_define_module_function_id(mrb: *mrb_state, cla: *RClass, name: mrb_sym, fun: mrb_func_t, aspec: mrb_aspec) void;

///  Defines a constant.
///
/// Example:
///
///          # Ruby style
///          class ExampleClass
///            AGE = 22
///          end
///          // C style
///          #include <stdio.h>
///          #include <mruby.h>
///
///          void
///          mrb_example_gem_init(mrb_state* mrb){
///            mrb_define_const(mrb, mrb->kernel_module, "AGE", mrb_fixnum_value(22));
///          }
///
///          mrb_value
///          mrb_example_gem_final(mrb_state* mrb){
///          }
///  @param mrb The MRuby state reference.
///  @param cla A class or module the constant is defined in.
///  @param name The name of the constant being defined.
///  @param val The value for the constant.
pub extern fn mrb_define_const(mrb: *mrb_state, cla: *RClass, name: [*:0]const u8, val: mrb_value) void;
pub extern fn mrb_define_const_id(mrb: *mrb_state, cla: *RClass, name: mrb_sym, val: mrb_value) void;

/// Undefines a method.
///
/// Example:
///
///     # Ruby style
///
///     class ExampleClassA
///       def example_method
///         "example"
///       end
///     end
///     ExampleClassA.new.example_method # => example
///
///     class ExampleClassB < ExampleClassA
///       undef_method :example_method
///     end
///
///     ExampleClassB.new.example_method # => undefined method 'example_method' for ExampleClassB (NoMethodError)
///
///     // C style
///     #include <stdio.h>
///     #include <mruby.h>
///
///     mrb_value
///     mrb_example_method(mrb_state *mrb){
///       return mrb_str_new_lit(mrb, "example");
///     }
///
///     void
///     mrb_example_gem_init(mrb_state* mrb){
///       struct RClass *example_class_a;
///       struct RClass *example_class_b;
///       struct RClass *example_class_c;
///
///       example_class_a = mrb_define_class(mrb, "ExampleClassA", mrb->object_class);
///       mrb_define_method(mrb, example_class_a, "example_method", mrb_example_method, MRB_ARGS_NONE());
///       example_class_b = mrb_define_class(mrb, "ExampleClassB", example_class_a);
///       example_class_c = mrb_define_class(mrb, "ExampleClassC", example_class_b);
///       mrb_undef_method(mrb, example_class_c, "example_method");
///     }
///
///     mrb_example_gem_final(mrb_state* mrb){
///     }
/// @param mrb The mruby state reference.
/// @param cla The class the method will be undefined from.
/// @param name The name of the method to be undefined.
pub extern fn mrb_undef_method(mrb: *mrb_state, cla: *RClass, name: [*:0]const u8) void;
pub extern fn mrb_undef_method_id(mrb_state: *mrb_state, RClass: *RClass, sym: mrb_sym) void;

/// Undefine a class method.
/// Example:
///
///      # Ruby style
///      class ExampleClass
///        def self.example_method
///          "example"
///        end
///      end
///
///     ExampleClass.example_method
///
///     // C style
///     #include <stdio.h>
///     #include <mruby.h>
///
///     mrb_value
///     mrb_example_method(mrb_state *mrb){
///       return mrb_str_new_lit(mrb, "example");
///     }
///
///     void
///     mrb_example_gem_init(mrb_state* mrb){
///       struct RClass *example_class;
///       example_class = mrb_define_class(mrb, "ExampleClass", mrb->object_class);
///       mrb_define_class_method(mrb, example_class, "example_method", mrb_example_method, MRB_ARGS_NONE());
///       mrb_undef_class_method(mrb, example_class, "example_method");
///      }
///
///      void
///      mrb_example_gem_final(mrb_state* mrb){
///      }
/// @param mrb The mruby state reference.
/// @param cls A class the class method will be undefined from.
/// @param name The name of the class method to be undefined.
pub extern fn mrb_undef_class_method(mrb: *mrb_state, cls: *RClass, name: [*:0]const u8) void;
pub extern fn mrb_undef_class_method_id(mrb: *mrb_state, cls: *RClass, name: mrb_sym) void;

/// Initialize a new object instance of c class.
///
/// Example:
///
///     # Ruby style
///     class ExampleClass
///     end
///
///     p ExampleClass # => #<ExampleClass:0x9958588>
///     // C style
///     #include <stdio.h>
///     #include <mruby.h>
///
///     void
///     mrb_example_gem_init(mrb_state* mrb) {
///       struct RClass *example_class;
///       mrb_value obj;
///       example_class = mrb_define_class(mrb, "ExampleClass", mrb->object_class); # => class ExampleClass; end
///       obj = mrb_obj_new(mrb, example_class, 0, NULL); # => ExampleClass.new
///       mrb_p(mrb, obj); // => Kernel#p
///      }
/// @param mrb The current mruby state.
/// @param cla Reference to the class of the new object.
/// @param argc Number of arguments in argv
/// @param argv Array of mrb_value to initialize the object
/// @return [mrb_value] The newly initialized object
pub extern fn mrb_obj_new(mrb: *mrb_state, cla: *RClass, argc: mrb_int, argv: [*]const mrb_value) mrb_value;

/// @see mrb_obj_new
pub fn mrb_class_new_instance(mrb: *mrb_state, argc: mrb_int, argv: [*]const mrb_value, cla: *RClass) mrb_value {
  return mrb_obj_new(mrb,cla,argc,argv);
}

/// Creates a new instance of Class, Class.
///
/// Example:
///
///      void
///      mrb_example_gem_init(mrb_state* mrb) {
///        struct RClass *example_class;
///
///        mrb_value obj;
///        example_class = mrb_class_new(mrb, mrb->object_class);
///        obj = mrb_obj_new(mrb, example_class, 0, NULL); // => #<#<Class:0x9a945b8>:0x9a94588>
///        mrb_p(mrb, obj); // => Kernel#p
///       }
///
/// @param mrb The current mruby state.
/// @param super The super class or parent.
/// @return [struct RClass *] Reference to the new class.
pub extern fn mrb_class_new(mrb: *mrb_state, super: *RClass) ?*RClass;

/// Creates a new module, Module.
///
/// Example:
///      void
///      mrb_example_gem_init(mrb_state* mrb) {
///        struct RClass *example_module;
///
///        example_module = mrb_module_new(mrb);
///      }
///
/// @param mrb The current mruby state.
/// @return [struct RClass *] Reference to the new module.
pub extern fn mrb_module_new(mrb: *mrb_state) ?*RClass;

/// Returns an mrb_bool. True if class was defined, and false if the class was not defined.
///
/// Example:
///     void
///     mrb_example_gem_init(mrb_state* mrb) {
///       struct RClass *example_class;
///       mrb_bool cd;
///
///       example_class = mrb_define_class(mrb, "ExampleClass", mrb->object_class);
///       cd = mrb_class_defined(mrb, "ExampleClass");
///
///       // If mrb_class_defined returns 1 then puts "True"
///       // If mrb_class_defined returns 0 then puts "False"
///       if (cd == 1){
///         puts("True");
///       }
///       else {
///         puts("False");
///       }
///      }
///
/// @param mrb The current mruby state.
/// @param name A string representing the name of the class.
/// @return [mrb_bool] A boolean value.
pub extern fn mrb_class_defined(mrb: *mrb_state, name: [*:0]const u8) mrb_bool;
pub extern fn mrb_class_defined_id(mrb: *mrb_state, name: mrb_sym) mrb_bool;

/// Gets a class.
/// @param mrb The current mruby state.
/// @param name The name of the class.
/// @return [struct RClass *] A reference to the class.
pub extern fn mrb_class_get(mrb: *mrb_state, name: [*:0]const u8) ?*RClass;
pub extern fn mrb_class_get_id(mrb: *mrb_state, name: mrb_sym) ?*RClass;

/// Gets a exception class.
/// @param mrb The current mruby state.
/// @param name The name of the class.
/// @return [struct RClass *] A reference to the class.
pub extern fn mrb_exc_get_id(mrb: *mrb_state, name: mrb_sym) ?*RClass;

// TODO: uncomment once mrb_intern_cstr works
// pub fn mrb_exc_get(mrb: *mrb_state, name: [*:0]const u8) ?*RClass {
//     const name_sym = mrb_intern_cstr(mrb, name);
//     mrb_exc_get_id(mrb, name_sym);
// }

/// Returns an mrb_bool. True if inner class was defined, and false if the inner class was not defined.
///
/// Example:
///     void
///     mrb_example_gem_init(mrb_state* mrb) {
///       struct RClass *example_outer, *example_inner;
///       mrb_bool cd;
///
///       example_outer = mrb_define_module(mrb, "ExampleOuter");
///
///       example_inner = mrb_define_class_under(mrb, example_outer, "ExampleInner", mrb->object_class);
///       cd = mrb_class_defined_under(mrb, example_outer, "ExampleInner");
///
///       // If mrb_class_defined_under returns 1 then puts "True"
///       // If mrb_class_defined_under returns 0 then puts "False"
///       if (cd == 1){
///         puts("True");
///       }
///       else {
///         puts("False");
///       }
///      }
///
/// @param mrb The current mruby state.
/// @param outer The name of the outer class.
/// @param name A string representing the name of the inner class.
/// @return [mrb_bool] A boolean value.
pub extern fn mrb_class_defined_under(mrb: *mrb_state, outer: *RClass, name: [*:0]const u8) mrb_bool;
pub extern fn mrb_class_defined_under_id(mrb: *mrb_state, outer: *RClass, name: mrb_sym) mrb_bool;

/// Gets a child class.
/// @param mrb The current mruby state.
/// @param outer The name of the parent class.
/// @param name The name of the class.
/// @return [struct RClass *] A reference to the class.
pub extern fn mrb_class_get_under(mrb: *mrb_state, outer: *RClass, name: [*:0]const u8) ?*RClass;
pub extern fn mrb_class_get_under_id(mrb: *mrb_state, outer: *RClass, name: mrb_sym) ?*RClass;

/// Gets a module.
/// @param mrb The current mruby state.
/// @param name The name of the module.
/// @return [struct RClass *] A reference to the module.
pub extern fn mrb_module_get(mrb: *mrb_state, name: [*:0]const u8) ?*RClass;
pub extern fn mrb_module_get_id(mrb: *mrb_state, name: mrb_sym) ?*RClass;

/// Gets a module defined under another module.
/// @param mrb The current mruby state.
/// @param outer The name of the outer module.
/// @param name The name of the module.
/// @return [struct RClass *] A reference to the module.
pub extern fn mrb_module_get_under(mrb: *mrb_state, outer: *RClass, name: [*:0]const u8) ?*RClass;
pub extern fn mrb_module_get_under_id(mrb: *mrb_state, outer: *RClass, name: mrb_sym) ?*RClass;

/// a function to raise NotImplementedError with current method name
pub extern fn mrb_notimplement(mrb_state: *mrb_state) void;

/// a function to be replacement of unimplemented method
pub extern fn mrb_notimplement_m(mrb_state: *mrb_state, mrb_value: mrb_value) mrb_value;

/// Duplicate an object.
///
/// Equivalent to:
///   Object#dup
/// @param mrb The current mruby state.
/// @param obj Object to be duplicate.
/// @return [mrb_value] The newly duplicated object.
pub extern fn mrb_obj_dup(mrb: *mrb_state, obj: mrb_value) mrb_value;

/// Returns true if obj responds to the given method. If the method was defined for that
/// class it returns true, it returns false otherwise.
///
///      Example:
///      # Ruby style
///      class ExampleClass
///        def example_method
///        end
///      end
///
///      ExampleClass.new.respond_to?(:example_method) # => true
///
///      // C style
///      void
///      mrb_example_gem_init(mrb_state* mrb) {
///        struct RClass *example_class;
///        mrb_sym mid;
///        mrb_bool obj_resp;
///
///        example_class = mrb_define_class(mrb, "ExampleClass", mrb->object_class);
///        mrb_define_method(mrb, example_class, "example_method", exampleMethod, MRB_ARGS_NONE());
///        mid = mrb_intern_str(mrb, mrb_str_new_lit(mrb, "example_method" ));
///        obj_resp = mrb_obj_respond_to(mrb, example_class, mid); // => 1(true in Ruby world)
///
///        // If mrb_obj_respond_to returns 1 then puts "True"
///        // If mrb_obj_respond_to returns 0 then puts "False"
///        if (obj_resp == 1) {
///          puts("True");
///        }
///        else if (obj_resp == 0) {
///          puts("False");
///        }
///      }
///
/// @param mrb The current mruby state.
/// @param cla A reference to a class.
/// @param mid A symbol referencing a method id.
/// @return [mrb_bool] A boolean value.
pub extern fn mrb_obj_respond_to(mrb: *mrb_state, cla: *RClass, mid: mrb_sym) mrb_bool;

/// Defines a new class under a given module
///
/// @param mrb The current mruby state.
/// @param outer Reference to the module under which the new class will be defined
/// @param name The name of the defined class
/// @param super The new class parent
/// @return [struct RClass *] Reference to the newly defined class
/// @see mrb_define_class
pub extern fn mrb_define_class_under(mrb: *mrb_state, outer: *RClass, name: [*:0]const u8, super: *RClass) ?*RClass;
pub extern fn mrb_define_class_under_id(mrb: *mrb_state, outer: *RClass, name: mrb_sym, super: *RClass) ?*RClass;
pub extern fn mrb_define_module_under(mrb: *mrb_state, outer: *RClass, name: [*:0]const u8) ?*RClass;
pub extern fn mrb_define_module_under_id(mrb: *mrb_state, outer: *RClass, name: mrb_sym) ?*RClass;


/// Function requires n arguments.
///
/// @param n
///      The number of required arguments.
pub fn mrb_args_req(n: u32) mrb_aspec {
    return (n & 0x1f) << 18;
}

/// Function takes n optional arguments
///
/// @param n
///      The number of optional arguments.
pub fn mrb_args_opt(n: u32) mrb_aspec {
    return (n & 0x1f) << 13;
}

/// Function takes n1 mandatory arguments and n2 optional arguments
///
/// @param n1
///      The number of required arguments.
/// @param n2
///      The number of optional arguments.
pub fn mrb_args_arg(n1: u32, n2: u32) mrb_aspec {
    return mrb_args_req(n1) | mrb_args_opt(n2);
}

///  rest argument
pub fn mrb_args_rest() mrb_aspec {
    return 1 << 12;
}

///  required arguments after rest
pub fn mrb_args_post(n: u8) mrb_aspec {
    return (n & 0x1f) << 7;
}

///  keyword arguments (n of keys, kdict)
pub fn mrb_args_key(n1: u8, n2: u8) mrb_aspec {
    return ((n1 & 0x1f) << 2) | (if (n2 != 0) @as(u8, 1<<1) else 0);
}

/// Function takes a block argument
pub fn mrb_args_block() mrb_aspec {
    return 1;
}

/// Function accepts any number of arguments
pub fn mrb_args_any() mrb_aspec {
    return mrb_args_rest();
}

/// Function accepts no arguments
pub fn mrb_args_none() mrb_aspec {
    return 0;
}

/// Format specifiers for {mrb_get_args} function
///
/// Must be a C string composed of the following format specifiers:
///
/// | char | Ruby type      | C types           | Notes                                              |
/// |:----:|----------------|-------------------|----------------------------------------------------|
/// | `o`  | {Object}       | {mrb_value}       | Could be used to retrieve any type of argument     |
/// | `C`  | {Class}/{Module} | {mrb_value}     | when `!` follows, the value may be `nil`           |
/// | `S`  | {String}       | {mrb_value}       | when `!` follows, the value may be `nil`           |
/// | `A`  | {Array}        | {mrb_value}       | when `!` follows, the value may be `nil`           |
/// | `H`  | {Hash}         | {mrb_value}       | when `!` follows, the value may be `nil`           |
/// | `s`  | {String}       | const char *, {mrb_int} | Receive two arguments; `s!` gives (`NULL`,`0`) for `nil` |
/// | `z`  | {String}       | const char *      | `NULL` terminated string; `z!` gives `NULL` for `nil` |
/// | `a`  | {Array}        | const {mrb_value} *, {mrb_int} | Receive two arguments; `a!` gives (`NULL`,`0`) for `nil` |
/// | `c`  | {Class}/{Module} | strcut RClass * | `c!` gives `NULL` for `nil`                        |
/// | `f`  | {Integer}/{Float} | {mrb_float}    |                                                    |
/// | `i`  | {Integer}/{Float} | {mrb_int}      |                                                    |
/// | `b`  | boolean        | {mrb_bool}        |                                                    |
/// | `n`  | {String}/{Symbol} | {mrb_sym}         |                                                    |
/// | `d`  | data           | void *, {mrb_data_type} const | 2nd argument will be used to check data type so it won't be modified; when `!` follows, the value may be `nil` |
/// | `I`  | inline struct  | void *, struct RClass | `I!` gives `NULL` for `nil`                    |
/// | `&`  | block          | {mrb_value}       | &! raises exception if no block given.             |
/// | `*`  | rest arguments | const {mrb_value} *, {mrb_int} | Receive the rest of arguments as an array; `*!` avoid copy of the stack.  |
/// | <code>\|</code> | optional     |                   | After this spec following specs would be optional. |
/// | `?`  | optional given | {mrb_bool}        | `TRUE` if preceding argument is given. Used to check optional argument is given. |
/// | `:`  | keyword args   | {mrb_kwargs} const | Get keyword arguments. @see mrb_kwargs |
///
/// @see mrb_get_args
///
/// Immediately after format specifiers it can add format modifiers:
///
/// | char | Notes                                                                                   |
/// |:----:|-----------------------------------------------------------------------------------------|
/// | `!`  | Switch to the alternate mode; The behaviour changes depending on the format specifier   |
/// | `+`  | Request a not frozen object; However, except nil value                                  |
pub const mrb_args_format = [*:0]const u8;

/// Get keyword arguments by `mrb_get_args()` with `:` specifier.
///
/// `mrb_kwargs::num` indicates that the total number of keyword values.
///
/// `mrb_kwargs::required` indicates that the specified number of keywords starting from the beginning of the `mrb_sym` array are required.
///
/// `mrb_kwargs::table` accepts a `mrb_sym` array of C.
///
/// `mrb_kwargs::values` is an object array of C, and the keyword argument corresponding to the `mrb_sym` array is assigned.
/// Note that `undef` is assigned if there is no keyword argument corresponding over `mrb_kwargs::required` to `mrb_kwargs::num`.
///
/// `mrb_kwargs::rest` is the remaining keyword argument that can be accepted as `**rest` in Ruby.
/// If `NULL` is specified, `ArgumentError` is raised when there is an undefined keyword.
///
/// Examples:
///
///      // def method(a: 1, b: 2)
///
///      uint32_t kw_num = 2;
///      uint32_t kw_required = 0;
///      mrb_sym kw_names[] = { mrb_intern_lit(mrb, "a"), mrb_intern_lit(mrb, "b") };
///      mrb_value kw_values[kw_num];
///      mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, NULL };
///
///      mrb_get_args(mrb, ":", &kwargs);
///      if (mrb_undef_p(kw_values[0])) { kw_values[0] = mrb_fixnum_value(1); }
///      if (mrb_undef_p(kw_values[1])) { kw_values[1] = mrb_fixnum_value(2); }
///
///
///      // def method(str, x:, y: 2, z: "default string", **opts)
///
///      mrb_value str, kw_rest;
///      uint32_t kw_num = 3;
///      uint32_t kw_required = 1;
///      // Note that `#include <mruby/presym.h>` is required beforehand because `MRB_SYM()` is used.
///      // If the usage of `MRB_SYM()` is not desired, replace it with `mrb_intern_lit()`.
///      mrb_sym kw_names[] = { MRB_SYM(x), MRB_SYM(y), MRB_SYM(z) };
///      mrb_value kw_values[kw_num];
///      mrb_kwargs kwargs = { kw_num, kw_required, kw_names, kw_values, &kw_rest };
///
///      mrb_get_args(mrb, "S:", &str, &kwargs);
///      // or: mrb_get_args(mrb, ":S", &kwargs, &str);
///      if (mrb_undef_p(kw_values[1])) { kw_values[1] = mrb_fixnum_value(2); }
///      if (mrb_undef_p(kw_values[2])) { kw_values[2] = mrb_str_new_cstr(mrb, "default string"); }
pub const mrb_kwargs = extern struct {
    /// number of keyword arguments
    num: u32,
    /// number of required keyword arguments
    required: u32,
    /// C array of symbols for keyword names
    table: *const mrb_sym,
    /// keyword argument values
    values: *mrb_value,
    /// keyword rest (dict)
    rest: *mrb_value
};

/// Retrieve arguments from mrb_state.
///
/// @param mrb The current MRuby state.
/// @param format is a list of format specifiers
/// @param ... The passing variadic arguments must be a pointer of retrieving type.
/// @return the number of arguments retrieved.
/// @see mrb_args_format
/// @see mrb_kwargs
pub extern fn mrb_get_args(mrb: *mrb_state, format: mrb_args_format, ...) mrb_int;

// TODO: after non-opaque mrb_state
// get method symbol
// pub fn mrb_get_mid(mrb: *mrb_state) mrb_sym {
//   return mrb.c.ci.mid;
// }

/// Retrieve number of arguments from mrb_state.
///
/// Correctly handles *splat arguments.
pub extern fn mrb_get_argc(mrb: *mrb_state) mrb_int;

/// Retrieve an array of arguments from mrb_state.
///
/// Correctly handles *splat arguments.
pub extern fn mrb_get_argv(mrb: *mrb_state) [*]const mrb_value;

/// Retrieve the first and only argument from mrb_state.
/// Raises ArgumentError unless the number of arguments is exactly one.
///
/// Correctly handles *splat arguments.
pub extern fn mrb_get_arg1(mrb: *mrb_state) mrb_value;

/// Check if a block argument is given from mrb_state.
pub extern fn mrb_block_given_p(mrb: *mrb_state) mrb_bool;

/// Call existing ruby functions.
///
/// Example:
///
///      #include <stdio.h>
///      #include <mruby.h>
///      #include "mruby/compile.h"
///
///      int
///      main()
///      {
///        mrb_int i = 99;
///        mrb_state *mrb = mrb_open();
///
///        if (!mrb) { }
///        FILE *fp = fopen("test.rb","r");
///        mrb_value obj = mrb_load_file(mrb,fp);
///        mrb_funcall(mrb, obj, "method_name", 1, mrb_fixnum_value(i));
///        mrb_funcall_id(mrb, obj, MRB_SYM(method_name), 1, mrb_fixnum_value(i));
///        fclose(fp);
///        mrb_close(mrb);
///      }
///
/// @param mrb The current mruby state.
/// @param val A reference to an mruby value.
/// @param name The name of the method.
/// @param argc The number of arguments the method has.
/// @param ... Variadic values(not type safe!).
/// @return [mrb_value] mruby function value.
pub extern fn mrb_funcall(mrb: *mrb_state, val: mrb_value, name: [*:0]const u8, argc: mrb_int, ...) mrb_value;
pub extern fn mrb_funcall_id(mrb: *mrb_state, val: mrb_value, mid: mrb_sym, argc: mrb_int, ...) mrb_value;

/// Call existing ruby functions. This is basically the type safe version of mrb_funcall.
///
///      #include <stdio.h>
///      #include <mruby.h>
///      #include "mruby/compile.h"
///      int
///      main()
///      {
///        mrb_state *mrb = mrb_open();
///        mrb_value obj = mrb_fixnum_value(1);
///
///        if (!mrb) { }
///
///        FILE *fp = fopen("test.rb","r");
///        mrb_value obj = mrb_load_file(mrb,fp);
///        mrb_funcall_argv(mrb, obj, MRB_SYM(method_name), 1, &obj); // Calling ruby function from test.rb.
///        fclose(fp);
///        mrb_close(mrb);
///       }
/// @param mrb The current mruby state.
/// @param val A reference to an mruby value.
/// @param name_sym The symbol representing the method.
/// @param argc The number of arguments the method has.
/// @param obj Pointer to the object.
/// @return [mrb_value] mrb_value mruby function value.
/// @see mrb_funcall
pub extern fn mrb_funcall_argv(mrb: *mrb_state, val: mrb_value, name: mrb_sym, argc: mrb_int, argv: [*]const mrb_value) mrb_value;

/// Call existing ruby functions with a block.
pub extern fn mrb_funcall_with_block(mrb: *mrb_state, val: mrb_value, name: mrb_sym, argc: mrb_int, argv: [*]const mrb_value, block: mrb_value) mrb_value;


/// `strlen` for character string literals (use with caution or `strlen` instead)
///  Adjacent string literals are concatenated in C/C++ in translation phase 6.
///  If `lit` is not one, the compiler will report a syntax error:
///   MSVC: "error C2143: syntax error : missing ')' before 'string'"
///   GCC:  "error: expected ')' before string constant"
pub fn mrb_strlen_lit(lit: [*:0]const u8) usize {
    return std.mem.len(lit);
}

/// Create a symbol from C string. But usually it's better to use MRB_SYM,
/// MRB_OPSYM, MRB_CVSYM, MRB_IVSYM, MRB_SYM_B, MRB_SYM_Q, MRB_SYM_E macros.
///
/// Example:
///
///     # Ruby style:
///     :pizza # => :pizza
///
///     // C style:
///     mrb_sym sym1 = mrb_intern_lit(mrb, "pizza"); //  => :pizza
///     mrb_sym sym2 = MRB_SYM(pizza);               //  => :pizza
///     mrb_sym sym3 = MRB_SYM_Q(pizza);             //  => :pizza?
///
/// @param mrb The current mruby state.
/// @param str The string to be symbolized
/// @return [mrb_sym] mrb_sym A symbol.
pub extern fn mrb_intern_cstr(mrb: *mrb_state, str: [*:0]const u8) mrb_sym;
pub extern fn mrb_intern(mrb_state: *mrb_state, char: [*:0]const u8, size: usize) mrb_sym;
pub extern fn mrb_intern_static(mrb_state: *mrb_state, char: [*:0]const u8, size: usize) mrb_sym;
pub fn mrb_intern_lit(mrb: *mrb_state, lit: [:0]const u8) mrb_sym {
    return mrb_intern_static(mrb, lit, mrb_strlen_lit(lit));
}
pub extern fn mrb_intern_str(mrb: *mrb_state, val: mrb_value) mrb_sym;
/// mrb_intern_check series functions returns 0 if the symbol is not defined
pub extern fn mrb_intern_check_cstr(mrb: *mrb_state, str: [*:0]const u8) mrb_sym;
pub extern fn mrb_intern_check(mrb: *mrb_state, str: [*:0]const u8, size: usize) mrb_sym;
pub extern fn mrb_intern_check_str(mrb: *mrb_state, val: mrb_value) mrb_sym;
/// mrb_check_intern series functions returns nil if the symbol is not defined
/// otherwise returns mrb_value
pub extern fn mrb_check_intern_cstr(mrb: *mrb_state, str: [*:0]const u8) mrb_value;
pub extern fn mrb_check_intern(mrb: *mrb_state, str: [*:0]const u8, size: usize) mrb_value;
pub extern fn mrb_check_intern_str(mrb: *mrb_state, val: mrb_value) mrb_value;
pub extern fn mrb_sym_name(mrb: *mrb_state, sym: mrb_sym) [*:0]const u8;
pub extern fn mrb_sym_name_len(mrb: *mrb_state, sym: mrb_sym, len: *mrb_int) [*:0]const u8;
pub extern fn mrb_sym_dump(mrb: *mrb_state, sym: mrb_sym) [*:0]const u8;
pub extern fn mrb_sym_str(mrb: *mrb_state, sym: mrb_sym) mrb_value;
pub fn mrb_sym2name(mrb: *mrb_state, sym: mrb_sym) [*:0]const u8 {
    return mrb_sym_name(mrb, sym);
}
pub fn mrb_sym2name_len(mrb: *mrb_state, sym: mrb_sym, len: *mrb_int) [*:0]const u8 {
    return mrb_sym_name_len(mrb, sym, len);
}
pub fn mrb_sym2str(mrb: *mrb_state, sym: mrb_sym) mrb_value {
    return mrb_sym_str(mrb, sym);
}

/// raise RuntimeError if no mem
pub extern fn mrb_malloc(mrb: *mrb_state, size: usize) *anyopaque;
/// ditto
pub extern fn mrb_calloc(mrb: *mrb_state, num: usize, size: usize) *anyopaque;
/// ditto
pub extern fn mrb_realloc(mrb: *mrb_state, ptr: *anyopaque, size: usize) *anyopaque;
/// return NULL if no memory available
pub extern fn mrb_realloc_simple(mrb: *mrb_state, ptr: *anyopaque, size: usize) *anyopaque;
/// return NULL if no memory available
pub extern fn mrb_malloc_simple(mrb: *mrb_state, size: usize) *anyopaque;
pub extern fn mrb_obj_alloc(mrb: *mrb_state, vtype: mrb_vtype, cla: *RClass) ?*RClass;
pub extern fn mrb_free(mrb: *mrb_state, ptr: *anyopaque) void;

// /** TODO: when MRB_VTYPE table works
//  * Allocates a Ruby object that matches the constant literal defined in
//  * `enum mrb_vtype` and returns a pointer to the corresponding C type.
//  *
//  * @param mrb   The current mruby state
//  * @param tt    The constant literal of `enum mrb_vtype`
//  * @param klass A Class object
//  * @return      Reference to the newly created object
//  */
// #define MRB_OBJ_ALLOC(mrb, tt, klass) ((MRB_VTYPE_TYPEOF(tt)*)mrb_obj_alloc(mrb, tt, klass))

pub extern fn mrb_str_new(mrb: *mrb_state, p: [*:0]const u8, len: usize) mrb_value;

/// Turns a C string into a Ruby string value.
pub extern fn mrb_str_new_cstr(mrb: *mrb_state, str: [*:0]const u8) mrb_value;
pub extern fn mrb_str_new_static(mrb: *mrb_state, p: [*:0]const u8, len: usize) mrb_value;
pub fn mrb_str_new_lit(mrb: *mrb_state, lit: [*:0]const u8) mrb_value {
    return mrb_str_new_static(mrb, lit, mrb_strlen_lit(lit));
}

pub extern fn mrb_obj_freeze(mrb: *mrb_state, val: mrb_value) mrb_value;
pub fn mrb_str_new_frozen(mrb: *mrb_state, p: [*:0]const u8 , len: usize) mrb_value {
    const value = mrb_str_new(mrb, p, len);
    return mrb_obj_freeze(mrb,value);
}
pub fn mrb_str_new_cstr_frozen(mrb: *mrb_state, p: [*:0]const u8) mrb_value {
    const value = mrb_str_new_cstr(mrb, p);
    return mrb_obj_freeze(mrb, value);
}
pub fn mrb_str_new_static_frozen(mrb: *mrb_state, p: [*:0]const u8, len: usize) mrb_value {
    const value = mrb_str_new_static(mrb, p, len);
    return mrb_obj_freeze(mrb, value);
}
pub fn mrb_str_new_lit_frozen(mrb: *mrb_state, lit: [*:0]const u8) mrb_value {
    const value = mrb_str_new_lit(mrb, lit);
    return mrb_obj_freeze(mrb, value);
}

// TODO: maybe? Is this even used?
// #ifdef _WIN32
// MRB_API char* mrb_utf8_from_locale(const char *p, int len);
// MRB_API char* mrb_locale_from_utf8(const char *p, int len);
// #define mrb_locale_free(p) free(p)
// #define mrb_utf8_free(p) free(p)
// #else
// #define mrb_utf8_from_locale(p, l) ((char*)(p))
// #define mrb_locale_from_utf8(p, l) ((char*)(p))
// #define mrb_locale_free(p)
// #define mrb_utf8_free(p)
// #endif

/// Creates new mrb_state.
///
/// @return
///      Pointer to the newly created mrb_state.
pub extern fn mrb_open() ?*mrb_state;

/// Create new mrb_state with custom allocators.
///
/// @param f
///      Reference to the allocation function.
/// @param ud
///      User data will be passed to custom allocator f.
///      If user data isn't required just pass NULL.
/// @return
///      Pointer to the newly created mrb_state.
pub extern fn mrb_open_allocf(f: mrb_allocf, ud: *anyopaque) ?*mrb_state;

/// Create new mrb_state with just the MRuby core
///
/// @param f
///      Reference to the allocation function.
///      Use mrb_default_allocf for the default
/// @param ud
///      User data will be passed to custom allocator f.
///      If user data isn't required just pass NULL.
/// @return
///      Pointer to the newly created mrb_state.
pub extern fn mrb_open_core(f: mrb_allocf, ud: *anyopaque) ?*mrb_state;

/// Closes and frees a mrb_state.
///
/// @param mrb
///      Pointer to the mrb_state to be closed.
pub extern fn mrb_close(mrb: *mrb_state) void;

// TODO: find proper signature names
// /// The default allocation function.
// ///
// /// @see mrb_allocf
// pub extern fn mrb_default_allocf(mrb: *mrb_state, *anyopaque, size: usize, *anyopaque) ?*anyopaque;

pub extern fn mrb_top_self(mrb: *mrb_state) mrb_value;
pub extern fn mrb_top_run(mrb: *mrb_state, proc: *const RProc, self: mrb_value, stack_keep: mrb_int) mrb_value;
pub extern fn mrb_vm_run(mrb: *mrb_state, proc: *const RProc, self: mrb_value, stack_keep: mrb_int) mrb_value;
pub extern fn mrb_vm_exec(mrb: *mrb_state, proc: *const RProc, iseq: [*]const mrb_code) mrb_value;

pub extern fn mrb_p(mrb: *mrb_state, val: mrb_value) void;
pub extern fn mrb_obj_id(obj: mrb_value) mrb_int;
pub extern fn mrb_obj_to_sym(mrb: *mrb_state, name: mrb_value) mrb_sym;

pub extern fn mrb_obj_eq(mrb: *mrb_state, a: mrb_value, b: mrb_value) mrb_bool;
pub extern fn mrb_obj_equal(mrb: *mrb_state, a: mrb_value, b: mrb_value) mrb_bool;
pub extern fn mrb_equal(mrb: *mrb_state, obj1: mrb_value, obj2: mrb_value) mrb_bool;

pub extern fn mrb_ensure_float_type(mrb: *mrb_state, val: mrb_value) mrb_value;
// TODO: #define mrb_as_float(mrb, x) mrb_float(mrb_ensure_float_type(mrb, x))

pub extern fn mrb_inspect(mrb: *mrb_state, obj: mrb_value) mrb_value;
pub extern fn mrb_eql(mrb: *mrb_state, obj1: mrb_value, obj2: mrb_value) mrb_bool;
/// mrb_cmp(mrb, obj1, obj2): 1:0:-1; -2 for error
pub extern fn mrb_cmp(mrb: *mrb_state, obj1: mrb_value, obj2: mrb_value) mrb_int;

// TODO: non-opaque mrb_state required
// MRB_INLINE int
// mrb_gc_arena_save(mrb_state *mrb)
// {
//   return mrb->gc.arena_idx;
// }

// MRB_INLINE void
// mrb_gc_arena_restore(mrb_state *mrb, int idx)
// {
//   mrb->gc.arena_idx = idx;
// }

pub extern fn mrb_garbage_collect(mrb: *mrb_state) void;
pub extern fn mrb_full_gc(mrb: *mrb_state) void;
pub extern fn mrb_incremental_gc(mrb: *mrb_state) void;
pub extern fn mrb_gc_mark(mrb: *mrb_state, obj: *RBasic) void;

// TODO: garbage collection
// #define mrb_gc_mark_value(mrb,val) do {\
//   if (!mrb_immediate_p(val)) mrb_gc_mark((mrb), mrb_basic_ptr(val)); \
// } while (0)
// MRB_API void mrb_field_write_barrier(mrb_state *, struct RBasic*, struct RBasic*);
// #define mrb_field_write_barrier_value(mrb, obj, val) do{\
//   if (!mrb_immediate_p(val)) mrb_field_write_barrier((mrb), (obj), mrb_basic_ptr(val)); \
// } while (0)
// MRB_API void mrb_write_barrier(mrb_state *, struct RBasic*);

pub extern fn mrb_type_convert(mrb: *mrb_state, val: mrb_value, typ: mrb_vtype, method: mrb_sym) mrb_value;
pub extern fn mrb_type_convert_check(mrb: *mrb_state, val: mrb_value, typ: mrb_vtype, method: mrb_sym) mrb_value;

pub extern fn mrb_any_to_s(mrb: *mrb_state, obj: mrb_value) mrb_value;
pub extern fn mrb_obj_classname(mrb: *mrb_state, obj: mrb_value) ?[*:0]const u8;
pub extern fn mrb_obj_class(mrb: *mrb_state, obj: mrb_value) ?*RClass;
pub extern fn mrb_class_path(mrb: *mrb_state, cla: *RClass) mrb_value;
pub extern fn mrb_obj_is_kind_of(mrb: *mrb_state, obj: mrb_value, cla: *RClass) mrb_bool;
pub extern fn mrb_obj_inspect(mrb: *mrb_state, self: mrb_value) mrb_value;
pub extern fn mrb_obj_clone(mrb: *mrb_state, self: mrb_value) mrb_value;

pub extern fn mrb_exc_new(mrb: *mrb_state, cla: *RClass, ptr: [*:0]const u8, len: usize) mrb_value;
pub extern fn mrb_exc_raise(mrb: *mrb_state, exc: mrb_value) mrb_noreturn;
pub extern fn mrb_raise(mrb: *mrb_state, cla: *RClass, msg: [*:0]const u8) mrb_noreturn;
pub extern fn mrb_raisef(mrb: *mrb_state, cla: *RClass, fmt: [*:0]const u8, ...) mrb_noreturn;
pub extern fn mrb_name_error(mrb: *mrb_state, id: mrb_sym, fmt: [*:0]const u8, ...) mrb_noreturn;
pub extern fn mrb_frozen_error(mrb: *mrb_state, frozen_obj: *anyopaque) mrb_noreturn;
pub extern fn mrb_argnum_error(mrb: *mrb_state, argc: mrb_int, min: c_int, max: c_int) mrb_noreturn;
pub extern fn mrb_warn(mrb: *mrb_state, fmt: [*:0]const u8, ...) void;
pub extern fn mrb_bug(mrb: *mrb_state, fmt: [*:0]const u8, ...) mrb_noreturn;
pub extern fn mrb_print_backtrace(mrb: *mrb_state) void;
pub extern fn mrb_print_error(mrb: *mrb_state) void;
// function for `raisef` formatting
// pub extern fn mrb_vformat(mrb: *mrb_state, format: [*:0]const u8, ap: va_list) mrb_value;

pub extern fn mrb_yield(mrb: *mrb_state, b: mrb_value, arg: mrb_value) mrb_value;
pub extern fn mrb_yield_argv(mrb: *mrb_state, b: mrb_value, argc: mrb_int, argv: [*]const mrb_value) mrb_value;
pub extern fn mrb_yield_with_class(mrb: *mrb_state, b: mrb_value, argc: mrb_int, argv: [*]const mrb_value, self: mrb_value, cla: *RClass) mrb_value;
/// continue execution to the proc
/// this function should always be called as the last function of a method
/// e.g. return mrb_yield_cont(mrb, proc, self, argc, argv);
pub extern fn mrb_yield_cont(mrb: *mrb_state, b: mrb_value, self: mrb_value, argc: mrb_int, argv: [*]const mrb_value) mrb_value;

/// mrb_gc_protect() leaves the object in the arena
pub extern fn mrb_gc_protect(mrb: *mrb_state, obj: mrb_value) void;
/// mrb_gc_register() keeps the object from GC.
pub extern fn mrb_gc_register(mrb: *mrb_state, obj: mrb_value) void;
/// mrb_gc_unregister() removes the object from GC root.
pub extern fn mrb_gc_unregister(mrb: *mrb_state, obj: mrb_value) void;

/// type conversion/check functions
pub extern fn mrb_ensure_array_type(mrb: *mrb_state, self: mrb_value) mrb_value;
pub extern fn mrb_check_array_type(mrb: *mrb_state, self: mrb_value) mrb_value;
pub extern fn mrb_ensure_hash_type(mrb: *mrb_state, hash: mrb_value) mrb_value;
pub extern fn mrb_check_hash_type(mrb: *mrb_state, hash: mrb_value) mrb_value;
pub extern fn mrb_ensure_string_type(mrb: *mrb_state, str: mrb_value) mrb_value;
pub extern fn mrb_check_string_type(mrb: *mrb_state, str: mrb_value) mrb_value;
pub extern fn mrb_ensure_int_type(mrb: *mrb_state, val: mrb_value) mrb_value;

/// string type checking (contrary to the name, it doesn't convert)
pub extern fn mrb_check_type(mrb: *mrb_state, x: mrb_value, t: mrb_vtype) void;

// TODO: When frozen_p is implemented
// MRB_INLINE void mrb_check_frozen(mrb_state *mrb, void *o)
// {
//   if (mrb_frozen_p((struct RBasic*)o)) mrb_frozen_error(mrb, o);
// }

pub extern fn mrb_define_alias(mrb: *mrb_state, cla: *RClass, a: [*:0]const u8, b: [*:0]const u8) void;
pub extern fn mrb_define_alias_id(mrb: *mrb_state, cla: *RClass, a: mrb_sym, b: mrb_sym) void;
pub extern fn mrb_class_name(mrb: *mrb_state, klass: *RClass) ?[*:0]const u8;
pub extern fn mrb_define_global_const(mrb: *mrb_state, name: [*:0]const u8, val: mrb_value) void;

pub extern fn mrb_attr_get(mrb: *mrb_state, obj: mrb_value, id: mrb_sym) mrb_value;

pub extern fn mrb_respond_to(mrb: *mrb_state, obj: mrb_value, mid: mrb_sym) mrb_bool;
pub extern fn mrb_obj_is_instance_of(mrb: *mrb_state, obj: mrb_value, cla: *RClass) mrb_bool;
pub extern fn mrb_func_basic_p(mrb: *mrb_state, obj: mrb_value, mid: mrb_sym, func: mrb_func_t) mrb_bool;

/// Resume a Fiber
///
/// Implemented in mruby-fiber
pub extern fn mrb_fiber_resume(mrb: *mrb_state, fib: mrb_value, argc: mrb_int, argv: [*]const mrb_value) mrb_value;

/// Yield a Fiber
///
/// Implemented in mruby-fiber
pub extern fn mrb_fiber_yield(mrb: *mrb_state, argc: mrb_int, argv: [*]const mrb_value) mrb_value;

/// Check if a Fiber is alive
///
/// Implemented in mruby-fiber
pub extern fn mrb_fiber_alive_p(mrb: *mrb_state, fib: mrb_value) mrb_value;

pub extern fn mrb_stack_extend(mrb_state: *mrb_state, mrb_int: mrb_int) void;

// TODO: fiber errors
// #define E_FIBER_ERROR mrb_exc_get_id(mrb, MRB_ERROR_SYM(FiberError))

pub extern fn mrb_pool_open(mrb_state: *mrb_state) ?*mrb_pool;
pub extern fn mrb_pool_close(pool: *mrb_pool) void;
pub extern fn mrb_pool_alloc(pool: *mrb_pool, size: usize) ?*anyopaque;
pub extern fn mrb_pool_realloc(pool: *mrb_pool, ptr: *anyopaque, oldlen: usize, newlen: usize) ?*anyopaque;
pub extern fn mrb_pool_can_realloc(pool: *mrb_pool, ptr: *anyopaque, size: usize) mrb_bool;
/// temporary memory allocation, only effective while GC arena is kept
pub extern fn mrb_alloca(mrb: *mrb_state, size: usize) ?*anyopaque;

pub extern fn mrb_state_atexit(mrb: *mrb_state, func: mrb_atexit_func) void;

pub extern fn mrb_show_version(mrb: *mrb_state) void;
pub extern fn mrb_show_copyright(mrb: *mrb_state) void;

pub extern fn mrb_format(mrb: *mrb_state, format: [*:0]const u8, ...) mrb_value;


/////////////////////////////////////////
//            mruby/array.h            //
/////////////////////////////////////////

pub const RArray = opaque {};

pub const mrb_shared_array = struct {
    redcnt: c_int,
    len: mrb_ssize,
    ptr: *mrb_value,
};

// TODO: Many array macros not added yet

/// Initializes a new array.
///
/// Equivalent to:
///
///      Array.new
///
/// @param mrb The mruby state reference.
/// @return The initialized array.
pub extern fn mrb_ary_new(mrb: *mrb_state) mrb_value;

/// Initializes a new array with initial values
///
/// Equivalent to:
///
///      Array[value1, value2, ...]
///
/// @param mrb The mruby state reference.
/// @param size The number of values.
/// @param vals The actual values.
/// @return The initialized array.
pub extern fn mrb_ary_new_from_values(mrb: *mrb_state, size: mrb_int, vals: [*]const mrb_value) mrb_value;

/// Initializes a new array with two initial values
///
/// Equivalent to:
///
///      Array[car, cdr]
///
/// @param mrb The mruby state reference.
/// @param car The first value.
/// @param cdr The second value.
/// @return The initialized array.
pub extern fn mrb_assoc_new(mrb: *mrb_state, car: mrb_value, cdr: mrb_value) mrb_value;

/// Concatenate two arrays. The target array will be modified
///
/// Equivalent to:
///      ary.concat(other)
///
/// @param mrb The mruby state reference.
/// @param self The target array.
/// @param other The array that will be concatenated to self.
pub extern fn mrb_ary_concat(mrb: *mrb_state, self: mrb_value, other: mrb_value) void;

/// Create an array from the input. It tries calling to_a on the
/// value. If value does not respond to that, it creates a new
/// array with just this value.
///
/// @param mrb The mruby state reference.
/// @param value The value to change into an array.
/// @return An array representation of value.
pub extern fn mrb_ary_splat(mrb: *mrb_state, value: mrb_value) mrb_value;

/// Pushes value into array.
///
/// Equivalent to:
///
///      ary << value
///
/// @param mrb The mruby state reference.
/// @param ary The array in which the value will be pushed
/// @param value The value to be pushed into array
pub extern fn mrb_ary_push(mrb: *mrb_state, array: mrb_value, value: mrb_value) void;

/// Pops the last element from the array.
///
/// Equivalent to:
///
///      ary.pop
///
/// @param mrb The mruby state reference.
/// @param ary The array from which the value will be popped.
/// @return The popped value.
pub extern fn mrb_ary_pop(mrb: *mrb_state, ary: mrb_value) mrb_value;

/// Sets a value on an array at the given index
///
/// Equivalent to:
///
///      ary[n] = val
///
/// @param mrb The mruby state reference.
/// @param ary The target array.
/// @param n The array index being referenced.
/// @param val The value being set.
pub extern fn mrb_ary_set(mrb: *mrb_state, ary: mrb_value, n: mrb_int, val: mrb_value) void;

/// Replace the array with another array
///
/// Equivalent to:
///
///      ary.replace(other)
///
/// @param mrb The mruby state reference
/// @param self The target array.
/// @param other The array to replace it with.
pub extern fn mrb_ary_replace(mrb: *mrb_state, self: mrb_value, other: mrb_value) void;

/// Unshift an element into the array
///
/// Equivalent to:
///
///     ary.unshift(item)
///
/// @param mrb The mruby state reference.
/// @param self The target array.
/// @param item The item to unshift.
pub extern fn mrb_ary_unshift(mrb: *mrb_state, self: mrb_value, item: mrb_value) mrb_value;

/// Get nth element in the array
///
/// Equivalent to:
///
///     ary[offset]
///
/// @param ary The target array.
/// @param offset The element position (negative counts from the tail).
pub extern fn mrb_ary_entry(ary: mrb_value, offset: mrb_int) mrb_value;

/// Replace subsequence of an array.
///
/// Equivalent to:
///
///      ary[head, len] = rpl
///
/// @param mrb The mruby state reference.
/// @param self The array from which the value will be partiality replaced.
/// @param head Beginning position of a replacement subsequence.
/// @param len Length of a replacement subsequence.
/// @param rpl The array of replacement elements.
///            It is possible to pass `mrb_undef_value()` instead of an empty array.
/// @return The receiver array.
pub extern fn mrb_ary_splice(mrb: *mrb_state, self: mrb_value, head: mrb_int, len: mrb_int, rpl: mrb_value) mrb_value;

/// Shifts the first element from the array.
///
/// Equivalent to:
///
///      ary.shift
///
/// @param mrb The mruby state reference.
/// @param self The array from which the value will be shifted.
/// @return The shifted value.
pub extern fn mrb_ary_shift(mrb: *mrb_state, self: mrb_value) mrb_value;

/// Removes all elements from the array
///
/// Equivalent to:
///
///      ary.clear
///
/// @param mrb The mruby state reference.
/// @param self The target array.
/// @return self
pub extern fn mrb_ary_clear(mrb: *mrb_state, self: mrb_value) mrb_value;

/// Join the array elements together in a string
///
/// Equivalent to:
///
///      ary.join(sep="")
///
/// @param mrb The mruby state reference.
/// @param ary The target array
/// @param sep The separator, can be NULL
pub extern fn mrb_ary_join(mrb: *mrb_state, ary: mrb_value, sep: mrb_value) mrb_value;

/// Update the capacity of the array
///
/// @param mrb The mruby state reference.
/// @param ary The target array.
/// @param new_len The new capacity of the array
pub extern fn mrb_ary_resize(mrb: *mrb_state, ary: mrb_value, new_len: mrb_int) mrb_value;


///////////////////////////////////////////
//            mruby/compile.h            //
///////////////////////////////////////////

pub const mrb_parser_state = opaque {};

/// load context
pub const mrbc_context = opaque {};

pub extern fn mrbc_context_new(mrb: *mrb_state) ?*mrbc_context;
pub extern fn mrbc_context_free(mrb: *mrb_state, cxt: *mrbc_context) void;
pub extern fn mrbc_filename(mrb: *mrb_state, cxt: *mrbc_context, s: [*:0]const u8) ?[*:0]const u8;
pub extern fn mrbc_partial_hook(mrb: *mrb_state, cxt: *mrbc_context, partial_hook: fn (state: *mrb_parser_state) callconv(.C) c_int, data: *anyopaque) void;
pub extern fn mrbc_cleanup_local_variables(mrb: *mrb_state, cxt: *mrbc_context) void;

/// AST node structure
pub const mrb_ast_node = extern struct {
    car: *mrb_ast_node,
    cdr: *mrb_ast_node,
    lineno: u16,
    filename_index: u16,
};

// TODO: lexer/parser structs and functions not added yet

/// program load functions
/// Please note! Currently due to interactions with the GC calling these functions will
/// leak one RProc object per function call.
/// To prevent this save the current memory arena before calling and restore the arena
/// right after, like so
/// int ai = mrb_gc_arena_save(mrb);
/// mrb_value status = mrb_load_string(mrb, buffer);
/// mrb_gc_arena_restore(mrb, ai);
// #ifndef MRB_NO_STDIO
pub extern fn mrb_load_file(mrb: *mrb_state, fp: *FILE) mrb_value;
pub extern fn mrb_load_file_cxt(mrb: *mrb_state, fp: *FILE, cxt: *mrbc_context) mrb_value;
pub extern fn mrb_load_detect_file_cxt(mrb: *mrb_state, fp: *FILE, cxt: *mrbc_context) mrb_value;
// #endif
pub extern fn mrb_load_string(mrb: *mrb_state, s: [*:0]const u8) mrb_value;
pub extern fn mrb_load_nstring(mrb: *mrb_state, s: [*:0]const u8, len: usize) mrb_value;
pub extern fn mrb_load_string_cxt(mrb: *mrb_state, s: [*:0]const u8, cxt: *mrbc_context) mrb_value;
pub extern fn mrb_load_nstring_cxt(mrb: *mrb_state, s: [*:0]const u8, len: usize, cxt: *mrbc_context) mrb_value;


////////////////////////////////////////////
//            mruby/variable.h            //
////////////////////////////////////////////

pub extern fn mrb_const_get(mrb_state: *mrb_state, mrb_value: mrb_value, mrb_sym: mrb_sym) mrb_value;
pub extern fn mrb_const_set(mrb_state: *mrb_state, mrb_value: mrb_value, mrb_sym: mrb_sym, mrb_value: mrb_value) void;
pub extern fn mrb_const_defined(mrb_state: *mrb_state, mrb_value: mrb_value, mrb_sym: mrb_sym) mrb_bool;
pub extern fn mrb_const_remove(mrb_state: *mrb_state, mrb_value: mrb_value, mrb_sym: mrb_sym) void;

pub extern fn mrb_iv_name_sym_p(mrb: *mrb_state, sym: mrb_sym) mrb_bool;
pub extern fn mrb_iv_name_sym_check(mrb: *mrb_state, sym: mrb_sym) void;
pub extern fn mrb_obj_iv_get(mrb: *mrb_state, obj: *RObject, sym: mrb_sym) mrb_value;
pub extern fn mrb_obj_iv_set(mrb: *mrb_state, obj: *RObject, sym: mrb_sym, v: mrb_value) void;
pub extern fn mrb_obj_iv_defined(mrb: *mrb_state, obj: *RObject, sym: mrb_sym) mrb_bool;
pub extern fn mrb_iv_get(mrb: *mrb_state, obj: mrb_value, sym: mrb_sym) mrb_value;
pub extern fn mrb_iv_set(mrb: *mrb_state, obj: mrb_value, sym: mrb_sym, v: mrb_value) void;
pub extern fn mrb_iv_defined(mrb_state: *mrb_state, mrb_value: mrb_value, mrb_sym: mrb_sym) mrb_bool;
pub extern fn mrb_iv_remove(mrb: *mrb_state, obj: mrb_value, sym: mrb_sym) mrb_value;
pub extern fn mrb_iv_copy(mrb: *mrb_state, dst: mrb_value, src: mrb_value) void;
pub extern fn mrb_const_defined_at(mrb: *mrb_state, mod: mrb_value, id: mrb_sym) mrb_bool;

/// Get a global variable. Will return nil if the var does not exist
///
/// Example:
///
///     !!!ruby
///     # Ruby style
///     var = $value
///
///     !!!c
///     // C style
///     mrb_sym sym = mrb_intern_lit(mrb, "$value");
///     mrb_value var = mrb_gv_get(mrb, sym);
///
/// @param mrb The mruby state reference
/// @param sym The name of the global variable
/// @return The value of that global variable. May be nil
pub extern fn mrb_gv_get(mrb: *mrb_state, sym: mrb_sym) mrb_value;

/// Set a global variable
///
/// Example:
///
///     !!!ruby
///     # Ruby style
///     $value = "foo"
///
///     !!!c
///     // C style
///     mrb_sym sym = mrb_intern_lit(mrb, "$value");
///     mrb_gv_set(mrb, sym, mrb_str_new_lit("foo"));
///
/// @param mrb The mruby state reference
/// @param sym The name of the global variable
/// @param val The value of the global variable
pub extern fn mrb_gv_set(mrb: *mrb_state, sym: mrb_sym, val: mrb_value) void;

/// Remove a global variable.
///
/// Example:
///
///     # Ruby style
///     $value = nil
///
///     // C style
///     mrb_sym sym = mrb_intern_lit(mrb, "$value");
///     mrb_gv_remove(mrb, sym);
///
/// @param mrb The mruby state reference
/// @param sym The name of the global variable
pub extern fn mrb_gv_remove(mrb: *mrb_state, sym: mrb_sym) void;

pub extern fn mrb_cv_get(mrb: *mrb_state, mod: mrb_value, sym: mrb_sym) mrb_value;
pub extern fn mrb_mod_cv_set(mrb: *mrb_state, c: *RClass, sym: mrb_sym, v: mrb_value) void;
pub extern fn mrb_cv_set(mrb: *mrb_state, mod: mrb_value, sym: mrb_sym, v: mrb_value) void;
pub extern fn mrb_cv_defined(mrb: *mrb_state, mod: mrb_value, sym: mrb_sym) mrb_bool;

pub const mrb_iv_foreach_func = fn (mrb: *mrb_state, sym: mrb_sym, val: mrb_value, ptr: *anyopaque) callconv(.C) c_int;
pub extern fn mrb_iv_foreach(mrb: *mrb_state, obj: mrb_value, func: mrb_iv_foreach_func, ptr: *anyopaque) void;


/////////////////////////////////////////
//            mruby/value.h            //
/////////////////////////////////////////

/// Returns a float in Ruby.
///
/// Takes a float and boxes it into an mrb_value
pub extern fn mrb_float_value(mrb: *mrb_state, f: mrb_float) mrb_value;
pub extern fn mrb_cptr_value(mrb: *mrb_state, p: *anyopaque) mrb_value;
/// Returns an integer in Ruby.
pub extern fn mrb_int_value(mrb: *mrb_state, i: mrb_int) mrb_value;
pub extern fn mrb_fixnum_value(i: mrb_int) mrb_value;
pub extern fn mrb_symbol_value(i: mrb_sym) mrb_value;
pub extern fn mrb_obj_value(p: *anyopaque) mrb_value;
/// Get a nil mrb_value object.
///
/// @return
///      nil mrb_value object reference.
pub extern fn mrb_nil_value() mrb_value;
/// Returns false in Ruby.
pub extern fn mrb_false_value() mrb_value;
/// Returns true in Ruby.
pub extern fn mrb_true_value() mrb_value;
pub extern fn mrb_bool_value(boolean: mrb_bool) mrb_value;
pub extern fn mrb_undef_value() mrb_value;

/////////////////////////////////////////
//            mruby/class.h            //
/////////////////////////////////////////
