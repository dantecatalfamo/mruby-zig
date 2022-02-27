const std = @import("std");
const mruby = @import("mruby.zig");

pub fn main() anyerror!void {
    var mrb = mruby.mrb_open() orelse return error.OpenError;
    defer mrb.close();
    std.log.debug("state pointer: {p}", .{ mrb });
    mrb.show_version();
    mrb.show_copyright();
    const program =
        \\ puts "hello from ruby!"
    ;
    _ = mruby.mrb_load_string(mrb, program);
    const kptr = mrb.kernel_module().?;
    std.log.debug("kernel module ponter: {p}", .{ kptr });
    mrb.define_module_function(kptr, "zigfunc", zigInRuby, mruby.mrb_args_none());
    _ = mruby.mrb_load_string(mrb, "zigfunc");
    _ = mrb.funcall(kptr.value(), "puts", .{ mruby.mrb_str_new_lit(mrb, "hello from puts called in zig!") });
    mrb.p(kptr.value());

    // Exception test
    mruby.mrb_sys_fail(mrb, "intentional system failure");
    mrb.p(mrb.exc().?.value());
}

export fn zigInRuby(mrb: *mruby.mrb_state, self: mruby.mrb_value) mruby.mrb_value {
    std.log.debug("Zig function called from ruby! mrb: {p}, self: {}", .{ mrb, self });
    mrb.p(mruby.mrb_get_backtrace(mrb));
    return self;
}

test "ref all decls" {
    std.testing.refAllDecls(mruby);
    std.testing.refAllDecls(mruby.mrb_state);
}
