module Instruction_Memory(input [31:0] PC_out, output reg [31:0] Instruction);
  always@(PC_out)begin  
    case (PC_out)
      0: Instruction <= 32'b1110_00_1_1101_0_0000_0000_000000010100; 
      4: Instruction <= 32'b1110_00_1_1101_0_0000_0001_101000000001; 
      8: Instruction <= 32'b1110_00_1_1101_0_0000_0010_000100000011; 
      12: Instruction <= 32'b1110_00_0_0100_1_0010_0011_000000000010; 
      16: Instruction <= 32'b1110_00_0_0101_0_0000_0100_000000000000; 
      20: Instruction <= 32'b1110_00_0_0010_0_0100_0101_000100000100; 
      24: Instruction <= 32'b1110_00_0_0110_0_0000_0110_000010100000; 
      28: Instruction <= 32'b1110_00_0_1100_0_0101_0111_000101000010; 
      32: Instruction <= 32'b1110_00_0_0000_0_0111_1000_000000000011; 
      36: Instruction <= 32'b1110_00_0_1111_0_0000_1001_000000000110;
      40: Instruction <= 32'b1110_00_0_0001_0_0100_1010_000000000101;
      44: Instruction <= 32'b1110_00_0_1010_1_1000_0000_000000000110;
      48: Instruction <= 32'b0001_00_0_0100_0_0001_0001_000000000001;
      52: Instruction <= 32'b1110_00_0_1000_1_1001_0000_000000001000;
      56: Instruction <= 32'b0000_00_0_0100_0_0010_0010_000000000010;
      60: Instruction <= 32'b1110_00_1_1101_0_0000_0000_101100000001;
      64: Instruction <= 32'b1110_01_0_0100_0_0000_0001_000000000000;
      68: Instruction <= 32'b1110_01_0_0100_1_0000_1011_000000000000;
      72: Instruction <= 32'b1110_01_0_0100_0_0000_0010_000000000100;
      76: Instruction <= 32'b1110_01_0_0100_0_0000_0011_000000001000;
      80: Instruction <= 32'b1110_01_0_0100_0_0000_0100_000000001101;
      84: Instruction <= 32'b1110_01_0_0100_0_0000_0101_000000010000;
      88: Instruction <= 32'b1110_01_0_0100_0_0000_0110_000000010100;
      92: Instruction <= 32'b1110_01_0_0100_1_0000_1010_000000000100;
      96: Instruction <= 32'b1110_01_0_0100_0_0000_0111_000000011000;
      100: Instruction <= 32'b1110_00_1_1101_0_0000_0001_000000000100;
      104: Instruction <= 32'b1110_00_1_1101_0_0000_0010_000000000000;
      108: Instruction <= 32'b1110_00_1_1101_0_0000_0011_000000000000;
      112: Instruction <= 32'b1110_00_0_0100_0_0000_0100_000100000011;
      116: Instruction <= 32'b1110_01_0_0100_1_0100_0101_000000000000;
      120: Instruction <= 32'b1110_01_0_0100_1_0100_0110_000000000100;
      124: Instruction <= 32'b1110_00_0_1010_1_0101_0000_000000000110;
      128: Instruction <= 32'b1100_01_0_0100_0_0100_0110_000000000000;
      132: Instruction <= 32'b1100_01_0_0100_0_0100_0101_000000000100;
      136: Instruction <= 32'b1110_00_1_0100_0_0011_0011_000000000001;
      140: Instruction <= 32'b1110_00_1_1010_1_0011_0000_000000000011;
      144: Instruction <= 32'b1011_10_1_0_111111111111111111110111;
      148: Instruction <= 32'b1110_00_1_0100_0_0010_0010_000000000001;
      152: Instruction <= 32'b1110_00_0_1010_1_0010_0000_000000000001; 
      156: Instruction <= 32'b1011_10_1_0_111111111111111111110011 ; 
      160: Instruction <= 32'b1110_01_0_0100_1_0000_0001_000000000000; 
      164: Instruction <= 32'b1110_01_0_0100_1_0000_0010_000000000100; 
      168: Instruction <= 32'b1110_01_0_0100_1_0000_0011_000000001000; 
      172: Instruction <= 32'b1110_01_0_0100_1_0000_0100_000000001100; 
      176: Instruction <= 32'b1110_01_0_0100_1_0000_0101_000000010000; 
      180: Instruction <= 32'b1110_01_0_0100_1_0000_0110_000000010100; 
      184: Instruction <= 32'b1110_10_1_0_111111111111111111111111 ; 
      default : Instruction = 32'b0;
    endcase
  end
endmodule






































