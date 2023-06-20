# mruby-zig

[mruby](https://mruby.org/) bindings for [zig](https://ziglang.org/)!

Mruby is the lightweight implementation of the Ruby language complying with part of the ISO standard.

Mruby documentation can be found [here](https://mruby.org/docs/api/).

## Embedding

To embed `mruby` into another zig project, you just need to
recursively clone this repository and add a couple of lines to your
`build.zig`.

- Add the following lines to `build.zig`, with the paths changed to match the correct location

```zig
const addMruby = @import("mruby-zig/build.zig").addMruby;

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "example",
        .root_source_file = .{ .path = "src/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(exe);

    // Run default rake task
    const build_mruby_step = addMruby(b, exe, &.{});

    // Add options to rake
    // const build_mruby_step = addMruby(b, exe, &.{"--verbose"});

    // Run specific tasks
    // const build_mruby_step = addMruby(b, exe, &.{
    //   "all",
    //   "test",
    // });

    // Use a specific `build_config.rb`
    // const relative_root_dir = std.fs.path.dirname(@src().file) orelse ".";
    // const root_dir = std.fs.realpathAlloc(b.allocator, relative_root_dir) catch @panic("realpathAlloc");
    // const config_path = std.fs.path.join(b.allocator, &.{ //
    //     root_dir, "src", "build_config.rb",
    // }) catch unreachable;
    // build_mruby_step.setEnvironmentVariable("MRUBY_CONFIG", config_path);

    // ...
}
```

- Import `mruby` and start a new interpreter

```zig
const std = @import("std");
const mruby = @import("mruby");

pub fn main() anyerror!void {
    // Opening a state
    var mrb = try mruby.open();
    defer mrb.close();

    // Loading a program from a string
    mrb.load_string("puts 'hello from ruby!'");
}
  ```

## Example

See `examples/main.zig`
