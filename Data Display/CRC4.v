module CRC4 (
    input [9:0] data,
    input [4:0] poly,
    output reg [3:0] CRC4_code,
    output reg [13:0] data_out
);

    reg [13:0] temp_data;
    reg [3:0] p;

    always @(*) begin

        p = 13;
        temp_data = {data, 4'b0};

        while (p > 3) begin

            if (temp_data[p] == 1'b1) begin
                temp_data[p-0] = temp_data[p-0] ^ 1;
                temp_data[p-1] = temp_data[p-1] ^ poly[3];
                temp_data[p-2] = temp_data[p-2] ^ poly[2];
                temp_data[p-3] = temp_data[p-3] ^ poly[1];
                temp_data[p-4] = temp_data[p-4] ^ poly[0];
            end

            else begin
                p = p - 1;
            end

        end

        CRC4_code[3] = temp_data[3];
        CRC4_code[2] = temp_data[2];
        CRC4_code[1] = temp_data[1];
        CRC4_code[0] = temp_data[0];
        
        data_out = {data, CRC4_code};
    end

endmodule

/*
test case
data poly CRC4_code
0x2C7 0x13 0xD
0x287 0x13 0xA
0x285 0x15 0xC
0x200 0x18 0x8
*/

