const std = @import("std");
const f = @import("fizzbuzz_func.zig");

pub fn main() !void {
    // -- normarl allocator --
    var allocator = std.heap.page_allocator;

    // -- check leak ---
    // var general_purpose_allocator = std.heap.GeneralPurposeAllocator(.{}){};
    // defer std.debug.assert(general_purpose_allocator.deinit() == .ok);
    // var allocator = general_purpose_allocator.allocator();

    const n = 100;
    var i: i32 = 1;
    std.debug.print("---- FizzBuzz from {d} to {d} ----\n", .{ i, n });
    while (i <= n) {
        const str = f.fizzbuzz(i, &allocator);
        defer allocator.free(str);
        printLn(str);
        i += 1;
    }
    std.debug.print("---- FizzBuzz end ----\n", .{});
}

// --- 標準出力に文字列を出力し、改行する ---
pub fn printLn(str: []const u8) void {
    const stdout = std.io.getStdOut().writer();
    stdout.print("{s}\n", .{str}) catch {};
}

// ========= test ========

test {
    _ = @import("fizzbuzz_func.zig");
}
