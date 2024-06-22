//Encabezado
module decodificador (
	input 			[6:0] opcode_i,
	output reg  	regwrite_o, 
	output reg  	alusrc_o,
	output reg		memread_o,
	output reg		memwrite_o,
	output reg		memtoreg_o,
	output reg		branch_o,
	output reg		zerom_o,
	output reg		tipoJ_o,
	output reg 		[4:0] aluop_o
);
always @(*)
	begin 
		case (opcode_i)
			7'b0010011:         //Tipo I
				begin 
					regwrite_o = 	1'b1; 				
					alusrc_o = 		1'b1; // checar
					memread_o = 	1'b1;
					memwrite_o = 	1'b0;
					memtoreg_o =  	1'b0;
					branch_o = 		1'b0;
					zerom_o =      1'b0;
					tipoJ_o =      1'b0;
					aluop_o  = 		5'b00100; 
				end
			7'b0110011:         //Tipo R
				begin 
					regwrite_o = 	1'b1;
					alusrc_o = 		1'b0;
					memread_o = 	1'b0;
					memwrite_o = 	1'b0;
					memtoreg_o =  	1'b0;
					branch_o = 		1'b0;
					zerom_o =      1'b0;
					tipoJ_o =      1'b0;
					aluop_o  = 		5'b01100;
				end
			7'b0100011: // Tipo S
				begin
					regwrite_o = 	1'b0;
					alusrc_o = 		1'b1;
					memread_o = 	1'b0;
					memwrite_o = 	1'b1;
					memtoreg_o =  	1'b0;
					branch_o = 		1'b0;
					zerom_o =      1'b0;
					tipoJ_o =      1'b0;
					aluop_o  = 		5'b01000;  
				end
			7'b0000011: // Tipo L
				begin
					regwrite_o = 	1'b1;
					alusrc_o = 		1'b1;
					memread_o = 	1'b1;
					memwrite_o = 	1'b0;
					memtoreg_o =  	1'b1;
					branch_o = 		1'b0;
					zerom_o =      1'b0;
					tipoJ_o =      1'b0;
					aluop_o  = 		5'b00000;   
				end
			7'b1100011: // Tipo B
				begin
					regwrite_o = 	1'b0;
					alusrc_o = 		1'b0;
					memread_o = 	1'b0;
					memwrite_o = 	1'b0;
					memtoreg_o =  	1'b0;
					branch_o = 		1'b1;
					zerom_o =      1'b1;
					tipoJ_o =      1'b0;
					aluop_o  = 		5'b11000;
				end
			7'b1101111: // Tipo J
			begin
				regwrite_o = 	1'b0;
				alusrc_o = 		1'b0;
				memread_o = 	1'b0;
				memwrite_o = 	1'b0;
				memtoreg_o =  	1'b0;
				branch_o = 		1'b1;
				zerom_o =      1'b1;
				tipoJ_o =      1'b1;
				aluop_o  = 		5'b11011;	
			end
			
			
			default
				begin 
					regwrite_o = 1'b0;
					alusrc_o = 1'b0;
				end
		endcase
	end
endmodule 