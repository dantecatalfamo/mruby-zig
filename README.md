# mruby-zig

mruby bindings for zig

## Embedding

To embed `mruby` into another zig project, you just need to
recursively clone this repository and add a couple of lines to your
`build.zig`.

- Add the following lines to `build.zig`, with the paths changed to match the correct location

  ```zig
  const addMruby = @import("mruby-zig/build.zig").addMruby;

  pub fn build(b: *std.build.Builder) void {
      [...]
      const exe = b.addExecutable("example", "src/main.zig");
      addMruby(exe);
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
