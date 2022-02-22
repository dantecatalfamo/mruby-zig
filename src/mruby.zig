const std = @import("std");
const c = @cImport({
    @cInclude("mruby.h");
});

pub const mrb_gc = opaque {};
pub const mrb_state = opaque {};
pub const mrb_irep = opaque {};
pub const mrb_callinfo = opaque {};
pub const mrb_contect = opaque {};
pub const mrb_jumpbuf = opaque {};
pub const mrb_code = u8;
pub const mrb_aspec = u32;
pub const mrb_sym = u32;

pub const mrb_value = if (@hasDecl(c, "MRB_NAN_BOXING"))
    struct { u: u64 }
else if (@hasDecl(c, "MRB_WORD_BOXING"))
    struct { w: usize }
else
    @compileError("Not implemented");

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

/// Function pointer type for a function callable by mruby.
///
/// The arguments to the function are stored on the mrb_state. To get them see mrb_get_args
///
/// @param mrb The mruby state
/// @param self The self object
/// @return [mrb_value] The function's return value
pub const mrb_func_t = fn (mrb: *mrb_state, self: mrb_value) callconv(.C) mrb_value;
pub const mrb_atexit_func = fn (*mrb_state) void;

pub extern fn mrb_open() ?*mrb_state;
pub extern fn mrb_close(mrb: *mrb_state) void;

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
pub extern fn mrb_define_class(mrb: *mrb_state, name: [*:0]const u8, super: RClass) ?*RClass;
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
pub extern fn mrb_undef_method_id(mrb_state: *mrb_state, RClass: *RClass, mrb_sym: mrb_sym) void;

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
/// @param c Reference to the class of the new object.
/// @param argc Number of arguments in argv
/// @param argv Array of mrb_value to initialize the object
/// @return [mrb_value] The newly initialized object
pub extern fn mrb_obj_new(mrb: *mrb_state, c: *RClass, argc: mrb_int, argv: [*]const mrb_value) mrb_value;

/// @see mrb_obj_new
pub fn mrb_class_new_instance(mrb: *mrb_state, argc: mrb_int, argv: [*]const mrb_value, c: *RClass) mrb_value {
  return mrb_obj_new(mrb,c,argc,argv);
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
pub fn mrb_exc_get(mrb: *mrb_state, name: [*:0]const u8) ?*RClass {
    const name_sym = mrb_intern_cstr(mrb, name);
    mrb_exc_get_id(mrb, name_sym);
}
