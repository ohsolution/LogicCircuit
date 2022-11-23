module Controller_module(clk,rst,state,MS,CS,DS);

	input clk,rst;
	input wire[1:0] MS,CS,DS;	
	output reg[1:0] state;
	reg[1:0] next_state;	
	
	initial begin
		state = 0;
		next_state = 0;		
	end
		
	parameter Sinit=0,Smem=1,Scal=2,Sdisplay=3;		
	
	always @(posedge clk)
	begin
		if(rst == 1'b1) 
		begin  
			state = Sinit;
			next_state = Sinit;
		end
		else state = next_state;
	end
	
	always@(*) begin
		next_state = state;		
		
		case(state)
			Sinit: begin
				if(MS == 2'b01 && CS == 2'b01 && DS == 2'b01)
				begin 
					next_state = Smem;
				end
			end
			Smem: begin 
				if(MS == 2'b10)
				begin 
					next_state = Scal;
				end
			end
			Scal: begin 
				if(CS == 2'b10 && MS == 2'b10)
				begin 
					next_state = Sdisplay;
				end
			end
		endcase
		
	end
endmodule

 