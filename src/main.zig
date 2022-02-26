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
    const kptr = mruby.mrb_state_get_kernel_module(mrb).?;
    std.log.debug("kernel module ponter: {p}", .{ kptr });
    mruby.mrb_define_module_function(mrb, kptr, "zigfunc", zigInRuby, mruby.mrb_args_none());
    _ = mruby.mrb_load_string(mrb, "zigfunc");
    mruby.mrb_p(mrb, mruby.mrb_obj_value(kptr));
}

export fn zigInRuby(mrb: *mruby.mrb_state, self: mruby.mrb_value) mruby.mrb_value {
    std.log.debug("Zig function called from ruby! mrb: {p}, self: {}", .{ mrb, self });
    return self;
}

test "ref all decls" {
    std.testing.refAllDecls(mruby);
}
