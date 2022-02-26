const std = @import("std");
const mruby = @import("mruby.zig");

pub fn main() anyerror!void {
    var mrb = mruby.mrb_open() orelse return error.OpenError;
    defer mruby.mrb_close(mrb);
    std.log.debug("state pointer: {p}", .{ mrb });
    mruby.mrb_show_version(mrb);
    mruby.mrb_show_copyright(mrb);
    const program =
        \\ puts "hello from ruby!"
    ;
    _ = mruby.mrb_load_string(mrb, program);
    const kptr = mrb.kernel_module().?;
    std.log.debug("kernel module ponter: {p}", .{ kptr });
    mruby.mrb_define_module_function(mrb, kptr, "zigfunc", zigInRuby, mruby.mrb_args_none());
    _ = mruby.mrb_load_string(mrb, "zigfunc");
    _ = mruby.mrb_funcall(mrb, kptr.value(), "puts", 1, mruby.mrb_str_new_lit(mrb, "hello from puts called in zig!"));
    mrb.p(kptr.value());

    // Exception test
    mruby.mrb_sys_fail(mrb, "intentional system failure");
    mruby.mrb_p(mrb, mrb.exc().?.value());
}

export fn zigInRuby(mrb: *mruby.mrb_state, self: mruby.mrb_value) mruby.mrb_value {
    std.log.debug("Zig function called from ruby! mrb: {p}, self: {}", .{ mrb, self });
    mruby.mrb_p(mrb, mruby.mrb_get_backtrace(mrb));
    return self;
}

test "ref all decls" {
    std.testing.refAllDecls(mruby);
}
