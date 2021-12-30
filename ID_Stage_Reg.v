module ID_Stage_Reg(
    input clk, rst, freeze, flush,
    input wb_enable_in, mem_read_enable_in, mem_write_enable_in,
    input branch_enable_in, S_in,
    input [3:0] exec_cmd_in,
    input [31:0] PC_in, Val_Rn_in, Val_Rm_in,
    input immidiate_in,
    input [11:0] Shift_operand_in,
    input [23:0] Signed_immidiate_24_in,
    input [3:0] rn_in, rm_in, Dest_in,
    input [3:0] Status_in,

    output reg wb_enable, mem_read_enable, mem_write_enable, branch_enable, S_out,
    output reg [3:0] exec_cmd,
    output reg [31:0] PC,
    output reg [31:0] Val_Rn, Val_Rm,
    output reg immidiate,
    output reg [11:0] Shift_operand, 
    output reg [23:0] Signed_immidiate_24,
    output reg [3:0]rn, rm, Dest,
    output reg [3:0]Status
);
    always @(posedge clk, posedge rst) begin
        if(rst) begin
            PC <= 32'b0;
            wb_enable <= 1'b0;
            mem_read_enable <= 1'b0;
            mem_write_enable <= 1'b0;
            branch_enable <= 1'b0;
            S_out <= 1'b0;
            exec_cmd <= 32'b0;
            Val_Rn <= 32'b0;
            Val_Rm <= 32'b0;
            immidiate <= 1'b0;
            Shift_operand <= 12'b0;
            Signed_immidiate_24 <= 24'b0;
            Dest <= 4'b0;
            Status <= 4'b0;
            rn <= 4'b0;
            rm <= 4'b0;
		end
        else if(~freeze) begin
            PC <= PC_in;
            wb_enable <= wb_enable_in;
            mem_read_enable <= mem_read_enable_in;
            mem_write_enable <= mem_write_enable_in;
            branch_enable <= branch_enable_in;
            S_out <= S_in;
            exec_cmd <= exec_cmd_in;
            Val_Rn <= Val_Rn_in;
            Val_Rm <= Val_Rm_in;
            immidiate <= immidiate_in;
            Shift_operand <= Shift_operand_in;
            Signed_immidiate_24 <= Signed_immidiate_24_in;
            Dest <= Dest_in;
            Status <= Status_in;
            rn <= rn_in;
            rm <= rm_in;
        end 
    end
    
    always @(negedge clk) begin
        if(flush) begin
            PC <= 32'b0;
            wb_enable <= 1'b0;
            mem_read_enable <= 1'b0;
            mem_write_enable <= 1'b0;
            branch_enable <= 1'b0;
            S_out <= 1'b0;
            exec_cmd <= 32'b0;
            Val_Rn <= 32'b0;
            Val_Rm <= 32'b0;
            immidiate <= 1'b0;
            Shift_operand <= 12'b0;
            Signed_immidiate_24 <= 24'b0;
            Dest <= 4'b0;
            Status <= 4'b0;
            rn <= 4'b0;
            rm <= 4'b0;
        end
    end
endmodule
