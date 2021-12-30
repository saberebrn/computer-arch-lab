module EXE_Stage(
    input rst, clk, mem_read_enable, mem_write_enable, immidiate,
    input [1:0] val_rn_sel, val_rm_sel,
    input [3:0] exec_cmd, Status,
    input [11:0] shift_operand, 
    input [23:0] Signed_immidiate_24,
    input [31:0] PC_in, Val_Rn, Val_Rn_exe, Val_Rn_mem, Val_Rm, Val_Rm_exe, Val_Rm_mem,
    output [3:0] Status_out,
    output [31:0] jump_addr, alu_out, final_Rm
);
    
    wire [31:0] val2, jump_addr_tmp, final_Rn, final_Rm;
    assign jump_addr_tmp = PC_in + {{8{Signed_immidiate_24[23]}}, Signed_immidiate_24};
    assign jump_addr = {jump_addr_tmp[31:2], 2'b00};

    assign final_Rm = val_rm_sel == 2'b00 ? Val_Rm
            : val_rm_sel == 2'b01 ? Val_Rm_exe
            : val_rm_sel == 2'b10 ? Val_Rm_mem
            : Val_Rm;

    assign final_Rn = val_rn_sel == 2'b00 ? Val_Rn
            : val_rn_sel == 2'b01 ? Val_Rn_exe
            : val_rn_sel == 2'b10 ? Val_Rn_mem
            : Val_Rn;

    Val2_Generator val2_gen(
        final_Rm,
        shift_operand,
        immidiate,
        mem_read_enable | mem_write_enable,
        val2
    );

    ALU alu(
        Status[2],
        final_Rn, 
        val2,
        exec_cmd,
        alu_out,
        Status_out
    );
endmodule