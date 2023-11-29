/*
主存1个块4B,地址有8位,地址的低2位为块内地址,高6位为块号,一个地址存放1B数据
cache 1行4B,共8行,采用直接映射,低2位为块内地址,中间3位为行号,高3位为标记
*/

//cache
module cache(
    input clk,
    input [7:0] address,
    output reg hit,
    output reg [7:0] data_out
);

reg [7:0] memory [255:0]; //256B的主存
reg [15:0] cache [31:0]; //前8位为数据,后8位为地址
reg [2:0] tag = 0;
reg [4:0] row = 0;

//初始化将memory中的数据赋值为0到255
integer i;
initial begin
    for (i = 0; i < 256; i = i + 1) begin
        memory[i] = i;
    end
end

always @(posedge clk) begin

    tag = address[7:5];
    row = {address[4:2],2'b0};

    //判断是否命中
    if (tag==cache[row][15:13]) begin
        hit = 1;
        data_out = cache[address[4:0]][7:0];
    end

    else begin
        hit = 0;

        cache[row][15:13] = tag;
        cache[row][7:0] = memory[{address[7:2],2'b00}];
        cache[row+1][7:0] = memory[{address[7:2],2'b01}];
        cache[row+2][7:0] = memory[{address[7:2],2'b10}];
        cache[row+3][7:0] = memory[{address[7:2],2'b11}];

        data_out = 8'bzzzzzzzz;
    end
end

endmodule

/*
test case:
clk address hit data_out
1   1       0   z
0   1       0   z
1   0       1   0
0   0       1   0
1   2       1   2
0   2       1   2
1   3       1   3
0   3       1   3
1   114     0   z
0   114     0   z
1   115     1   115
0   115     1   115
*/