const std = @import("std");
// const mruby = @import("../src/mruby.zig");
const mruby = @import("mruby");

pub fn main() anyerror!void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    var allocator = gpa.allocator();
    defer _ = gpa.deinit();

    // const LoggingAlloc = std.heap.LoggingAllocator(.debug, .err);
    // var logging_alloc = LoggingAlloc.init(allocator).allocator();

    // To open a state that uses a zig allocator instead of malloc,
    // initialize an `mruby.MrubyAllocator` struct using the allocator
    // of your choice, and pass a pointer to it to `mruby.open_allocator`.
    // Call `deinit()` on it to clean up when done.
    var mrb_alloc = mruby.MrubyAllocator.init(allocator);
    defer mrb_alloc.deinit();

    // Alternatively to use malloc, call `mruby.open()`
    var mrb = try mruby.open_allocator(&mrb_alloc);
    defer mrb.close();

    mrb.show_version();
    mrb.show_copyright();

    // Loading a program from a string
    const program = "puts 'hello from ruby!'";
    _ = mrb.load_string(program);

    // Loading a program from file
    _ = try mrb.load_file("examples/hello.rb");

    // Adding a zig function to ruby
    const kptr = mrb.kernel_module();
    const kval = kptr.value();
    mrb.define_module_function(kptr, "zigfunc", zigInRuby, .{});
    mrb.define_module_function(kptr, "zigOneArg", zigOneArg, .{ .req = 1 });
    mrb.define_module_function(kptr, "zigThreeArgs", zigThreeArgs, .{ .req = 3 });

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

    // Custom class
    const fancy_class = try mrb.define_class("FancyClass", mrb.object_class());

    // Custom data types
    var fancy_data = try allocator.create(DataType);
    fancy_data.* = DataType{
        .int = 1337,
        .small_array = .{ 1, 2, 3, 4 },
        .allocator = allocator,
    };
    const data_obj = try mrb.data_object_alloc(fancy_class, fancy_data, &data_type_descriptor);
    mrb.gv_set(mrb.intern("$data"), data_obj.value());

    // Custom data type class methods
    mrb.define_method(fancy_class, "int", dataTypeGetInt, .{});
    mrb.define_method(fancy_class, "int=", dataTypeSetInt, .{ .req = 1 });
    mrb.define_method(fancy_class, "array", dataTypeGetArray, .{});

    // Exception test
    mrb.sys_fail("intentional system failure");
    mrb.print_error();
    mrb.set_exc(null);

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
}

export fn zigInRuby(mrb: *mruby.mrb_state, self: mruby.mrb_value) mruby.mrb_value {
    std.log.debug("Zig function called from ruby! mrb: {p}, self: {}", .{ mrb, self.w });
    mrb.p(mrb.get_backtrace());
    return self;
}

export fn zigOneArg(mrb: *mruby.mrb_state, self: mruby.mrb_value) mruby.mrb_value {
    const arg = mrb.get_arg1();
    if (arg.integer_p()) {
        std.log.debug("Received integer: {d}", .{ arg.integer() });
    } else {
        std.log.debug("Received type: {}", .{ arg.vType() });
    }
    return self;
}

export fn zigThreeArgs(mrb: *mruby.mrb_state, self: mruby.mrb_value) mruby.mrb_value {
    var str: [*:0]const u8 = undefined;
    var sym: mruby.mrb_sym = undefined;
    var int: mruby.mrb_int = undefined;
    const num_args = mrb.get_args("zni", .{ &str, &sym, &int });
    std.log.debug("Received {d} args. string: \"{s}\", symbol: :{s}, integer: {d}", .{ num_args, str, mrb.sym_name(sym), int });
    return self;
}

pub const DataType = struct {
    int: i64,
    small_array: [4]u8,
    allocator: std.mem.Allocator,
};

const data_type_descriptor = mruby.mrb_data_type {
    .struct_name = "zigDataType",
    .dfree = dataTypeFree,
};

pub export fn dataTypeFree(mrb: *mruby.mrb_state, ptr: *anyopaque) void {
    _ = mrb;
    const data = @ptrCast(*DataType, @alignCast(@alignOf(DataType), ptr));
    const allocator = data.allocator;
    std.log.debug("Freeing data type!", .{});
    allocator.destroy(data);
}

pub export fn dataTypeGetInt(mrb: *mruby.mrb_state, self: mruby.mrb_value) mruby.mrb_value {
    const rawptr = mrb.data_get_ptr(self, &data_type_descriptor);
    const ptr = @ptrCast(*DataType, @alignCast(@alignOf(DataType), rawptr));
    return mrb.int_value(ptr.int);
}

pub export fn dataTypeSetInt(mrb: *mruby.mrb_state, self: mruby.mrb_value) mruby.mrb_value {
    var int: i64 = undefined;
    _ = mrb.get_args("i", .{ &int });
    const rawptr = mrb.data_get_ptr(self, &data_type_descriptor);
    const ptr = @ptrCast(*DataType, @alignCast(@alignOf(DataType), rawptr));
    ptr.int = int;
    return self;
}

pub export fn dataTypeGetArray(mrb: *mruby.mrb_state, self: mruby.mrb_value) mruby.mrb_value {
    const rawptr = mrb.data_get_ptr(self, &data_type_descriptor);
    const ptr = @ptrCast(*DataType, @alignCast(@alignOf(DataType), rawptr));
    const array = mrb.ary_new();
    for (ptr.small_array) |val| {
        mrb.ary_push(array, mrb.int_value(val));
    }
    return array;
}

test "ref all decls" {
    std.testing.refAllDecls(mruby);
    std.testing.refAllDecls(mruby.mrb_state);
}
