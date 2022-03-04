# mruby-zig

Expermimental mruby bindings for zig

## Hacking

- Pull in the `mruby` git submodule

  ```sh
  git submodule update --init
  ```

- Compile `mruby`.
  In most cases this should be as simple as entering the `mruby` and running `make`

  ```sh
  cd mruby
  make
  cd ..
  ```

- Zig build

  To run the current example `main.zig` program, type `zig build run`

## Embedding

To embed `mruby` into another zig project, you need to add a couple of
lines to your build file. You will also need a copy of the `mruby`
source tree, and the files `src/mruby.zig` and `src/mruby_compat.c`.

- Import `mruby.zig` into the relevant file
  For example: `@import("mruby.zig")`

- Add the following lines to `build.zig`, with the paths changed to match the correct location

  ```zig
  exe.addSystemIncludePath("./mruby/include");
  exe.addLibraryPath("./mruby/build/host/lib");
  exe.linkSystemLibrary("mruby");
  exe.linkLibC();
  exe.addCSourceFile("src/mruby_compat.c", &.{});
  ```
