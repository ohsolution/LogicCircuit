module SingleSRAMController
#(
    parameter                   ADDR_WIDTH  = 12,
                                DATA_WIDTH  = 32
 )
(
    input                       clk,
    input                       rst_n,
    // address interface
    input                       addr_valid_i,
    output                      addr_ready_o,
    input   [ADDR_WIDTH-1:0]    addr_i,
    // data interface
    output                      data_valid_o,
    input                       data_ready_i,
    output  [DATA_WIDTH-1:0]    data_o,
    // SRAM interfaces
    output  reg [3:0]           sram_ce_n,
    output  reg [3:0]           sram_oe_n,
    output  [ADDR_WIDTH-3:0]	sram_addr[3:0],
    input   [DATA_WIDTH-1:0]    sram_data
);

    // FSM's state
    parameter [1:0]             S_IDLE      = 2'b00,
                                S_ACCESS1   = 2'b01,
                                S_ACCESS2   = 2'b10,
                                S_DATA      = 2'b11;
    ///////////////////////////////////////////////////////////////////// 
    ///////////////////////// Your Code below here /////////////////////
    ////////////////////////////////////////////////////////////////////
    reg [1:0] NS,CS;
    reg [3:0] count1,count2;
    reg AREADY,DVALID,CE,OE,check;
    reg [DATA_WIDTH -1:0] t_data;
    reg [ADDR_WIDTH -3:0] t_addr;
    initial begin
        NS=0;
        CS=0;
        count1=0;
        count2=0;
        AREADY=1;
        DVALID=0;
        CE=1;
        OE=1;
        check=0;
    end
    assign addr_ready_o = AREADY;
    assign data_valid_o = DVALID ;
    assign sram_ce_n = {3'b111,CE};
    assign sram_oe_n = {3'b111,OE};
    assign data_o = t_data;
    assign sram_addr[0] = t_addr ;
    always @(posedge clk or negedge rst_n ) begin 
        if(!rst_n) CS<=0;
        else CS<=NS; 
    end
 
    always @(*)begin
        NS=CS;
        CE=0;   
        OE=0;   
        case(CS) 
            S_IDLE :begin
                check=0;            
                AREADY  = 1;
                DVALID  = 0;
                if(addr_valid_i) begin
                    t_addr = addr_i[ADDR_WIDTH -3:0];
                    NS=S_ACCESS1 ;
                end
            end
            S_ACCESS1: begin
                AREADY  = 0;
                DVALID  = 0;  
                if(count1 >=5 && check==1) begin 
                    NS=S_ACCESS2 ;
                    check=0;
                end
                else if(count1>=6) NS=S_ACCESS2;
            end
            S_ACCESS2: begin
                AREADY  = 0;
                if(count2 ==2)begin
                    AREADY =0;
                    NS= S_DATA ;
                    if(data_ready_i ==1 && addr_valid_i==1) begin
                        t_addr =addr_i[ADDR_WIDTH -3:0];
                        AREADY =1;
                    end    
                    t_data = sram_data;
                    DVALID =1;
                end               
            end
            S_DATA: begin
                if( AREADY ==1) begin
                    NS=S_ACCESS1 ;
                    check=1;
                 end
                else if(check!=1 && data_ready_i) NS=S_IDLE ;
                AREADY  = 0;
                DVALID  = 0;
            end
        endcase    
    end
    
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n) begin
            count1<=0;
            count2<=0;
        end
        else if(CS==S_ACCESS1)begin
            count1<=count1+1;
            count2<=0;
        end
        else if(CS==S_ACCESS2)begin
            count2<=count2+1;
            count1<=0;
        end
        else begin
            count1<=0;
            count2<=0;
        end
    end
 
    
    ///////////////////////////////////////////////////////////////////// 
    ///////////////////////// Your Code upward here /////////////////////
    ////////////////////////////////////////////////////////////////////

endmodule
