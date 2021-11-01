module ID_Module(
    input clk, rst,
    input [31:0] PC_in,
    output [31:0] PC
);

    wire [31:0] pc_conector;
    ID_Stage logic_process(
        clk, rst, PC_in, pc_conector
    );
    ID_Stage_Reg register(
        clk, rst, pc_conector, PC 
    );

endmodule