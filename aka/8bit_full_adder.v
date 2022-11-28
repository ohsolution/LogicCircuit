
module eight_bit_full_adder_module (clk,rst,a, b, sum,block,db,c);

input clk,rst,block,db;
input [7:0] a, b;

output wire [7:0] sum;
output reg c;

wire [7:0] check;

wire cout;
wire cout_1, cout_2, cout_3, cout_4, cout_5, cout_6, cout_7;

reg cin;

initial begin 
	cin = 0;
end



full_adder_behavioral_module full_adder_1(.clk(clk),.rst(rst),.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(cout_1),.block(block));
full_adder_behavioral_module full_adder_2(.clk(clk),.rst(rst),.a(a[1]), .b(b[1]), .cin(cout_1), .sum(sum[1]), .cout(cout_2),.block(block));
full_adder_behavioral_module full_adder_3(.clk(clk),.rst(rst),.a(a[2]), .b(b[2]), .cin(cout_2), .sum(sum[2]), .cout(cout_3),.block(block));
full_adder_behavioral_module full_adder_4(.clk(clk),.rst(rst),.a(a[3]), .b(b[3]), .cin(cout_3), .sum(sum[3]), .cout(cout_4),.block(block));
full_adder_behavioral_module full_adder_5(.clk(clk),.rst(rst),.a(a[4]), .b(b[4]), .cin(cout_4), .sum(sum[4]), .cout(cout_5),.block(block));
full_adder_behavioral_module full_adder_6(.clk(clk),.rst(rst),.a(a[5]), .b(b[5]), .cin(cout_5), .sum(sum[5]), .cout(cout_6),.block(block));
full_adder_behavioral_module full_adder_7(.clk(clk),.rst(rst),.a(a[6]), .b(b[6]), .cin(cout_6), .sum(sum[6]), .cout(cout_7),.block(block));
full_adder_behavioral_module full_adder_8(.clk(clk),.rst(rst),.a(a[7]), .b(b[7]), .cin(cout_7), .sum(sum[7]), .cout(cout),.block(block));	

endmodule

module pe (clk, reset, in_a, in_b, mul_in, out_a, out_b, mul_out, out);

input clk, reset;
input [7:0] in_a, in_b, mul_in;
output reg [7:0] out_a, out_b, mul_out, out;

 
always @(posedge clk)
    if(reset)
      begin
        out_a = 0 ;
        out_b = 0 ;
        mul_out = 0 ;
        out = 0 ;
      end
    else
      begin
          mul_out = mul_in + in_a * in_b ;
          out_a = in_a ;
          out_b = in_b ;
          out = mul_out + out ;
      end
 
endmodule

module systolic_array_3by3(clk, reset, in_a_0, in_a_1, in_a_2, in_b_0, in_b_1, in_b_2, out);

input clk,reset;
input [7:0] in_a_0, in_a_1, in_a_2;
input [7:0] in_b_0, in_b_1, in_b_2;
output [7:0] out;


wire [7:0] a_00, a_01, a_10, a_11, a_20, a_21 ;
wire [7:0] b_00, b_01, b_02, b_10, b_11, b_12 ; 
wire [7:0] mul_00, mul_11 ;
  
pe pe00 (.clk(clk), .reset(reset), .in_a(in_a_0), .in_b(in_b_0), .mul_in(0),         .out_a(a_00), .out_b(b_00), .mul_out(mul_00), .out());
pe pe01 (.clk(clk), .reset(reset), .in_a(a_00),   .in_b(in_b_1), .mul_in(0),         .out_a(a_01), .out_b(b_01), .mul_out(),       .out());
pe pe02 (.clk(clk), .reset(reset), .in_a(a_01),   .in_b(in_b_2), .mul_in(0),         .out_a(),     .out_b(b_02), .mul_out(),       .out());
pe pe10 (.clk(clk), .reset(reset), .in_a(in_a_1), .in_b(b_00),   .mul_in(0),         .out_a(a_10), .out_b(b_10), .mul_out(),       .out());
pe pe11 (.clk(clk), .reset(reset), .in_a(a_10),   .in_b(b_01),   .mul_in(mul_00),    .out_a(a_11), .out_b(b_11),  .mul_out(mul_11),  .out());
pe pe12 (.clk(clk), .reset(reset), .in_a(a_11),   .in_b(b_02),   .mul_in(0),         .out_a(),     .out_b(b_12), .mul_out(),       .out());
pe pe20 (.clk(clk), .reset(reset), .in_a(in_a_2), .in_b(b_10),   .mul_in(0),         .out_a(a_20), .out_b(),     .mul_out(),       .out());
pe pe21 (.clk(clk), .reset(reset), .in_a(a_20),   .in_b(b_11),   .mul_in(0),         .out_a(a_21), .out_b(),     .mul_out(),       .out());
pe pe22 (.clk(clk), .reset(reset), .in_a(a_21),   .in_b(b_12),   .mul_in(mul_11),    .out_a(),     .out_b(),      .mul_out(),        .out(out));


endmodule

`timescale 1ns/1ns

module tb_systolic_array_3by3;

reg CLK;
reg RESET;

reg [7:0] IN_A_0, IN_A_1, IN_A_2, IN_A_3, IN_A_4, IN_A_5, IN_A_6, IN_A_7;
reg [7:0] IN_B_0, IN_B_1, IN_B_2 ;

wire [31:0] OUT;

wire [7:0] C_00 = OUT[7:0];
wire [7:0] C_01 = OUT[15:8];
wire [7:0] C_10 = OUT[23:16];
wire [7:0] C_11 = OUT[31:24];



systolic_array_3by3 systolic_array_0 (.clk(CLK), .reset(RESET), .in_a_0(IN_A_0), .in_a_1(IN_A_1), .in_a_2(IN_A_2), .in_b_0(IN_B_0), .in_b_1(IN_B_1), .in_b_2(IN_B_2), .out(OUT[7:0]));
systolic_array_3by3 systolic_array_1 (.clk(CLK), .reset(RESET), .in_a_0(IN_A_1), .in_a_1(IN_A_2), .in_a_2(IN_A_3), .in_b_0(IN_B_0), .in_b_1(IN_B_1), .in_b_2(IN_B_2), .out(OUT[15:8]));
systolic_array_3by3 systolic_array_2 (.clk(CLK), .reset(RESET), .in_a_0(IN_A_0), .in_a_1(IN_A_1), .in_a_2(IN_A_2), .in_b_0(IN_B_0), .in_b_1(IN_B_1), .in_b_2(IN_B_2), .out(OUT[23:16]));
systolic_array_3by3 systolic_array_3 (.clk(CLK), .reset(RESET), .in_a_0(IN_A_0), .in_a_1(IN_A_1), .in_a_2(IN_A_2), .in_b_0(IN_B_0), .in_b_1(IN_B_1), .in_b_2(IN_B_2), .out(OUT[31:24]));



initial
begin
  forever
    begin
      #5 CLK = !CLK;
      end
   end
   
   
initial
  begin
    CLK = 1'b0;
    RESET = 1;
    IN_A_0 = 0 ; IN_A_1 = 0 ; IN_A_2 = 0 ; IN_A_3 = 0 ; IN_A_4 = 0 ; IN_A_5 = 0 ; IN_A_6 = 0 ; IN_A_7 = 0 ; IN_B_0 = 0 ; IN_B_1 = 0 ; IN_B_2 = 0 ;
    
    #15 RESET = 0;
        IN_A_0 = 1 ; IN_A_1 = 2 ; IN_A_2 = 3 ; IN_A_3 = 4 ; IN_A_4 = 1 ; IN_A_5 = 2 ; IN_A_6 = 1 ; IN_A_7 = 2 ; IN_B_0 = 8 ; IN_B_1 = 7 ; IN_B_2 = 6 ;
    #10 IN_A_0 = 1 ; IN_A_1 = 2 ; IN_A_2 = 1 ; IN_A_3 = 2 ; IN_A_4 = 1 ; IN_A_5 = 2 ; IN_A_6 = 3 ; IN_A_7 = 4 ; IN_B_0 = 5 ; IN_B_1 = 4 ; IN_B_2 = 3 ;
    #10 IN_A_0 = 1 ; IN_A_1 = 2 ; IN_A_2 = 3 ; IN_A_3 = 4 ; IN_A_4 = 1 ; IN_A_5 = 2 ; IN_A_6 = 1 ; IN_A_7 = 2 ; IN_B_0 = 2 ; IN_B_1 = 1 ; IN_B_2 = 0 ;
    
    #10 IN_A_0 = 0 ; IN_A_1 = 0 ; IN_A_2 = 0 ; IN_A_3 = 0 ; IN_A_4 = 0 ; IN_A_5 = 0 ; IN_A_6 = 0 ; IN_A_7 = 0 ; IN_B_0 = 0 ; IN_B_1 = 0 ; IN_B_2 = 0 ;
    

  end

     
endmodule
