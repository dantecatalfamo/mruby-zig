const std = @import("std");
const assert = std.debug.assert;
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
pub extern fn mrb_state_get_context(mrb: *mrb_state) ?*mrb_context;
pub extern fn mrb_state_get_root_context(mrb: *mrb_state) ?*mrb_context;
pub extern fn mrb_context_prev(cxt: *mrb_context) ?*mrb_context;
pub extern fn mrb_context_callinfo(cxt: *mrb_context) ?*mrb_callinfo;
pub extern fn mrb_context_fiber_state(cxt: *mrb_context) mrb_fiber_state;
pub extern fn mrb_context_fiber(cxt: *mrb_context) ?*RFiber;
pub extern fn mrb_callinfo_n(ci: *mrb_callinfo) u8;
pub extern fn mrb_callinfo_nk(ci: *mrb_callinfo) u8;
pub extern fn mrb_callinfo_cci(ci: *mrb_callinfo) u8;
pub extern fn mrb_callinfo_mid(ci: *mrb_callinfo) mrb_sym;
pub extern fn mrb_callinfo_stack(ci: *mrb_callinfo) [*]*?mrb_value;
pub extern fn mrb_callinfo_proc(ci: *mrb_callinfo) ?*RProc;
pub extern fn mrb_gc_arena_save1(mrb: *mrb_state) c_int;
pub extern fn mrb_gc_arena_restore1(mrb: *mrb_state) void;

///////////////////////////////////
//            mruby.h            //
///////////////////////////////////

// TODO: Make a type to make mrb_aspec less combresome

pub const mrb_state = opaque {
    const Self = @This();

    // Struct getters

    pub fn exc(self: *Self) ?*RObject {
        return mrb_state_get_exc(self);
    }
    pub fn top_self(self: *Self) ?*RObject {
        return mrb_state_get_top_self(self);
    }
    pub fn object_class(self: *Self) ?*RClass {
        return mrb_state_get_object_class(self);
    }
    pub fn class_class(self: *Self) ?*RClass {
        return mrb_state_get_class_class(self);
    }
    pub fn module_class(self: *Self) ?*RClass {
        return mrb_state_get_module_class(self);
    }
    pub fn proc_class(self: *Self) ?*RClass {
        return mrb_state_get_proc_class(self);
    }
    pub fn string_class(self: *Self) ?*RClass {
        return mrb_state_get_string_class(self);
    }
    pub fn array_class(self: *Self) ?*RClass {
        return mrb_state_get_array_class(self);
    }
    pub fn hash_class(self: *Self) ?*RClass {
        return mrb_state_get_hash_class(self);
    }
    pub fn range_class(self: *Self) ?*RClass {
        return mrb_state_get_range_class(self);
    }
    pub fn float_class(self: *Self) ?*RClass {
        return mrb_state_get_float_class(self);
    }
    pub fn integer_class(self: *Self) ?*RClass {
        return mrb_state_get_integer_class(self);
    }
    pub fn true_class(self: *Self) ?*RClass {
        return mrb_state_get_true_class(self);
    }
    pub fn false_class(self: *Self) ?*RClass {
        return mrb_state_get_false_class(self);
    }
    pub fn nil_class(self: *Self) ?*RClass {
        return mrb_state_get_nil_class(self);
    }
    pub fn symbol_class(self: *Self) ?*RClass {
        return mrb_state_get_symbol_class(self);
    }
    pub fn kernel_module(self: *Self) ?*RClass {
        return mrb_state_get_kernel_module(self);
    }
    pub fn context(self: *Self) ?*mrb_context {
        return mrb_state_get_context(self);
    }
    pub fn root_contect(self: *Self) ?*mrb_context {
        return mrb_state_get_root_context(self);
    }

    //  mruby.h functions

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
    pub fn define_class(self: *Self, name: [*:0]const u8, super: *RClass) ?*RClass {
        return mrb_define_class(self, name, super);
    }
    pub fn define_class_id(self: *Self, name: mrb_sym, super: *RClass) ?*RClass {
        return mrb_define_class_id(self, name, super);
    }

    /// Defines a new module.
    ///
    /// @param mrb The current mruby state.
    /// @param name The name of the module.
    /// @return [struct RClass *] Reference to the newly defined module.
    pub fn define_module(self: *Self, name: [*:0]const u8) ?*RClass {
        return mrb_define_module(self, name);
    }
    pub fn define_module_id(self: *Self, name: mrb_sym) ?*RClass {
        return mrb_define_module_id(self, name);
    }

    pub fn singleton_class(self: *Self, val: mrb_value) mrb_value {
        return mrb_singleton_class(self, val);
    }
    pub fn singleton_class_ptr(self: *Self, val: mrb_value) ?*RClass {
        return mrb_singleton_class_ptr(self, val);
    }

    /// Include a module in another class or module.
    /// Equivalent to:
    ///
    ///   module B
    ///     include A
    ///   end
    /// @param mrb The current mruby state.
    /// @param cla A reference to module or a class.
    /// @param included A reference to the module to be included.
    pub fn include_module(self: *Self, cla: *RClass, included: *RClass) void {
        return mrb_include_module(self, cla, included);
    }

    /// Prepends a module in another class or module.
    ///
    /// Equivalent to:
    ///  module B
    ///    prepend A
    ///  end
    /// @param mrb The current mruby state.
    /// @param cla A reference to module or a class.
    /// @param prepended A reference to the module to be prepended.
    pub fn prepend_module(self: *Self, cla: *RClass, prepended: *RClass) void {
        return mrb_prepend_module(self, cla, prepended);
    }

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
    pub fn define_method(self: *Self, cla: *RClass, name: [*:0]const u8, func: mrb_func_t, aspec: mrb_aspec) void {
        return mrb_define_method(self, cla, name, func, aspec);
    }
    pub fn define_method_id(self: *Self, cla: *RClass, mid: mrb_sym, func: mrb_func_t, aspec: mrb_aspec) void {
        return mrb_define_method_id(self, cla, mid, func, aspec);
    }

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
    pub fn define_class_method(self: *Self, cla: *RClass, name: [*:0]const u8, fun: mrb_func_t, aspec: mrb_aspec) void {
        return mrb_define_class_method(self, cla, name, fun, aspec);
    }
    pub fn define_class_method_id(self: *Self, cla: *RClass, name: mrb_sym, fun: mrb_func_t, aspec: mrb_aspec) void {
        return mrb_define_class_method_id(self, cla, name, fun, aspec);
    }

    /// Defines a singleton method
    ///
    /// @see mrb_define_class_method
    pub fn define_singleton_method(self: *Self, cla: *RObject, name: [*:0]const u8, fun: mrb_func_t, aspec: mrb_aspec) void {
        return mrb_define_singleton_method(self, cla, name, fun, aspec);
    }
    pub fn define_singleton_method_id(self: *Self, cla: *RObject, name: mrb_sym, fun: mrb_func_t, aspec: mrb_aspec) void {
        return mrb_define_singleton_method_id(self, cla, name, fun, aspec);
    }

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
    pub fn define_module_function(self: *Self, cla: *RClass, name: [*:0]const u8, fun: mrb_func_t, aspec: mrb_aspec) void {
        return mrb_define_module_function(self, cla, name, fun, aspec);
    }
    pub fn define_module_function_id(self: *Self, cla: *RClass, name: mrb_sym, fun: mrb_func_t, aspec: mrb_aspec) void {
        return mrb_define_module_function_id(self, cla, name, fun, aspec);
    }

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
    pub fn define_const(self: *Self, cla: *RClass, name: [*:0]const u8, value: mrb_value) void {
        return mrb_define_const(self, cla, name, value);
    }
    pub fn define_const_id(self: *Self, cla: *RClass, name: mrb_sym, value: mrb_value) void {
        return mrb_define_const_id(self, cla, name, value);
    }

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
    pub fn undef_method(self: *Self, cla: *RClass, name: [*:0]const u8) void {
        return mrb_undef_method(self, cla, name);
    }
    pub fn undef_method_id(self: *Self, cla: *RClass, sym: mrb_sym) void {
        return mrb_undef_method_id(self, cla, sym);
    }

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
    pub fn undef_class_method(self: *Self, cla: *RClass, name: [*:0]const u8) void {
        return mrb_undef_class_method(self, cla, name);
    }
    pub fn undef_class_method_id(self: *Self, cla: *RClass, name: mrb_sym) void {
        return mrb_undef_class_method_id(self, cla, name);
    }

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
    pub fn obj_new(self: *Self, cla: *RClass, argc: mrb_int, argv: [*]const mrb_value) mrb_value {
        return mrb_obj_new(self, cla, argc, argv);
    }

    /// @see mrb_obj_new
    pub fn class_new_instance(self: *Self, argc: mrb_int, argv: [*]const mrb_value, cla: *RClass) mrb_value {
      return mrb_class_new_instance(self, argc, argv, cla);
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
    pub fn class_new(self: *Self, super: *RClass) ?*RClass {
        return mrb_class_new(self, super);
    }

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
    pub fn module_new(self: *Self) ?*RClass {
        return mrb_module_new(self);
    }

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
    pub fn class_defined(self: *Self, name: [*:0]const u8) mrb_bool {
        return mrb_class_defined(self, name);
    }
    pub fn class_defined_id(self: *Self, name: mrb_sym) mrb_bool {
        return mrb_class_defined_id(self, name);
    }

    /// Gets a class.
    /// @param mrb The current mruby state.
    /// @param name The name of the class.
    /// @return [struct RClass *] A reference to the class.
    pub fn class_get(self: *Self, name: [*:0]const u8) ?*RClass {
        return mrb_class_get(self, name);
    }
    pub fn class_get_id(self: *Self, name: mrb_sym) ?*RClass {
        return mrb_class_get_id(self, name);
    }

    /// Gets a exception class.
    /// @param mrb The current mruby state.
    /// @param name The name of the class.
    /// @return [struct RClass *] A reference to the class.
    pub fn exc_get_id(self: *Self, name: mrb_sym) ?*RClass {
        return mrb_exc_get_id(self, name);
    }

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
    pub fn class_defined_under(self: *Self, outer: *RClass, name: [*:0]const u8) mrb_bool {
        return mrb_class_defined_under(self, outer, name);
    }
    pub fn class_defined_under_id(self: *Self, outer: *RClass, name: mrb_sym) mrb_bool {
        return mrb_class_defined_under_id(self, outer, name);
    }

    /// Gets a child class.
    /// @param mrb The current mruby state.
    /// @param outer The name of the parent class.
    /// @param name The name of the class.
    /// @return [struct RClass *] A reference to the class.
    pub fn class_get_under(self: *Self, outer: *RClass, name: [*:0]const u8) ?*RClass {
        return mrb_class_get_under(self, outer, name);
    }
    pub fn class_get_under_id(self: *Self, outer: *RClass, name: mrb_sym) ?*RClass {
        return mrb_class_get_under_id(self, outer, name);
    }

    /// Gets a module.
    /// @param mrb The current mruby state.
    /// @param name The name of the module.
    /// @return [struct RClass *] A reference to the module.
    pub fn module_get(self: *Self, name: [*:0]const u8) ?*RClass {
        return mrb_module_get(self, name);
    }
    pub fn module_get_id(self: *Self, name: mrb_sym) ?*RClass {
        return mrb_module_get_id(self, name);
    }

    /// Gets a module defined under another module.
    /// @param mrb The current mruby state.
    /// @param outer The name of the outer module.
    /// @param name The name of the module.
    /// @return [struct RClass *] A reference to the module.
    pub fn module_get_under(self: *Self, outer: *RClass, name: [*:0]const u8) ?*RClass {
        return mrb_module_get_under(self, outer, name);
    }
    pub fn module_get_under_id(self: *Self, outer: *RClass, name: mrb_sym) ?*RClass {
        return mrb_module_get_under_id(self, outer, name);
    }

    /// a function to raise NotImplementedError with current method name
    pub fn notimplement(self: *Self) void {
        return mrb_notimplement(self);
    }

    /// a function to be replacement of unimplemented method
    pub fn notimplement_m(self: *Self, value: mrb_value) mrb_value {
        return mrb_notimplement_m(self, value);
    }

    /// Duplicate an object.
    ///
    /// Equivalent to:
    ///   Object#dup
    /// @param mrb The current mruby state.
    /// @param obj Object to be duplicate.
    /// @return [mrb_value] The newly duplicated object.
    pub fn obj_dup(self: *Self, obj: mrb_value) mrb_value {
        return mrb_obj_dup(self, obj);
    }

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
    pub fn obj_respond_to(self: *Self, cla: *RClass, mid: mrb_sym) mrb_bool {
        return mrb_obj_respond_to(self, cla, mid);
    }

    /// Defines a new class under a given module
    ///
    /// @param mrb The current mruby state.
    /// @param outer Reference to the module under which the new class will be defined
    /// @param name The name of the defined class
    /// @param super The new class parent
    /// @return [struct RClass *] Reference to the newly defined class
    /// @see mrb_define_class
    pub fn define_class_under(self: *Self, outer: *RClass, name: [*:0]const u8, super: *RClass) ?*RClass {
        return mrb_define_class_under(self, outer, name, super);
    }
    pub fn define_class_under_id(self: *Self, outer: *RClass, name: mrb_sym, super: *RClass) ?*RClass {
        return mrb_define_class_under_id(self, outer, name, super);
    }
    pub fn define_module_under(self: *Self, outer: *RClass, name: [*:0]const u8) ?*RClass {
        return mrb_define_module_under(self, outer, name);
    }
    pub fn define_module_under_id(self: *Self, outer: *RClass, name: mrb_sym) ?*RClass {
        return mrb_define_module_under_id(self, outer, name);
    }

    /// Retrieve arguments from mrb_state.
    ///
    /// @param mrb The current MRuby state.
    /// @param format is a list of format specifiers
    /// @param ... The passing variadic arguments must be a pointer of retrieving type.
    /// @return the number of arguments retrieved.
    /// @see mrb_args_format
    /// @see mrb_kwargs
    pub fn get_args(self: *Self, fmt: mrb_args_format, args: anytype) mrb_int {
        return @call(.{}, mrb_get_args, .{ self, fmt } ++ args);
    }

    /// get method symbol
    pub fn get_mid(self: *Self) mrb_sym {
        return mrb_get_mid(self);
    }

    /// Retrieve number of arguments from mrb_state.
    ///
    /// Correctly handles *splat arguments.
    pub fn get_argc(self: *Self) mrb_int {
        return mrb_get_argc(self);
    }

    /// Retrieve an array of arguments from mrb_state.
    ///
    /// Correctly handles *splat arguments.
    pub fn get_argv(self: *Self) [*]const mrb_value {
        return mrb_get_argv(self);
    }

    /// Retrieve the first and only argument from mrb_state.
    /// Raises ArgumentError unless the number of arguments is exactly one.
    ///
    /// Correctly handles *splat arguments.
    pub fn get_arg1(self: *Self) mrb_value {
        return mrb_get_arg1(self);
    }

    /// Check if a block argument is given from mrb_state.
    pub fn block_given_p(self: *Self) mrb_bool {
        return mrb_block_given_p(self);
    }

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
    pub fn funcall(self: *Self, value: mrb_value, name: [*:0]const u8, args: anytype) mrb_value {
        return @call(.{}, mrb_funcall, .{ self, value, name, args.len } ++ args);
    }
    pub fn funcall_id(self: *Self, value: mrb_value, mid: mrb_sym, args: anytype) mrb_value {
        return @call(.{}, mrb_funcall_id, .{ self, value, mid, args.len } ++ args);
    }

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
    pub fn funcall_argv(self: *Self, value: mrb_value, name: mrb_sym, args: []const *mrb_value) mrb_value {
        return mrb_funcall_argv(self, value, name, args.len, args.ptr);
    }

    /// Call existing ruby functions with a block.
    pub fn funcall_with_block(self: *Self, value: mrb_value, name: mrb_sym, args: []const *mrb_value, block: mrb_value) mrb_value {
        return mrb_funcall_with_block(self, value, name, args.len, args.ptr, block);
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
    pub fn intern_cstr(self: *Self, str: [*:0]const u8) mrb_sym {
        return mrb_intern_cstr(self, str);
    }
    pub fn intern(self: *Self, char: []const u8) mrb_sym {
        return mrb_intern(self, char.ptr, char.len);
    }
    pub fn intern_static(self: *Self, char: []const u8) mrb_sym {
        return mrb_intern_static(self, char.ptr, char.len);
    }
    pub fn mrb_intern_lit(self: *Self, lit: []const u8) mrb_sym {
        return self.intern_static(lit);
    }
    pub fn intern_str(self: *Self, value: mrb_value) mrb_sym {
        return mrb_intern_str(self, value);
    }
    /// mrb_intern_check series functions returns 0 if the symbol is not defined
    pub fn intern_check_cstr(self: *Self, str: [*:0]const u8) mrb_sym {
        return mrb_intern_check_cstr(self, str);
    }
    pub fn intern_check(self: *Self, str: []const u8) mrb_sym {
        return mrb_intern_check(self, str.ptr, str.len);
    }
    pub fn intern_check_str(self: *Self, value: mrb_value) mrb_sym {
        return mrb_intern_check_str(self, value);
    }
    /// mrb_check_intern series functions returns nil if the symbol is not defined
    /// otherwise returns mrb_value
    pub fn check_intern_cstr(self: *Self, str: [*:0]const u8) mrb_value {
        return mrb_check_intern_cstr(self, str);
    }
    pub fn check_intern(self: *Self, str: []const u8) mrb_value {
        return mrb_check_intern(self, str.ptr, str.len);
    }
    pub fn check_intern_str(self: *Self, value: mrb_value) mrb_value {
        return mrb_check_intern_str(self, value);
    }

    pub fn sym_name(self: *Self, sym: mrb_sym) [*:0]const u8 {
        return mrb_sym_name(self, sym);
    }
    pub fn sym_name_len(self: *Self, sym: mrb_sym, len: *mrb_int) [*:0]const u8 {
        return mrb_sym_name_len(self, sym, len);
    }
    pub fn sym_dump(self: *Self, sym: mrb_sym) [*:0]const u8 {
        return mrb_sym_dump(self, sym);
    }
    pub fn sym_str(self: *Self, sym: mrb_sym) mrb_value {
        return mrb_sym_str(self, sym);
    }
    pub fn sym2name(self: *Self, sym: mrb_sym) [*:0]const u8 {
        return mrb_sym_name(self, sym);
    }
    pub fn sym2name_len(self: *Self, sym: mrb_sym, len: *mrb_int) [*:0]const u8 {
        return mrb_sym_name_len(self, sym, len);
    }
    pub fn sym2str(self: *Self, sym: mrb_sym) mrb_value {
        return mrb_sym_str(self, sym);
    }

    /// raise RuntimeError if no mem
    pub fn malloc(self: *Self, size: usize) *anyopaque {
        return mrb_malloc(self, size);
    }
    /// ditto
    pub fn calloc(self: *Self, num: usize, size: usize) *anyopaque {
        return mrb_calloc(self, num, size);
    }
    /// ditto
    pub fn realloc(self: *Self, ptr: *anyopaque, size: usize) *anyopaque {
        return mrb_realloc(self, ptr, size);
    }
    /// return NULL if no memory available
    pub fn realloc_simple(self: *Self, ptr: *anyopaque, size: usize) ?*anyopaque {
        return mrb_realloc_simple(self, ptr, size);
    }
    /// return NULL if no memory available
    pub fn malloc_simple(self: *Self, size: usize) ?*anyopaque {
        return mrb_malloc_simple(self, size);
    }
    pub fn obj_alloc(self: *Self, vtype: mrb_vtype, cla: *RClass) ?*RClass {
        return mrb_obj_alloc(self, vtype, cla);
    }
    pub fn free(self: *Self, ptr: *anyopaque) void {
        return mrb_free(self, ptr);
    }

    pub fn str_new(self: *Self, str: []const u8) mrb_value {
        return mrb_str_new(self, str.ptr, str.len);
    }

    /// Turns a C string into a Ruby string value.
    pub fn str_new_cstr(self: *Self, str: [*:0]const u8) mrb_value {
        return mrb_str_new_cstr(self, str);
    }
    pub fn str_new_static(self: *Self, str: []const u8) mrb_value {
        return mrb_str_new_static(self, str.ptr, str.len);
    }
    pub fn str_new_lit(self: *Self, lit: []const u8) mrb_value {
        return mrb_str_new_static(self, lit.ptr, lit.len);
    }

    pub fn obj_freeze(self: *Self, value: mrb_value) mrb_value {
        return mrb_obj_freeze(self, value);
    }
    pub fn str_new_frozen(self: *Self, str: []const u8) mrb_value {
        const value = mrb_str_new(self, str.ptr, str.len);
        return mrb_obj_freeze(self, value);
    }
    pub fn str_new_cstr_frozen(self: *Self, str: [*:0]const u8) mrb_value {
        const value = mrb_str_new_cstr(self, str);
        return mrb_obj_freeze(self, value);
    }
    pub fn str_new_static_frozen(self: *Self, str: []const u8) mrb_value {
        const value = mrb_str_new_static(self, str.ptr, str.len);
        return mrb_obj_freeze(self, value);
    }
    pub fn str_new_lit_frozen(self: *Self, lit: []const u8) mrb_value {
        const value = mrb_str_new_lit(self, lit);
        return mrb_obj_freeze(self, value);
    }

    /// Closes and frees a mrb_state.
    ///
    /// @param mrb
    ///      Pointer to the mrb_state to be closed.
    pub fn close(self: *Self) void {
        return mrb_close(self);
    }

    pub fn top_self_value(self: *Self) mrb_value {
        return mrb_top_self(self);
    }
    pub fn top_run(self: *Self, proc: *const RProc, proc_self: mrb_value, stack_keep: mrb_int) mrb_value {
        return mrb_top_run(self, proc, proc_self, stack_keep);
    }
    pub fn vm_run(self: *Self, proc: *const RProc, proc_self: mrb_value, stack_keep: mrb_int) mrb_value {
        return mrb_vm_run(self, proc, proc_self, stack_keep);
    }
    pub fn vm_exec(self: *Self, proc: *const RProc, iseq: [*]const mrb_code) mrb_value {
        return mrb_vm_exec(self, proc, iseq);
    }

    pub fn p(self: *Self, value: mrb_value) void {
        return mrb_p(self, value);
    }
    pub fn obj_id(obj: mrb_value) mrb_int {
        return mrb_obj_id(obj);
    }
    pub fn obj_to_sym(self: *Self, name: mrb_value) mrb_sym {
        return mrb_obj_to_sym(self, name);
    }

    pub fn obj_eq(self: *Self, a: mrb_value, b: mrb_value) mrb_bool {
        return mrb_obj_eq(self, a, b);
    }
    pub fn obj_equal(self: *Self, a: mrb_value, b: mrb_value) mrb_bool {
        return mrb_obj_equal(self, a, b);
    }
    pub fn equal(self: *Self, obj1: mrb_value, obj2: mrb_value) mrb_bool {
        return mrb_equal(self, obj1, obj2);
    }
    pub fn ensure_float_type(self: *Self, value: mrb_value) mrb_value {
        return mrb_ensure_float_type(self, value);
    }
    pub fn inspect(self: *Self, obj: mrb_value) mrb_value {
        return mrb_inspect(self, obj);
    }
    pub fn eql(self: *Self, obj1: mrb_value, obj2: mrb_value) mrb_bool {
        return mrb_eql(self, obj1, obj2);
    }
    /// mrb_cmp(mrb, obj1, obj2): 1:0:-1; -2 for error
    pub fn cmp(self: *Self, obj1: mrb_value, obj2: mrb_value) !mrb_int {
        const ret = mrb_cmp(self, obj1, obj2);
        if (ret == -2) return error.CmpError;
        return ret;
    }

    pub fn gc_arena_save(self: *Self) c_int {
        return mrb_gc_arena_save1(self);
    }
    pub fn gc_arena_restore(self: *Self, idx: c_int) void {
        return mrb_gc_arena_restore1(self, idx);
    }
    pub fn garbage_collect(self: *Self) void {
        return mrb_garbage_collect(self);
    }
    pub fn full_gc(self: *Self) void {
        return mrb_full_gc(self);
    }
    pub fn incremental_gc(self: *Self) void {
        return mrb_incremental_gc(self);
    }
    pub fn gc_mark(self: *Self, obj: *RBasic) void {
        return mrb_gc_mark(self, obj);
    }

    pub fn type_convert(self: *Self, value: mrb_value, typ: mrb_vtype, method: mrb_sym) mrb_value {
        return mrb_type_convert(self, value, typ, method);
    }
    pub fn type_convert_check(self: *Self, value: mrb_value, typ: mrb_vtype, method: mrb_sym) mrb_value {
        return mrb_type_convert_check(self, value, typ, method);
    }

    pub fn any_to_s(self: *Self, obj: mrb_value) mrb_value {
        return mrb_any_to_s(self, obj);
    }
    pub fn obj_classname(self: *Self, obj: mrb_value) ?[*:0]const u8 {
        return mrb_obj_classname(self, obj);
    }
    pub fn obj_class(self: *Self, obj: mrb_value) ?*RClass {
        return mrb_obj_class(self, obj);
    }
    pub fn class_path(self: *Self, cla: *RClass) mrb_value {
        return mrb_class_path(self, cla);
    }
    pub fn obj_is_kind_of(self: *Self, obj: mrb_value, cla: *RClass) mrb_bool {
        return mrb_obj_is_kind_of(self, obj, cla);
    }
    pub fn obj_inspect(self: *Self, obj_self: mrb_value) mrb_value {
        return mrb_obj_inspect(self, obj_self);
    }
    pub fn obj_clone(self: *Self, obj_self: mrb_value) mrb_value {
        return mrb_obj_clone(self, obj_self);
    }

    pub fn exc_new(self: *Self, cla: *RClass, str: []const u8) mrb_value {
        return mrb_exc_new(self, cla, str.ptr, str.len);
    }
    pub fn exc_raise(self: *Self, exception: mrb_value) mrb_noreturn {
        return mrb_exc_raise(self, exception);
    }
    pub fn raise(self: *Self, cla: *RClass, msg: [*:0]const u8) mrb_noreturn {
        return mrb_raise(self, cla, msg);
    }
    pub fn raisef(self: *Self, cla: *RClass, fmt: [*:0]const u8, args: anytype) mrb_noreturn {
        return @call(.{}, mrb_raisef, .{ self, cla, fmt } ++ args);
    }
    pub fn name_error(self: *Self, id: mrb_sym, fmt: [*:0]const u8, args: anytype) mrb_noreturn {
        return @call(.{}, mrb_name_error, .{ self, id, fmt } ++ args);
    }
    pub fn frozen_error(self: *Self, frozen_obj: *anyopaque) mrb_noreturn {
        return mrb_frozen_error(self, frozen_obj);
    }
    pub fn argnum_error(self: *Self, argc: mrb_int, min: c_int, max: c_int) mrb_noreturn {
        return mrb_argnum_error(self, argc, min, max);
    }
    pub fn warn(self: *Self, fmt: [*:0]const u8, args: anytype) void {
        return @call(.{}, mrb_warn, .{ self, fmt } ++ args );
    }
    pub fn bug(self: *Self, fmt: [*:0]const u8, args: anytype) mrb_noreturn {
        return @call(.{}, mrb_bug, .{ self, fmt } ++ args);
    }
    pub fn print_backtrace(self: *Self) void {
        return mrb_print_backtrace(self);
    }
    pub fn print_error(self: *Self) void {
        return mrb_print_error(self);
    }

    pub fn yield(self: *Self, b: mrb_value, arg: mrb_value) mrb_value {
        return mrb_yield(self, b, arg);
    }
    pub fn yield_argv(self: *Self, b: mrb_value, args: []const mrb_value) mrb_value {
        return mrb_yield_argv(self, b, args.len, args.ptr);
    }
    pub fn yield_with_class(self: *Self, b: mrb_value, args: []const mrb_value, yielf_self: mrb_value, cla: *RClass) mrb_value {
        return mrb_yield_with_class(self, b, args.len, args.ptr, yielf_self, cla);
    }
    /// continue execution to the proc
    /// this function should always be called as the last function of a method
    /// e.g. return mrb_yield_cont(mrb, proc, self, argc, argv);
    pub fn yield_cont(self: *Self, b: mrb_value, yielf_self: mrb_value, args: []const mrb_value) mrb_value {
        return mrb_yield_cont(self, b, yielf_self, args.len, args.ptr);
    }

    /// mrb_gc_protect() leaves the object in the arena
    pub fn gc_protect(self: *Self, obj: mrb_value) void {
        return mrb_gc_protect(self, obj);
    }
    /// mrb_gc_register() keeps the object from GC.
    pub fn gc_register(self: *Self, obj: mrb_value) void {
        return mrb_gc_register(self, obj);
    }
    /// mrb_gc_unregister() removes the object from GC root.
    pub fn gc_unregister(self: *Self, obj: mrb_value) void {
        return mrb_gc_unregister(self, obj);
    }

    /// type conversion/check functions
    pub fn ensure_array_type(self: *Self, value: mrb_value) mrb_value {
        return mrb_ensure_array_type(self, value);
    }
    pub fn check_array_type(self: *Self, value: mrb_value) mrb_value {
        return mrb_check_array_type(self, value);
    }
    pub fn ensure_hash_type(self: *Self, hash: mrb_value) mrb_value {
        return mrb_ensure_hash_type(self, hash);
    }
    pub fn check_hash_type(self: *Self, hash: mrb_value) mrb_value {
        return mrb_check_hash_type(self, hash);
    }
    pub fn ensure_string_type(self: *Self, str: mrb_value) mrb_value {
        return mrb_ensure_string_type(self, str);
    }
    pub fn check_string_type(self: *Self, str: mrb_value) mrb_value {
        return mrb_check_string_type(self, str);
    }
    pub fn ensure_int_type(self: *Self, value: mrb_value) mrb_value {
        return mrb_ensure_int_type(self, value);
    }

    /// string type checking (contrary to the name, it doesn't convert)
    pub fn check_type(self: *Self, x: mrb_value, t: mrb_vtype) void {
        return mrb_check_type(self, x, t);
    }

    pub fn define_alias(self: *Self, cla: *RClass, a: [*:0]const u8, b: [*:0]const u8) void {
        return mrb_define_alias(self, cla, a, b);
    }
    pub fn define_alias_id(self: *Self, cla: *RClass, a: mrb_sym, b: mrb_sym) void {
        return mrb_define_alias_id(self, cla, a, b);
    }
    pub fn class_name(self: *Self, klass: *RClass) ?[*:0]const u8 {
        return mrb_class_name(self, klass);
    }
    pub fn define_global_const(self: *Self, name: [*:0]const u8, value: mrb_value) void {
        return mrb_define_global_const(self, name, value);
    }

    pub fn attr_get(self: *Self, obj: mrb_value, id: mrb_sym) mrb_value {
        return mrb_attr_get(self, obj, id);
    }

    pub fn respond_to(self: *Self, obj: mrb_value, mid: mrb_sym) mrb_bool {
        return mrb_respond_to(self, obj, mid);
    }
    pub fn obj_is_instance_of(self: *Self, obj: mrb_value, cla: *RClass) mrb_bool {
        return mrb_obj_is_instance_of(self, obj, cla);
    }
    pub fn func_basic_p(self: *Self, obj: mrb_value, mid: mrb_sym, func: mrb_func_t) mrb_bool {
        return mrb_func_basic_p(self, obj, mid, func);
    }

    /// Resume a Fiber
    ///
    /// Implemented in mruby-fiber
    pub fn fiber_resume(self: *Self, fib: mrb_value, args: []const mrb_value) mrb_value {
        return mrb_fiber_resume(self, fib, args.len, args.ptr);
    }

    /// Yield a Fiber
    ///
    /// Implemented in mruby-fiber
    pub fn fiber_yield(self: *Self, args: []const mrb_value) mrb_value {
        return mrb_fiber_yield(self, args.len, args.ptr);
    }

    /// Check if a Fiber is alive
    ///
    /// Implemented in mruby-fiber
    pub fn fiber_alive_p(self: *Self, fib: mrb_value) mrb_value {
        return mrb_fiber_alive_p(self, fib);
    }

    pub fn stack_extend(self: *Self, int: mrb_int) void {
        return mrb_stack_extend(self, int);
    }

    pub fn pool_open(self: *Self) ?*mrb_pool {
        return mrb_pool_open(self);
    }
    /// temporary memory allocation, only effective while GC arena is kept
    pub fn alloca(self: *Self, size: usize) ?*anyopaque {
        return mrb_alloca(self, size);
    }

    pub fn state_atexit(self: *Self, func: mrb_atexit_func) void {
        return mrb_state_atexit(self, func);
    }

    pub fn show_version(self: *Self) void {
        return mrb_show_version(self);
    }
    pub fn show_copyright(self: *Self) void {
        return mrb_show_copyright(self);
    }

    pub fn format(self: *Self, fmt: [*:0]const u8, args: anytype) mrb_value {
        return @call(.{}, mrb_format, .{ self, fmt } ++ args);
    }

    // mruby/array.h

    /// Initializes a new array.
    ///
    /// Equivalent to:
    ///
    ///      Array.new
    ///
    /// @param mrb The mruby state reference.
    /// @return The initialized array.
    pub fn ary_new(self: *Self) mrb_value {
        return mrb_ary_new(self);
    }

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
    pub fn ary_new_from_values(self: *Self, vals: []const mrb_value) mrb_value {
        return mrb_ary_new_from_values(self, vals.len, vals.ptr);
    }

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
    pub fn assoc_new(self: *Self, car: mrb_value, cdr: mrb_value) mrb_value {
        return mrb_assoc_new(self, car, cdr);
    }

    /// Concatenate two arrays. The target array will be modified
    ///
    /// Equivalent to:
    ///      ary.concat(other)
    ///
    /// @param mrb The mruby state reference.
    /// @param self The target array.
    /// @param other The array that will be concatenated to self.
    pub fn ary_concat(self: *Self, array_self: mrb_value, other: mrb_value) void {
        return mrb_ary_concat(self, array_self, other);
    }

    /// Create an array from the input. It tries calling to_a on the
    /// value. If value does not respond to that, it creates a new
    /// array with just this value.
    ///
    /// @param mrb The mruby state reference.
    /// @param value The value to change into an array.
    /// @return An array representation of value.
    pub fn ary_splat(self: *Self, value: mrb_value) mrb_value {
        return mrb_ary_splat(self, value);
    }

    /// Pushes value into array.
    ///
    /// Equivalent to:
    ///
    ///      ary << value
    ///
    /// @param mrb The mruby state reference.
    /// @param ary The array in which the value will be pushed
    /// @param value The value to be pushed into array
    pub fn ary_push(self: *Self, array: mrb_value, value: mrb_value) void {
        return mrb_ary_push(self, array, value);
    }

    /// Pops the last element from the array.
    ///
    /// Equivalent to:
    ///
    ///      ary.pop
    ///
    /// @param mrb The mruby state reference.
    /// @param ary The array from which the value will be popped.
    /// @return The popped value.
    pub fn ary_pop(self: *Self, ary: mrb_value) mrb_value {
        return mrb_ary_pop(self, ary);
    }

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
    pub fn ary_set(self: *Self, ary: mrb_value, n: mrb_int, value: mrb_value) void {
        return mrb_ary_set(self, ary, n, value);
    }

    /// Replace the array with another array
    ///
    /// Equivalent to:
    ///
    ///      ary.replace(other)
    ///
    /// @param mrb The mruby state reference
    /// @param self The target array.
    /// @param other The array to replace it with.
    pub fn ary_replace(self: *Self, array_self: mrb_value, other: mrb_value) void {
        return mrb_ary_replace(self, array_self, other);
    }

    /// Unshift an element into the array
    ///
    /// Equivalent to:
    ///
    ///     ary.unshift(item)
    ///
    /// @param mrb The mruby state reference.
    /// @param self The target array.
    /// @param item The item to unshift.
    pub fn ary_unshift(self: *Self, array_self: mrb_value, item: mrb_value) mrb_value {
        return mrb_ary_unshift(self, array_self, item);
    }

    /// Get nth element in the array
    ///
    /// Equivalent to:
    ///
    ///     ary[offset]
    ///
    /// @param ary The target array.
    /// @param offset The element position (negative counts from the tail).
    pub fn ary_entry(ary: mrb_value, offset: mrb_int) mrb_value {
        return mrb_ary_entry(ary, offset);
    }

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
    pub fn ary_splice(self: *Self, array_self: mrb_value, head: mrb_int, len: mrb_int, rpl: mrb_value) mrb_value {
        return mrb_ary_splice(self, array_self, head, len, rpl);
    }

    /// Shifts the first element from the array.
    ///
    /// Equivalent to:
    ///
    ///      ary.shift
    ///
    /// @param mrb The mruby state reference.
    /// @param self The array from which the value will be shifted.
    /// @return The shifted value.
    pub fn ary_shift(self: *Self, array_self: mrb_value) mrb_value {
        return mrb_ary_shift(self, array_self);
    }

    /// Removes all elements from the array
    ///
    /// Equivalent to:
    ///
    ///      ary.clear
    ///
    /// @param mrb The mruby state reference.
    /// @param self The target array.
    /// @return self
    pub fn ary_clear(self: *Self, array_self: mrb_value) mrb_value {
        return mrb_ary_clear(self, array_self);
    }

    /// Join the array elements together in a string
    ///
    /// Equivalent to:
    ///
    ///      ary.join(sep="")
    ///
    /// @param mrb The mruby state reference.
    /// @param ary The target array
    /// @param sep The separator, can be NULL
    pub fn ary_join(self: *Self, ary: mrb_value, sep: mrb_value) mrb_value {
        return mrb_ary_join(self, ary, sep);
    }

    /// Update the capacity of the array
    ///
    /// @param mrb The mruby state reference.
    /// @param ary The target array.
    /// @param new_len The new capacity of the array
    pub fn ary_resize(self: *Self, ary: mrb_value, new_len: mrb_int) mrb_value {
        return mrb_ary_resize(self, ary, new_len);
    }

    // mruby/compile.h

    // TODO: mrbc/lex/parse structs and functions

    /// program load functions
    /// Please note! Currently due to interactions with the GC calling these functions will
    /// leak one RProc object per function call.
    /// To prevent this save the current memory arena before calling and restore the arena
    /// right after, like so
    /// int ai = mrb_gc_arena_save(mrb);
    /// mrb_value status = mrb_load_string(mrb, buffer);
    /// mrb_gc_arena_restore(mrb, ai);
    // #ifndef MRB_NO_STDIO
    pub fn load_file(self: *Self, fp: *FILE) mrb_value {
        return mrb_load_file(self, fp);
    }
    pub fn load_file_cxt(self: *Self, fp: *FILE, cxt: *mrbc_context) mrb_value {
        return mrb_load_file_cxt(self, fp, cxt);
    }
    pub fn load_detect_file_cxt(self: *Self, fp: *FILE, cxt: *mrbc_context) mrb_value {
        return mrb_load_detect_file_cxt(self, fp, cxt);
    }
    // #endif
    pub fn load_string(self: *Self, s: [*:0]const u8) mrb_value {
        return mrb_load_string(self, s);
    }
    pub fn load_nstring(self: *Self, s: []const u8) mrb_value {
        return mrb_load_nstring(self, s.ptr, s.len);
    }
    pub fn load_string_cxt(self: *Self, s: [*:0]const u8, cxt: *mrbc_context) mrb_value {
        return mrb_load_string_cxt(self, s, cxt);
    }
    pub fn load_nstring_cxt(self: *Self, s: []const u8, cxt: *mrbc_context) mrb_value {
        return mrb_load_nstring_cxt(self, s.ptr, s.len, cxt);
    }

    // mruby/variable.h

    pub fn const_get(self: *Self, obj: mrb_value, sym: mrb_sym) mrb_value {
        return mrb_const_get(self, obj, sym);
    }
    pub fn const_set(self: *Self, obj: mrb_value, sym: mrb_sym, value: mrb_value) void {
        return mrb_const_set(self, obj, sym, value);
    }
    pub fn const_defined(self: *Self, obj: mrb_value, sym: mrb_sym) mrb_bool {
        return mrb_const_defined(self, obj, sym);
    }
    pub fn const_remove(self: *Self, obj: mrb_value, sym: mrb_sym) void {
        return mrb_const_remove(self, obj, sym);
    }

    pub fn iv_name_sym_p(self: *Self, sym: mrb_sym) mrb_bool {
        return mrb_iv_name_sym_p(self, sym);
    }
    pub fn iv_name_sym_check(self: *Self, sym: mrb_sym) void {
        return mrb_iv_name_sym_check(self, sym);
    }
    pub fn obj_iv_get(self: *Self, obj: *RObject, sym: mrb_sym) mrb_value {
        return mrb_obj_iv_get(self, obj, sym);
    }
    pub fn obj_iv_set(self: *Self, obj: *RObject, sym: mrb_sym, v: mrb_value) void {
        return mrb_obj_iv_set(self, obj, sym, v);
    }
    pub fn obj_iv_defined(self: *Self, obj: *RObject, sym: mrb_sym) mrb_bool {
        return mrb_obj_iv_defined(self, obj, sym);
    }
    pub fn iv_get(self: *Self, obj: mrb_value, sym: mrb_sym) mrb_value {
        return mrb_iv_get(self, obj, sym);
    }
    pub fn iv_set(self: *Self, obj: mrb_value, sym: mrb_sym, v: mrb_value) void {
        return mrb_iv_set(self, obj, sym, v);
    }
    pub fn iv_defined(self: *Self, obj: mrb_value, sym: mrb_sym) mrb_bool {
        return mrb_iv_defined(self, obj, sym);
    }
    pub fn iv_remove(self: *Self, obj: mrb_value, sym: mrb_sym) mrb_value {
        return mrb_iv_remove(self, obj, sym);
    }
    pub fn iv_copy(self: *Self, dst: mrb_value, src: mrb_value) void {
        return mrb_iv_copy(self, sdt, src);
    }
    pub fn const_defined_at(self: *Self, mod: mrb_value, id: mrb_sym) mrb_bool {
        return mrb_const_defined_at(self, mod, id);
    }

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
    pub fn gv_get(self: *Self, sym: mrb_sym) mrb_value {
        return mrb_gv_get(self, sym);
    }

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
    pub fn gv_set(self: *Self, sym: mrb_sym, val: mrb_value) void {
        return mrb_gv_set(self, sym, val);
    }

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
    pub fn gv_remove(self: *Self, sym: mrb_sym) void {
        return mrb_gv_remove(self, sym);
    }

    pub fn cv_get(self: *Self, mod: mrb_value, sym: mrb_sym) mrb_value {
        return mrb_cv_get(self, mod, sym);
    }
    pub fn mod_cv_set(self: *Self, cla: *RClass, sym: mrb_sym, v: mrb_value) void {
        return mrb_mod_cv_set(self, cla, sym, v);
    }
    pub fn cv_set(self: *Self, mod: mrb_value, sym: mrb_sym, v: mrb_value) void {
        return mrb_cv_set(self, mod, sym, v);
    }
    pub fn cv_defined(self: *Self, mod: mrb_value, sym: mrb_sym) mrb_bool {
        return mrb_cv_defined(self, mod, sym);
    }

    // mruby/value.h

    /// Returns a float in Ruby.
    ///
    /// Takes a float and boxes it into an mrb_value
    pub fn float_value(self: *Self, f: mrb_float) mrb_value {
        return mrb_get_float_value(self, f);
    }
    pub fn cptr_value(self: *Self, p: *anyopaque) mrb_value {
        return mrb_get_cptr_value(self, p);
    }
    /// Returns an integer in Ruby.
    pub fn int_value(self: *Self, i: mrb_int) mrb_value {
        return mrb_get_int_value(self, i);
    }
    pub fn fixnum_value(i: mrb_int) mrb_value {
        return mrb_get_fixnum_value(i);
    }
    pub fn symbol_value(i: mrb_sym) mrb_value {
        return mrb_get_symbol_value(i);
    }
    pub fn obj_value(p: *anyopaque) mrb_value {
        return mrb_get_obj_value(p);
    }
    /// Get a nil mrb_value object.
    ///
    /// @return
    ///      nil mrb_value object reference.
    pub fn nil_value() mrb_value {
        return mrb_get_nil_value();
    }
    /// Returns false in Ruby.
    pub fn false_value() mrb_value {
        return mrb_get_false_value();
    }
    /// Returns true in Ruby.
    pub fn true_value() mrb_value {
        return mrb_get_true_value();
    }
    pub fn bool_value(boolean: mrb_bool) mrb_value {
        return mrb_get_bool_value(boolean);
    }
    pub fn undef_value() mrb_value {
        return mrb_get_undef_value();
    }

    // mruby/class.h

    pub fn class(self: *Self, v: mrb_value) ?*RClass {
        return mrb_class(self, v);
    }
    pub fn alias_method(self: *Self, cla: *RClass, a: mrb_sym, b: mrb_sym) void {
        return mrb_alias_method(self, cla, a, b);
    }
    pub fn remove_method(self: *Self, cla: *RClass, sym: mrb_sym) void {
        return mrb_remove_method(self, cla, sym);
    }

    // mruby/data.h

    /// Create RData object with klass, add data pointer and data type
    pub fn data_object_alloc(self: *Self, klass: *RClass, data_ptr: *anyopaque, data_type: *const mrb_data_type) ?*RData {
        return mrb_data_object_alloc(self, klass, data_ptr, data_type);
    }
    pub fn data_check_type(self: *Self, value: mrb_value, data_type: *const mrb_data_type) void {
        return mrb_data_check_type(self, value, data_type);
    }
    /// Get data pointer from RData object pointed to by mrb_value
    pub fn data_get_ptr(self: *Self, value: mrb_value, data_type: *const mrb_data_type) ?*anyopaque {
        return mrb_data_get_ptr(self, value, data_type);
    }
    pub fn data_check_get_ptr(self: *Self, value: mrb_value, data_type: *const mrb_data_type) ?*anyopaque {
        return mrb_data_check_get_ptr(self, value, data_type);
    }
    /// Define data pointer and data type of existing value pointing to RData object
    pub fn data_init(value: mrb_value, data_ptr: *anyopaque, data_type: *mrb_data_type) void {
        return mrb_data_init(value, data_ptr, data_type);
    }

    // mruby/error.h

    pub fn sys_fail(self: *Self, mesg: [*:0]const u8) void {
        return mrb_sys_fail(self, mesg);
    }
    pub fn exc_new_str(self: *Self, cla: *RClass, str: mrb_value) mrb_value {
        return mrb_exc_new_str(self, cla, str);
    }
    pub fn mrb_exc_new_lit(self: *Self, cla: *RClass, lit: []const u8) mrb_value {
        return mrb_exc_new_str(self, cla, mrb_str_new_lit(self, lit));
    }
    pub fn mrb_exc_new_str_lit(self: *Self, cla: *RClass, lit: []const u8) mrb_value {
        return mrb_exc_new_lit(self, cla, lit);
    }
    pub fn make_exception(self: *Self, args: []const mrb_value) mrb_value {
        return mrb_make_exception(self, args.len, args.ptr);
    }
    pub fn exc_backtrace(self: *Self, exc: mrb_value) mrb_value {
        return mrb_exc_backtrace(self, exc);
    }
    pub fn get_backtrace(self: *Self) mrb_value {
        return mrb_get_backtrace(self);
    }
    pub fn no_method_error(self: *Self, id: mrb_sym, args: mrb_value, fmt: [*:0]const u8, vars: anytype) mrb_noreturn {
        return @call(.{}, .{ self, id, args, fmt } ++ vars);
    }

};

pub const mrb_context = opaque {
    const Self = @This();

    pub fn prev(self: *Self) ?*mrb_context {
        return mrb_context_prev(self);
    }
    pub fn callinfo(self: *Self) ?*mrb_callinfo {
        return mrb_context_callinfo(self);
    }
    pub fn fiber_state(self: *Self) mrb_fiber_state {
        return mrb_context_fiber_state(self);
    }
    pub fn fiber(self: *Self) ?*RFiber {
        return mrb_context_fiber(self);
    }
};

pub const mrb_callinfo = opaque {
    const Self = @This();

    pub fn n(self: *Self) u8 {
        return mrb_callinfo_n(self);
    }
    pub fn nk(self: *Self) u8 {
        return mrb_callinfo_nk(self);
    }
    pub fn cci(self: *Self) u8 {
        return mrb_callinfo_cci(self);
    }
    pub fn mid(self: *Self) mrb_sym {
        return mrb_callinfo_mid(self);
    }
    pub fn stack(self: *Self) [*]?*mrb_value {
        return mrb_callinfo_stack(self);
    }
    pub fn proc(self: *Self) ?*RProc {
        return mrb_callinfo_proc(self);
    }
};

pub const mrb_gc = opaque {};
pub const mrb_irep = opaque {};
pub const mrb_jmpbuf = opaque {};
pub const mrb_jumpbuf = opaque {};
pub const mrb_pool = opaque {
    const Self = @This();

    pub fn pool_close(self: *Self) void {
        return mrb_pool_close(self);
    }
    pub fn pool_alloc(self: *Self, size: usize) ?*anyopaque {
        return mrb_pool_alloc(self, size);
    }
    pub fn pool_realloc(self: *Self, ptr: *anyopaque, oldlen: usize, newlen: usize) ?*anyopaque {
        return mrb_pool_realloc(self, ptr, oldlen, newlen);
    }
    pub fn pool_can_realloc(self: *Self, ptr: *anyopaque, size: usize) mrb_bool {
        return mrb_pool_can_realloc(self, ptr, size);
    }
};
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
pub const mrb_value = extern struct {  // HACK: assume word boxing for now
    w: usize,

    const Self = @This();

    pub fn vType(self: Self) mrb_vtype {
        return mrb_type(self);
    }

    pub fn cptr(self: Self) *anyopaque {
        return mrb_get_cptr(self);
    }
    pub fn ptr(self: Self) *anyopaque {
        return mrb_get_ptr(self);
    }
    pub fn integer(self: Self) mrb_int {
        return mrb_get_integer(self);
    }
    pub fn float(self: Self) mrb_float {
        return mrb_get_float(self);
    }
    pub fn sym(self: Self) mrb_sym {
        return mrb_get_sym(self);
    }
    pub fn boolean(self: Self) mrb_bool {
        return mrb_get_bool(self);
    }
    pub fn rbasic(self: Self) ?*RBasic {
        return @ptrCast(*RBasic, self.ptr());
    }
    pub fn rfloat(self: Self) ?*RFloat {
        return @ptrCast(*RFloat, self.ptr());
    }
    pub fn rdata(self: Self) ?*RData {
        return @ptrCast(*RData, self.ptr());
    }
    pub fn rinteger(self: Self) ?*RInteger {
        return @ptrCast(*RInteger, self.ptr());
    }
    pub fn rcptr(self: Self) ?*RCptr {
        return @ptrCast(*RCptr, self.ptr());
    }
    pub fn robject(self: Self) ?*RObject {
        return @ptrCast(*RObject, self.ptr());
    }
    pub fn rclass(self: Self) ?*RClass {
        return @ptrCast(*RClass, self.ptr());
    }
    pub fn rproc(self: Self) ?*RProc {
        return @ptrCast(*RProc, self.ptr());
    }
    pub fn rarray(self: Self) ?*RArray {
        return @ptrCast(*RArray, self.ptr());
    }
    pub fn rhash(self: Self) ?*RHash {
        return @ptrCast(*RHash, self.ptr());
    }
    pub fn rstring(self: Self) ?*RString {
        return @ptrCast(*RString, self.ptr());
    }
    pub fn rrange(self: Self) ?*RRange {
        return @ptrCast(*RRange, self.ptr());
    }
    pub fn rexception(self: Self) ?*RException {
        return @ptrCast(*RException, self.ptr());
    }
    pub fn renv(self: Self) ?*REnv {
        return @ptrCast(*REnv, self.ptr());
    }
    pub fn rfiber(self: Self) ?*RFiber {
        return @ptrCast(*RFiber, self.ptr());
    }
    pub fn ristruct(self: Self) ?*RIStruct {
        return @ptrCast(*RIStruct, self.ptr());
    }
    pub fn rbreak(self: Self) ?*RBreak {
        return @ptrCast(*RBreak, self.ptr());
    }
    pub fn rcomplex(self: Self) ?*RComplex {
        return @ptrCast(*RComplex, self.ptr());
    }
    pub fn rrational(self: Self) ?*RRational {
        return @ptrCast(*RRational, self.ptr());
    }


    pub fn fixnum_p(self: Self) mrb_bool {
        return mrb_get_fixnum_p(o);
    }
    pub fn integer_p(o: mrb_value) mrb_bool {
        return mrb_get_integer_p(o);
    }
    pub fn symbol_p(o: mrb_value) mrb_bool {
        return mrb_get_symbol_p(o);
    }
    pub fn undef_p(o: mrb_value) mrb_bool {
        return mrb_get_undef_p(o);
    }
    pub fn nil_p(o: mrb_value) mrb_bool {
        return mrb_get_nil_p(o);
    }
    pub fn false_p(o: mrb_value) mrb_bool {
        return mrb_get_false_p(o);
    }
    pub fn true_p(o: mrb_value) mrb_bool {
        return mrb_get_true_p(o);
    }
    pub fn float_p(o: mrb_value) mrb_bool {
        return mrb_get_float_p(o);
    }
    pub fn array_p(o: mrb_value) mrb_bool {
        return mrb_get_array_p(o);
    }
    pub fn string_p(o: mrb_value) mrb_bool {
        return mrb_get_string_p(o);
    }
    pub fn hash_p(o: mrb_value) mrb_bool {
        return mrb_get_hash_p(o);
    }
    pub fn cptr_p(o: mrb_value) mrb_bool {
        return mrb_get_cptr_p(o);
    }
    pub fn exception_p(o: mrb_value) mrb_bool {
        return mrb_get_exception_p(o);
    }
    pub fn free_p(o: mrb_value) mrb_bool {
        return mrb_get_free_p(o);
    }
    pub fn object_p(o: mrb_value) mrb_bool {
        return mrb_get_object_p(o);
    }
    pub fn class_p(o: mrb_value) mrb_bool {
        return mrb_get_class_p(o);
    }
    pub fn module_p(o: mrb_value) mrb_bool {
        return mrb_get_module_p(o);
    }
    pub fn iclass_p(o: mrb_value) mrb_bool {
        return mrb_get_iclass_p(o);
    }
    pub fn sclass_p(o: mrb_value) mrb_bool {
        return mrb_get_sclass_p(o);
    }
    pub fn proc_p(o: mrb_value) mrb_bool {
        return mrb_get_proc_p(o);
    }
    pub fn range_p(o: mrb_value) mrb_bool {
        return mrb_get_range_p(o);
    }
    pub fn env_p(o: mrb_value) mrb_bool {
        return mrb_get_env_p(o);
    }
    pub fn data_p(o: mrb_value) mrb_bool {
        return mrb_get_data_p(o);
    }
    pub fn fiber_p(o: mrb_value) mrb_bool {
        return mrb_get_fiber_p(o);
    }
    pub fn istruct_p(o: mrb_value) mrb_bool {
        return mrb_get_istruct_p(o);
    }
    pub fn break_p(o: mrb_value) mrb_bool {
        return mrb_get_break_p(o);
    }
};

pub const iv_tbl = opaque {};

pub const mrb_fiber_state = enum(c_int) {
  MRB_FIBER_CREATED,
  MRB_FIBER_RUNNING,
  MRB_FIBER_RESUMED,
  MRB_FIBER_SUSPENDED,
  MRB_FIBER_TRANSFERRED,
  MRB_FIBER_TERMINATED,
};

// Opaque types

pub const RBasic = opaque {
    const Self = @This();

    pub fn value(self: *Self) mrb_value {
        return mrb_obj_value(self);
    }
};
pub const RFloat = opaque {
    const Self = @This();

    pub fn value(self: *Self) mrb_value {
        return mrb_obj_value(self);
    }
};

pub const RData = opaque {
    const Self = @This();

    pub fn value(self: *Self) mrb_value {
        return mrb_obj_value(self);
    }

    pub fn data(self: *Self) ?*anyopaque;
    pub fn data_type(self: *Self) ?*mrb_data_type;

};
pub const RInteger = opaque {
    const Self = @This();

    pub fn value(self: *Self) mrb_value {
        return mrb_obj_value(self);
    }
};
pub const RCptr = opaque {
    const Self = @This();

    pub fn value(self: *Self) mrb_value {
        return mrb_obj_value(self);
    }
};
pub const RObject = opaque {
    const Self = @This();

    pub fn value(self: *Self) mrb_value {
        return mrb_obj_value(self);
    }
};
pub const RClass = opaque {
    const Self = @This();

    pub fn value(self: *Self) mrb_value {
        return mrb_obj_value(self);
    }

    pub fn class_real(self: *Self) ?*Self {
        return mrb_class_real(self);
    }

};
pub const RProc = opaque {
    const Self = @This();

    pub fn value(self: *Self) mrb_value {
        return mrb_obj_value(self);
    }
};
pub const RArray = opaque {
    const Self = @This();

    pub fn value(self: *Self) mrb_value {
        return mrb_obj_value(self);
    }

    pub fn len(self: *Self) mrb_int {
        return mrb_ary_len(ptr);
    }

    pub fn capa(self: *Self) mrb_int {
        return mrb_ary_capa(ptr);
    }

};
pub const RHash = opaque {
    const Self = @This();

    pub fn value(self: *Self) mrb_value {
        return mrb_obj_value(self);
    }
};
pub const RString = opaque {
    const Self = @This();

    pub fn value(self: *Self) mrb_value {
        return mrb_obj_value(self);
    }
};
pub const RRange = opaque {
    const Self = @This();

    pub fn value(self: *Self) mrb_value {
        return mrb_obj_value(self);
    }
};
pub const RException = opaque {
    const Self = @This();

    pub fn value(self: *Self) mrb_value {
        return mrb_obj_value(self);
    }
};
pub const REnv = opaque {
    const Self = @This();

    pub fn value(self: *Self) mrb_value {
        return mrb_obj_value(self);
    }
};
pub const RFiber = opaque {
    const Self = @This();

    pub fn value(self: *Self) mrb_value {
        return mrb_obj_value(self);
    }
};
pub const RIStruct = opaque {
    const Self = @This();

    pub fn value(self: *Self) mrb_value {
        return mrb_obj_value(self);
    }
};
pub const RBreak = opaque {
    const Self = @This();

    pub fn value(self: *Self) mrb_value {
        return mrb_obj_value(self);
    }
};
pub const RComplex = opaque {
    const Self = @This();

    pub fn value(self: *Self) mrb_value {
        return mrb_obj_value(self);
    }
};
pub const RRational = opaque {
    const Self = @This();

    pub fn value(self: *Self) mrb_value {
        return mrb_obj_value(self);
    }
};


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
pub fn mrb_args_req(n: u4) mrb_aspec {
    return (@as(u32, n) & 0x1f) << 18;
}

/// Function takes n optional arguments
///
/// @param n
///      The number of optional arguments.
pub fn mrb_args_opt(n: u4) mrb_aspec {
    return (@as(u32, n) & 0x1f) << 13;
}

/// Function takes n1 mandatory arguments and n2 optional arguments
///
/// @param n1
///      The number of required arguments.
/// @param n2
///      The number of optional arguments.
pub fn mrb_args_arg(n1: u4, n2: u4) mrb_aspec {
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
pub fn mrb_args_key(n1: u4, n2: u4) mrb_aspec {
    return ((@as(u32, n1) & 0x1f) << 2) | (if (n2 != 0) @as(u8, 1<<1) else 0);
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

// get method symbol
pub fn mrb_get_mid(mrb: *mrb_state) mrb_sym {
    return mrb.context().?.callinfo().?.mid();
}

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
pub extern fn mrb_funcall(mrb: *mrb_state, val: mrb_value, name: [*:0]const u8, argc: usize, ...) mrb_value;
pub extern fn mrb_funcall_id(mrb: *mrb_state, val: mrb_value, mid: mrb_sym, argc: usize, ...) mrb_value;

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
pub extern fn mrb_funcall_argv(mrb: *mrb_state, val: mrb_value, name: mrb_sym, argc: usize, argv: [*]const *mrb_value) mrb_value;

/// Call existing ruby functions with a block.
pub extern fn mrb_funcall_with_block(mrb: *mrb_state, val: mrb_value, name: mrb_sym, argc: usize, argv: [*]const *mrb_value, block: mrb_value) mrb_value;


/// `strlen` for character string literals (use with caution or `strlen` instead)
///  Adjacent string literals are concatenated in C/C++ in translation phase 6.
///  If `lit` is not one, the compiler will report a syntax error:
///   MSVC: "error C2143: syntax error : missing ')' before 'string'"
///   GCC:  "error: expected ')' before string constant"
pub fn mrb_strlen_lit(lit: []const u8) usize {
    return lit.len;
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
pub extern fn mrb_intern(mrb_state: *mrb_state, char: [*]const u8, size: usize) mrb_sym;
pub extern fn mrb_intern_static(mrb_state: *mrb_state, char: [*]const u8, size: usize) mrb_sym;
pub fn mrb_intern_lit(mrb: *mrb_state, lit: []const u8) mrb_sym {
    return mrb_intern_static(mrb, lit.ptr, mrb_strlen_lit(lit));
}
pub extern fn mrb_intern_str(mrb: *mrb_state, val: mrb_value) mrb_sym;
/// mrb_intern_check series functions returns 0 if the symbol is not defined
pub extern fn mrb_intern_check_cstr(mrb: *mrb_state, str: [*:0]const u8) mrb_sym;
pub extern fn mrb_intern_check(mrb: *mrb_state, str: [*]const u8, size: usize) mrb_sym;
pub extern fn mrb_intern_check_str(mrb: *mrb_state, val: mrb_value) mrb_sym;
/// mrb_check_intern series functions returns nil if the symbol is not defined
/// otherwise returns mrb_value
pub extern fn mrb_check_intern_cstr(mrb: *mrb_state, str: [*:0]const u8) mrb_value;
pub extern fn mrb_check_intern(mrb: *mrb_state, str: [*]const u8, size: usize) mrb_value;
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

pub extern fn mrb_str_new(mrb: *mrb_state, p: [*]const u8, len: usize) mrb_value;

/// Turns a C string into a Ruby string value.
pub extern fn mrb_str_new_cstr(mrb: *mrb_state, str: [*:0]const u8) mrb_value;
pub extern fn mrb_str_new_static(mrb: *mrb_state, ptr: [*]const u8, len: usize) mrb_value;
pub fn mrb_str_new_lit(mrb: *mrb_state, lit: []const u8) mrb_value {
    return mrb_str_new_static(mrb, lit.ptr, lit.len);
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
pub fn mrb_str_new_lit_frozen(mrb: *mrb_state, lit: []const u8) mrb_value {
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

// pub extern fn mrb_gc_arena_save(mrb: *mrb_state) c_int;
// pub extern fn mrb_gc_arena_restore(mrb: *mrb_state) void;

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

pub extern fn mrb_pool_open(mrb: *mrb_state) ?*mrb_pool;
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

pub fn mrb_ary_ptr(val: mrb_value) ?*RArray {
    return mrb_ary_get_ptr(val);
}
pub fn mrb_ary_value(ptr: *RArray) mrb_value {
    return mrb_ary_get_value(ptr);
}

// hacks
extern fn mrb_ary_get_ptr(val: mrb_value) ?*RArray;
extern fn mrb_ary_get_value(ptr: *RArray) mrb_value;
pub extern fn mrb_ary_len(ptr: *RArray) mrb_int;
pub extern fn mrb_ary_capa(ptr: *RArray) mrb_int;

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
pub extern fn mrb_mod_cv_set(mrb: *mrb_state, cla: *RClass, sym: mrb_sym, v: mrb_value) void;
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
pub fn mrb_float_value(mrb: *mrb_state, f: mrb_float) mrb_value {
    return mrb_get_float_value(mrb, f);
}
pub fn mrb_cptr_value(mrb: *mrb_state, p: *anyopaque) mrb_value {
    return mrb_get_cptr_value(mrb, p);
}
/// Returns an integer in Ruby.
pub fn mrb_int_value(mrb: *mrb_state, i: mrb_int) mrb_value {
    return mrb_get_int_value(mrb, i);
}
pub fn mrb_fixnum_value(i: mrb_int) mrb_value {
    return mrb_get_fixnum_value(i);
}
pub fn mrb_symbol_value(i: mrb_sym) mrb_value {
    return mrb_get_symbol_value(i);
}
pub fn mrb_obj_value(p: *anyopaque) mrb_value {
    return mrb_get_obj_value(p);
}
/// Get a nil mrb_value object.
///
/// @return
///      nil mrb_value object reference.
pub fn mrb_nil_value() mrb_value {
    return mrb_get_nil_value();
}
/// Returns false in Ruby.
pub fn mrb_false_value() mrb_value {
    return mrb_get_false_value();
}
/// Returns true in Ruby.
pub fn mrb_true_value() mrb_value {
    return mrb_get_true_value();
}
pub fn mrb_bool_value(boolean: mrb_bool) mrb_value {
    return mrb_get_bool_value(boolean);
}
pub fn mrb_undef_value() mrb_value {
    return mrb_get_undef_value();
}

// hacks
pub extern fn mrb_get_float_value(mrb: *mrb_state, f: mrb_float) mrb_value;
pub extern fn mrb_get_cptr_value(mrb: *mrb_state, p: *anyopaque) mrb_value;
pub extern fn mrb_get_int_value(mrb: *mrb_state, i: mrb_int) mrb_value;
pub extern fn mrb_get_fixnum_value(i: mrb_int) mrb_value;
pub extern fn mrb_get_symbol_value(i: mrb_sym) mrb_value;
pub extern fn mrb_get_obj_value(p: *anyopaque) mrb_value;
pub extern fn mrb_get_nil_value() mrb_value;
pub extern fn mrb_get_false_value() mrb_value;
pub extern fn mrb_get_true_value() mrb_value;
pub extern fn mrb_get_bool_value(boolean: mrb_bool) mrb_value;
pub extern fn mrb_get_undef_value() mrb_value;


/////////////////////////////////////////////////
//            mruby/<boxing_type>.h            //
/////////////////////////////////////////////////


pub extern fn mrb_integer_func(o: mrb_value) mrb_int;
pub extern fn mrb_type(o:mrb_value) mrb_vtype;
// hacks
pub extern fn mrb_get_ptr(v: mrb_value) *anyopaque;
pub extern fn mrb_get_cptr(v: mrb_value) *anyopaque;
pub extern fn mrb_get_float(v: mrb_value) mrb_float;
pub extern fn mrb_get_integer(v: mrb_value) mrb_int;
pub extern fn mrb_get_sym(v: mrb_value) mrb_sym;
pub extern fn mrb_get_bool(v: mrb_value) mrb_bool;

pub extern fn mrb_get_fixnum_p(o: mrb_value) mrb_bool;
pub extern fn mrb_get_integer_p(o: mrb_value) mrb_bool;
pub extern fn mrb_get_symbol_p(o: mrb_value) mrb_bool;
pub extern fn mrb_get_undef_p(o: mrb_value) mrb_bool;
pub extern fn mrb_get_nil_p(o: mrb_value) mrb_bool;
pub extern fn mrb_get_false_p(o: mrb_value) mrb_bool;
pub extern fn mrb_get_true_p(o: mrb_value) mrb_bool;

pub extern fn mrb_get_float_p(o: mrb_value) mrb_bool;
pub extern fn mrb_get_array_p(o: mrb_value) mrb_bool;
pub extern fn mrb_get_string_p(o: mrb_value) mrb_bool;
pub extern fn mrb_get_hash_p(o: mrb_value) mrb_bool;
pub extern fn mrb_get_cptr_p(o: mrb_value) mrb_bool;
pub extern fn mrb_get_exception_p(o: mrb_value) mrb_bool;
pub extern fn mrb_get_free_p(o: mrb_value) mrb_bool;
pub extern fn mrb_get_object_p(o: mrb_value) mrb_bool;
pub extern fn mrb_get_class_p(o: mrb_value) mrb_bool;
pub extern fn mrb_get_module_p(o: mrb_value) mrb_bool;
pub extern fn mrb_get_iclass_p(o: mrb_value) mrb_bool;
pub extern fn mrb_get_sclass_p(o: mrb_value) mrb_bool;
pub extern fn mrb_get_proc_p(o: mrb_value) mrb_bool;
pub extern fn mrb_get_range_p(o: mrb_value) mrb_bool;
pub extern fn mrb_get_env_p(o: mrb_value) mrb_bool;
pub extern fn mrb_get_data_p(o: mrb_value) mrb_bool;
pub extern fn mrb_get_fiber_p(o: mrb_value) mrb_bool;
pub extern fn mrb_get_istruct_p(o: mrb_value) mrb_bool;
pub extern fn mrb_get_break_p(o: mrb_value) mrb_bool;



/////////////////////////////////////////
//            mruby/class.h            //
/////////////////////////////////////////

pub extern fn mrb_class(mrb: *mrb_state, v: mrb_value) ?*RClass;
// pub extern fn mrb_define_method_raw(mrb: *mrb_state, cla: *RClass, sym: mrb_sym, method: mrb_method_t) void;
pub extern fn mrb_alias_method(mrb: *mrb_state, cla: *RClass, a: mrb_sym, b: mrb_sym) void;
pub extern fn mrb_remove_method(mrb: *mrb_state, cla: *RClass, sym: mrb_sym) void;
// pub extern fn mrb_method_search_vm(mrb: *mrb_state, cla: *RClass, sym: mrb_sym) mrb_method_t;
// pub extern fn mrb_method_search(mrb: *mrb_state, cla: *RClass, sym: mrb_sym) mrb_method_t;
pub extern fn mrb_class_real(cl: *RClass) ?*RClass;

// pub const mrb_mt_foreach_func = fn (mrb: *mrb_state, sym: mrb_sym, method: mrb_method_t, data: *anyopaque) c_int;
// pub extern fn mrb_mt_foreach(mrb: *mrb_state, cla: *RClass, func: *mrb_mt_foreach_func, data: *anyopaque) void;


////////////////////////////////////////
//            mruby/data.h            //
////////////////////////////////////////

pub const mrb_data_type = extern struct {
    struct_name: [*:0]const u8,
    dfree: fn (mrb: *mrb_state, ptr: *anyopaque) callconv(.C) void,
};
/// Create RData object with klass, add data pointer and data type
pub extern fn mrb_data_object_alloc(mrb: *mrb_state, klass: *RClass, data_ptr: *anyopaque, data_type: *const mrb_data_type) ?*RData;
pub extern fn mrb_data_check_type(mrb: *mrb_state, value: mrb_value, data_type: *const mrb_data_type) void;
/// Get data pointer from RData object pointed to by mrb_value
pub extern fn mrb_data_get_ptr(mrb: *mrb_state, value: mrb_value, data_type: *const mrb_data_type) ?*anyopaque;
pub extern fn mrb_data_check_get_ptr(mrb: *mrb_state, value: mrb_value, data_type: *const mrb_data_type) ?*anyopaque;
/// Define data pointer and data type of existing RData object
pub extern fn mrb_data_init(value: mrb_value, data_ptr: *anyopaque, data_type: *mrb_data_type) void;
pub fn mrb_rdata(obj: mrb_value) ?*RData {
    return @ptrCast(*RData, mrb_get_ptr(obj));
}
pub extern fn mrb_rdata_data(data: *RData) ?*anyopaque;
pub extern fn mrb_rdata_type(data: *RData) ?*mrb_data_type;


/////////////////////////////////////////
//            mruby/error.h            //
/////////////////////////////////////////

pub extern fn mrb_sys_fail(mrb: *mrb_state, mesg: [*:0]const u8) void;
pub extern fn mrb_exc_new_str(mrb: *mrb_state, cla: *RClass, str: mrb_value) mrb_value;
pub fn mrb_exc_new_lit(mrb: *mrb_state, cla: *RClass, lit: []const u8) mrb_value {
    return mrb_exc_new_str(mrb, cla, mrb_str_new_lit(mrb, lit));
}
pub fn mrb_exc_new_str_lit(mrb: *mrb_state, cla: *RClass, lit: []const u8) mrb_value {
    return mrb_exc_new_lit(mrb, cla, lit);
}
pub extern fn mrb_make_exception(mrb: *mrb_state, argc: mrb_int, argv: [*]const mrb_value) mrb_value;
pub extern fn mrb_exc_backtrace(mrb: *mrb_state, exc: mrb_value) mrb_value;
pub extern fn mrb_get_backtrace(mrb: *mrb_state) mrb_value;
pub extern fn mrb_no_method_error(mrb: *mrb_state, id: mrb_sym, args: mrb_value, fmt: [*:0]const u8, ...) mrb_noreturn;
