const std = @import("std");
const mruby = @import("mruby");

pub fn main() anyerror!void {

    // Opening a state
    var mrb = try mruby.open();
    defer mrb.close();

    mrb.show_version();
    mrb.show_copyright();

    // Loading a program from a string
    const program =
        \\ puts "hello from ruby!"
    ;
    _ = mrb.load_string(program);

    // Adding a zig function to ruby
    const kptr = mrb.kernel_module();
    const kval = kptr.value();
    mrb.define_module_function(kptr, "zigfunc", zigInRuby, .{});

    // Calling ruby methods from zig
    _ = mrb.funcall(kval, "zigfunc", .{});
    _ = mrb.funcall(kval, "puts", .{ mrb.str_new_lit("hello from puts called in zig!") });
    _ = mrb.funcall(kval, "puts", .{ mrb.int_value(1337) });

    // Freezing objects
    const strf = mrb.str_new("this is a string");
    std.log.debug("string frozen? {}", .{ strf.frozen_p() });
    try strf.freeze();
    std.log.debug("freezing string", .{});
    std.log.debug("string frozen? {}", .{ strf.frozen_p() });

    // Dollar store repl
    var line: [4096]u8 = undefined;
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();
    while (true) {
        try stdout.writeAll("> ");
        const line_read = try stdin.readUntilDelimiterOrEof(&line, '\n');
        if (line_read) |valid_line| {
            const returned = mrb.load_nstring(valid_line);
            if (mrb.exc()) |exception| {
                mrb.p(exception.value());
                mrb.set_exc(null);
            } else {
                try stdout.writeAll(" => ");
                mrb.p(returned);
            }
        } else {
            break;
        }
    }

    // Exception test
    mrb.sys_fail("intentional system failure");
    mrb.print_error();
}

export fn zigInRuby(mrb: *mruby.mrb_state, self: mruby.mrb_value) mruby.mrb_value {
    std.log.debug("Zig function called from ruby! mrb: {p}, self: {}", .{ mrb, self.w });
    mrb.p(mrb.get_backtrace());
    return self;
}

test "ref all decls" {
    std.testing.refAllDecls(mruby);
    std.testing.refAllDecls(mruby.mrb_state);
}
