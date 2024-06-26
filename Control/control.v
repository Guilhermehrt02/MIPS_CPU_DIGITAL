module control(instructionIn, controlOut);
	input [31:0] instructionIn;
	output reg [19:0] controlOut;
	
	reg selectMux01;
	reg selectMux02;
	reg selectMux03;
	reg [1:0] selectALU;
	reg weRAM;
	reg weRegFile;
	reg startMultiplicador;
	reg [3:0] addressRS;
	reg [3:0] addressRT;
	reg [3:0] addressRD;
	
	wire [5:0] codFunction;
	wire [5:0] codOperation;
	
	parameter LW = 3, SW = 4, OpMat = 2; //Parametros de codOperation
	parameter ADD = 32, SUB = 34, MUL = 50, AND = 36, OR = 37; // Parametros de codFunction
	
	assign codFunction = instructionIn[5:0];
	assign codOperation = instructionIn[31:26];
	
	always@(instructionIn)
	begin
		case (codOperation)
			LW:
			begin
				selectMux01 = 1; //Select IMM - Chanel 2 MUX01
				selectMux02 = 1; //Select ALU - Chanel 2 MUX02
				selectMux03 = 1; //Select M - Chanel 2 MUX03
				selectALU = 0; //Select soma Na ALU
				weRAM = 1; //Select Leitura memoria
				weRegFile = 1; //Select Escrita memoria reg file
				startMultiplicador = 0; //Multiplicador desligado
				
				addressRS = instructionIn[24:21]; //resgata address RS 
				addressRT = instructionIn[19:16]; //resgata address RT
				addressRD = instructionIn[19:16]; //Por ser instrucao do tipo I, o RT é o meu destino, logo inseri ele no RD tambem
			end
			
			SW:
			begin
				selectMux01 = 1; //Select IMM - Chanel 2 MUX01
				selectMux02 = 1; //Select ALU - Chanel 2 MUX02
				selectMux03 = 1; //Select M - Chanel 2 MUX03
				selectALU = 0; //Select soma Na ALU
				weRAM = 0; //Select Escrita memoria
				weRegFile = 0; //Select Leitura memoria reg file
				startMultiplicador = 0; //Multiplicador desligado
				
				addressRS = instructionIn[24:21]; //resgata address RS 
				addressRT = instructionIn[19:16]; //resgata address RT
				addressRD = instructionIn[19:16]; //Por ser instrucao do tipo I, o RT é o meu destino, logo inseri ele no RD tambem
			end
			
			OpMat:
			begin
				addressRS = instructionIn[24:21]; //resgata address RS 
				addressRT = instructionIn[19:16]; //resgata address RT
				addressRD = instructionIn[14:11]; //resgata address RD
			
				case (codFunction)
					ADD:
					begin
						selectMux01 = 0; //Select B - Chanel 1 MUX01
						selectMux02 = 1; //Select ALU - Chanel 2 MUX02
						selectMux03 = 0; //Select D - Chanel 1 MUX03
						selectALU = 0; //Select soma Na ALU
						weRAM = 1; //Select Leitura memoria
						weRegFile = 1; //Select Escrita memoria reg file
						startMultiplicador = 0; //Multiplicador desligado
					end
					
					SUB:
					begin
						selectMux01 = 0; //Select B - Chanel 1 MUX01
						selectMux02 = 1; //Select ALU - Chanel 2 MUX02
						selectMux03 = 0; //Select D - Chanel 1 MUX03
						selectALU = 1; //Select subtracao Na ALU
						weRAM = 1; //Select Leitura memoria
						weRegFile = 1; //Select Escrita memoria reg file
						startMultiplicador = 0; //Multiplicador desligado
					end
					
					MUL:
					begin
						selectMux01 = 0; //Select B - Chanel 1 MUX01
						selectMux02 = 0; //Select Multiplicador - Chanel 1 MUX02
						selectMux03 = 0; //Select D - Chanel 1 MUX03
						selectALU = 0; //Select soma Na ALU
						weRAM = 1; //Select Leitura memoria
						weRegFile = 1; //Select Escrita memoria reg file
						startMultiplicador = 1; //Multiplicador ligado
					end
					
					AND:
					begin
						selectMux01 = 0; //Select B - Chanel 1 MUX01
						selectMux02 = 1; //Select ALU - Chanel 2 MUX02
						selectMux03 = 0; //Select D - Chanel 1 MUX03
						selectALU = 2; //Select AND Na ALU
						weRAM = 1; //Select Leitura memoria
						weRegFile = 1; //Select Escrita memoria reg file
						startMultiplicador = 0; //Multiplicador desligado
					end
					
					OR:
					begin
						selectMux01 = 0; //Select B - Chanel 1 MUX01
						selectMux02 = 1; //Select ALU - Chanel 2 MUX02
						selectMux03 = 0; //Select D - Chanel 1 MUX03
						selectALU = 3; //Select OR Na ALU
						weRAM = 1; //Select Leitura memoria
						weRegFile = 1; //Select Escrita memoria reg file
						startMultiplicador = 0; //Multiplicador desligado
					end
					
				endcase//end case codFunction
				
			end //
			
			default:
			begin
				selectMux01 = 0; //Select B - Chanel 1 MUX01
				selectMux02 = 1; //Select ALU - Chanel 2 MUX02
				selectMux03 = 0; //Select D - Chanel 1 MUX03
				selectALU = 0; //Select soma Na ALU
				weRAM = 1; //Select Leitura memoria
				weRegFile = 0; //Select Leitura memoria reg file
				startMultiplicador = 0; //Multiplicador desligado
			end
			
		endcase //end case codOperation
	
		controlOut = {startMultiplicador, addressRD, addressRT, addressRS, weRegFile, selectMux03, weRAM, selectMux02, selectALU, selectMux01};
		
	end
	
endmodule 