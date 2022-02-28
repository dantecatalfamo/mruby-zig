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
    const strf = mrb.str_new("this is a string");
    std.log.debug("string frozen? {}", .{ strf.frozen_p() });
    try strf.freeze();
    std.log.debug("freezing string", .{});
    std.log.debug("string frozen? {}", .{ strf.frozen_p() });

    const int = mrb.int_value(5);
    const float = mrb.float_value(5.0);
    const str = mrb.str_new("hello");
    var pointer: u8 = 5;
    const cptr = mrb.cptr_value(&pointer);
    const obj = mrb.obj_value(strf.rstring().?);
    const bol = mrb.bool_value(true);

    std.log.debug("int immediate: {}", .{ int.immediate_p() });
    std.log.debug("float immediate: {}", .{ float.immediate_p() });
    std.log.debug("str immediate: {}", .{ str.immediate_p() });
    std.log.debug("cptr immediate: {}", .{ cptr.immediate_p() });
    std.log.debug("obj immediate: {}", .{ obj.immediate_p() });
    std.log.debug("bool immediate: {}", .{ bol.immediate_p() });

    std.log.debug("cptr value:", .{});
    mrb.p(cptr);

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
