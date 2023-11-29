//4bit CSA sub_adder
module CSA_sub_adder(
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output [3:0] S,
    output Cout
);

wire [3:0] G;
wire [3:0] P;
wire [4:0] C;

assign G = A & B;

assign P = A ^ B;

assign C[0] = Cin;
assign C[1] = G[0] | (P[0]&C[0]);
assign C[2] = G[1] | (P[1]&G[0]) | (P[1]&P[0]&C[0]);
assign C[3] = G[2] | (P[2]&G[1]) | (P[2]&P[1]&G[0]) | (P[2]&P[1]&P[0]&C[0]);
assign C[4] = G[3] | (P[3]&G[2]) | (P[3]&P[2]&G[1]) | (P[3]&P[2]&P[1]&G[0]) | (P[3]&P[2]&P[1]&P[0]&C[0]);

assign S = P ^ C[3:0];

assign Cout = C[4];

endmodule

/*
test case:
A B Cin S Cout
1 1 0 2 0
1 1 1 3 0
2 7 0 9 0
7 2 1 10 0
9 8 1 3 1
*/