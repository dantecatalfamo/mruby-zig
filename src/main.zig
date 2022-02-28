const std = @import("std");
const mruby = @import("mruby.zig");

pub fn main() anyerror!void {
    var mrb = try mruby.open();
    defer mrb.close();
    std.log.debug("state pointer: {p}", .{ mrb });
    mrb.show_version();
    mrb.show_copyright();
    const program =
        \\ puts "hello from ruby!"
    ;
    _ = mrb.load_string(program);
    const kptr = mrb.kernel_module().?;
    const kval = kptr.value();
    mrb.define_module_function(kptr, "zigfunc", zigInRuby, mruby.mrb_args_none());
    _ = mrb.funcall(kval, "zigfunc", .{});
    _ = mrb.funcall(kval, "puts", .{ mrb.str_new_lit("hello from puts called in zig!") });
    _ = mrb.funcall(kval, "puts", .{ mrb.int_value(1337) });

    // Exception test
    mrb.sys_fail("intentional system failure");
    mrb.print_error();
}

export fn zigInRuby(mrb: *mruby.mrb_state, self: mruby.mrb_value) mruby.mrb_value {
    std.log.debug("Zig function called from ruby! mrb: {p}, self: {}", .{ mrb, self });
    mrb.p(mrb.get_backtrace());
    return self;
}

test "ref all decls" {
    std.testing.refAllDecls(mruby);
    std.testing.refAllDecls(mruby.mrb_state);
}
