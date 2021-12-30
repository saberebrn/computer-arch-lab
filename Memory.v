module Memory(
    input clk, rst, sram_we_n,
    input [16:0] sram_addr, 
    inout [31:0] sram_dq
);
<<<<<<< HEAD
    reg [31:0] memory [0:511];
    assign #30 sram_dq = sram_we_n ? memory[sram_addr]: 32'bzzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz;
=======
    reg [31:0] data [0:63];
    wire [31:0] inner_address;
    assign inner_address = (address - 32'd1024) >> 2;
    assign ReadData = (MemRead == 1'b1) ? data[inner_address] : 32'bzzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz; 
>>>>>>> forwarding

    always @(posedge clk) begin
		if (~sram_we_n) begin
			memory[sram_addr] = sram_dq;
		end
	end
endmodule