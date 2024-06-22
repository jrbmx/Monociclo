module memoria_a (

	input 		[2:0] addr_i,
	output		[31:0] operador_o //Se quita el reg porque se uso el assign en la linea 19

);

	//definicion de la memoria
	reg 			[31:0] memory [7:0]; //Parametro de profundidad - memory - luego parametro de ancho
	
	initial
	begin
		memory[0] = 32'b10;
		memory[1] = 32'b11001110101001110010101110100011;
//		memory[1] = 32'b1001_1101_0100_1110_0101_0111_0100_0110;
		memory[2] = 32'b11001110101001110010101110100011;
		//memory[2] = 32'b1001_1101_0100_1110_0101_0111_0100_0110; SRL
		//memory[2] = 32'b0110_0111_0101_0011_1001_0101_1101_0001;
	end
	
	//Puerto de lectura
	assign 			operador_o = memory[addr_i];

endmodule 