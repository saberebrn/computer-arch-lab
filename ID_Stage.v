module ID_Stage(
    input clk, rst, writeBackEn,
    input[31:0] Instruction, Result_WB,
    input[3:0]Dest_wb, status,
    output wb_enable, mem_read_enable, mem_write_enable, branch_enable, S_out, immidiate,
    output[3:0] exec_cmd, dest,
    output[31:0] Val_Rn, Val_Rm,
    output[11:0] Shift_operand,
    output[23:0] Signed_immidiate_24
);


    wire [3:0] Src_Rn, Src_Rm, exec;
    wire cond_out, state, wb, mem_read, mem_write, branch;
    assign Src_Rn = Instruction[19:16];
    assign Src_Rm = mem_write_enable ? Instruction[15:12] : Instruction[3:0];

    assign wb_enable = ~cond_out ? 0: wb;
	assign mem_read_enable = ~cond_out ? 0: mem_read;
	assign mem_write_enable = ~cond_out ? 0: mem_write;
	assign S_out = ~cond_out ? 0: state;
	assign branch_enable = ~cond_out ? 0: branch;
	assign exec_cmd = ~cond_out ? 0: exec;
	assign Shift_operand = Instruction[11:0];
	assign immidiate = Instruction[25];
    assign Dest = Instruction[15:12];
	assign Signed_immidiate_24 = Instruction[23:0];

    RegisterFile RF(clk, rst, Src_Rn, Src_Rm, Dest_wb, Result_WB, writeBackEn, Val_Rn, Val_Rm);
    Condition_Check CC(status, Instruction[31:28], cond_out);
    Control_Unit CU(
        Instruction[27:26],
        Instruction[24:21],
        Instruction[20],
        exec,
        mem_read,
        mem_write,
        wb,
        branch,
        state
    );

endmodule