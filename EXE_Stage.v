module EXE_Stage(
    input rst, clk, mem_read_enable, mem_write_enable, immidiate, immadiate_32_enable,
    input [3:0] exec_cmd, Status,
    input [11:0] shift_operand, 
    input [23:0] Signed_immidiate_24,
    input [31:0] instruction, PC_in, Val_Rn, Val_Rm,
    output [3:0] Status_out,
    output [31:0] jump_addr, alu_out
);

    wire [31:0] val2, jump_addr_tmp;
    assign jump_addr_tmp = PC_in + {{8{Signed_immidiate_24[23]}}, Signed_immidiate_24};
    assign jump_addr = {jump_addr_tmp[31:2], 2'b00};

    Val2_Generator val2_gen(
        instruction,
        Val_Rm,
        shift_operand,
        immidiate,
        immadiate_32_enable,
        mem_read_enable | mem_write_enable,
        val2
    );

    ALU alu(
        Status[2],
        Val_Rn, 
        val2,
        exec_cmd,
        alu_out,
        Status_out
    );
endmodule