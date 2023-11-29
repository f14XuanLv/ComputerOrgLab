//Booth_Multiplier
module Booth_Multiplier(
    input [7:0] A,
    input [7:0] B,
    output reg [15:0] S,
    output [15:0] S1
);

assign S1 = A*B; //S1为A*B的正确结果,用于验证

//计算-A,2A,-2A
wire [15:0] A0;
wire [15:0] A1;
wire [15:0] A2;
wire [15:0] A3;
assign A0 = {8'b0, A};
assign A1 = ~A0 + 1'b1; //-A
assign A2 = A0<<1; //2A
assign A3 = ~A2 + 1'b1; //-2A

//对B进行radix-4编码
wire [8:0] B1;
assign B1 = B<<1;

wire [3:0] E[3:0];
assign E[0] = 2-2*B1[2*0+2]+B1[2*0+1]+B1[2*0];
assign E[1] = 2-2*B1[2*1+2]+B1[2*1+1]+B1[2*1];
assign E[2] = 2-2*B1[2*2+2]+B1[2*2+1]+B1[2*2];
assign E[3] = 2-2*B1[2*3+2]+B1[2*3+1]+B1[2*3];

wire [15:0] P[3:0];
assign P[0] = (E[0]==0)?A3<<(2*0):(E[0]==1)?A1<<(2*0):(E[0]==2)?16'b0:(E[0]==3)?A0<<(2*0):A2<<(2*0);
assign P[1] = (E[1]==0)?A3<<(2*1):(E[1]==1)?A1<<(2*1):(E[1]==2)?16'b0:(E[1]==3)?A0<<(2*1):A2<<(2*1);
assign P[2] = (E[2]==0)?A3<<(2*2):(E[2]==1)?A1<<(2*2):(E[2]==2)?16'b0:(E[2]==3)?A0<<(2*2):A2<<(2*2);
assign P[3] = (E[3]==0)?A3<<(2*3):(E[3]==1)?A1<<(2*3):(E[3]==2)?16'b0:(E[3]==3)?A0<<(2*3):A2<<(2*3);

wire [15:0] P_sum;
assign P_sum = P[0] + P[1] + P[2] + P[3];

//计算A和B的非0最高位之和
reg [3:0]bit_A;
reg [3:0]bit_B;
reg [7:0]bit_sum;
 
always @(P_sum) begin
    bit_A = 7;
    bit_B = 7;
    while (A[bit_A] == 0) begin
        bit_A = bit_A - 1;
    end
    while (B[bit_B] == 0) begin
        bit_B = bit_B - 1;
    end
    bit_sum = bit_A + bit_B+1;

    S = P_sum<<(15-bit_sum);
    S = S>>(15-bit_sum);
end

endmodule

/*
test case:
A B S
0 1 0
25 5 125
255 255 65025
114 191 21774
11 45 495
14 19 266
19 81 1539
*/