`timescale 1ns/1ps
module ADDRDecoding_TB;

    reg [31:0] adress;
    reg Clk;
    wire cs;
    
    // Instanciação do módulo ADDRDecoding
    ADDRDecoding uut (
        .adress(adress),
        .Clk(Clk),
        .cs(cs)
    );
    
    // Geração do sinal de clock
    initial begin
        Clk = 0;
        forever #5 Clk = ~Clk; // Período de clock de 10 ns
    end
    
    initial begin
        // Teste com um endereço fora do intervalo
        adress = 32'h0000172F;
        #10;
        
        // Teste com um endereço no início do intervalo
        adress = 32'h00001730;
        #10;
        
        // Teste com um endereço dentro do intervalo
        adress = 32'h00001800;
        #10;
        
        // Teste com um endereço no final do intervalo
        adress = 32'h00001B2F;
        #10;
        
        // Teste com um endereço fora do intervalo
        adress = 32'h00001B30;
        #10;
        
        // Termina a simulação
        $stop;
    end
endmodule
