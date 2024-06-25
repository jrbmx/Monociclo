//Los puertos de lectura son asincronos
//Los puertos de escritura son sincronos

//Para guardarlo nos vamos al menu save
//Nos vamos a la carpeta monociclo y se crea una
//Nueva llamada regfile

//De fung7 solo se toma el bit 5, de menor a mayor
//significativo. Eso seria el b`it 30 de la instruccion
//de 32 bits

//Se copia la carpeta del ALU al proyecto de monociclo

//Menu project 
//add remove files in project
//Vamos a la ALU y agregamos uno por uno todos los archivos
//pertenecientes a la ALU
//Memorias y displays de 7 segmentos NOOO
*/
Grupo: 5CV3 
Proyecto: BancoDeRegistros
Archico: BancoDeRegistros.v
Equipo: 6
Integrantes: Díaz Ortiz Brandon Aldair
González Rosales Brenda Yareth
Hernández Suarez Diego Armando
Pérez Aguilar Dulce Evelyn 
Romero Barrientos Jonathan Rubén
Descripción: Banco de registros donde se puede leer desde dos registros diferentes simultáneamente,
y se puede escribir en un registro seleccionado (rd_i) cuando la señal de escritura (wren_i)
está activa y en el flanco de subida del reloj
*/

module BancoDeRegistros(
	input 	    	 clk_i,
	input 	[4:0]  rd_i,
	input 	[31:0] datard_i,
	input	     		 wren_i,
	//Puerto de lectura
	input 	[4:0]  rs1_i,
	input 	[4:0]  rs2_i,
	output	[31:0] datars1_o,	
	output	[31:0] datars2_o
);
	//Definir una memoria de 32*32
	//reg [31:0] Registros [0:31];
	reg [31:0] Registros [2**5-1:0];
	
	initial
	begin
		Registros[0] = 32'b0;
	end 
	
	//Puerto de escritura
	always @(posedge clk_i)
	begin
		if(wren_i)
			Registros[rd_i] = datard_i;
	end

	assign datars1_o = Registros[rs1_i];
	assign datars2_o = Registros[rs2_i];

endmodule
