/*
	ENCABEZADO
*/


module fulladder (

	input a_i,
	input b_i,
	input c_i,
	
	output c_o,
	output s_o

);

	//XOR Gate
	wire axorb_w;
	//AND Gates
	wire canda_w;
	wire candb_w;
	wire banda_w;
	
	//1era XOR Gate
	assign axorb_w = a_i ^ b_i;
	//2da XOR Gate
	//Resultado de la suma
	assign s_o = c_i ^ axorb_w;
	
	//Todas las AND Gate
	assign canda_w = c_i & a_i;
	assign candb_w = c_i & b_i;
	assign banda_w = b_i & a_i;
	
	//Acarreo de salida
	//OR Gate
	assign c_o = canda_w | candb_w | banda_w;
	
endmodule 