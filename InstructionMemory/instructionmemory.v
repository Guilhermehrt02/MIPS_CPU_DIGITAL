module instructionmemory(Clk, adress, outInstruction);
    input Clk;
    input [9:0] adress;
    output reg [31:0] outInstruction;

    parameter numLinhas = 1024;
    parameter numBits = 32;

    reg [numBits-1:0] M [0: (1 << $clog2(numLinhas)) -1];

    integer i; // Declarar o inteiro fora do bloco initial

    // Carrega as instruções na memória
    initial begin
        // Load A
        M[0] = 32'b00100001111000000001000000110000; // LW $t7, 0x1030 ($zero)
        // Load B
        M[1] = 32'b00100001111000010001000000110001; // LW $t7, 0x1031 ($zero)
        // Load C
        M[2] = 32'b00100001111000100001000000110010; // LW $t7, 0x1032 ($zero)
        // Load D
        M[3] = 32'b00100001111000110001000000110011; // LW $t7, 0x1033 ($zero)
        // Store result
        M[4] = 32'b00100101111001100001010000101111; // STR $t7, 0x142F ($zero)
        // B - A
        M[5] = 32'b00011100001000000010001010100010; // SUB $t4, $t1, $t0
        // C - D
        M[6] = 32'b00011100010000110010101010100010; // SUB $t5, $t2, $t3
        // (B - A) * (C - D)
        M[7] = 32'b00011100100001010011001010110010; // MUL $t6, $t4, $t5
        // Add (demonstrativo)
        M[8] = 32'b00011100000000000010001010100000; // ADD $t4, $zero, $zero
        // And (demonstrativo)
        M[9] = 32'b00011100000000000010001010100100; // AND $t4, $zero, $zero
        // Or (demonstrativo)
        M[10] = 32'b00011100000000000010001010100101; // OR $t4, $zero, $zero
        // Preenche o restante da memória com zeros
        for (i = 11; i < (1 << $clog2(numLinhas)); i = i + 1) begin
            M[i] = 32'b0;
        end
    end

    always @(posedge Clk) begin
        outInstruction = M[adress];
    end

endmodule
