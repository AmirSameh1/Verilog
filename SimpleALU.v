module SimpleALU#(parameter Width = 4)(
input [Width-1:0] A,B,
output reg [2*Width-1:0] Out);
reg [1:0] Sel;

always @(*)begin

case(Sel)
'b00: Out = A+B;
'b01: Out = A&B;
'b10: Out = A*B;
'b11: Out = A+1;
endcase


end

endmodule
