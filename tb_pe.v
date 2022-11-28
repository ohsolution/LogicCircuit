`timescale 1ns/1ns

module tb_pe;

reg CLK;
reg RESET;
reg [7:0] IN_A, IN_B, MUL_IN;

wire [7:0] OUT_A, OUT_B, MUL_OUT, OUT;

pe pe_1(.clk(CLK), .reset(RESET), .in_a(IN_A),  .in_b(IN_B), .mul_in(MUL_IN), .out_a(OUT_A), .out_b(OUT_B), .mul_out(MUL_OUT), .out(OUT));

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
    MUL_IN = 0;
    IN_A = 0; IN_B = 0;
    
    #15 RESET = 0; IN_A = 2; IN_B = 1;
    #10 IN_A = 2; IN_B = 2; 
    #10 IN_A = 2; IN_B = 3; 
    #10 IN_A = 3; IN_B = 1; 
    #10 IN_A = 3; IN_B = 2; 
    #10 IN_A = 3; IN_B = 3; 
    #10 IN_A = 0; IN_B = 0;
  end
endmodule
