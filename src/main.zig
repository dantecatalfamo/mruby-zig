const std = @import("std");
const mruby = @import("mruby.zig");

pub fn main() anyerror!void {
    var mrb = mruby.mrb_open() orelse return error.OpenError;
    defer mruby.mrb_close(mrb);
    std.log.debug("state pointer: {p}", .{ mrb });
    mruby.mrb_show_version(mrb);
    mruby.mrb_show_copyright(mrb);
}

test "ref all decls" {
    std.testing.refAllDecls(mruby);
}
