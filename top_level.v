module top_level(input rst, clk);
    wire [31:0] pc_1, pc_2, pc_3, pc_4, pc_5, Instruction, BranchAddr;
    wire freeze, flush, Branch_taken;
    assign freeze = 1'b0;
    assign flush = 1'b0;
    assign Branch_taken = 1'b0;
    assign BranchAddr = 32'b0;

    IF_Module if_module(
        rst, clk, freeze, flush, Branch_taken, BranchAddr, pc_1, Instruction
    );
    ID_Module id_module(rst, clk, pc_1, pc_2);
    EXE_Module exe_module(rst, clk, pc_2, pc_3);
    MEM_Module mem_module(rst, clk, pc_3, pc_4);
    WB_Stage wb_module(rst, clk, pc_4, pc_5);

endmodule