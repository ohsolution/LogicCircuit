`timescale 1ns/1ns

module tb_systolic_array_2by2;


 reg CLK;
 reg RESET;
 reg [7:0] A1,A2,B1,B2;


reg[7:0] row_1[0:12];
reg[7:0] row_2[0:12];
reg[7:0] col_1[0:12];
reg[7:0] col_2[0:12];

wire [7:0] C1,C2,C3,C4;

systolic_array_2by2 sys_0 (.clk(CLK), .reset(RESET), .a1(A1), .a2(A2), .b1(B1), .b2(B2), .c1(C1), .c2(C2), .c3(C3), .c4(C4));

initial 
begin
forever 
    begin
    #5 CLK = !CLK;
    end
end


initial begin

CLK = 0;
RESET = 1;
A1 = 0;
A2 = 0;
B1 = 0;
B2 = 0;


#10 RESET = 0;
#5;  A1 = 1; A2 = 0; B1 = 8; B2 = 0;
#10;  A1 = 2; A2 = 1; B1 = 7; B2 =0;
#10;  A1 = 3; A2 = 2; B1 = 6; B2 =8;
#10;  A1 = 4; A2 = 1; B1 = 0; B2 =7;
#10;  A1 = 1; A2 = 2; B1 = 5; B2 =6;
#10;  A1 = 2; A2 = 1; B1 = 4; B2 =0;
#10;  A1 = 1; A2 = 2; B1 = 3; B2 =5;
#10;  A1 = 2; A2 = 3; B1 = 0; B2 =4;
#10;  A1 = 1; A2 = 4; B1 = 2; B2 =3;
#10;  A1 = 2; A2 = 1; B1 = 1; B2 =0;
#10;  A1 = 3; A2 = 2; B1 = 0; B2 =2;
#10;  A1 = 4; A2 = 1; B1 = 0; B2 =1;
#10;  A1 = 0; A2 = 2; B1 = 0; B2 =0;

#100;

end


    
endmodule