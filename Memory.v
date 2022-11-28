module Memory_module(clk,rst,state,inret22,inret33,MS,CS,DATA,FILTER,ret22,ret33);

input clk,rst;
input [1:0] state,CS;
output reg [1:0] MS;

output wire [127:0] DATA;
reg [7:0] VDATA[0:4] [0:4];
assign DATA[7:0] = VDATA[0][0]; assign DATA[15:8] = VDATA[0][1]; assign DATA[23:16] = VDATA[0][2]; assign DATA[31:24] = VDATA[0][3]; 
assign DATA[39:32] = VDATA[1][0]; assign DATA[47:40] = VDATA[1][1]; assign DATA[55:48] = VDATA[1][2]; assign DATA[63:56] = VDATA[1][3]; 
assign DATA[71:64] = VDATA[2][0]; assign DATA[79:72] = VDATA[2][1]; assign DATA[87:80] = VDATA[2][2]; assign DATA[95:88] = VDATA[2][3]; 
assign DATA[103:96] = VDATA[3][0]; assign DATA[111:104] = VDATA[3][1]; assign DATA[119:112] = VDATA[3][2]; assign DATA[127:120] = VDATA[3][3]; 

output wire [71:0] FILTER;
reg [7:0] VFILTER[0:3] [0:3];
assign FILTER[7:0] = VFILTER[0][0]; assign FILTER[15:8] = VFILTER[0][1]; assign FILTER[23:16] = VFILTER[0][2]; 
assign FILTER[31:24] = VFILTER[1][0]; assign FILTER[39:32] = VFILTER[1][1]; assign FILTER[47:40] = VFILTER[1][2]; 
assign FILTER[55:48] = VFILTER[2][0]; assign FILTER[63:56] = VFILTER[2][1]; assign FILTER[71:64] = VFILTER[2][2]; 


output wire[31:0] ret22;
reg [7:0] Vret22[0:2] [0:2];
assign ret22[7:0] = Vret22[0][0]; assign ret22[15:8] = Vret22[0][1]; 
assign ret22[23:16] = Vret22[1][0]; assign ret22[31:24] = Vret22[1][1]; 

output wire [31:0] ret33;
reg [7:0] Vret33[0:2] [0:2];
assign ret33[7:0] = Vret33[0][0]; assign ret33[15:8] = Vret33[0][1]; 
assign ret33[23:16] = Vret33[1][0]; assign ret33[31:24] = Vret33[1][1]; 


input [31:0] inret22;
wire [7:0] Vinret22[0:2] [0:2];
assign Vinret22[0][0] = inret22[7:0]; assign Vinret22[0][1] = inret22[15:8]; 
assign Vinret22[1][0] = inret22[23:16]; assign Vinret22[1][1] = inret22[31:24]; 

input [31:0] inret33;
wire [7:0] Vinret33[0:2] [0:2];
assign Vinret33[0][0] = inret33[7:0]; assign Vinret33[0][1] = inret33[15:8]; 
assign Vinret33[1][0] = inret33[23:16]; assign Vinret33[1][1] = inret33[31:24]; 

integer i,j;


initial begin 
   MS = 2'b00; 
   
end

always @(posedge clk)
begin 
   if(rst==1'b1) begin 
    
    MS <= 2'b00; 
      
    end
end 

always @(*) begin         
    if(state == 2'b00) begin 
        VDATA[0][0] =0; VDATA[0][1] =0; VDATA[0][2] =0; VDATA[0][3] =0;
        VDATA[1][0] =0; VDATA[1][1] =0; VDATA[1][2] =0; VDATA[1][3] =0;
        VDATA[2][0] =0; VDATA[2][1] =0; VDATA[2][2] =0; VDATA[2][3] =0;
        VDATA[3][0] =0; VDATA[3][1] =0; VDATA[3][2] =0; VDATA[3][3] =0;
            
        VFILTER[0][0] =0; VFILTER[0][1] =0; VFILTER[0][2] =0;
        VFILTER[1][0] =0; VFILTER[1][1] =0; VFILTER[1][2] =0;
        VFILTER[2][0] =0; VFILTER[2][1] =0; VFILTER[2][2] =0;
        
        Vret22[0][0] = 0; Vret22[0][1] = 0; 
        Vret22[1][0] = 0; Vret22[1][1] = 0;
        
        Vret33[0][0] = 0; Vret33[0][1] = 0;
        Vret33[1][0] = 0; Vret33[1][1] = 0;
        
        MS = 2'b01;  
    end
    if(state == 2'b01) begin // mem init
            
     		
        VDATA[0][0] = 1; VDATA[0][1] = 1; VDATA[0][2] = 7; VDATA[0][3] = 2;
        
		VDATA[1][0] = 8; VDATA[1][1] = 6; VDATA[1][2] = 8; VDATA[1][3] = 10;
		VDATA[2][0] = 3; VDATA[2][1] = 2; VDATA[2][2] = 4; VDATA[2][3] = 1;
		VDATA[3][0] = 5; VDATA[3][1] =7; VDATA[3][2] = 0; VDATA[3][3] = 9;

		VFILTER[0][0] = 3; VFILTER[0][1] = 2; VFILTER[0][2] = 0;
		VFILTER[1][0] = 5; VFILTER[1][1] = 0; VFILTER[1][2] = 4;
		VFILTER[2][0] = 0; VFILTER[2][1] = 5; VFILTER[2][2] = 4;
    
        MS = 2'b10;            
    end     
    else if(state == 2'b10) begin // cal
        if(CS == 2'b01) begin             
            Vret22[0][0] = Vinret22[0][0]; Vret22[0][1] = Vinret22[0][1];
            Vret22[1][0] = Vinret22[1][0]; Vret22[1][1] = Vinret22[1][1];
            
            Vret33[0][0] = Vinret33[0][0]; Vret33[0][1] = Vinret33[0][1];
            Vret33[1][0] = Vinret33[1][0]; Vret33[1][1] = Vinret33[1][1];            
           MS = 2'b11;             
        end                
    end           
end

endmodule