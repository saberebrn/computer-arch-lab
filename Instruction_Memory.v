module Instruction_Memory(input [31:0] PC_out, output reg [31:0] Instruction);
  always@(PC_out)begin  
    case (PC_out)
      0: Instruction = 32'b000000_00001_00010_00000_00000000000;
      4: Instruction = 32'b000000_00011_00100_00000_00000000000;
      8: Instruction = 32'b000000_00101_00110_00000_00000000000;
      12: Instruction = 32'b000000_00111_01000_00010_00000000000;
      16: Instruction = 32'b000000_01001_01010_00011_00000000000;
      20: Instruction = 32'b000000_01011_01100_00000_00000000000;
      24: Instruction = 32'b000000_01101_01110_00000_00000000000;
      default : Instruction = 32'b0;
    endcase
  end
endmodule