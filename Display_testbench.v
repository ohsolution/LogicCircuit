module Display_testbench;
    
    
reg clk,rst; // clock
reg[31:0] ret22;
reg[31:0] ret33;

reg [1:0] state;
wire [1:0] DS;

Display_module Display(.clk(clk),.rst(rst),.state(state),.ret22(ret22),.ret33(ret33),.DS(DS));

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
    clk = 0; rst= 1; ret22=0; ret33=0;
    
    #20
    rst = 0;

    #60
    state = 2'b01;
    
    #60
    state = 2'b10;
    
    #60
    ret22 = 124812789; ret33 =12828;
    state = 2'b11;    
end 

endmodule