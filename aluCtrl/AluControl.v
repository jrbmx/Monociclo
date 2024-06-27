//Encabezado
*/
Grupo: 5CV3 
Nombre Proyecto: monociclo
Nombre Archivo: monociclo.v
Equipo: 6
Integrantes: Díaz Ortiz Brandon Aldair
González Rosales Brenda Yareth
Hernández Suarez Diego Armando
Pérez Aguilar Dulce Evelyn 
Romero Barrientos Jonathan Rubén
Descripción: incluye los case para la selección de tipo de instrucción, así como la operación a seleccionar
*/

module AluControl(
	input f7_i,
	input [2:0] f3_i,
	input [4:0] aluop_i,
	output reg [3:0] aluoperacion_o,
	output reg [2:0] branch_ctrl_o
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
			5'b01000:		//Intrucciones S
				begin
					aluoperacion_o = 4'b0_0_10;
				end
			5'b00000:		//Intrucciones L
				begin
					aluoperacion_o = 4'b0_0_10;
				end

			5'b11000:      //instrucciones B
				begin
					case (f3_1)
						3'b000:			//BEQ
							begin
								aluoperacion_o= 4'b0_1_00;
								branch_ctrl_o = 3'b000;
							end
						3'b001:			//BNE
							begin
								aluoperacion_o= 4'b0_1_00;
								branch_ctrl_o = 3'b001;
							end
						3'b100:			//BLT
							begin
								aluoperacion_o= 4'b0_1_01;
								branch_ctrl_o = 3'b100;
							end
						
						3'b101:			//BGE
							begin
								aluoperacion_o= 4'b0_1_01;
								branch_ctrl_o = 3'b101;
							end
						3'b110:			//BLTU
							begin
								aluoperacion_o= 4'b0_1_10;
								branch_ctrl_o = 3'b110;
							end
						3'b111:			//BGEU
							begin
								aluoperacion_o= 4'b0_1_10;
								branch_ctrl_o = 3'b111;
							end
					endcase
				end
			5'b11011:			//instrucciones J
				begin
					aluoperacion_o = 4'b0_0_10;
				end
			default:
				begin
					aluoperacion_o = 4'b1_1_11;
				end
		endcase
	end			
endmodule 
