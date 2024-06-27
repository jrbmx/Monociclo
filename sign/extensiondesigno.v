/*	Grupo: 5CV3 	Proyecto: ExteniónDeSigno	Archivo: extensiodesigno.v
Equipo: 6
Integrantes: 
Díaz Ortiz Brandon Aldair			González Rosales Brenda Yareth
Hernández Suarez Diego Armando			Pérez Aguilar Dulce Evelyn 
Romero Barrientos Jonathan Rubén
Descripción: El módulo extensiondesigno está parametrizado con IMM, 
que define el número de bits para la extensión del valor inmediato
*/

module extensiondesigno #(
parameter  IMM = 20
)

(
	input 		[31:0]  instruccion_i,
	output reg 	[31:0]  inmediato_o
);
	wire      [6:0]  opcode_w;
	assign           opcode_w = instruccion_i[6:0];
	reg [31:0] result; // Variable interna
	
	always @(*)
	begin 
		case (opcode_w)
			7'b0110011:         //Tipo R
					inmediato_o = 32'b0;
			7'b0010011:         //Tipo I
					inmediato_o = {{IMM{instruccion_i[31]}}, instruccion_i[31:20]};
			7'b0100011: // Tipo S
				   inmediato_o = {{IMM{instruccion_i[31]}}, instruccion_i[31:25], instruccion_i[11:7] };
			7'b0000011: // Tipo L
				   inmediato_o = {{IMM{instruccion_i[31]}}, instruccion_i[31:20]};
			7'b1100011: // Tipo B
				   inmediato_o = {{IMM{instruccion_i[31]}}, instruccion_i[7], instruccion_i[30:25], instruccion_i[11:8] };
			7'b1101111: // Tipo J
				   inmediato_o = {{12{instruccion_i[31]}}, instruccion_i[19:12], instruccion_i[20], instruccion_i[30:21] };
			default:
					inmediato_o = 32'b0;
		endcase
	end
endmodule 
