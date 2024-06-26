module Counter_TB();

    reg Load;
    reg Clk;
    wire K;

    // Instanciação do módulo Counter
    Counter uut (
        .Load(Load),
        .Clk(Clk),
        .K(K)
    );

    // Geração de clock
    always #5 Clk = ~Clk;

    initial begin
        // Inicialização
        $dumpfile("Counter_tb.vcd");
        $dumpvars(0, Counter_tb);

        Clk = 0;
        Load = 0;

        // Teste 1: Reset com Load
        Load = 1;
        #10;
        if (K !== 0) $display("Erro no reset com Load!");

        // Teste 2: Contagem até 30
        Load = 0;
        #150;
        if (K !== 1) $display("Erro na contagem até 30!");

        // Teste 3: Reset novamente com Load
        Load = 1;
        #10;
        if (K !== 0) $display("Erro no reset com Load!");

        // Teste 4: Contagem parcial (menor que 30)
        Load = 0;
        #100;
        if (K !== 0) $display("Erro na contagem parcial!");

        $display("Testbench concluído.");
        $finish;
    end

endmodule
