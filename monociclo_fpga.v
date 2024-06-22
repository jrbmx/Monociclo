module monociclo_fpga(
	input 		 clk_i,
	input 		 rst_ni,
	output [6:0] disp0,
	output [6:0] disp1,
	output [6:0] disp2,
	output [6:0] disp3,
	output [6:0] disp4,
	output [6:0] disp5,
	output [6:0] disp6,
	output [6:0] disp7
	

);

//definicion de señales
wire 				[31:0] salida_o;
wire 				clkDiv_o;

//Instancia del PC
monociclo PC(
		.clk_i		(clkDiv_o),
		.rst_ni		(rst_ni),
		.salida_o 	(salida_o)
);

//Instancia del divisor de frecuencia
divFreq divisor (	
	.clk_i 		(clk_i),
	.rst_ni		(rst_ni),
	.clk_o 		(clkDiv_o)
);


//instancia de displays
Disp7segs disp_0(
	.entrada_i (salida_o[3:0]),
	.salida_o (disp0)
);

Disp7segs disp_1(
	.entrada_i (salida_o[7:4]),
	.salida_o (disp1)
);

Disp7segs disp_2(
	.entrada_i (salida_o[11:8]),
	.salida_o (disp2)
);

Disp7segs disp_3(
	.entrada_i (salida_o[15:12]),
	.salida_o (disp3)
);

Disp7segs disp_4(
	.entrada_i (salida_o[19:16]),
	.salida_o (disp4)
);

Disp7segs disp_5(
	.entrada_i (salida_o[23:20]),
	.salida_o (disp5)
);

Disp7segs disp_6(
	.entrada_i (salida_o[27:24]),
	.salida_o (disp6)
);

Disp7segs disp_7(
	.entrada_i (salida_o[31:28]),
	.salida_o (disp7)
);

endmodule