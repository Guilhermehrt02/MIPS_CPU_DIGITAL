module ACC_TB();

    reg [32:0] Entradas;
    reg Load;
    reg Sh;
    reg Ad;
    reg Clk;
    reg Rst;
    wire [32:0] Saidas;

    // Instanciação do módulo ACC
    ACC uut (
        .Saidas(Saidas),
        .Entradas(Entradas),
        .Load(Load),
        .Sh(Sh),
        .Ad(Ad),
        .Clk(Clk),
        .Rst(Rst)
    );

    // Geração de clock
    always #5 Clk = ~Clk;

    initial begin
        // Inicialização
        $dumpfile("ACC_tb.vcd");
        $dumpvars(0, ACC_tb);

        Clk = 0;
        Load = 0;
        Sh = 0;
        Ad = 0;
        Rst = 0;
        Entradas = 33'b0;

        // Reset
        Rst = 1;
        #10;
        Rst = 0;
        #10;
        if (Saidas !== 33'b0) $display("Erro no reset!");

        // Teste 1: Load
        Entradas = 33'h1FFFF; // 17 bits de valor
        Load = 1;
        #10;
        Load = 0;
        if (Saidas[15:0] !== 16'hFFFF || Saidas[32:16] !== 17'b0) $display("Erro no Load! Esperado: 0x0001FFFF, Obtido: 0x%h", Saidas);

        // Teste 2: Ad
        Entradas = 33'h1FFFF0000; // 17 bits de valor
        Ad = 1;
        #10;
        Ad = 0;
        if (Saidas[32:16] !== 17'h1FFFF) $display("Erro no Ad! Esperado: 0x1FFFF0000, Obtido: 0x%h", Saidas);

        // Teste 3: Sh
        Sh = 1;
        #10;
        Sh = 0;
        if (Saidas !== {1'b0, 32'h0FFFF8000}) $display("Erro no Sh! Esperado: 0x0FFFF8000, Obtido: 0x%h", Saidas);

        // Teste 4: Combinado (Load e Sh)
        Entradas = 33'h1FFFF;
        Load = 1;
        #10;
        Load = 0;
        Sh = 1;
        #10;
        Sh = 0;
        if (Saidas !== {1'b0, 16'hFFFF, 16'b0}) $display("Erro no Load e Sh combinado! Esperado: 0x0000FFFF, Obtido: 0x%h", Saidas);

        $display("Testbench concluído.");
        $finish;
    end

endmodule
