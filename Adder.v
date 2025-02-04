module Adder#(parameter Width=4)(
input[Width-1:0] A ,B,
input Cin,
output [Width:0] Sum);

assign Sum = A+B+Cin;

endmodule
