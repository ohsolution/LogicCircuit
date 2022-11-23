`timescale 1ns/10ps

module TB_TOP ();

    // parameters, which can be overidden externally
    parameter   CLOCK_PERIOD        = 1.0;	// 1ns

    parameter   ADDR_WIDTH          = 12,
                DATA_WIDTH          = 32;

    parameter   CONFIG_SINGLE       = 0,
                CONFIG_MULTI        = 1;
    parameter   CONFIG              = CONFIG_SINGLE ; // choose one of (CONFIG_SINGLE / CONFIG_MULTI)
    // local parameters, which cannot be overidden
    localparam  SRAM_CNT            = (CONFIG==CONFIG_SINGLE) ? 1 : 4;

    //----------------------------------------------------------
    // clock and reset generation
    //----------------------------------------------------------
    reg clk;
    reg rst_n;

    // clock generation
    initial begin
        clk         = 1'b0;
		forever
        	#(CLOCK_PERIOD/2) clk = ~clk;
    end

    // reset generation
    initial begin
        rst_n       = 1'b0;
        #(CLOCK_PERIOD*2);
        rst_n       = 1'b1; // release the reset after 2 cycles
    end

    // set a timeout for simulation
    initial begin
        // dump all signals
        $dumpfile("./mydump.vcd");
        $dumpvars(0, TB_TOP);

        // after 1,000,000 cycle, terminate the simulation
        #1000000;
        $display("Simulaion Timeout");
        $finish;
    end

    reg     [DATA_WIDTH-1:0]    cs_MC_o;
    wire                        addr_valid, addr_ready;
    wire    [ADDR_WIDTH-1:0]    addr;
    wire                        data_valid, data_ready;
    wire    [DATA_WIDTH-1:0]    data;
    wire    [3:0]               sram_ce_n;
    wire    [3:0]               sram_oe_n;
    wire    [ADDR_WIDTH-3:0]    sram_addr[3:0];
    wire    [DATA_WIDTH-1:0]    sram_data;

    //----------------------------------------------------------
    // Driver
    //----------------------------------------------------------
    Driver  #(
        .ADDR_WIDTH             (ADDR_WIDTH),
        .DATA_WIDTH             (DATA_WIDTH)
    )
    u_driver
    (
        .clk                    (clk),
        .rst_n                  (rst_n),
        // address interface
        .addr_valid_o           (addr_valid),
        .addr_ready_i           (addr_ready),
        .addr_o                 (addr),
        // data interface
        .data_valid_i           (data_valid),
        .data_ready_o           (data_ready),
        .data_i                 (data)
    );

	// configure parameters based on the configuration
	defparam 	u_driver.TEST_CNT 	= (CONFIG==CONFIG_SINGLE)
									  ? 2048 : 8192;
	defparam	u_driver.ADDR_FILE 	= (CONFIG==CONFIG_SINGLE)
									  ? "C:/RTL/rtl/single_address.txt"
									  : "C:/RTL/rtl/address.txt";
	defparam	u_driver.ANS_FILE 	= (CONFIG==CONFIG_SINGLE)
									  ? "C:/RTL/rtl/single_ans.txt"
									  : "C:/RTL/rtl/ans.txt";
    
    //----------------------------------------------------------
    // design under test
    //----------------------------------------------------------
    generate
        if (CONFIG == CONFIG_SINGLE) begin: gen_MC
            SingleSRAMController #(
                .ADDR_WIDTH     (ADDR_WIDTH),
                .DATA_WIDTH     (DATA_WIDTH)
            )
            u_dut
            (
                .clk            (clk),
                .rst_n          (rst_n),
                // address interface
                .addr_valid_i   (addr_valid),
                .addr_ready_o   (addr_ready),
                .addr_i         (addr),
                // data interface
                .data_o         (data),
                .data_valid_o   (data_valid),
                .data_ready_i   (data_ready),
                // SRAM interfaces
                .sram_ce_n      (sram_ce_n),
                .sram_oe_n      (sram_oe_n),
                .sram_addr      (sram_addr),
                .sram_data      (sram_data)
            );
        end
        else if (CONFIG == CONFIG_MULTI) begin
            MultiSRAMController #(
                .ADDR_WIDTH     (ADDR_WIDTH),
                .DATA_WIDTH     (DATA_WIDTH)
            )
            u_dut
            (
                .clk            (clk),
                .rst_n          (rst_n),
                // address interface
                .addr_valid_i   (addr_valid),
                .addr_ready_o   (addr_ready),
                .addr_i         (addr),
                // data interface
                .data_o         (data),
                .data_valid_o   (data_valid),
                .data_ready_i   (data_ready),
                // SRAM interfaces
                .sram_ce_n      (sram_ce_n),
                .sram_oe_n      (sram_oe_n),
                .sram_addr      (sram_addr),
                .sram_data      (sram_data)
            );
        end
    endgenerate

    //----------------------------------------------------------
    // SRAMs
    //----------------------------------------------------------
    

    SRAM #(
        .SRAM_DATA_WIDTH    (DATA_WIDTH),
        .SRAM_ADDR_WIDTH    (ADDR_WIDTH-2),
        .DATA_FILE          ("C:/RTL/rtl/memory0.bin")
    )
    u_sram0
    (
        .sram_addr_in       (sram_addr[0]),
        .oe_n               (sram_oe_n[0]),
        .ce_n               (sram_ce_n[0]),
        .sram_data_out      (sram_data)
    );

    SRAM #(
        .SRAM_DATA_WIDTH    (DATA_WIDTH),
        .SRAM_ADDR_WIDTH    (ADDR_WIDTH-2),
        .DATA_FILE          ("C:/RTL/rtl/memory1.bin")
    )
    u_sram1
    (
        .sram_addr_in       (sram_addr[1]),
        .oe_n               (sram_oe_n[1]),
        .ce_n               (sram_ce_n[1]),
        .sram_data_out      (sram_data)
    );

    SRAM #(
        .SRAM_DATA_WIDTH    (DATA_WIDTH),
        .SRAM_ADDR_WIDTH    (ADDR_WIDTH-2),
        .DATA_FILE          ("C:/RTL/rtl/memory2.bin")
    )
    u_sram2
    (
        .sram_addr_in       (sram_addr[2]),
        .oe_n               (sram_oe_n[2]),
        .ce_n               (sram_ce_n[2]),
        .sram_data_out      (sram_data)
    );

    SRAM #(
        .SRAM_DATA_WIDTH    (DATA_WIDTH),
        .SRAM_ADDR_WIDTH    (ADDR_WIDTH-2),
        .DATA_FILE          ("C:/RTL/rtl/memory3.bin")
    )
    u_sram3
    (
        .sram_addr_in       (sram_addr[3]),
        .oe_n               (sram_oe_n[3]),
        .ce_n               (sram_ce_n[3]),
        .sram_data_out      (sram_data)
    );


endmodule
