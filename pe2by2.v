module pe_2by2 (clk, reset, in_a, in_b, out_a, out_b, out);

input wire clk, reset;
input wire [7:0] in_a, in_b;
output reg [7:0] out_a, out_b, out;

reg [7:0] mul;
 
always @(posedge clk or negedge reset)
    if(reset)
      begin
        out_a = 0;
        out_b = 0;
        out = 0;
      end
    else
      begin
          mul = in_a * in_b ;
          out_a = in_a ;
          out_b = in_b ;
          out = mul + out ;
      end
 
endmodule