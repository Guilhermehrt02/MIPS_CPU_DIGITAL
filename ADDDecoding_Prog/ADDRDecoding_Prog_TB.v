`timescale 1ns/1ps

module ADDRDecoding_Prog_TB;

    reg [31:0] address;
    reg Clk;
    wire cs;
    
    // Instanciação do módulo ADDRDecoding_Prog
    ADDRDecoding_Prog uut (
        .adress(address),
        .Clk(Clk),
        .cs(cs)
    );
    
    // Geração do sinal de clock
    initial begin
        Clk = 0;
        forever #5 Clk = ~Clk; // Período de clock de 10 ns
    end
    
    // Teste de entrada
    initial begin
        // Teste com um endereço fora do intervalo
        address = 32'h0000172F;
        #10;
        
        // Teste com um endereço no início do intervalo
        address = 32'h00001030;
        #10;
        
        // Teste com um endereço dentro do intervalo
        address = 32'h00001130;
        #10;
        
        // Teste com um endereço no final do intervalo
        address = 32'h0000142F;
        #10;
        
        // Teste com um endereço fora do intervalo
        address = 32'h00001B30;
        #10;
        
        // Termina a simulação
        $stop;
    end
endmodule
