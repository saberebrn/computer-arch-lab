module Memory(
    input clk, rst, sram_we_n,
    input [16:0] sram_addr, 
    inout [31:0] sram_dq
);
    reg [31:0] memory [0:511];
    assign #30 sram_dq = sram_we_n ? memory[sram_addr]: 32'bzzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz;

    always @(posedge clk) begin
		if (~sram_we_n) begin
			memory[sram_addr] = sram_dq;
		end
	end
endmodule