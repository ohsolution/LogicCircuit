
module full_adder_behavioral_module (clk,rst,a, b, cin, sum, cout,block);
	
	input clk,rst,a,b,cin,block;
	
	output reg sum, cout;
		
	initial begin 
		sum=0;cout =0;		
	end
	
	
	
	always@(posedge clk)
	begin
		if(block == 1'b0) begin
			{cout, sum} <= a + b + cin;
		end
	end
	
	
	always @(posedge clk) begin
		if(rst == 1'b1) begin
			sum = 0; cout = 0;
		end
		
	end
endmodule


