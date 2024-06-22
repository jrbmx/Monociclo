module memoria_b (

	input 		[2:0] addr_i,
	output 		[31:0] operador_o 

);

	//definicion de la memoria
	reg 			[31:0] memory [7:0]; //Parametro de profundidad - memory - luego parametro de ancho
	
	initial
	begin
		memory[0] = 32'b1;
		memory[1] = 32'b10100111001001100100101001000101;
		memory[2] = 32'b10100111001001100100101001000101;
	end

	//Puerto de lectura
	assign 			operador_o = memory[addr_i];
	
endmodule 