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
        // Use `zig cc` to compile code for consistency.
        // `-ffast-math` used to avoid strange complex number compilation error
        //
        // [mruby-zig]$ zig build
        // mkdir -p /home/dante/src/github.com/dantecatalfamo/mruby-zig/mruby/build/host/bin
        // LD    build/host/bin/mirb
        // zig cc -target x86_64-linux-gnu  -o "/home/dante/src/github.com/dantecatalfamo/mruby-zig/mruby/build/host/bin/mirb" "/home/dante/src/github.com/dantecatalfamo/mruby-zig/mruby/build/host/mrbgems/mruby-bin-mirb/tools/mirb/mirb.o" "/home/dante/src/github.com/dantecatalfamo/mruby-zig/mruby/build/host/lib/libmruby.a"  -lm
        // LLD Link... ld.lld: error: undefined symbol: __divdc3
        // >>> referenced by cmath.c:162 (mrbgems/mruby-cmath/src/cmath.c:162)
        // >>>               cmath.o:(cmath_log) in archive /home/dante/src/github.com/dantecatalfamo/mruby-zig/mruby/build/host/lib/libmruby.a
        // >>> did you mean: __divdf3
        // >>> defined in: /home/dante/.cache/zig/o/a4bd34886613d2e269c83a864437187f/libcompiler_rt.a(/home/dante/.cache/zig/o/a4bd34886613d2e269c83a864437187f/compiler_rt.o)
        // rake aborted!
        // Command failed with status (1): [zig cc -target x86_64-linux-gnu  -o "/home...]
        // /home/dante/src/github.com/dantecatalfamo/mruby-zig/mruby/lib/mruby/build/command.rb:37:in `_run'
        // /home/dante/src/github.com/dantecatalfamo/mruby-zig/mruby/lib/mruby/build/command.rb:217:in `run'
        // /home/dante/src/github.com/dantecatalfamo/mruby-zig/mruby/tasks/bin.rake:17:in `block (4 levels) in <top (required)>'
        // /home/dante/src/github.com/dantecatalfamo/mruby-zig/mruby/Rakefile:42:in `block in <top (required)>'
        // Tasks: TOP => build => /home/dante/src/github.com/dantecatalfamo/mruby-zig/mruby/bin/mirb => /home/dante/src/github.com/dantecatalfamo/mruby-zig/mruby/build/host/bin/mirb
        // (See full trace by running task with --trace)
        // LLD Link... ld.lld: error: undefined symbol: __divdc3
        // >>> referenced by cmath.c:162 (mrbgems/mruby-cmath/src/cmath.c:162)
        // >>>               cmath.o:(cmath_log) in archive /home/dante/src/github.com/dantecatalfamo/mruby-zig/mruby/build/host/lib/libmruby.a
        // >>> did you mean: __divdf3
        // >>> defined in: /home/dante/.cache/zig/o/83760f4c975d893977be512204091f81/libcompiler_rt.a(/home/dante/.cache/zig/o/83760f4c975d893977be512204091f81/compiler_rt.o)
        // error: LLDReportedFailure
        // mruby-zig...The following command exited with error code 1:
        // /home/dante/.asdf/installs/zig/master/zig build-exe /home/dante/src/github.com/dantecatalfamo/mruby-zig/examples/main.zig -lmruby -lc /home/dante/src/github.com/dantecatalfamo/mruby-zig/src/mruby_compat.c --cache-dir /home/dante/src/github.com/dantecatalfamo/mruby-zig/zig-cache --global-cache-dir /home/dante/.cache/zig --name mruby-zig -target native-native-gnu -mcpu=skylake+sgx --pkg-begin mruby /home/dante/src/github.com/dantecatalfamo/mruby-zig/src/mruby.zig --pkg-end -isystem /home/dante/src/github.com/dantecatalfamo/mruby-zig/mruby/include -L /home/dante/src/github.com/dantecatalfamo/mruby-zig/mruby/build/host/lib --enable-cache
        // error: the following build command failed with exit code 1:
        // /home/dante/src/github.com/dantecatalfamo/mruby-zig/zig-cache/o/ea89ac36fa5fcd5b5e7bec7d5258adf6/build /home/dante/.asdf/installs/zig/master/zig /home/dante/src/github.com/dantecatalfamo/mruby-zig /home/dante/src/github.com/dantecatalfamo/mruby-zig/zig-cache /home/dante/.cache/zig
        //
        // If `-ffast-math` is passed in through CFLAGS it still
        // produces the error, but not when as a part of CC. ¯\_(ツ)_/¯
        //
        // Related issue: https://github.com/ziglang/zig/issues/9259
        // StackOverflow:  https://stackoverflow.com/questions/49438158/why-is-muldc3-called-when-two-stdcomplex-are-multiplied
        var process = std.ChildProcess.init(&.{"rake", "CC=zig cc -ffast-math", "AR=zig ar", "--verbose"}, self.builder.allocator);
        _ = try process.spawnAndWait();
        try std.os.chdir("..");
    }
};
