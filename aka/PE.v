
module pe_module(clk,a,b,rst,val,a_out,b_out,block,db);

input db;
input clk,rst,block;
input [7:0] a,b;

output reg[7:0] val;
wire [7:0] dval;
reg [7:0] pv;

output reg[7:0] a_out;
output reg[7:0] b_out;

wire [7:0] mul_out;

multiplier_module multiplier(.clk(clk), .a(a), .b(b), .rst(rst), .zout(mul_out));
eight_bit_full_adder_module FA(.clk(clk),.rst(rst),.a(mul_out), .b(pv), .sum(dval),.block(block),.db(db));
	
always @(val) begin 
	if(db==1'b1) begin 
	$display("%d %d %d %d %d %d\n",a,b,pv, mul_out,dval,val);
	end
end

	
always @(posedge block)
begin		
	pv = val;
	a_out = a;
	b_out = b;	
end



initial begin 	
	pv = 0;
	a_out=0; 
	b_out=0;
	val = 0;
end

always @(posedge clk) begin
	if(rst == 1'b1) begin
		a_out = 0; pv=0; b_out = 0;
	end
	else begin
		if(block == 1'b0) begin 
			val <= dval;
		end
	end	
end

endmodule

