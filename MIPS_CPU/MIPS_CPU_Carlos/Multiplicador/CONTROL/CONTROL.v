module CONTROL (
	output reg Idle,
	output reg Done,
	output reg Load,
	output reg Sh,
	output reg Ad,
	input St,
	input Clk,
	input M,
	input K,
	input Rst
);
	parameter S0= 0, S1= 1, S2 = 2, S3 = 3;

	reg [1:0] estado_atual = 0;

	always @(*) begin
	  case(estado_atual)
	  
		 S0: 
		 begin
			Idle=1;
			Done=0;
			Sh=0;
		 end
		 
		 S1: 
		 begin
			Done=0;
			Sh=0;
			Idle=0;
		 end
		 
		 S2: 
		 begin
			Sh=1;
			Done=0;
			Idle=0;
		 end
		 
		 S3: 
		 begin
			Done=1;
			Sh=0;
			Idle=0;
		 end
		 
		 default: estado_atual <= S0;
		 
	  endcase
	end

	always @(posedge Clk) begin

	  if(Rst==0) begin
		 estado_atual <= S0;
	  end
	  
	  case(estado_atual)
	  
		 S0: 
		 begin
			if(St == 0) begin
			  estado_atual <= S0;
			  Load = 0;
			  Ad = 0;
			end 
			else begin
			  Ad = 0;
			  Load = 1;
			  estado_atual <= S1;
			end
		 end
		 
		 S1: 
		 begin
			if(M==1) begin
			  Ad = 1;
			  Load =0;
			  estado_atual <=S2;
			end 
			else begin
			  Ad = 0;
			  estado_atual <= S2;
			end
		 end
		 
		 S2: 
		 begin
			Ad=0;
			Load =0;
			
			if(K==1) begin
			  estado_atual<=S3;
			end 
			else begin
			  estado_atual <= S1;
			end
		 end
		 
		 S3: 
		 begin
			estado_atual <= S0;
			Ad = 0;
		 end
		 
		 default: estado_atual <= S0;
		 
	  endcase
	end
	
endmodule
