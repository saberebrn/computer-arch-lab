module MEM_Stage(
    input clk, rst, mem_read_enable, mem_write_enable,
    input [31:0] alu_out, val_rm,
    output [31:0] mem_out
);

    Memory mem(
        clk, rst, mem_read_enable, mem_write_enable,
        alu_out, val_rm, mem_out
    );

endmodule
