module EXE_Module(
    input rst, clk, wb_enable, mem_read_enable, mem_write_enable, immidiate, imm_32_enable,
    input [3:0] exec_cmd, Status, dest,
    input [11:0] Shift_operand,
    input [23:0] Signed_immidiate_24,
    input [31:0] instruction, PC_in, Val_Rn, Val_Rm,
    output wb_enable_out, mem_read_enable_out, mem_write_enable_out,
    output [3:0] Status_out, dest_out,
    output [31:0] jump_addr, alu_out, Val_Rm_out
);

    wire [31:0] alo_connector;
    EXE_Stage logic_process(
        rst, 
        clk,
        mem_read_enable, 
        mem_write_enable, 
        immidiate,
        imm_32_enable,
        exec_cmd, 
        Status,
        Shift_operand, 
        Signed_immidiate_24,
        instruction,
        PC_in, 
        Val_Rn, 
        Val_Rm,
        Status_out,
        jump_addr,
        alo_connector
    );

    EXE_Stage_Reg register(
        clk, 
        rst, 
        wb_enable, 
        mem_read_enable, 
        mem_write_enable,
        dest,
        alo_connector,
        Val_Rm,
        wb_enable_out,
        mem_read_enable_out,
        mem_write_enable_out,
        dest_out,
        alu_out, 
        Val_Rm_out
    );
endmodule