//Crear otra carpeta dentro de la carpeta monociclo llamada icache

//Crear otro archivo
//este archivo se guardara dentro de la carpeta icache

module icache(
	//Puerto de lectura
	input	[5:0]	rdaddr_i,
	output	[31:0]	inst_o
);

	//definir la memoria
	//todas las memorias siempre se definen como tipo reg
	//las memorias tienen dos direcciones, ancho y profundidad
	//el primer parametro es el ancho
	reg [31:0] memoria [0:31];

	
	initial
	begin
//		memoria[0] = 32'b10101010101010101010101010101010;
//		memoria[1] = 32'b01010101010101010101010101010101;
//		memoria[2] = 32'b11111111111111110000000000000000;
		//$readmemh("burbuja.hex", memoria);
		$readmemh("HEX_burbuja.hex", memoria);
	end


	
	//Definir la lectura de la memoria
	assign inst_o = memoria[rdaddr_i];

endmodule 