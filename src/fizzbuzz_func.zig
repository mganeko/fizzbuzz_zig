const std = @import("std");
const Allocator = std.mem.Allocator;

pub fn fizzbuzz(i: i32, allocator: *Allocator) []u8 {
    var str: []u8 = undefined;
    //const allocator = std.heap.page_allocator;

    if (@mod(i, 3 * 5) == 0) {
        str = std.fmt.allocPrint(allocator.*, "FizzBuzz", .{}) catch {
            return undefined;
        };
    } else if (@mod(i, 3) == 0) {
        str = std.fmt.allocPrint(allocator.*, "Fizz", .{}) catch {
            return undefined;
        };
    } else if (@mod(i, 5) == 0) {
        str = std.fmt.allocPrint(allocator.*, "Buzz", .{}) catch {
            return undefined;
        };
        return str;
    } else {
        str = std.fmt.allocPrint(allocator.*, "{d}", .{i}) catch {
            return undefined;
        };
    }

    return str;
}

// ================ test ==============

// test "shoud be ERROR" {
//     try std.testing.expectEqual(1, 0);
// }

test "1 to '1'" {
    var allocator = std.heap.page_allocator;
    const str = fizzbuzz(1, &allocator);
    defer allocator.free(str);
    //std.testing.expectEqual(str, "1");
    try std.testing.expectEqualSlices(u8, str, "1");
}

test "2 to '2'" {
    var allocator = std.heap.page_allocator;
    const str = fizzbuzz(2, &allocator);
    defer allocator.free(str);
    try std.testing.expectEqualSlices(u8, str, "2");
}

test "3 to 'Fizz'" {
    var allocator = std.heap.page_allocator;
    const str = fizzbuzz(3, &allocator);
    defer allocator.free(str);
    try std.testing.expectEqualSlices(u8, str, "Fizz");
}

test "5 to 'Buzz'" {
    var allocator = std.heap.page_allocator;
    const str = fizzbuzz(5, &allocator);
    defer allocator.free(str);
    try std.testing.expectEqualSlices(u8, str, "Buzz");
}

test "15 to 'FizzBuzz'" {
    var allocator = std.heap.page_allocator;
    const str = fizzbuzz(15, &allocator);
    defer allocator.free(str);
    try std.testing.expectEqualSlices(u8, str, "FizzBuzz");
}
