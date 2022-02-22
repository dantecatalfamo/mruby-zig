const std = @import("std");
const mruby = @import("mruby.zig");

pub fn main() anyerror!void {
    var mrb = mruby.mrb_open();
    std.log.debug("state pointer: {p}", .{ mrb });
    std.log.info("All your codebase are belong to us.", .{});
    _ = mruby.mrb_value;
}

test "basic test" {
    try std.testing.expectEqual(10, 3 + 7);
}
