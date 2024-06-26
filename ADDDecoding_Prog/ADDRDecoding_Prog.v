module ADDRDecoding_Prog(
    input [31:0] adress,
    input Clk,
    output reg cs
);
    always @(posedge Clk) begin
        // Verifica se o endereço está entre 0x1030 (inicio do intervalo de memoria grupo(7)*250h) e 0x142F (inicio + 1kword(1023))
        if ((adress >= 32'h00001030) && (adress <= 32'h0000142F))
            cs <= 0;  // Habilita memória interna
        else
            cs <= 1;  // Habilita memória externa
    end
endmodule
