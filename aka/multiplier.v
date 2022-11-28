module multiplier_module(clk, a, b, rst, zout);

	input clk, rst;
	input [7:0] a, b;
	output wire [7:0] zout;	 
	reg [15:0] p;
	
	assign zout[7:0] = p[7:0];
	
	always@(posedge clk)
	begin
		if (rst ==1)
		begin
			p <= 0;
		end
		else
		begin
			p <= a*b;
		end
	end

endmodule