`timescale 1ns/1ns

module Computation_module(clk,state,CS,DATA,FILTER,ret22,ret33);

input clk;
input wire [1:0] state;

output reg [1:0] CS;

input [127:0] DATA;
wire [7:0] VDATA[0:4] [0:4];
assign VDATA[0][0] = DATA[7:0]; assign VDATA[0][1] = DATA[15:8]; assign VDATA[0][2] = DATA[23:16]; assign VDATA[0][3] = DATA[31:24]; 
assign VDATA[1][0] = DATA[39:32]; assign VDATA[1][1] = DATA[47:40]; assign VDATA[1][2] = DATA[55:48]; assign VDATA[1][3] = DATA[63:56]; 
assign VDATA[2][0] = DATA[71:64]; assign VDATA[2][1] = DATA[79:72]; assign VDATA[2][2] = DATA[87:80]; assign VDATA[2][3] = DATA[95:88]; 
assign VDATA[3][0] = DATA[103:96]; assign VDATA[3][1] = DATA[111:104]; assign VDATA[3][2] = DATA[119:112]; assign VDATA[3][3] = DATA[127:120]; 

input [71:0] FILTER;
wire [7:0] VFILTER[0:3] [0:3];
assign VFILTER[0][0] = FILTER[7:0]; assign VFILTER[0][1] = FILTER[15:8]; assign VFILTER[0][2] = FILTER[23:16]; 
assign VFILTER[1][0] = FILTER[31:24]; assign VFILTER[1][1] = FILTER[39:32]; assign VFILTER[1][2] = FILTER[47:40]; 
assign VFILTER[2][0] = FILTER[55:48]; assign VFILTER[2][1] = FILTER[63:56]; assign VFILTER[2][2] = FILTER[71:64]; 

reg [7:0] IN_A_0, IN_A_1, IN_A_2, IN_A_3, IN_A_4, IN_A_5, IN_A_6, IN_A_7;
reg [7:0] IN_B_0, IN_B_1, IN_B_2 ;
output wire [31:0] ret33,ret22;

reg rst;

systolic_array_3by3 systolic_array_0 (.clk(clk), .reset(rst), .in_a_0(IN_A_0), .in_a_1(IN_A_1), .in_a_2(IN_A_2), .in_b_0(IN_B_0), .in_b_1(IN_B_1), .in_b_2(IN_B_2), .out(ret33[7:0]));
systolic_array_3by3 systolic_array_1 (.clk(clk), .reset(rst), .in_a_0(IN_A_1), .in_a_1(IN_A_2), .in_a_2(IN_A_3), .in_b_0(IN_B_0), .in_b_1(IN_B_1), .in_b_2(IN_B_2), .out(ret33[15:8]));
systolic_array_3by3 systolic_array_2 (.clk(clk), .reset(rst), .in_a_0(IN_A_4), .in_a_1(IN_A_5), .in_a_2(IN_A_6), .in_b_0(IN_B_0), .in_b_1(IN_B_1), .in_b_2(IN_B_2), .out(ret33[23:16]));
systolic_array_3by3 systolic_array_3 (.clk(clk), .reset(rst), .in_a_0(IN_A_5), .in_a_1(IN_A_6), .in_a_2(IN_A_7), .in_b_0(IN_B_0), .in_b_1(IN_B_1), .in_b_2(IN_B_2), .out(ret33[31:24]));

reg [7:0] A1,A2,B1,B2;

systolic_array_2by2 sys_0 (.clk(clk), .reset(rst), .a1(A1), .a2(A2), .b1(B1), .b2(B2), .c1(ret22[7:0]), .c2(ret22[15:8]), .c3(ret22[23:16]), .c4(ret22[31:24]));


initial begin
   CS=0; 
   
end


always @(negedge clk) begin 
    
    if(state == 2'b00) begin
        IN_A_0 = 0 ; IN_A_1 = 0 ; IN_A_2 = 0 ; IN_A_3 = 0 ; IN_A_4 = 0 ; IN_A_5 = 0 ; IN_A_6 = 0 ; IN_A_7 = 0 ; IN_B_0 = 0 ; IN_B_1 = 0 ; IN_B_2 = 0 ;
        CS=2'b01;
    end    
    else if(state == 2'b10) begin
              A1 = 0;
A2 = 0;
B1 = 0;
B2 = 0;  rst = 1; #10; rst=0;
   #5   A1 = VDATA[0][0]; A2 = 0; B1 = VFILTER[2][2]; B2 = 0; IN_A_0 = VDATA[0][0] ; IN_A_1 = VDATA[0][1] ; IN_A_2 = VDATA[0][2] ; IN_A_3 = VDATA[0][3] ; IN_A_4 = VDATA[1][0] ; IN_A_5 = VDATA[1][1] ; IN_A_6 = VDATA[1][2] ; IN_A_7 = VDATA[1][3] ; IN_B_0 = VFILTER[2][2] ; IN_B_1 = VFILTER[2][1] ; IN_B_2 = VFILTER[2][0] ;
   #10  A1 = VDATA[0][1]; A2 = VDATA[1][0]; B1 = VFILTER[2][1]; B2 =0; IN_A_0 = VDATA[1][0] ; IN_A_1 = VDATA[1][1] ; IN_A_2 = VDATA[1][2] ; IN_A_3 = VDATA[1][3] ; IN_A_4 = VDATA[2][0] ; IN_A_5 = VDATA[2][1] ; IN_A_6 = VDATA[2][2] ; IN_A_7 = VDATA[2][3] ; IN_B_0 = VFILTER[1][2] ; IN_B_1 = VFILTER[1][1] ; IN_B_2 = VFILTER[1][0] ;
   #10  A1 = VDATA[0][2]; A2 = VDATA[1][1]; B1 = VFILTER[2][0]; B2 =VFILTER[2][2]; IN_A_0 = VDATA[2][0] ; IN_A_1 = VDATA[2][1] ; IN_A_2 = VDATA[2][2] ; IN_A_3 = VDATA[2][3] ; IN_A_4 = VDATA[3][0] ; IN_A_5 = VDATA[3][1] ; IN_A_6 = VDATA[3][2] ; IN_A_7 = VDATA[3][3] ; IN_B_0 = VFILTER[0][2] ; IN_B_1 = VFILTER[0][1] ; IN_B_2 = VFILTER[0][0] ;
   #10  A1 = VDATA[0][3]; A2 = VDATA[1][2]; B1 = 0; B2 = VFILTER[2][1]; IN_A_0 = 0 ; IN_A_1 = 0 ; IN_A_2 = 0 ; IN_A_3 = 0 ; IN_A_4 = 0 ; IN_A_5 = 0 ; IN_A_6 = 0 ; IN_A_7 = 0 ; IN_B_0 = 0 ; IN_B_1 = 0 ; IN_B_2 = 0 ;
   #10  A1 = VDATA[1][0]; A2 = VDATA[1][3]; B1 = VFILTER[1][2]; B2 =VFILTER[2][0];
   #10  A1 = VDATA[1][1]; A2 = VDATA[2][0]; B1 = VFILTER[1][1]; B2 =0;
   #10  A1 = VDATA[1][2]; A2 = VDATA[2][1]; B1 = VFILTER[1][0]; B2 =VFILTER[1][2];
   #10  A1 = VDATA[1][3]; A2 = VDATA[2][2]; B1 = 0; B2 =VFILTER[1][1];
   #10  A1 = VDATA[2][0]; A2 = VDATA[2][3]; B1 = VFILTER[0][2]; B2 =VFILTER[1][0];
   #10  A1 = VDATA[2][1]; A2 = VDATA[3][0]; B1 = VFILTER[0][1]; B2 =0;
   #10  A1 = VDATA[2][2]; A2 = VDATA[3][1]; B1 = VFILTER[0][0]; B2 =VFILTER[0][2];
   #10  A1 = VDATA[2][3]; A2 = VDATA[3][2]; B1 = 0; B2 =VFILTER[0][1];
   #10  A1 = 0; A2 = VDATA[3][3]; B1 = 0; B2 =VFILTER[0][0];
    #15;
       
    CS = 2'b10;               
    end     
end

endmodule