module Adder(
input[3:0] A ,B,
input Cin,
output [4:0] Sum);

assign Sum = A+B+Cin;

endmodule
