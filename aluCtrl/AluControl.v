//Encabezado
module AluControl(
	input f7_i,
	input [2:0] f3_i,
	input [4:0] aluop_i,
	output reg [3:0] aluoperacion_o
);

always @(*)
	begin 
		case(aluop_i)
			5'b01100:		//Intrucciones R
				begin 
					case({f7_i, f3_i})		//Bit 3 usa la alu principal
							4'b0_000: //Suma
								aluoperacion_o = 4'b0_0_10;
							4'b1_000: //Resta
								aluoperacion_o = 4'b0_0_11;
							4'b0_010: //SLT
								aluoperacion_o = 4'b0_1_01;
							4'b0_111: //AND
								aluoperacion_o = 4'b0_0_00;
							4'b0_110: //OR
								aluoperacion_o = 4'b0_0_01;
							4'b0_100: //XOR
								aluoperacion_o = 4'b0_1_00;
							4'b0_011: //SLTU
								aluoperacion_o = 4'b0_1_10;
							4'b0_001: //SLL
								aluoperacion_o = 4'b1_0_01;
							4'b0_101: //SRL
								aluoperacion_o = 4'b1_0_10;
							4'b1_101: //SRA
								aluoperacion_o = 4'b1_0_11;
					endcase 
				end 
			5'b00100:			//Instrucciones I
				begin 
					case({f7_i, f3_i})
						  4'b0_000: //Suma
								aluoperacion_o = 4'b0_0_10;
						  4'b0_010: //SLT
								aluoperacion_o = 4'b0_1_01; //checar
						  4'b0_111: //AND
								aluoperacion_o = 4'b0_0_00;
						  4'b0_110: //OR
								aluoperacion_o = 4'b0_0_01;
						  4'b0_100: //XOR
								aluoperacion_o = 4'b0_1_00;
							4'b0_011: //SLTU
								aluoperacion_o = 4'b0_1_10; // checar
							4'b0_001: //SLL
								aluoperacion_o = 4'b1_0_01;  // cehcar
							4'b0_101: //SRL
								aluoperacion_o = 4'b1_0_10;  // checar
							4'b1_101: //SRA
								aluoperacion_o = 4'b1_0_11;
					endcase
				end 
			5'b01000:		//Intrucciones S
				begin
					aluoperacion_o = 4'b0_0_10;
				end
			5'b00000:		//Intrucciones L
				begin
					aluoperacion_o = 4'b0_0_10;
				end
		endcase
	end			
endmodule 