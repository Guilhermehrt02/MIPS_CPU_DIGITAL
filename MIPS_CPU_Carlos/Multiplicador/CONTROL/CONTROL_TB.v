module CONTROL_TB();

    reg St;
    reg Clk;
    reg M;
    reg K;
    reg Rst;
    wire Idle;
    wire Done;
    wire Load;
    wire Sh;
    wire Ad;

    // Instanciação do módulo CONTROL
    CONTROL uut (
        .Idle(Idle),
        .Done(Done),
        .Load(Load),
        .Sh(Sh),
        .Ad(Ad),
        .St(St),
        .Clk(Clk),
        .M(M),
        .K(K),
        .Rst(Rst)
    );

    // Geração de clock
    always #5 Clk = ~Clk;

    initial begin
        // Inicialização
        $dumpfile("CONTROL_tb.vcd");
        $dumpvars(0, CONTROL_tb);

        Clk = 0;
        St = 0;
        M = 0;
        K = 0;
        Rst = 0;

        // Reset
        Rst = 1;
        #10;
        Rst = 0;
        #10;

        // Teste 1: Reset
        if (Idle !== 1 || Done !== 0 || Load !== 0 || Sh !== 0 || Ad !== 0) $display("Erro no estado inicial!");

        // Teste 2: St = 1, verifica transição para S1
        St = 1;
        #10;
        if (Idle !== 0 || Done !== 0 || Load !== 1 || Sh !== 0 || Ad !== 0) $display("Erro na transição para S1!");

        // Teste 3: M = 1, verifica transição para S2
        St = 0;
        M = 1;
        #10;
        if (Idle !== 0 || Done !== 0 || Load !== 0 || Sh !== 1 || Ad !== 1) $display("Erro na transição para S2!");

        // Teste 4: K = 1, verifica transição para S3
        M = 0;
        K = 1;
        #10;
        if (Idle !== 0 || Done !== 1 || Load !== 0 || Sh !== 0 || Ad !== 0) $display("Erro na transição para S3!");

        // Teste 5: Retorno ao estado inicial
        K = 0;
        #10;
        if (Idle !== 1 || Done !== 0 || Load !== 0 || Sh !== 0 || Ad !== 0) $display("Erro no retorno ao estado inicial!");

        $display("Testbench concluído.");
        $finish;
    end

endmodule
