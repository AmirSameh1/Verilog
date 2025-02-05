module ALUII#(parameter Width =8, Priority=0, ADC="On")(
input [Width-1:0] A,B,
input [3:0]OP,
input Cin, red_op_A,red_op_B, bypass_A, bypass_B,
output reg [2*Width-1:0] Out,
output reg Oddparitty ,Invalid);

always@(*)begin
Oddparitty =0;
Invalid= red_op_A | red_op_B;

if(!bypass_A && !bypass_B)
case(OP)

'b000:begin

if(!red_op_A && !red_op_B)
Out = A&B;

else if(red_op_A && !red_op_B)
Out = &A;

else if(!red_op_A && red_op_B)
Out = &B;

else

if(!Priority)
Out=&A;
else
Out=&B;

Invalid=0;

end

'b001:begin

if(!red_op_A && !red_op_B)
Out = A^B;

else if(red_op_A && !red_op_B)
Out = ^A;

else if(!red_op_A && red_op_B)
Out = ^B;

else

if(!Priority)
Out=^A;
else
Out=^B;

Invalid=0;

end

'b010:begin

if(ADC =="On")
Out = A+B+Cin;
else
Out = A+B;

Oddparitty=~^Out;


end

'b011:begin

Out = A*B;

Oddparitty=~^Out;

end

'b100:begin

if(A>=B)
Out=A-B;
else
Out=B-A;

Oddparitty=~^Out;

end

'b101:begin

if(!A && !B)begin
Out =A;
Invalid=1;
end

else if(!B)begin
Out =A;
Invalid=1;
end

else
Out =A/B;

Oddparitty=~^Out;

end

'b110:Invalid=1;
'b111:Invalid=1;

endcase

else if(bypass_A && !bypass_B) begin
Out =A;
Invalid=0;
end

else if(!bypass_A && bypass_B)begin
Out=B;
Invalid=0;
end

else

if(!Priority)begin
Out=A;
Invalid=0;
end
else begin
Out=B;
Invalid=0;
end


end

endmodule
