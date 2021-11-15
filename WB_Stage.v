module WB_Stage(
    input rst, clk, mem_read_enable,
    input [31:0] alu_res, mem_res,
    output [31:0] wb_value
);

    assign wb_value = mem_read_enable ? mem_res : alu_res;

endmodule