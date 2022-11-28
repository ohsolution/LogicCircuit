module pe (clk, reset, in_a, in_b, mul_in, out_a, out_b, mul_out, out);

input clk, reset;
input [7:0] in_a, in_b, mul_in;
output reg [7:0] out_a, out_b, mul_out, out;

 
always @(posedge clk or negedge reset)
    if(reset)
      begin
        out_a = 0 ;
        out_b = 0 ;
        mul_out = 0 ;
        out = 0 ;
      end
    else
      begin
          mul_out = mul_in + in_a * in_b ;          
          out_a = in_a ;
          out_b = in_b ;
          out = mul_out + out;          
      end
 
endmodule
