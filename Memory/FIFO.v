//FIFO
module FIFO(
    input clk,
    input [7:0] data,
    input Enq_Deq,
    output reg [7:0] S
);

reg [7:0] fifo [7:0];  

reg [2:0] head = 0;
reg [2:0] tail = 0;

always @(posedge clk) begin
    if (Enq_Deq) begin
        fifo[tail] = data;
        tail = tail + 1;
        S = 8'bzzzzzzzz;
    end
    else begin
        S = fifo[head];
        head = head + 1;
    end
end

endmodule

/*
test case:
clk data Enq_Deq S
1   1    1       z
0   0    0       z
1   1    1       z
0   0    0       z
1   4    1       z
0   0    0       z
1   5    1       z
0   0    0       z
1   1    1       z
0   0    0       z
1   4    1       z
0   0    0       z
1   0    0       1
0   0    0       1
1   0    0       1
0   0    0       1
1   0    0       4
0   0    0       4
1   0    0       5
0   0    0       5
1   0    0       1
0   0    0       1
1   0    0       4
0   0    0       4
*/