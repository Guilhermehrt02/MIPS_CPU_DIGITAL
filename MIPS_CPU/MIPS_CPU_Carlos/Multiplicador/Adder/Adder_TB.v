module Adder_TB();

    reg [15:0] OperandoA;
    reg [15:0] OperandoB;
    wire [16:0] Soma;

    // Instanciação do módulo Adder
    Adder uut (
        .Soma(Soma),
        .OperandoA(OperandoA),
        .OperandoB(OperandoB)
    );

    initial begin
        // Inicialização
        $dumpfile("Adder_tb.vcd");
        $dumpvars(0, Adder_tb);

        // Teste 1: Soma simples
        OperandoA = 16'd10;
        OperandoB = 16'd20;
        #10;
        if (Soma !== 17'd30) $display("Erro na soma simples! Esperado: 30, Obtido: %d", Soma);

        // Teste 2: Soma com overflow
        OperandoA = 16'hFFFF; // 65535
        OperandoB = 16'd1;
        #10;
        if (Soma !== 17'd65536) $display("Erro na soma com overflow! Esperado: 65536, Obtido: %d", Soma);

        // Teste 3: Soma com zeros
        OperandoA = 16'd0;
        OperandoB = 16'd0;
        #10;
        if (Soma !== 17'd0) $display("Erro na soma com zeros! Esperado: 0, Obtido: %d", Soma);

        // Teste 4: Soma com valores máximos
        OperandoA = 16'h7FFF; // 32767
        OperandoB = 16'h7FFF; // 32767
        #10;
        if (Soma !== 17'd65534) $display("Erro na soma com valores máximos! Esperado: 65534, Obtido: %d", Soma);

        $display("Testbench concluído.");
        $finish;
    end

endmodule
