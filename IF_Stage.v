module IF_Stage(
    input clk, rst, freeze, Branch_taken, 
    input [31:0] BranchAddr,
    output [31:0] PC, Instruction
);

    reg pc_write_en;
    wire [31:0] pc_in, pc_out;
    assign PC = pc_out + 4;
    Register PC_Module(clk, rst, ~freeze, pc_in, pc_out);
    MUX_2 PC_Mux(PC, BranchAddr, ~Branch_taken, pc_in);
    Instruction_Memory Instruction_Mem(pc_out, Instruction);

endmodule