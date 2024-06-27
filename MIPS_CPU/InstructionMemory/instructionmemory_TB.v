`timescale 1ns / 1ps

module instructionmemory_TB;

    // Parameters
    parameter data_WIDTH = 32;
    parameter ADDR_WIDTH = 10;

    // Inputs
    reg [ADDR_WIDTH-1:0] ADDR_Prog;
    reg clk;

    // Outputs
    wire [data_WIDTH-1:0] dataOut;

    // Instantiate the Unit Under Test (UUT)
    instructionmemory #(
        .data_WIDTH(data_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) uut (
        .ADDR_Prog(ADDR_Prog),
        .clk(clk),
        .dataOut(dataOut)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10 ns period
    end

    // Test sequence
    initial begin
        // Initialize Inputs
        ADDR_Prog = 0;

        // Wait for global reset to finish
        #100;
        
        // Test each memory location
        $display("Starting test...");

        // Test memory addresses 0 to 15
		  integer i;
        for (i = 0; i < 16; i = i + 1) begin
            ADDR_Prog = i;
            #10; // wait for one clock cycle
            $display("ADDR_Prog = %d, dataOut = %b", ADDR_Prog, dataOut);
        end

        $display("Test completed.");
        $stop;
    end

endmodule
