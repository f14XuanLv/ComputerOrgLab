//hamming_encode
module hamming_encode(
    input [5:0] A,
    output [9:0] Y,
    input [9:0] Y1,
    output [3:0] Error
);
assign Y[0] = ((A[0] ^ A[1]) ^ (A[3] ^ A[4]));
assign Y[1] = ((A[0] ^ A[2]) ^ (A[3] ^ A[5]));
assign Y[2] = A[0];
assign Y[3] = ((A[1] ^ A[2]) ^ A[3]);
assign Y[4] = A[1];
assign Y[5] = A[2];
assign Y[6] = A[3];
assign Y[7] = (A[4] ^ A[5]);
assign Y[8] = A[4];
assign Y[9] = A[5];
assign Error[0] = (((Y1[0] ^ Y1[2]) ^ (Y1[4] ^ Y1[6])) ^ Y1[8]);
assign Error[1] = (((Y1[1] ^ Y1[2]) ^ (Y1[5] ^ Y1[6])) ^ Y1[9]);
assign Error[2] = ((Y1[4] ^ Y1[3]) ^ (Y1[6] ^ Y1[5]));
assign Error[3] = ((Y1[8] ^ Y1[7]) ^ Y1[9]);
endmodule

/*
test case
Y1 Error
0x2E4   0
0x2E5   0x01
0x2E6   0x02
0x2E0   0x03
0x2EC   0x04
0x2F4   0x05
0x2C4   0x06
0x2A4   0x07
0x264   0x08
0x3E4   0x09
0x0E4   0x0A
*/
