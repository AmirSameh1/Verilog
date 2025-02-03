module decoder3x8(
input [2:0]A,
input Enable,
output [7:0]B);

decoder_2x4 D1(.A (A[1:0]) , .Enable (~A[2]&Enable), .B ( B[3:0]));
decoder_2x4 D2(.A (A[1:0]) , .Enable (A[2]&Enable), .B ( B[7:4]));

endmodule
