const std = @import("std");

const stdout = std.io.getStdOut().writer();

const Value = struct {
    data: f32,
    label: [*:0]const u8,
    _prev: ?*const Value,
    // _prev1: ?*Value,
    // _prev_vec: ?@Vector(2, *Value),
    // _prev_arr: ?[2]*Value,

    pub fn init(data: f32, label: [*:0]const u8) Value {
        return Value{ .data = data, .label = label, ._prev = null };
    }

    // Vpub fn setPrev(self: *Value, other: *Value) void {
    //     self._prev = other;
    // }

    pub fn add(self: Value, other: Value) Value {
        // var value = Value{ .data = self.data + other.data, .label = undefined, ._prev = null, ._prev1 = null };

        var value = Value.init(self.data + other.data, undefined);

        value.setPrev(&self);

        return value;
    }

    pub fn mul(self: Value, other: Value) Value {
        return Value{ .data = self.data * other.data, .label = undefined };
    }

    pub fn print(self: Value) !void {
        try stdout.print("Value=({d}, label={s})\n", .{ self.data, self.label });
    }
    pub fn setPrev(self: *Value, other: *const Value) void {
        self._prev = other;
    }
};

pub fn main() !void {
    const v = Value.init(11, "a"); // Value{ .data = 12, .label = "a" };
    const w = Value.init(12, "b"); // Value{ .data = 13, .label = "b" };

    var z = v.add(w);
    z.label = "c";

    std.debug.print("z={?}\n", .{z});

    // var o = v.mul(w);
    // o.label = "d";
    //
    // try v.print();
    // try w.print();
    // try z.print();
    // try o.print();
    //
    // setPrev(&v, &w);
    //
    // std.debug.print("v.prev={?}\n", .{v._prev});
}
