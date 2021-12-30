module Memory(
    input clk, rst, MemRead, MemWrite,
    input [31:0] address, WriteData, 
    output [31:0] ReadData
);
    reg [31:0] data [0:63];
    wire [31:0] inner_address;
    assign inner_address = (address - 32'd1024) >> 2;
    assign ReadData = (MemRead == 1'b1) ? data[inner_address] : 32'bzzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz; 

    always @(posedge clk) begin
		if (MemWrite) begin
			data[inner_address] = WriteData;
		end
	end
endmodule