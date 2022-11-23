


module Display_module(clk,rst,state,ret22,ret33,DS);
    
    input clk,rst;    
    input [1:0] state;    
    
    output reg [1:0] DS;
    
    
    input [31:0] ret22;
    wire [7:0] Vret22[0:2] [0:2];
    assign Vret22[0][0] = ret22[7:0]; assign Vret22[0][1] = ret22[15:8]; 
    assign Vret22[1][0] = ret22[23:16]; assign Vret22[1][1] = ret22[31:24]; 

    input [31:0] ret33;
    wire [7:0] Vret33[0:2] [0:2];
    assign Vret33[0][0] = ret33[7:0]; assign Vret33[0][1] = ret33[15:8]; 
    assign Vret33[1][0] = ret33[23:16]; assign Vret33[1][1] = ret33[31:24]; 

    integer i,j;
    
    always @(posedge clk)
    begin 
    if(rst==1'b1) begin 
        DS= 2'b00;    
        end
    end 

    always @(*) begin         
        if(state == 2'b00) begin // init           
            DS=2'b01; 
        end
        else if(state == 2'b11) begin // Display
            
            $display("result of 2 X 2 systollic Array\n");
            for(i = 0; i<2;i=i+1) begin 
                for(j=0;j<2;j=j+1) $display("ret[%d][%d] = %d",i,j,Vret22[i][j]);
            end
            
            $display("result of 3 X 3 systollic Array\n");
            for(i = 0; i<2;i=i+1) begin 
                for(j=0;j<2;j=j+1) $display("ret[%d][%d] = %d",i,j,Vret33[i][j]);          
            end
            DS = 2'b10;       
            $display("\n");
        end                   
    end    

endmodule