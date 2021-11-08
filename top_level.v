module top_level(input rst, clk);
    wire [31:0] pc_1, pc_2, pc_3, pc_4, pc_5, Instruction, BranchAddr, Result_WB;
    wire freeze, flush, Branch_taken;
    wire WBEnable;
    wire [3:0]Dest_wb, status;
    assign freeze = 1'b0;
    assign flush = 1'b0;
    assign Branch_taken = 1'b0;
    assign BranchAddr = 32'b0;
    assign WBEnable = 1'b0;
    assign Result_WB = 32'b0;
    assign Dest_wb = 4'b0;
    assign status = 4'b1111;

    wire wb_enable_exec, mem_read_enable, mem_write_enable, branch_enable, S, immidiate;
    wire [3:0] exec_cmd, Status, Dest;
    wire [31:0] Val_Rn, Val_Rm;
    
    wire [11:0] Shift_operand;
    wire [23:0] Signed_immidiate_24;
  
    IF_Module if_module(rst, clk, freeze, flush, Branch_taken, BranchAddr, pc_1, Instruction);
    ID_Module id_module(
        rst, clk, freeze, flush, WBEnable, pc_1, Instruction, Result_WB, Dest_wb, status,
        wb_enable_exec, mem_read_enable, mem_write_enable, branch_enable, S, 
        exec_cmd, pc_2,  Val_Rn, Val_Rm, immidiate,
        Shift_operand, Signed_immidiate_24, Dest, Status
    );
    EXE_Module exe_module(rst, clk, pc_2, pc_3);
    MEM_Module mem_module(rst, clk, pc_3, pc_4);
    WB_Stage wb_module(rst, clk, pc_4, pc_5);

endmodule