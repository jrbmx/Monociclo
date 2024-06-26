module ALUNBits #(
	parameter 			N = 32
)
(
	input 	  	[N-1:0] a_i,
	input 	  	[N-1:0] b_i,
	input 	  	[3:0]   operacion_i,
	input 			     c_i,
	input 			     invert_i,
	//input 			     less_i,
	output 				  c_o,
	output reg 	[N-1:0] final_o,
	output reg 			  zeroflag_o
);

	wire 					set_o;
	wire 					cf_o;
	wire 			[N-2:0] carries_w;
	wire	 	  	[N-1:0]  salida_o;
	reg 			[N-1:0] 	sol_o;
	wire			[31:0]	muxalu_dato_o;

	
	//variable para utilizar en el bucle
	genvar i;
	generate
	
		for(i = 0; i < N; i = i + 1)
			begin: alubucle
				//Instancia de la ALU de 1 Bit
				case (i)
				0:
					ALU ALUBit0(
					.a_i				(a_i[i]),
					.b_i				(b_i[i]),
					.operacion_i	(operacion_i),
					.c_i				(c_i),
					.invert_i		(invert_i),
					.less_i			(set_o),
					.sltu_i			(~cf_o),
					.salida_o		(salida_o[i]),
					.c_o				(carries_w[i]),
					.set_o			()
					);
				N-1:
					ALU ALUBitN_1(
					.a_i				(a_i[i]),
					.b_i				(b_i[i]),
					.operacion_i	(operacion_i),
					.c_i				(carries_w[i-1]),
					.invert_i		(invert_i),
					.less_i			(1'b0),
					.sltu_i			(1'b0),
					.salida_o		(salida_o[i]),
					.c_o				(cf_o),
					.set_o			(set_o)
					);
				default:
					ALU ALUBitX(
					.a_i				(a_i[i]),
					.b_i				(b_i[i]),
					.operacion_i	(operacion_i),
					.c_i				(carries_w[i-1]),
					.invert_i		(invert_i),
					.less_i			(1'b0),
					.sltu_i			(1'b0),
					.salida_o		(salida_o[i]),
					.c_o				(carries_w[i]),
					.set_o			()
					);
				endcase
			end
	
	endgenerate
	
	always @(*) begin
		case(operacion_i[3])
			1'b1:
				begin
					case(operacion_i[2:0])
						3'b001: sol_o = a_i << b_i;
						3'b010: sol_o = a_i >> b_i;
						3'b011: sol_o = $signed(a_i) >>> $signed(b_i);
						default:
							sol_o = 32'b00000000000000000000000000000000;
					endcase
				end
			default: 
				begin
					sol_o = salida_o;
				end
		endcase
	end
	
	always @(*) begin
		final_o = sol_o;
		zeroflag_o = ~(|(sol_o));
	end

endmodule 