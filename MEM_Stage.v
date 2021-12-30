module MEM_Stage(
    input clk, rst, CLK, RST, mem_read_enable, mem_write_enable,
    input [31:0] alu_out, val_rm,
    output ready,
    output [31:0] mem_out
);

    wire [31:0] sram_dq;
    wire [16:0] sram_addr;
    wire sram_ub_n, sram_lb_n, sram_we_n, sram_ce_n, sram_oe_n;

    Memory mem(
        CLK, RST, sram_we_n,
        sram_addr, sram_dq
    );

    SRAM_controller sc(
        clk, rst, mem_write_enable, mem_read_enable,
        alu_out, val_rm,
        sram_dq,
        ready, sram_ub_n, sram_lb_n, sram_we_n, sram_ce_n, sram_oe_n,
        sram_addr,
        mem_out
    );

endmodule
