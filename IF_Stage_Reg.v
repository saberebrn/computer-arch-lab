module IF_Stage_Reg(
    input clk, rst, freeze, flush,
    input[31:0] PC_in, Instruction_in,
    output reg [31:0] PC, Instruction 
);
    always @(posedge clk, posedge rst) begin
        if(rst || flush) begin
			PC <= 32'b0;
            Instruction <= 32'b0;
		end
        else if (~freeze) begin
            PC <= PC_in;
            Instruction <= Instruction_in;
        end 
    end

    always @(negedge clk) begin
        if(flush) begin
			PC <= 32'b0;
            Instruction <= 32'b0;
		end
    end
endmodule