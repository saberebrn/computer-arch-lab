module ID_Stage(
    input clk, rst, writeBackEn, hazard,
    input[31:0] Instruction, Result_WB,
    input[3:0]Dest_wb, status,
    output wb_enable, mem_read_enable, mem_write_enable, branch_enable, S_out, immidiate, two_src, imm_32_enable,
    output[3:0] exec_cmd, dest, Src_Rn, Src_Rm,
    output[31:0] Val_Rn, Val_Rm,
    output[11:0] Shift_operand,
    output[23:0] Signed_immidiate_24
);


    wire [3:0] exec, dreg, opcode;
    wire cond_out, state, wb, mem_read, mem_write, branch, cond_haz_or, ld, ld4;
    wire [31:0]immd_32_counter_input, imm_32_counter;
    assign two_src = ~immidiate | mem_write_enable;
    assign cond_haz_or = hazard | ~cond_out;
    assign Src_Rn = (~imm_32_enable) ? Instruction[19:16] : dreg;
    assign Src_Rm = mem_write_enable ? Instruction[15:12] : Instruction[3:0];

    assign opcode = Instruction[24:21];
    assign wb_enable = cond_haz_or ? 0: wb;
	assign mem_read_enable = cond_haz_or ? 0: mem_read;
	assign mem_write_enable = cond_haz_or ? 0: mem_write;
	assign S_out = cond_haz_or ? 0: state;
	assign branch_enable = cond_haz_or ? 0: branch;
	assign exec_cmd = cond_haz_or ? 0: exec;
	assign Shift_operand = Instruction[11:0];
	assign immidiate = Instruction[25];
    assign dest = (~imm_32_enable) ? Instruction[15:12] : dreg;
	assign Signed_immidiate_24 = Instruction[23:0];

    assign ld = ((opcode == 4'b0011) || (imm_32_counter != 32'b0)) && ~hazard; 
    assign immd_32_counter_input = (opcode == 4'b0011) ? Val_Rn + 32'd1 : imm_32_counter - 32'd1;
    Register RI32(clk, rst, ld, immd_32_counter_input, imm_32_counter);
    assign imm_32_enable = imm_32_counter != 32'b0;

    assign ld4 = (opcode == 4'b0011); 
    Register4 RI32D(clk, rst, ld4, dest, dreg);
    assign imm_32_enable = imm_32_counter != 32'd0;

    RegisterFile RF(clk, rst, Src_Rn, Src_Rm, Dest_wb, Result_WB, writeBackEn, Val_Rn, Val_Rm);
    Condition_Check CC(imm_32_enable, status, Instruction[31:28], cond_out);
    Control_Unit CU(
        Instruction[27:26],
        Instruction[24:21],
        Instruction[20],
        imm_32_enable,
        exec,
        mem_read,
        mem_write,
        wb,
        branch,
        state
    );

endmodule