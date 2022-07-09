# mruby-zig

mruby bindings for zig

## Hacking

To run the current example `main.zig` program, type `zig build run`. The `build.zig` file should handle pulling in and compiling `mruby`.

## Embedding

To embed `mruby` into another zig project, you need to add a couple of
lines to your build file. You will also need a copy of the `mruby`
source tree, and the files `src/mruby.zig` and `src/mruby_compat.c`.

- Add the following lines to `build.zig`, with the paths changed to match the correct location

  ```zig
  const mruby = @import("mruby/build.zig");

  pub fn build(b: *std.build.Builder) void {
      [...]
      const exe = b.addExecutable("example", "src/main.zig");
      mruby.addMruby(exe);
      [...]
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
