const std = @import("std");
const path = std.fs.path;

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

    const mruby_step = addMrubyStep(b);

    const exe = b.addExecutable("mruby-zig", "examples/main.zig");
    exe.step.dependOn(mruby_step);
    exe.setTarget(target);
    exe.setBuildMode(mode);
    addMruby(exe);
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    const exe_tests = b.addTest("examples/main.zig");
    exe_tests.setTarget(target);
    exe_tests.setBuildMode(mode);
    addMruby(exe_tests);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&exe_tests.step);
}

pub fn addMrubyStep(b: *std.build.Builder) *std.build.Step {
    const submodule_step = b.step("submodule", "Pull in git submodule");
    submodule_step.makeFn = fetchSubmodule;

    const mruby_step = b.step("mruby", "Build mruby");
    mruby_step.makeFn = buildMruby;
    mruby_step.dependOn(submodule_step);

    return mruby_step;
}

pub fn addMruby(self: *std.build.LibExeObjStep) void {
    // Won't compile on my macbook without this
    // zig version 0.10.0-dev.934+acec06cfa
    // fails with the following error:
    //     error(compilation): clang failed with stderr: In file included from /Users/dante/src/github.com/dantecatalfamo/mruby-zig/src/mruby_compat.c:4:
    //     In file included from /Users/dante/src/github.com/dantecatalfamo/mruby-zig/mruby/include/mruby.h:117:
    //     /Users/dante/src/github.com/dantecatalfamo/mruby-zig/mruby/include/mruby/value.h:426:10: fatal error: 'mach-o/getsect.h' file not found
    if (self.target.isDarwin()) {
        self.addFrameworkPath("/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX12.1.sdk");
    }
    var allocator = std.heap.page_allocator;
    const src_dir = path.dirname(@src().file) orelse ".";

    const mruby_path = path.join(allocator, &.{ src_dir, "mruby" }) catch unreachable;
    defer allocator.free(mruby_path);

    const include_path = path.join(allocator, &.{ mruby_path, "include" }) catch unreachable;
    defer allocator.free(include_path);

    const library_path = path.join(allocator, &.{ mruby_path, "build", "host", "lib" }) catch unreachable;
    defer allocator.free(library_path);

    const compat_path = path.join(allocator, &.{ src_dir, "src", "mruby_compat.c" }) catch unreachable;
    defer allocator.free(compat_path);

    const package_path = path.join(allocator, &.{ src_dir, "src", "mruby.zig" }) catch unreachable;
    defer allocator.free(package_path);

    self.addSystemIncludePath(include_path);
    self.addLibraryPath(library_path);
    self.linkSystemLibrary("mruby");
    self.linkLibC();
    self.addCSourceFile(compat_path, &.{});
    self.addPackagePath("mruby", package_path);
}

pub fn buildMruby(self: *std.build.Step) !void {
    _ = self;
    var allocator = std.heap.page_allocator;
    try std.os.chdir("mruby");
    var process = std.ChildProcess.init(&.{"rake"}, allocator);
    _ = try process.spawnAndWait();
    try std.os.chdir("..");
}

pub fn fetchSubmodule(self: *std.build.Step) !void {
    _ = self;
    var allocator = std.heap.page_allocator;
    var process = std.ChildProcess.init(&.{"git", "submodule", "update", "--init"}, allocator);
    _ = try process.spawnAndWait();
}
