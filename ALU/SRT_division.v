module SRT_division(
    input [7:0] A, //被除数
    input [7:0] B, //除数
    output [7:0] R, //余数
    output [7:0] Q1, //A/B的正确结果,用于验证
    output [7:0] Q //SRT除法的结果
);

assign R = A%B;  
assign Q1 = A/B; 

wire B_is_0 = (B == 0);

reg [7:0] Q;
reg [8:0] A_reg;
reg [8:0] B_reg;

always @(A or B) begin
    if(B_is_0) begin
        Q = {8{1'bx}};
    end
    else begin
        A_reg = {1'b0, A};
        B_reg = {1'b0, B};
        
        Q = 0;
        
        while(A_reg >= B_reg) begin
            A_reg = A_reg - B_reg;
            Q = Q + 1;
        end
    end
end

endmodule

/*
test case:
A B Q
0 1 0
25 5 5
25 6 4
128 32 4
128 33 3
114 19 6
255 52 4
*/