const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    var target = b.standardTargetOptions(.{});
    // For some reason building on Fedora while linking to libmruby.a
    // causes a segfault on launch. For now we'll just use musl
    // The output in GDB is the following:
    //   Program received signal SIGSEGV, Segmentation fault.
    //   0x00000000002ed513 in std.start.main (c_argc=1, c_argv=0x7fffffffdd38, c_envp=0x7fffffffe0a4) at /home/dante/zig/0.10.0-dev.974+bf6540ce5/files/lib/std/start.zig:450
    //   450        while (c_envp[env_count] != null) : (env_count += 1) {}
    if (target.isLinux()) {
        target.abi = .musl;
    }

    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("mruby-zig", "src/main.zig");
    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.addSystemIncludePath("./mruby/include/");
    exe.addLibraryPath("./mruby/build/host/lib");
    exe.linkSystemLibrary("mruby");
    exe.linkLibC();
    exe.addCSourceFile("src/mrb_state_hack.c", &.{});
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    const exe_tests = b.addTest("src/main.zig");
    exe_tests.setTarget(target);
    exe_tests.setBuildMode(mode);
    exe_tests.addSystemIncludePath("./mruby/include/");
    exe_tests.addLibraryPath("./mruby/build/host/lib");
    exe_tests.linkSystemLibrary("mruby");
    exe_tests.linkLibC();

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&exe_tests.step);
}
