module ALUNBits_FPGA (

	input				[2:0] addra_i,
	input				[2:0] addrb_i,
	input 					c_i,
	input 					invert_i,
	input				[3:0] operacion_i,
	output					c_o,
	output			[6:0] disp0_o,
	output			[6:0] disp1_o,
	output			[6:0] disp2_o,
	output			[6:0] disp3_o,
	output			[6:0] disp4_o,
	output			[6:0] disp5_o,
	output			[6:0] disp6_o,
	output			[6:0] disp7_o
);

	//Seccion de definicion de senales
	wire				[31:0] opea_w;
	wire				[31:0] opeb_w;
	wire 				[31:0] salida_o;
	wire 				[31:0] res_output;
	wire 				[31:0] sol_output;

	//Instancia de memorias
	memoria_a mema (

		.addr_i		(addra_i),
		.operador_o	(opea_w)

	);
	
	memoria_b memb (

		.addr_i		(addrb_i),
		.operador_o	(opeb_w)

	);


	//Instancia de ALUNBits
	ALUNBits #(
		.N 			(32)
	)
	ALU_FPGA
	(
		.a_i					(opea_w),
		.b_i					(opeb_w),
		.operacion_i		(operacion_i),
		.c_i					(c_i),
		.invert_i			(invert_i),
		.c_o					(c_o),
		.salida_o			(res_output),
		.sol_o				(sol_output)
	);
	
	assign salida_o = (operacion_i[3] == 1'b1) ? sol_output : res_output;

	//Displays de 7 segmentos
	Disp7segs Disp0(

		.entrada_i		(salida_o[3:0]),
		.salida_o		(disp0_o)

	);
	
	Disp7segs Disp1(

		.entrada_i		(salida_o[7:4]),
		.salida_o		(disp1_o)

	);
	
	Disp7segs Disp2(

		.entrada_i		(salida_o[11:8]),
		.salida_o		(disp2_o)

	);
	
	Disp7segs Disp3(

		.entrada_i		(salida_o[15:12]),
		.salida_o		(disp3_o)

	);
	
	Disp7segs Disp4(

		.entrada_i		(salida_o[19:16]),
		.salida_o		(disp4_o)

	);
	
	Disp7segs Disp5(

		.entrada_i		(salida_o[23:20]),
		.salida_o		(disp5_o)

	);
	
	Disp7segs Disp6(

		.entrada_i		(salida_o[27:24]),
		.salida_o		(disp6_o)

	);
	
	
	Disp7segs Disp7(

		.entrada_i		(salida_o[31:28]),
		.salida_o		(disp7_o)

	);
	
	

endmodule 