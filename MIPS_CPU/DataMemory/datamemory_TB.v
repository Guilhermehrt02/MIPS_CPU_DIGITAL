`timescale 1ns / 1ps

module datamemory_TB;

    // Parâmetros
    parameter SIZE = 32;

    // Sinais de clock e reset
    reg clk;
    reg reset;

    // Sinais de controle
    reg WR_RD;
    reg cs;
    reg [SIZE-1:0] ADDR;
    reg [SIZE-1:0] din;

    // Sinais de saída
    wire [SIZE-1:0] dout;

    // Instância do módulo DataMemory
    datamemory DUT(
        .clk(clk),
        .WR_RD(WR_RD),
        .cs(cs),
        .ADDR(ADDR),
        .din(din),
        .dout(dout)
    );

    // Clock generation
    always begin
        #5 clk = ~clk; // Inverte o clock a cada 5 unidades de tempo
    end

    // Teste de escrita e leitura
    initial begin
        // Inicializações
        clk = 0;
        reset = 0;
        WR_RD = 1;
        cs = 0;
        ADDR = 0;
        din = 0;

        // Aguarda um pouco
        #10;

        // Teste de leitura
        cs = 1;
        WR_RD = 1;
        ADDR = 10'h000; // Endereço para leitura de A
        #10;

        ADDR = 10'h001; // Endereço para leitura de B
        #10;

        ADDR = 10'h002; // Endereço para leitura de C
        #10;

        ADDR = 10'h003; // Endereço para leitura de D
        #10;

        // Teste de escrita
        WR_RD = 0;
        cs = 1;
        ADDR = 10'h000; // Endereço para escrever em A
        din = 32'hABCDEFFF; // Dados para escrever em A
        #10;

        WR_RD = 0;
        cs = 1;
        ADDR = 10'h001; // Endereço para escrever em B
        din = 32'h12345678; // Dados para escrever em B
        #10;

        WR_RD = 0;
        cs = 1;
        ADDR = 10'h002; // Endereço para escrever em C
        din = 32'h98765432; // Dados para escrever em C
        #10;

        WR_RD = 0;
        cs = 1;
        ADDR = 10'h003; // Endereço para escrever em D
        din = 32'hAAAA5555; // Dados para escrever em D
        #10;

        // Teste de leitura após escrita
        WR_RD = 1;
        cs = 1;
        ADDR = 10'h000; // Endereço para leitura de A após escrita
        #10;

        ADDR = 10'h001; // Endereço para leitura de B após escrita
        #10;

        ADDR = 10'h002; // Endereço para leitura de C após escrita
        #10;

        ADDR = 10'h003; // Endereço para leitura de D após escrita
        #10;
        
        // Finaliza a simulação
        $finish;
    end

endmodule
