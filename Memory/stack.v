//stack
module stack(
    input clk,
    input data,
    input push_pop,
    output reg [3:0] STACK,
    output reg S
);

reg [3:0] stack;
always @(posedge clk) begin
    S = push_pop ? 1'bz : STACK[3];
    stack = push_pop ? stack>>1 : stack<<1;
    stack[3] = push_pop ? data : stack[3];
    STACK = stack;
end

endmodule

/*
test case:
clk data push_pop STACK S
0   0    0        0x0   0
1   1    1        0x8   z
0   0    1        0x8   z
1   0    1        0x4   z
0   0    1        0x4   z
1   1    1        0xA   z
0   0    0        0xA   z
1   0    0        0x4   1
0   0    0        0x4   1
1   0    0        0x8   0
0   0    0        0x8   0
1   0    0        0x0   1
0   0    0        0x0   1
*/
