module Controller_testbench;

    reg clk,rst;
    
    reg[1:0] MS; 
    reg[1:0] CS;
    reg[1:0] DS;
    wire [1:0] state;
    
    Controller_module controll(.clk(clk),.rst(rst),.state(state),.MS(MS),.CS(CS),.DS(DS));
    
    initial
    begin 
        forever
        begin 
        #10 clk = !clk; 
        end
    end 

    initial
    begin         
        clk = 0; rst= 1; MS = 0; CS= 0 ; DS= 0;
    
        #20
        rst = 0;

        #20
        MS = 2'b01;
        #20
        CS= 2'b01;
        #20
        DS = 2'b01;
                
        #60
        MS = 2'b10;
        
        #120
        CS = 2'b10;        
    end 
endmodule