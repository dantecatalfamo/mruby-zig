const std = @import("std");
const path = std.fs.path;

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "mruby-zig",
        .root_source_file = .{ .path = "examples/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    b.installArtifact(exe);
    const build_mruby = addMruby(b, exe, &.{"--verbose"});

    const compile_mruby_srcs = b.addSystemCommand(&[_][]const u8{
        "mruby/build/host/bin/mrbc",
        "-o",
        "examples/bytecode.mrb",
        "examples/bytecode.rb",
    });
    compile_mruby_srcs.step.dependOn(&build_mruby.step);
    exe.step.dependOn(&compile_mruby_srcs.step);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    const unit_tests = b.addTest(.{
        .root_source_file = .{ .path = "examples/main.zig" },
        .target = target,
        .optimize = optimize,
    });
    _ = addMruby(b, unit_tests, &.{"--verbose"});

    const run_unit_tests = b.addRunArtifact(unit_tests);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_unit_tests.step);
}

pub fn addMruby(
    owner: *std.Build,
    exe: *std.Build.Step.Compile,
    comptime args: []const []const u8,
) *std.Build.Step.Run {
    const allocator = owner.allocator;

    const src_dir = path.dirname(@src().file) orelse ".";
    const mruby_path = path.join(allocator, &.{ src_dir, "mruby" }) catch unreachable;
    const include_path = path.join(allocator, &.{ mruby_path, "include" }) catch unreachable;
    const library_path = path.join(allocator, &.{ mruby_path, "build", "host", "lib" }) catch unreachable;
    const compat_path = path.join(allocator, &.{ src_dir, "src", "mruby_compat.c" }) catch unreachable;
    const package_path = path.join(allocator, &.{ src_dir, "src", "mruby.zig" }) catch unreachable;
    const rakefile_path = path.join(allocator, &.{ mruby_path, "Rakefile" }) catch unreachable;

    exe.addSystemIncludePath(include_path);
    exe.addLibraryPath(library_path);
    exe.linkSystemLibrary("mruby");
    exe.linkLibC();
    exe.addCSourceFile(compat_path, &.{});

    const mod = owner.createModule(.{
        .source_file = .{ .path = package_path },
    });
    exe.addModule("mruby", mod);

    const default_args = &[_][]const u8{
        "rake",
        "--no-search",
        "-C",
        mruby_path,
        "-f",
        rakefile_path,
    };

    const build_mruby = owner.addSystemCommand(default_args ++ args);

    build_mruby.setEnvironmentVariable("CC", "zig cc");
    build_mruby.setEnvironmentVariable("CXX", "zig c++");
    build_mruby.setEnvironmentVariable("AR", "zig ar");

    exe.step.dependOn(&build_mruby.step);

    return build_mruby;
}
