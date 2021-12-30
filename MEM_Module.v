
module MEM_Module(
    input clk, rst, write_back_enable, mem_read_enable, mem_write_enable,
    input [3:0] dest,
    input [31:0] alu_res, val_rm,
    output write_back_enable_out, mem_read_enable_out, 
    output [3:0] dest_out,
    output [31:0] alu_res_out, mem, mem_out
);

    MEM_Stage logic_process(
        clk, rst, mem_read_enable, mem_write_enable, alu_res, val_rm, mem
    );

    MEM_Stage_Reg register(
        clk, rst, write_back_enable, mem_read_enable, dest, alu_res, mem, 
        write_back_enable_out, mem_read_enable_out, dest_out, alu_res_out, mem_out
    );

endmodule