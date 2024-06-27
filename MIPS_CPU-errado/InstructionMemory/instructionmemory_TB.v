module instructionmemory_TB;
  // Parameters
  parameter DATA_WIDTH = 32;
  parameter ADDR_WIDTH = 10;

  // Inputs
  reg [ADDR_WIDTH-1:0] address;
  reg clk;

  // Outputs
  wire [DATA_WIDTH-1:0] dataOut;

  // Instantiate the Unit Under Test (UUT)
  instructionmemory #(DATA_WIDTH, ADDR_WIDTH) uut (
    .address(address), 
    .clk(clk), 
    .dataOut(dataOut)
  );

  initial begin
    // Initialize Inputs
    address = 0;
    clk = 0;

    // Wait for the global reset
    #10;
    
    // Stimulus
    address = 0; #10; // Expect dataOut to be 32'b001000_01111_00000_0001_0000_0011_0000
    address = 1; #10; // Expect dataOut to be 32'b001000_01111_00001_0001_0000_0011_0001
    address = 2; #10; // Expect dataOut to be 32'b001000_01111_00010_0001_0000_0011_0010
    address = 3; #10; // Expect dataOut to be 32'b001000_01111_00011_0001_0000_0011_0011
    address = 4; #10; // Expect dataOut to be 32'b000111_00001_00000_00100_01010_100010
    address = 5; #10; // Expect dataOut to be 32'b000111_00010_00011_00101_01010_100010
    address = 6; #10; // Expect dataOut to be 32'b000111_00100_00101_00110_01010_110010
    address = 7; #10; // Expect dataOut to be 32'b001001_01111_00110_0001_0100_0010_1111
    
    // Continue for other addresses as needed

    // Finish simulation
    $finish;
  end

  // Clock generation
  always #5 clk = ~clk;

  // Monitor changes
  initial begin
    $monitor("At time %t, address = %h, dataOut = %h", $time, address, dataOut);
  end

endmodule
