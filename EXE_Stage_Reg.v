module EXE_Stage_Reg(
    input clk, rst, wb_enable, mem_read_enable, mem_write_enable,
    inout [3:0] dest,
    input [31:0] alu, Val_Rm,
    output reg wb_enable_out, mem_read_enable_out, mem_write_enable_out,
    output reg [3:0] dest_out,
    output reg [31:0] alu_out, Val_Rm_out
);
    always @(posedge clk, posedge rst) begin
        if(rst) begin
			wb_enable_out = 0;
            mem_read_enable_out = 0;
            mem_write_enable_out = 0;
            dest_out = 0;
            alu_out = 0;
            Val_Rm_out = 0;
		end
        else begin
            wb_enable_out = wb_enable;
            mem_read_enable_out = mem_read_enable;
            mem_write_enable_out = mem_write_enable;
            dest_out = dest;
            alu_out = alu;
            Val_Rm_out = Val_Rm;
        end 
    end
endmodule