module SimpleALUTestbench#(parameter Width=8)();

reg [Width-1:0] A_TB,B_TB;
reg [2*Width-1:0] ExpectedOut;
wire [2*Width-1:0] Out_DUT;
reg[1:0] Sel_TB;
integer i,j;


SimpleALU#(.Width(Width)) DUT(.A(A_TB),.B(B_TB),.Out(Out_DUT));

initial begin

for(i=0; i<=20; i=i+1)begin

A_TB=i;
B_TB=20-i;

for(j=0; j<4; j=j+1)begin
Sel_TB=j;

case(Sel_TB)
'b00: ExpectedOut=A_TB+B_TB;
'b01: ExpectedOut=A_TB&B_TB;
'b10: ExpectedOut=A_TB*B_TB;
'b11: ExpectedOut=A_TB+1;
endcase


if(ExpectedOut != Out_DUT)begin
$display("ERROR AT OPERATION( %d ) : A_TB=%d B_TB=%d ExpectedOut=%d",Sel_TB,A_TB,B_TB,ExpectedOut);
$stop;
end

else begin
$display("PASSED OPERATION( %d ) : A_TB=%d B_TB=%d ExpectedOut=%d",Sel_TB,A_TB,B_TB,ExpectedOut);
end

end

end
$stop;
end
endmodule
