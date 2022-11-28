
`timescale 1ns/1ns

module TopMoudle(clk,rst,MS,CS,DS,state,inret22,inret33,ret22,ret33,DATA,FILTER);

  	input clk;
	input rst;
	
	output wire [1:0] MS,CS,DS,state;
	output wire [31:0] inret22,inret33,ret22,ret33;
	output wire [127:0]DATA;
	output wire [71:0]FILTER;
	
	Controller_module Controller(.clk(clk),.rst(rst),.state(state),.MS(MS),.CS(CS),.DS(DS));
	Memory_module Memory(.clk(clk),.rst(rst),.state(state),.inret22(inret22),.inret33(inret33),.MS(MS),.CS(CS),.DATA(DATA),.FILTER(FILTER),.ret22(ret22),.ret33(ret33));
	Computation_module Computation(.clk(clk),.state(state),.CS(CS),.DATA(DATA),.FILTER(FILTER),.ret22(inret22),.ret33(inret33));
	Display_module Display(.clk(clk),.rst(rst),.state(state),.ret22(ret22),.ret33(ret33),.DS(DS));	
	

endmodule
