
module sys_testbench;

reg CLK,RST; // clock

wire [127:0] DATA;
reg [7:0] VDATA[0:4] [0:4];
assign DATA[7:0] = VDATA[0][0]; assign DATA[15:8] = VDATA[0][1]; assign DATA[23:16] = VDATA[0][2]; assign DATA[31:24] = VDATA[0][3]; 
assign DATA[39:32] = VDATA[1][0]; assign DATA[47:40] = VDATA[1][1]; assign DATA[55:48] = VDATA[1][2]; assign DATA[63:56] = VDATA[1][3]; 
assign DATA[71:64] = VDATA[2][0]; assign DATA[79:72] = VDATA[2][1]; assign DATA[87:80] = VDATA[2][2]; assign DATA[95:88] = VDATA[2][3]; 
assign DATA[103:96] = VDATA[3][0]; assign DATA[111:104] = VDATA[3][1]; assign DATA[119:112] = VDATA[3][2]; assign DATA[127:120] = VDATA[3][3]; 

wire [71:0] FILTER;
reg [7:0] VFILTER[0:3] [0:3];
assign FILTER[7:0] = VFILTER[0][0]; assign FILTER[15:8] = VFILTER[0][1]; assign FILTER[23:16] = VFILTER[0][2]; 
assign FILTER[31:24] = VFILTER[1][0]; assign FILTER[39:32] = VFILTER[1][1]; assign FILTER[47:40] = VFILTER[1][2]; 
assign FILTER[55:48] = VFILTER[2][0]; assign FILTER[63:56] = VFILTER[2][1]; assign FILTER[71:64] = VFILTER[2][2]; 

wire [7:0] o0,o1,o2,o3;
wire [2:0] cst;


//systolic_array_module stary(.clk(clk), .rst(rst), .zin(DATA), .filter(FILTER), .out_c_0(o0), .out_c_1(o1), .out_c_2(o2), .out_c_3(o3));

systolic_array_module systolic_array(.clk(CLK),.rst(RST),.zin(DATA),.filter(FILTER),.out_c_0(o0),.out_c_1(o1),.out_c_2(o2),.out_c_3(o3),.state(cst));

initial
begin
    CLK = 1'b0; RST = 1'b0;    
end

initial
begin 
    forever
    begin 
       #10 CLK = !CLK; 
    end
end 

initial
begin         
    
 VDATA[0][0] = 1; VDATA[0][1] = 7; VDATA[0][2] = 0; VDATA[0][3] = 2;
		VDATA[1][0] = 2; VDATA[1][1] = 2; VDATA[1][2] = 1; VDATA[1][3] = 4;
		VDATA[2][0] = 3; VDATA[2][1] = 6; VDATA[2][2] = 7; VDATA[2][3] = 5;
		VDATA[3][0] = 4; VDATA[3][1] = 4; VDATA[3][2] = 2; VDATA[3][3] = 3;

		VFILTER[0][0] = 4; VFILTER[0][1] = 6; VFILTER[0][2] = 1;
		VFILTER[1][0] = 3; VFILTER[1][1] = 5; VFILTER[1][2] = 8;
		VFILTER[2][0] = 5; VFILTER[2][1] = 9; VFILTER[2][2] = 2;
    #20    
    RST = 0;    
    #1300;
    $display("%d %d\n %d %d\n",o0,o1,o2,o3);
    
end 

endmodule
