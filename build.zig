const std = @import("std");
const path = std.fs.path;

pub fn build(b: *std.build.Builder) void {
    // Standard target options allows the person running `zig build` to choose
    // what target to build for. Here we do not override the defaults, which
    // means any target is allowed, and the default is native. Other options
    // for restricting supported target set are available.
    var target = b.standardTargetOptions(.{});

    // Standard release options allow the person running `zig build` to select
    // between Debug, ReleaseSafe, ReleaseFast, and ReleaseSmall.
    const mode = b.standardReleaseOptions();

    const exe = b.addExecutable("mruby-zig", "examples/main.zig");
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

pub fn addMruby(exe: *std.build.LibExeObjStep) void {
    // Won't compile on my macbook without this
    // zig version 0.10.0-dev.934+acec06cfa
    // fails with the following error:
    //     error(compilation): clang failed with stderr: In file included from /Users/dante/src/github.com/dantecatalfamo/mruby-zig/src/mruby_compat.c:4:
    //     In file included from /Users/dante/src/github.com/dantecatalfamo/mruby-zig/mruby/include/mruby.h:117:
    //     /Users/dante/src/github.com/dantecatalfamo/mruby-zig/mruby/include/mruby/value.h:426:10: fatal error: 'mach-o/getsect.h' file not found
    if (exe.target.isDarwin()) {
        exe.addFrameworkPath("/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk");
    }
    var allocator = exe.builder.allocator;

    var build_mruby_step = BuildMrubyStep.init(exe.builder);

    const src_dir = path.dirname(@src().file) orelse ".";
    const mruby_path = path.join(allocator, &.{ src_dir, "mruby" }) catch unreachable;
    const include_path = path.join(allocator, &.{ mruby_path, "include" }) catch unreachable;
    const library_path = path.join(allocator, &.{ mruby_path, "build", "host", "lib" }) catch unreachable;
    const compat_path = path.join(allocator, &.{ src_dir, "src", "mruby_compat.c" }) catch unreachable;
    const package_path = path.join(allocator, &.{ src_dir, "src", "mruby.zig" }) catch unreachable;

    exe.addSystemIncludePath(include_path);
    exe.addLibraryPath(library_path);
    exe.linkSystemLibrary("mruby");
    exe.linkLibC();
    exe.addCSourceFile(compat_path, &.{});
    exe.addPackagePath("mruby", package_path);
    exe.step.dependOn(&build_mruby_step.step);
}

pub const BuildMrubyStep = struct {
    step: std.build.Step,
    builder: *std.build.Builder,

    pub fn init(builder: *std.build.Builder) *BuildMrubyStep {
        const self = builder.allocator.create(BuildMrubyStep) catch unreachable;
        self.* = BuildMrubyStep {
            .builder = builder,
            .step = std.build.Step.init(.custom, "build mruby", builder.allocator, make),
        };
        return self;
    }

    fn make(step: *std.build.Step) !void {
        const self = @fieldParentPtr(BuildMrubyStep, "step", step);
        const src_dir = path.dirname(@src().file) orelse ".";
        const mruby_path = path.join(self.builder.allocator, &.{ src_dir, "mruby" }) catch unreachable;
        try std.os.chdir(mruby_path);
        var process = std.ChildProcess.init(&.{"rake", "CC=zig cc -ffast-math", "AR=zig ar", "--verbose"}, self.builder.allocator);
        _ = try process.spawnAndWait();
        try std.os.chdir("..");
    }
};
