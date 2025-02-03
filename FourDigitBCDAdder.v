module FourDigitBCDAdder(
input [15:0] A,B,
input Cin,
output [16:0] Sum);

wire [4:0] w1 ,w2,w3,w4;

BCDAdder BC1(.A(A[3:0]),.B(B[3:0]),.Cin(Cin),.Sum(w1));
BCDAdder BC2(.A(A[7:4]),.B(B[7:4]),.Cin(w1[4]),.Sum(w2));
BCDAdder BC3(.A(A[11:8]),.B(B[11:8]),.Cin(w2[4]),.Sum(w3));
BCDAdder BC4(.A(A[15:12]),.B(B[15:12]),.Cin(w3[4]),.Sum(w4));

assign Sum ={w4[4:0],w3[3:0],w2[3:0],w1[3:0]};

endmodule