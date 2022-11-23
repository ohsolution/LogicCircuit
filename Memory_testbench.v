module Memory_testbench;

reg clk,rst; // clock
reg [2:0] state,CS;
reg [31:0] inret22;
reg [31:0] inret33;

wire [2:0] MS;
wire [127:0] DATA;
wire [71:0] FILTER;
wire [31:0] ret22;
wire [31:0] ret33;


Memory_module Memory(.clk(clk),.rst(rst),.state(state),.inret22(inret22),.inret33(inret33),.MS(MS),.CS(CS),.DATA(DATA),.FILTER(FILTER),.ret22(ret22),.ret33(ret33));

initial
begin 
    forever
    begin 
       #10 clk = !clk; 
    end
end 

initial
begin 
    state = 0;
    CS=0; clk = 0; rst= 1;
    
    #20
    rst = 0;
    #100
    state = 2'b01;
    
    #200
    inret22 = 124812789; inret33 =12828;
    state = 2'b10;
    
    #40
    $display("ret22 : %d   ",ret22); $display("ret33 : %d   ",ret33);
    CS = 2'b01;
end 

endmodule
