`timescale 1ns/1ns

module tb_multi;

	reg CLK,RESET;
	reg [7:0] A, B;
	wire [7:0] OUT;
	
	multiplier_module multi1(.clk(CLK), .a(A), .b(B), .rst(RESET), .zout(OUT));

	initial
	begin
		CLK =1'b0;
		RESET = 1'b1;
		A = 1'b0;
		B = 1'b0;
	end

	initial
	begin
		forever
		begin
			#10 CLK = !CLK;
		end
	end
	
	initial
	begin
		#20 RESET = 1'b0;
		A = 8'b11111111;
		B = 8'b01010101;
		#20
		A = 8'b00001111;
		B = 8'b00000000;
		#20
		A = 8'b00000000;
    B = 8'b00000010;		
		#20;
		#20;
		
	end
endmodule
