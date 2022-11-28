module systolic_array_2by2(clk,reset,a1,a2,b1,b2,c1,c2,c3,c4);

 input wire clk,reset;
 input wire [7:0] a1,a2,b1,b2;
 output wire [7:0] c1,c2,c3,c4;
 
 wire [7:0] a_out1,a_out2,b_out1,b_out2;
 
 
 pe_2by2 pe1 (.clk(clk), .reset(reset), .in_a(a1), .in_b(b1), .out_a(a_out1), .out_b(b_out1), .out(c1));
 pe_2by2 pe2 (.clk(clk), .reset(reset), .in_a(a_out1), .in_b(b2), .out_a(), .out_b(b_out2), .out(c2));
 pe_2by2 pe3 (.clk(clk), .reset(reset), .in_a(a2), .in_b(b_out1), .out_a(a_out2), .out_b(), .out(c3));
 pe_2by2 pe4 (.clk(clk), .reset(reset), .in_a(a_out2), .in_b(b_out2), .out_a(), .out_b(), .out(c4));


endmodule