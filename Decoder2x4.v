module decoder_2x4(
input[1:0]A,
input Enable,
output [3:0]B);


assign B = {A[0] & A[1] & Enable ,(~A[0]) & A[1] & Enable, A[0] & (~A[1]) & Enable,(~A[0]) & (~A[1])& Enable};

endmodule
