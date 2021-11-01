module MUX_2(input [31:0] first, second, input select,output [31:0] out);
	assign out = select ? first : second; 
endmodule