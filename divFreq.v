module divFreq (

	input				clk_i,
	input				rst_ni,
	output	reg	clk_o

);

//definicion de señales
//	wire 				rst_ni;]
	reg 				[31:0] cuenta;
//monociclo

	always@(posedge clk_i,negedge rst_ni)
	begin
		if(!rst_ni)
		begin
			clk_o<= 1'b1; 	//Output encendido 
         cuenta<=32'b0; //Reinicia el contador
		end 
		else
		begin
			if(cuenta==32'd49_999_999)
				begin
					cuenta <= 32'b0;
					clk_o <= ~clk_o; // Alternar el reloj de salida cuando el conteo llegue a 50 M
				end
			else
				cuenta <= cuenta+1'b1; //Incrementa
		end

	end

endmodule