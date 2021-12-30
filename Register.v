module Register(input clk, rst, ld, input [31:0] in, output reg [31:0] out);

	always@(negedge clk, posedge rst) 
	begin
		if (rst) out <= 0;
		else if (ld) #1 out <= in;
	end
	
endmodule