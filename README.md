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
    const build_mruby_step = addMruby(b, exe);

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
