module top_level(input clk, rst, CLK, RST, forwarding_en);
    wire [31:0] pc_1, pc_2, pc_3, pc_4, pc_5, Instruction, BranchAddr, Result_WB, alu_out, val_rm_exec, Val_Rn, Val_Rm, alu_res_mem, mem, mem_out, mem_forward_data;
    wire [23:0] Signed_immidiate_24;
    wire [11:0] Shift_operand;
    wire [3:0] exec_cmd, Dest, status_out_exec, status_in_id, status_out_id, dest_out_exec, dest_out_mem, Rn, Rm, rn_reg, rm_reg;
    wire [1:0] forwarding_sel_rn, forwarding_sel_rm;
    wire flush, wb_enable_exec, mem_read_enable_exec, mem_write_enable_exec, branch_enable, S, immidiate, wb_enable_mem, mem_read_enable_mem, mem_write_enable_mem, write_back_enable_wb, mem_read_enable_wb;

    wire two_src, hazard_detected, mem_ready;
    assign mem_forward_data =  mem_read_enable_mem ? mem : alu_out;
    assign flush = branch_enable;
    
    IF_Module if_module(
        rst, clk, hazard_detected | ~mem_ready, flush, branch_enable, BranchAddr, pc_1, Instruction
    );

    ID_Module id_module(
        rst, clk, ~mem_ready, flush, write_back_enable_wb, hazard_detected, pc_1, Instruction, Result_WB, dest_out_mem, status_in_id, wb_enable_exec, 
        mem_read_enable_exec, mem_write_enable_exec, branch_enable, S, two_src, exec_cmd, Rn, Rm, rn_reg, rm_reg, pc_2,  Val_Rn, Val_Rm, 
        immidiate, Shift_operand, Signed_immidiate_24, Dest, status_out_id
    );
    
    EXE_Module exe_module(
        rst, clk, ~mem_ready, wb_enable_exec, mem_read_enable_exec, mem_write_enable_exec, immidiate, forwarding_sel_rn, forwarding_sel_rm,
        exec_cmd, status_out_id, Dest, Shift_operand, Signed_immidiate_24, pc_2,
        Val_Rn, mem_forward_data, Result_WB, Val_Rm, mem_forward_data, Result_WB,
        wb_enable_mem, mem_read_enable_mem, mem_write_enable_mem,
        status_out_exec, dest_out_exec, BranchAddr, alu_out, val_rm_exec
    );

    MEM_Module mem_module(
        clk, rst, ~mem_ready, CLK, RST, wb_enable_mem, mem_read_enable_mem, mem_write_enable_mem, dest_out_exec, alu_out, val_rm_exec,
        write_back_enable_wb, mem_read_enable_wb, mem_ready, dest_out_mem, alu_res_mem, mem, mem_out
    );

    WB_Stage wb_module(
        rst, clk, mem_read_enable_wb, alu_res_mem, mem_out, Result_WB
    );

    Status_Register st(
        clk, rst, S, status_out_exec, status_in_id
    );

    Hazard_Detection_Unit hdu(
        wb_enable_exec, wb_enable_mem, two_src, forwarding_en,
        Rn, Rm, Dest, dest_out_exec,
        hazard_detected
    );

    Forwarding fw(
        forwarding_en, write_back_enable_wb, wb_enable_mem,
        rn_reg, rm_reg, dest_out_exec, dest_out_mem,
        forwarding_sel_rn, forwarding_sel_rm
    );

endmodule