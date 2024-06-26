`timescale 1ns/10ps

module instructionmemory_TB();
    reg Clk;
    reg [9:0] adress;
    wire [31:0] outInstruction;

    // Instância do módulo instructionmemory
    instructionmemory DUT(
        .Clk(Clk),
        .adress(adress),
        .outInstruction(outInstruction)
    );

    // Geração do clock
    initial begin
        Clk = 0;
        forever #5 Clk = ~Clk; // Período de clock de 10 ns
    end

    // Teste das instruções
    initial begin
        // Inicializa o endereço
        adress = 0;
        
        // A cada 10 unidades de tempo, incrementa o endereço para ler a próxima instrução
        #10 adress = 10'h000;
        
        #10 adress = 10'h001;
        
        #10 adress = 10'h002;
        
        #10 adress = 10'h003;
        
        #10 adress = 10'h004;
        
        #10 adress = 10'h005;
        
        #10 adress = 10'h006;
        
        
        #10 adress = 10'h007;
        
        
        #10 adress = 10'h008;
        
        
        #10 adress = 10'h009;
        
        
        #10 adress = 10'h00A;
       
        
        // Testa endereço fora do intervalo das instruções definidas
        #10 adress = 10'h00B;
    
        
        // Termina a simulação
        #10 $finish;
    end
endmodule
