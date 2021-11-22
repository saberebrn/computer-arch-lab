module MEM_Stage_Reg(
    input clk, rst, write_back_enable, mem_read_enable,
    input [3:0] dest,
    input [31:0] alu_res, mem,
    output reg write_back_enable_out, mem_read_enable_out,
    output reg [3:0] dest_out, 
    output reg [31:0] alu_res_out, mem_out
);

    always @(posedge clk, posedge rst) begin
        if(rst) begin
			{write_back_enable_out, mem_read_enable_out, dest_out, alu_res_out, mem_out} <= 70'b0;
		end
        else begin
            write_back_enable_out <= write_back_enable;
            mem_read_enable_out <= mem_read_enable;
            dest_out <= dest;
            alu_res_out <= alu_res;
            mem_out <= mem;
        end 
    end

endmodule