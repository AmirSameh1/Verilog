module SimpleALU#(parameter Width = 4)(
input [Width-1:0] A,B,
output reg [2*Width-1:0] Out);
reg [1:0] Sel;

always @(*)begin

case(Sel)

'b00:begin
 Out = A+B;
end

'b01:begin
 Out = A&B;
end

'b10:begin
 Out = A*B;
end

'b11:begin
 Out = A+1;
end

endcase

end

endmodule
