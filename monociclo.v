//Encabezado
*/
Grupo: 5CV3 
Nombre Proyecto: monociclo
Nombre Archivo: monociclo.v
Equipo: 6
Integrantes: Díaz Ortiz Brandon Aldair
González Rosales Brenda Yareth
Hernández Suarez Diego Armando
Pérez Aguilar Dulce Evelyn 
Romero Barrientos Jonathan Rubén
Descripción: incluye las etapas necesarias para ejecutar instrucciones:
Fetch, Decode, Execute, Memory Access y Write Back.
*/
module monociclo (
	input					clk_i,
	input					rst_ni,
	output	[31:0]	salida_o
);
	//SECCION DE DECLARACION DE SEÑALES
	reg		[31:0]	pc_r;
	wire 		[3:0]		id_alu_operacion_o;
	wire		[31:0]	pcnext_w;
	wire		[31:0]	if_inst_o;
	wire					id_alusrc_o;
	wire		[31:0]	wb_resultado_o;
	wire					c_o;
	wire		[31:0]	rr_dators1_o;
	wire		[31:0]	rr_dators2_o;
	wire		[31:0]	es_dato_o;
	wire		[31:0]	muxalu_dato_o;
	wire					id_memread_o;
	wire					id_memwrite_o;
	wire					id_memtoreg_o;
	wire					id_branch_o;
	wire					id_zero_o;
	wire					id_tipoJ_o;
	wire 		[31:0] 	mem_dato_o;
	wire		[31:0]	rf_dators2_o;
	wire					id_regwrite_o;
	wire 		[31:0]	ex_dato_o;
	wire 		[4:0] 	id_aluop_o;
	
	//Agregadas 20-06-2024
	wire 		[31:0]	ex_sll_dato_o;
	wire 		[31:0] 	branch_pc_w;
	wire 					ex_zeroflag_o;
	wire 					pcsrc_w;
	wire 		[31:0] 	pcbranchnext_w;
	wire 		[31:0] 	tipo_j_w;
		
	
	//Seccion de asignacion de señales para monitoreo en FPGA
	//assign	salida_o	=	if_inst_o;
	assign	salida_o	=	ex_dato_o;
	
	//Calculo de PC
	always @(posedge clk_i, negedge rst_ni)
	begin
		if (!rst_ni)
			pc_r	<=	32'b0;
		else
			pc_r	<= pcbranchnext_w;
	end
	
	assign	pcnext_w = pc_r + 32'h4;
	
	//ICACHE
	icache icache_u0(
		.rdaddr_i	(pc_r[7:2]),
		.inst_o		(if_inst_o)
	);
	
	//BANCO DE REGISTROS
	
	//rf_dators2_o
	//id_regwrite_o habilitacion de escritura del banco de registros
	BancoDeRegistros registerFile(
		.clk_i		(clk_i),
		.rd_i			(if_inst_o[11:7]),
		.datard_i	(wb_resultado_o),
		.wren_i		(id_regwrite_o),
		.rs1_i		(if_inst_o[19:15]),
		.rs2_i		(if_inst_o[24:20]),
		.datars1_o	(rr_dators1_o),
		.datars2_o	(rr_dators2_o)
	);
	
	//Extension de signo
	
	extensiondesigno	extend_u3 (
		.instruccion_i			(if_inst_o),	
		.inmediato_o			(es_dato_o)	
	);
	
	//Muxtiplexor para el segundo operando de la ALU
	assign muxalu_dato_o  = (id_alusrc_o) ? es_dato_o : rr_dators2_o;
	
	//Etapa de decodificacion
	decodificador decode_u0(
		.opcode_i			(if_inst_o[6:0]),
		.regwrite_o			(id_regwrite_o),
		.alusrc_o			(id_alusrc_o),
		.memread_o			(id_memread_o),
		.memwrite_o			(id_memwrite_o),
		.memtoreg_o			(id_memtoreg_o),
		.branch_o			(id_branch_o),
		.zerom_o				(id_zero_o),
		.tipoJ_o				(id_tipoJ_o),
		.aluop_o				(id_aluop_o)
	);
	
	//Alu Control
	AluControl AluCtrl(
		.f7_i					(if_inst_o[30]),
		.f3_i					(if_inst_o[14:12]),
		.aluop_i				(id_aluop_o),
		.aluoperacion_o	(id_alu_operacion_o)
	);
	
	sll1bit sll1(
		.entrada_i			(es_dato_o),
		.salida_o			(ex_sll_dato_o)
	);
	
	assign branch_pc_w = ex_sll_dato_o + pc_r;
	assign pcsrc_w= id_branch_o & ex_zeroflag_o;
	assign pcbranchnext_w = (pcsrc_w)? branch_pc_w :pcnext_w; 
	//concectar 
//	assign wb_resultado_o = ex_resultado_o;

	//Multiplexor para tipo J
	assign tipo_j_w = (id_tipoJ_o)? wb_resultado_o : pcnext_w; 
	
	
	//Conexión de la ALU
	ALUNBits #(
		.N 	(32)
	)
	(
		.a_i					(rr_dators1_o),
		.b_i					(muxalu_dato_o),
		.c_i					(id_alu_operacion_o[2]),
		.invert_i			(id_alu_operacion_o[2]),
//		.less_i				(),
		.operacion_i		(id_alu_operacion_o),
		.final_o			 	(ex_dato_o), //pc_r para ver las instrucciones del txt
		.c_o					(c_o),
		.zeroflag_o			(ex_zeroflag_o)
	);
	
	
	//MEMORY ACCESS STAGE
	dcache  dcache_u0(
		.clk_i			(clk_i),
		.writeen_i		(id_memwrite_o),
		.readen_i		(id_memread_o),
		.addr_i			(ex_dato_o[6:2]),
		.dato_i			(rr_dators2_o),
		.dato_o			(mem_dato_o)

	);
	//conectar wb_resultado_o al bus de datos de entrada
	assign	wb_resultado_o = (id_memtoreg_o) ? mem_dato_o : ex_dato_o;
	
endmodule
