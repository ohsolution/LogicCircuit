module systolic_array_module(clk, rst, zin, filter, out_c_0, out_c_1, out_c_2, out_c_3,state);

input clk, rst;
reg block;
output wire[7:0] out_c_0, out_c_1, out_c_2, out_c_3;



wire[7:0] a_out_0, b_out_0, a_out_1, b_out_1, a_out_2, b_out_2, a_out_3, b_out_3;

input [127:0] zin;
wire [7:0] vin[0:4] [0:4];
assign vin[0][0] = zin[7:0]; assign vin[0][1] = zin[15:8]; assign vin[0][2] = zin[23:16]; assign vin[0][3] = zin[31:24]; 
assign vin[1][0] = zin[39:32]; assign vin[1][1] = zin[47:40]; assign vin[1][2] = zin[55:48]; assign vin[1][3] = zin[63:56]; 
assign vin[2][0] = zin[71:64]; assign vin[2][1] = zin[79:72]; assign vin[2][2] = zin[87:80]; assign vin[2][3] = zin[95:88]; 
assign vin[3][0] = zin[103:96]; assign vin[3][1] = zin[111:104]; assign vin[3][2] = zin[119:112]; assign vin[3][3] = zin[127:120]; 


input [71:0] filter;
wire [7:0] vfilter[0:3] [0:3];
assign vfilter[0][0] = filter[7:0]; assign vfilter[0][1] = filter[15:8]; assign vfilter[0][2] = filter[23:16]; 
assign vfilter[1][0] = filter[31:24]; assign vfilter[1][1] = filter[39:32]; assign vfilter[1][2] = filter[47:40]; 
assign vfilter[2][0] = filter[55:48]; assign vfilter[2][1] = filter[63:56]; assign vfilter[2][2] = filter[71:64]; 


wire [7:0] row_1[0:12];
wire [7:0] row_2[0:12];
wire  [7:0] col_1[0:12];
wire [7:0] col_2[0:12];


assign  row_1[0] = vin[0][0];
assign row_1[1] =vin[0][1];
assign row_1[2] = vin[0][2];
assign row_1[3] = vin[0][3];
assign row_1[4] =vin[1][0];
assign row_1[5] = vin[1][1];
assign row_1[6] = vin[1][2];
assign row_1[7] = vin[1][3];
assign row_1[8] =  vin[2][0];
assign row_1[9] =  vin[2][1];
assign row_1[10] =  vin[2][2];
assign row_1[11] =  vin[2][3];
assign row_1[12] = 0;

assign row_2[0] = 0;
assign  row_2[1] = vin[1][0];
assign  row_2[2] = vin[1][1];
assign row_2[3] = vin[1][2];
assign row_2[4] = vin[1][3];
assign row_2[5] = vin[2][0];
assign row_2[6] = vin[2][1];
assign row_2[7] = vin[2][2];
assign row_2[8] = vin[2][3];
assign row_2[9] = vin[3][0];
assign row_2[10] = vin[3][1];
assign row_2[11] = vin[3][2];
assign row_2[12] = vin[3][3];

assign col_1[0] = vfilter[2][2];
assign  col_1[1] = vfilter[2][1];
assign  col_1[2] = vfilter[2][0];
assign  col_1[3] = 0;
assign  col_1[4] = vfilter[1][2];
assign  col_1[5] = vfilter[1][1];
assign  col_1[6] = vfilter[1][0];
assign  col_1[7] = 0;
assign  col_1[8] = vfilter[0][2];
assign  col_1[9] = vfilter[0][1];
assign  col_1[10] = vfilter[0][0];
assign  col_1[11] = 0;
assign  col_1[12] = 0;

assign col_2[0] = 0;
assign  col_2[1] = 0;
assign  col_2[2] = vfilter[2][2];
assign  col_2[3] = vfilter[2][1];
assign  col_2[4] = vfilter[2][0];
assign  col_2[5] = 0;
assign  col_2[6] = vfilter[1][2];
assign  col_2[7] = vfilter[1][1];
assign  col_2[8] = vfilter[1][0];
assign  col_2[9] = 0;
assign  col_2[10] = vfilter[0][2];
assign  col_2[11] = vfilter[0][1];
assign  col_2[12] = vfilter[0][0];



reg zero = 0;
integer lop = 0;
output reg[2:0] state;
reg[2:0] next_state;


parameter S0=0,S1=1,S2=2,S3=3,S4=4,last=5;


reg [7:0] ia00,ia01,ia11,ia20;

wire c1,c2,c3,c4;
pe_module pe0(.clk(clk),.a(ia00),.b(ia01),.rst(rst),.val(out_c_0),.a_out(a_out_0),.b_out(b_out_0),.block(block),.db(1),.c(c1));
pe_module pe1(.clk(clk),.a(a_out_0),.b(ia11),.rst(rst),.val(out_c_1),.a_out(a_out_1),.b_out(b_out_1),.block(block),.db(0),.c(c2));
pe_module pe2(.clk(clk),.a(ia20),.b(b_out_0),.rst(rst),.val(out_c_2),.a_out(a_out_2),.b_out(b_out_2),.block(block),.db(0),.c(c3));
pe_module pe3(.clk(clk),.a(a_out_2),.b(b_out_1),.rst(rst),.val(out_c_3),.a_out(a_out_3),.b_out(b_out_3),.block(block),.db(0),.c(c4));

initial begin
    state = S0;
    next_state = S0;      
    block = 1'b1;   
    ia00=0; ia01 =0; ia11=0; ia20 =0;
    
    /*
    
assign row_1 = {0, vin[2][3], vin[2][2], vin[2][1], vin[2][0], vin[1][3], vin[1][2], vin[1][1], vin[1][0], vin[0][3], vin[0][2], vin[0][1], vin[0][0]};
assign row_2 = {vin[3][3], vin[3][2], vin[3][1], vin[3][0], vin[2][3], vin[2][2], vin[2][1], vin[2][0], vin[1][3], vin[1][2], vin[1][1], vin[1][0], 0};
assign col_1 = {0,0, vfilter[0][0], vfilter[0][1], vfilter[0][2], 0, vfilter[1][0], vfilter[1][1], vfilter[1][2], 0, vfilter[2][0], vfilter[2][1], vfilter[2][2]};
assign col_2 = {vfilter[0][0], vfilter[0][1], vfilter[0][2], 0, vfilter[1][0], vfilter[1][1], vfilter[1][2], 0, vfilter[2][0], vfilter[2][1], vfilter[2][2], 0, 0};
    */
    
end


always @(posedge clk)
   begin
      if(rst == 1'b1) begin         
         state <= S0;
         next_state <= S0;
      end
      
      else state <= next_state;
   end

always@(*) begin
  
  state = next_state;

    case(state) 
        S0: begin
            block = 1'b1;
            next_state = S1;            
        end
        S1: begin             
            ia00 =row_1[lop];  ia01 = col_1[lop]; ia11=col_2[lop]; ia20=row_2[lop];
            next_state = S2;
        end
        S2: begin 
            block = 1'b0;
            lop = lop + 1;            
            next_state = S3;
            c1 = 0; c2= 0; c3=0; c4=0;
        end
        S3: begin 
            if(c1 == 1'b1 && c2 == 1'b1 && c3 == 1'b1 && c4 == 1'b1) begin 
            next_state = S4;            
            end
        end
        S4: begin
            if(lop==13) next_state=last;
            else next_state = S0;
        end
        last: begin 
            block = 1'b1;
            next_state = last;
        end
        
    endcase    

end

        
endmodule