module ID_Module(
    input clk, rst, flush, wb_enable_in,
    input [31:0] PC_in, Instruction, Result_WB, 
    input [3:0]Dest_wb, status_in,
    output wb_enable, mem_read_enable, mem_write_enable, branch_enable, S_out,
    output [3:0] exec_cmd,
    output [31:0] PC,
    output [31:0] Val_Rn, Val_Rm,
    output immidiate,
    output [11:0] Shift_operand, 
    output [23:0] Signed_immidiate_24,
    output [3:0]Dest,
    output [3:0]Status
);

    wire wb_enable_connector, mem_read_enable_connector, mem_write_enable_connector;
    wire branch_enable_connector, S_connector, immidiate_connector;
    wire [3:0] Dest_connector, exec_cmd_connector, Status_connector;
    wire [3:0] dest_connector, status_connector;
    wire [11:0] Shift_operand_connector;
    wire [23:0] Signed_immidiate_24_connector;
    wire [31:0] Val_Rn_connector, Val_Rm_connector;

    ID_Stage logic_process(
        clk, 
        rst, 
        wb_enable_in,
        Instruction,
        Result_WB,
        Dest_wb,
        status_in,
        wb_enable_connector,
        mem_read_enable_connector,
        mem_write_enable_connector,
        branch_enable_connector,
        S_connector,
        immidiate_connector,
        exec_cmd_connector,
        dest_connector,
        Val_Rn_connector,
        Val_Rm_connector,
        Shift_operand_connector,
        Signed_immidiate_24_connector  
    );

    ID_Stage_Reg register(
        clk,
        rst,
        flush,
        wb_enable_connector,
        mem_read_enable_connector,
        mem_write_enable_connector,
        branch_enable_connector,
        S_connector,
        exec_cmd_connector,
        PC_in,
        Val_Rn_connector,
        Val_Rm_connector,
        immidiate_connector,
        Shift_operand_connector,
        Signed_immidiate_24_connector,
        Dest_connector,
        Status_connector,
        wb_enable,
        mem_read_enable,
        mem_write_enable,
        branch_enable,
        S_out,
        exec_cmd,
        PC,
        Val_Rn,
        Val_Rm,
        immidiate,
        Shift_operand,
        Signed_immidiate_24,
        Dest,
        Status
    );

endmodule