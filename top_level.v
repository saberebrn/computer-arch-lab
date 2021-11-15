module top_level(input rst, clk);
    wire [31:0] pc_1, pc_2, pc_3, pc_4, pc_5, Instruction, BranchAddr, Result_WB, dest_out_exec, alu_out, val_rm_exec, Val_Rn, Val_Rm, mem_out;
    wire [23:0] Signed_immidiate_24;
    wire [11:0] Shift_operand;
    wire [3:0] exec_cmd, Dest, status_out_exec, status_in_id,  status_out_id;
    wire freeze, flush, wb_enable_exec, mem_read_enable_exec, mem_write_enable_exec, branch_enable, S, immidiate, wb_enable_mem, mem_read_enable_mem, mem_write_enable_mem;
    

    // delet
    assign mem_out = 32'b0;

    assign freeze = 1'b0;
    assign flush = 1'b0;

    IF_Module if_module(
        rst, clk, freeze, flush, branch_enable, BranchAddr, pc_1, Instruction
    );

    ID_Module id_module(
        rst, clk, flush, wb_enable_mem, pc_1, Instruction, Result_WB, dest_out_exec, status_in_id, wb_enable_exec, 
        mem_read_enable_exec, mem_write_enable_exec, branch_enable, S, exec_cmd, pc_2,  Val_Rn, Val_Rm, 
        immidiate, Shift_operand, Signed_immidiate_24, Dest, status_out_id
    );
    
    EXE_Module exe_module(
        rst, clk, wb_enable_exec, mem_read_enable_exec, mem_write_enable_exec, immidiate,
        exec_cmd, status_out_id, Dest, Shift_operand, Signed_immidiate_24, pc_2, Val_Rn, Val_Rm,
        wb_enable_mem, mem_read_enable_mem, mem_write_enable_mem,
        status_out_exec, dest_out_exec, BranchAddr, alu_out, val_rm_exec
    );

    MEM_Module mem_module(rst, clk, pc_3, pc_4);


    WB_Stage wb_module(
        rst, clk, mem_read_enable_mem, alu_out, mem_out, Result_WB
    );

    Status_Register st(
        clk, rst, S, status_out_exec, status_in_id
    );

endmodule