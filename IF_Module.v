
module IF_Module(
    input rst, clk, freeze, flush, Branch_taken, 
    input [31:0] BranchAddr,
    output [31:0] PC, Instruction
);

    wire [31:0] pc_conector, instruction_conector;
    IF_Stage logic_process(
        clk, rst, freeze, Branch_taken, BranchAddr, pc_conector, instruction_conector
    );
    IF_Stage_Reg register(
        clk, rst, freeze, flush, pc_conector, instruction_conector, PC, Instruction 
    );

endmodule