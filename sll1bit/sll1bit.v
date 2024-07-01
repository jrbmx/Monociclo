/*	Grupo: 5CV3 	
Proyecto: sll1bit	
Archivo: sll1bit.v
Equipo: 6
Integrantes: 
Díaz Ortiz Brandon Aldair			
González Rosales Brenda Yareth
Hernández Suarez Diego Armando			
Pérez Aguilar Dulce Evelyn 
Romero Barrientos Jonathan Rubén
Descripción: Hace un desplazamiento hacia la izquierda en un bit
de la entrada_i y lo guarda en una salida_o
*/
module sll1bit(
	input [31:0] entrada_i,
	output [31:0] salida_o
);

	assign salida_o = entrada_i<<1;
endmodule 
