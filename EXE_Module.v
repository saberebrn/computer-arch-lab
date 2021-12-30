module EXE_Module(
    input rst, clk, freeze, wb_enable, mem_read_enable, mem_write_enable, immidiate,
    input [1:0] val_rn_sel, val_rm_sel,
    input [3:0] exec_cmd, Status, dest,
    input [11:0] Shift_operand,
    input [23:0] Signed_immidiate_24,
    input [31:0] PC_in, Val_Rn, Val_Rn_exe, Val_Rn_mem, Val_Rm, Val_Rm_exe, Val_Rm_mem,
    output wb_enable_out, mem_read_enable_out, mem_write_enable_out,
    output [3:0] Status_out, dest_out,
    output [31:0] jump_addr, alu_out, Val_Rm_out
);

    wire [31:0] alo_connector, val_rm_connector;
    EXE_Stage logic_process(
        rst, 
        clk,
        mem_read_enable, 
        mem_write_enable, 
        immidiate,
        val_rn_sel,
        val_rm_sel,
        exec_cmd, 
        Status,
        Shift_operand, 
        Signed_immidiate_24,
        PC_in, 
        Val_Rn, 
        Val_Rn_exe,
        Val_Rn_mem,
        Val_Rm,
        Val_Rm_exe,
        Val_Rm_mem,
        Status_out,
        jump_addr,
        alo_connector,
        val_rm_connector
    );

    EXE_Stage_Reg register(
        clk, 
        rst, 
        freeze,
        wb_enable, 
        mem_read_enable, 
        mem_write_enable,
        dest,
        alo_connector,
        val_rm_connector,
        wb_enable_out,
        mem_read_enable_out,
        mem_write_enable_out,
        dest_out,
        alu_out, 
        Val_Rm_out
    );
endmodule