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
            
     		
VDATA[0][0] = 41; VDATA[0][1] = 35; VDATA[0][2] = 190; VDATA[0][3] = 132;
		VDATA[1][0] = 225; VDATA[1][1] = 108; VDATA[1][2] = 214; VDATA[1][3] = 174;
		VDATA[2][0] = 82; VDATA[2][1] = 144; VDATA[2][2] = 73; VDATA[2][3] = 241;
		VDATA[3][0] = 241; VDATA[3][1] = 187; VDATA[3][2] = 233; VDATA[3][3] = 235;

		VFILTER[0][0] = 179; VFILTER[0][1] = 166; VFILTER[0][2] = 219;
		VFILTER[1][0] = 60; VFILTER[1][1] = 135; VFILTER[1][2] = 12;
		VFILTER[2][0] = 62; VFILTER[2][1] = 153; VFILTER[2][2] = 36;
    
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