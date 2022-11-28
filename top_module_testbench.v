`timescale 1ns/1ns

module top_module_testbench;

reg clk,rst;
wire [1:0] MS,CS,DS,state;
wire [31:0] inret22,inret33,ret22,ret33;
wire [127:0]DATA;
   wire [71:0]FILTER;


wire[7:0] s2c00,s2c01,s2c10,s2c11;
wire[7:0] s3c00,s3c01,s3c10,s3c11;

assign s2c00 = ret22[7:0]; assign s2c01 = ret22[15:8]; assign s2c10 = ret22[23:16]; assign s2c11 = ret22[31:24];
assign s3c00 = ret33[7:0]; assign s3c01 = ret33[15:8]; assign s3c10 = ret33[23:16]; assign s3c11 = ret33[31:24];


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