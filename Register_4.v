module Register4(input clk, rst, ld, input [3:0] in, output reg [3:0] out);

	always@(negedge clk, posedge rst) 
	begin
		if (rst) out <= 0;
		else if (ld) out <= in;
	end
	
endmodule