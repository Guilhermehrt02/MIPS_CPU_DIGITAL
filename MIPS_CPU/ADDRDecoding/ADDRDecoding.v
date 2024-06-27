module ADDRDecoding(
    input [31:0] adress,
    input Clk,
    output reg cs
);
    always @(posedge Clk) begin
        // Verifica se o endereço está entre 0x1730 (inicio do intervalo de memoria grupo(7)*350h) e 0x1B2F (inicio + 1kword(1023))
        if ((adress >= 32'h00001730) && (adress <= 32'h00001B2F))
            cs <= 0;  // Habilita memória interna
        else
            cs <= 1;  // Habilita memória externa
    end
endmodule
