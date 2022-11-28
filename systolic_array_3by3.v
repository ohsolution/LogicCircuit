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
