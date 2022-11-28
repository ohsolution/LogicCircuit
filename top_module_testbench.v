`timescale 1ns/1ns

module top_module_testbench;

reg clk,rst;
wire [1:0] MS,CS,DS,state;
wire [31:0] inret22,inret33,ret22,ret33;
wire [127:0]DATA;
   wire [71:0]FILTER;


TopMoudle TOP(.clk(clk),.rst(rst),.MS(MS),.CS(CS),.DS(DS),.state(state),.inret22(inret22),.inret33(inret33),.ret22(ret22),.ret33(ret33),.DATA(DATA),.FILTER(FILTER));

initial
begin 
    forever
    begin 
       #5 clk = !clk; 
    end
end 


initial begin 
clk = 0; rst = 0;   
end

endmodule