
module tb_pe;

	reg clk,rst,block;
	
	reg [7:0] a,b;
	wire [7:0] a_out, b_out, val;
	
	pe_module pe1(.clk(clk),.a(a),.b(b),.rst(rst),.val(val),.a_out(a_out),.b_out(b_out),.block(block));

	initial
	begin
		clk = 1'b0; rst = 1'b0; block = 1'b0;
		a=0; b=0;
	end

	initial
	begin
		forever
		begin
			#10 clk = !clk;
		end
	end
	
	initial
	begin
		
		block = 1'b1;		
		#20;
		a= 3; b= 7;
		#20;				
		block= 1'b0;
		
		
		
		//S0(block =1) => S1(a,b set) => S2(block = 0l) => S0
		
		
		#20;		
		$display("%d\n",val);				
		#20;		
		
		block = 1'b1;		
		#20;
		a= 5; b= 4;
		#20;				
		block= 1'b0;
		#20;		
		$display("%d\n",val);				
		#20;
		
		block = 1'b1;		
		#20;
		a= 2; b= 0;
		#20;				
		block= 1'b0;
		#20;		
		$display("%d\n",val);				
		#20;
		
		block = 1'b1;		
		#20;
		a= 22; b= 6;
		#20;				
		block= 1'b0;
		#20;		
		$display("%d\n",val);				
		#20;
	end
endmodule

