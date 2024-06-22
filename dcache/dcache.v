module dcache (
	input 				clk_i,
	input 				writeen_i,
	input					readen_i,
	
	input		[4:0]		addr_i,
	input		[31:0]	dato_i,
	output	[31:0] 	dato_o

);
	reg 	[31:0] datacache [2**5-1:0];	
	///[2**10-1:0];	
	
	always @(posedge clk_i)
	begin 
		if	(writeen_i)
			datacache[addr_i] = dato_i;
			
	end
	assign 	dato_o = (readen_i) ? datacache[addr_i] : 32'b0;
endmodule
