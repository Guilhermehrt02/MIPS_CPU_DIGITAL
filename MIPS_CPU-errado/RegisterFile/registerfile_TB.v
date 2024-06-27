`timescale 1ns/10ps

module registerfile_TB();
    reg Clk;
    reg reset;
    reg we;
    reg [3:0] addressA;
    reg [3:0] addressB;
    reg [3:0] addressIn;
    reg [31:0] regIn;
    wire [31:0] A;
    wire [31:0] B;
    
    registerfile DUT (
        .Clk(Clk),
        .reset(reset),
        .we(we),
        .addressA(addressA),
        .addressB(addressB),
        .addressIn(addressIn),
        .regIn(regIn),
        .A(A),
        .B(B)
    );
    
    initial begin
        Clk = 0;
        forever #10 Clk = ~Clk;
    end
    
    initial begin
        reset = 0;
        #10 reset = 1;
        #10 reset = 0;
        
        // Escrever nos registradores
        we = 0;
        addressIn = 4'b0011;
        regIn = 32'hABABFFFF;//escreve em s3 esse valor
        #20;
        
        addressIn = 4'b0101;
        regIn = 32'h15161718;//escreve em s5 esse valor
        #20;
        
        addressIn = 4'b1111;
        regIn = 32'h0045AB7F;//escreve em t7 esse valor
        #20;
        
        // Ler dos registradores
        we = 1;
        addressA = 4'b0011; // valor de s3
        addressB = 4'b0100; // Este não foi escrito, deve ser 0
        #20;
        
        addressA = 4'b0001; // Este não foi escrito, deve ser 0
        addressB = 4'b1111; // valor de t7
        #20;
        
        addressA = 4'b1111; // valor de t7
        addressB = 4'b0101; // valor de r3
        #20;
        
        $stop;
    end
endmodule
