module BCDAdder(
input [3:0]A,B,
input Cin,
output[4:0]Sum);

wire [4:0]w1;

Adder#(.Width(4)) FA1(.A(A),.B(B), .Cin(Cin), .Sum(w1));
Adder#(.Width(4)) FA2(.A(w1[3:0]),.B({1'b0,Sum[4] ,Sum[4] ,1'b0}), .Cin(0), .Sum(Sum[3:0]));
assign Sum[4]= w1[4] |(w1[3]&w1[2]) | (w1[3]&w1[1]);

endmodule
