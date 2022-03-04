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

    const submodule_step = b.step("submodule", "Pull in git submodule");
    submodule_step.makeFn = fetchSubmodule;

    const mruby_step = b.step("mruby", "Build mruby");
    mruby_step.makeFn = buildMruby;
    mruby_step.dependOn(submodule_step);

    const exe = b.addExecutable("mruby-zig", "examples/main.zig");
    exe.addPackagePath("mruby", "src/mruby.zig");
    exe.step.dependOn(mruby_step);
    exe.setTarget(target);
    exe.setBuildMode(mode);
    // Won't compile on my macbook without this
    // zig version 0.10.0-dev.934+acec06cfa
    // fails with the following error:
    //     error(compilation): clang failed with stderr: In file included from /Users/dante/src/github.com/dantecatalfamo/mruby-zig/src/mruby_compat.c:4:
    //     In file included from /Users/dante/src/github.com/dantecatalfamo/mruby-zig/mruby/include/mruby.h:117:
    //     /Users/dante/src/github.com/dantecatalfamo/mruby-zig/mruby/include/mruby/value.h:426:10: fatal error: 'mach-o/getsect.h' file not found
    if (target.isDarwin()) {
        exe.addFrameworkPath("/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX12.1.sdk");
    }
    exe.addSystemIncludePath("./mruby/include");
    exe.addLibraryPath("./mruby/build/host/lib");
    exe.linkSystemLibrary("mruby");
    exe.linkLibC();
    exe.addCSourceFile("src/mruby_compat.c", &.{});
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
    if (target.isDarwin()) {
        exe.addFrameworkPath("/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX12.1.sdk");
    }
    exe_tests.addSystemIncludePath("./mruby/include");
    exe_tests.addLibraryPath("./mruby/build/host/lib");
    exe_tests.linkSystemLibrary("mruby");
    exe_tests.linkLibC();
    exe_tests.addCSourceFile("src/mruby_compat.c", &.{});

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&exe_tests.step);
}

pub fn buildMruby(self: *std.build.Step) !void {
    _ = self;
    var allocator = std.heap.page_allocator;
    try std.os.chdir("mruby");
    var process = try std.ChildProcess.init(&.{"rake"}, allocator);
    defer process.deinit();
    _ = try process.spawnAndWait();
    try std.os.chdir("..");
}

pub fn fetchSubmodule(self: *std.build.Step) !void {
    _ = self;
    var allocator = std.heap.page_allocator;
    var process = try std.ChildProcess.init(&.{"git", "submodule", "update", "--init"}, allocator);
    defer process.deinit();
    _ = try process.spawnAndWait();
}
