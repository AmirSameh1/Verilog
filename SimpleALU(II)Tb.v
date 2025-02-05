module ALUIITb#(parameter Width =8, Priority=0, ADC="On")();
reg [Width-1:0] A_Tb,B_Tb;
reg [3:0] OP_Tb;
reg Cin_Tb, red_op_A_Tb,red_op_B_Tb, bypass_A_Tb, bypass_B_Tb;
reg [2*Width-1:0] ExpectedOut;
wire [2*Width-1:0] Out_DUT;
reg ExpectedOddparitty ,ExpectedInvalid;
wire Oddparitty_DUT ,Invalid_DUT;
integer i; 


ALUII#(.Width(Width), .Priority(Priority), .ADC(ADC)) DUT(
.A(A_TB),
.B(B_TB),
.OP(OP_Tb),
.Cin(Cin_Tb),
.red_op_A(red_op_A_Tb),
.red_op_B(red_op_B_Tb),
.bypass_A(bypass_A_Tb),
.bypass_B(bypass_B_Tb),
.Out(Out_DUT),
.Oddparitty(Oddparitty_DUT),
.Invalid(Invalid_DUT));


initial begin

for(i=0; i<20; i=i+1)begin

A_Tb=$urandom_range(0,50);
B_Tb=$urandom_range(0,50);
OP_Tb=$urandom_range(0,7);
Cin_Tb=$urandom_range(0,1);
red_op_A_Tb=$urandom_range(0,1);
red_op_B_Tb=$urandom_range(0,1);
bypass_A_Tb=$urandom_range(0,1);
bypass_B_Tb=$urandom_range(0,1);

ExpectedOddparitty =0;
ExpectedInvalid= red_op_A_Tb | red_op_B_Tb;

if(!bypass_A_Tb && !bypass_B_Tb)
case(OP_Tb)

'b000:begin

if(!red_op_A_Tb && !red_op_B_Tb)
ExpectedOut = A_Tb&B_Tb;

else if(red_op_A_Tb && !red_op_B_Tb)
ExpectedOut = &A_Tb;

else if(!red_op_A_Tb && red_op_B_Tb)
ExpectedOut = &B_Tb;

else

if(!Priority)
ExpectedOut=&A_Tb;
else
ExpectedOut=&B_Tb;

ExpectedInvalid=0;

end

'b001:begin

if(!red_op_A_Tb && !red_op_B_Tb)
ExpectedOut = A_Tb^B_Tb;

else if(red_op_A_Tb && !red_op_B_Tb)
ExpectedOut = ^A_Tb;

else if(!red_op_A_Tb && red_op_B_Tb)
ExpectedOut = ^B_Tb;

else

if(!Priority)
ExpectedOut=^A_Tb;
else
ExpectedOut=^B_Tb;

ExpectedInvalid=0;

end

'b010:begin

if(ADC =="On")
ExpectedOut = A_Tb+B_Tb+Cin_Tb;
else
ExpectedOut = A_Tb+B_Tb;

ExpectedOddparitty=~^ExpectedOut;


end

'b011:begin

ExpectedOut = A_Tb*B_Tb;

ExpectedOddparitty=~^ExpectedOut;

end

'b100:begin

if(A_Tb>=B_Tb)
ExpectedOut=A_Tb-B_Tb;
else
ExpectedOut=B_Tb-A_Tb;

ExpectedOddparitty=~^ExpectedOut;

end

'b101:begin

if(!A_Tb && !B_Tb)begin
ExpectedOut =A_Tb;
ExpectedInvalid=1;
end

else if(!B_Tb)begin
ExpectedOut =A_Tb;
ExpectedInvalid=1;
end

else
ExpectedOut =A_Tb/B_Tb;

ExpectedOddparitty=~^ExpectedOut;

end

'b110:ExpectedInvalid=1;
'b111:ExpectedInvalid=1;

endcase

else if(bypass_A_Tb && !bypass_B_Tb)begin
ExpectedOut =A_Tb;
ExpectedInvalid=0;
end

else if(!bypass_A_Tb && bypass_B_Tb)begin
ExpectedOut=B_Tb;
ExpectedInvalid=0;
end

else

if(!Priority)begin
ExpectedOut=A_Tb;
ExpectedInvalid=0;
end
else begin
ExpectedOut=B_Tb;
ExpectedInvalid=0;
end

if(ExpectedOut!=Out_DUT | ExpectedOddparitty!=Oddparitty_DUT | ExpectedInvalid!=Invalid_DUT)begin
$display("ERROR AT OPERATION( %d ) :red_op_A_Tb=%b red_op_B_Tb=%b bypass_A_Tb=%b bypass_B_Tb=%b A_Tb=%d B_Tb=%d ExpectedOut=%d  ExpectedOddparitty=%d  ExpectedInvalid=%d",OP_Tb,red_op_A_Tb,red_op_B_Tb,bypass_A_Tb,bypass_B_Tb,A_Tb,B_Tb,ExpectedOut,ExpectedOddparitty,ExpectedInvalid);
$stop;
end
else
$display("PASSED OPERATION( %d ) :red_op_A_Tb=%b red_op_B_Tb=%b bypass_A_Tb=%b bypass_B_Tb=%b A_Tb=%d B_Tb=%d ExpectedOut=%d  ExpectedOddparitty=%d  ExpectedInvalid=%d",OP_Tb,red_op_A_Tb,red_op_B_Tb,bypass_A_Tb,bypass_B_Tb,A_Tb,B_Tb,ExpectedOut,ExpectedOddparitty,ExpectedInvalid);


end
$stop;
end
endmodule