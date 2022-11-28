`timescale 1ns/1ns
module tb_systolic_array_3by3;

reg CLK;
reg RESET;

reg [7:0] IN_A_0, IN_A_1, IN_A_2, IN_A_3, IN_A_4, IN_A_5, IN_A_6, IN_A_7;
reg [7:0] IN_B_0, IN_B_1, IN_B_2 ;

wire [31:0] OUT;

wire [7:0] C_00 = OUT[7:0];
wire [7:0] C_01 = OUT[15:8];
wire [7:0] C_10 = OUT[23:16];
wire [7:0] C_11 = OUT[31:24];



systolic_array_3by3 systolic_array_0 (.clk(CLK), .reset(RESET), .in_a_0(IN_A_0), .in_a_1(IN_A_1), .in_a_2(IN_A_2), .in_b_0(IN_B_0), .in_b_1(IN_B_1), .in_b_2(IN_B_2), .out(OUT[7:0]));
systolic_array_3by3 systolic_array_1 (.clk(CLK), .reset(RESET), .in_a_0(IN_A_1), .in_a_1(IN_A_2), .in_a_2(IN_A_3), .in_b_0(IN_B_0), .in_b_1(IN_B_1), .in_b_2(IN_B_2), .out(OUT[15:8]));
systolic_array_3by3 systolic_array_2 (.clk(CLK), .reset(RESET), .in_a_0(IN_A_0), .in_a_1(IN_A_1), .in_a_2(IN_A_2), .in_b_0(IN_B_0), .in_b_1(IN_B_1), .in_b_2(IN_B_2), .out(OUT[23:16]));
systolic_array_3by3 systolic_array_3 (.clk(CLK), .reset(RESET), .in_a_0(IN_A_0), .in_a_1(IN_A_1), .in_a_2(IN_A_2), .in_b_0(IN_B_0), .in_b_1(IN_B_1), .in_b_2(IN_B_2), .out(OUT[31:24]));



initial
begin
  forever
    begin
      #5 CLK = !CLK;
		end
	end
	
	
initial
  begin
    CLK = 1'b0;
    RESET = 1;
    IN_A_0 = 0 ; IN_A_1 = 0 ; IN_A_2 = 0 ; IN_A_3 = 0 ; IN_A_4 = 0 ; IN_A_5 = 0 ; IN_A_6 = 0 ; IN_A_7 = 0 ; IN_B_0 = 0 ; IN_B_1 = 0 ; IN_B_2 = 0 ;
    
    #15 RESET = 0;
        IN_A_0 = 1 ; IN_A_1 = 2 ; IN_A_2 = 3 ; IN_A_3 = 4 ; IN_A_4 = 1 ; IN_A_5 = 2 ; IN_A_6 = 1 ; IN_A_7 = 2 ; IN_B_0 = 8 ; IN_B_1 = 7 ; IN_B_2 = 6 ;
    #10 IN_A_0 = 1 ; IN_A_1 = 2 ; IN_A_2 = 1 ; IN_A_3 = 2 ; IN_A_4 = 1 ; IN_A_5 = 2 ; IN_A_6 = 3 ; IN_A_7 = 4 ; IN_B_0 = 5 ; IN_B_1 = 4 ; IN_B_2 = 3 ;
    #10 IN_A_0 = 1 ; IN_A_1 = 2 ; IN_A_2 = 3 ; IN_A_3 = 4 ; IN_A_4 = 1 ; IN_A_5 = 2 ; IN_A_6 = 1 ; IN_A_7 = 2 ; IN_B_0 = 2 ; IN_B_1 = 1 ; IN_B_2 = 0 ;
    
    #10 IN_A_0 = 0 ; IN_A_1 = 0 ; IN_A_2 = 0 ; IN_A_3 = 0 ; IN_A_4 = 0 ; IN_A_5 = 0 ; IN_A_6 = 0 ; IN_A_7 = 0 ; IN_B_0 = 0 ; IN_B_1 = 0 ; IN_B_2 = 0 ;
    

  end

     
endmodule
