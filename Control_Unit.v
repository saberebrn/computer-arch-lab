`define MOV_ALU_CMD 4'b0001
`define MOVN_ALU_CMD 4'b1001
`define ADD_ALU_CMD 4'b0010
`define ADC_ALU_CMD 4'b0011
`define SUB_ALU_CMD 4'b0100
`define SBC_ALU_CMD 4'b0101
`define AND_ALU_CMD 4'b0110
`define ORR_ALU_CMD 4'b0111
`define EOR_ALU_CMD 4'b1000
`define CMP_ALU_CMD 4'b1100
`define TST_ALU_CMD 4'b1110
`define LDR_ALU_CMD 4'b1010
`define STR_ALU_CMD 4'b1010

`define MOV_OPCODE 4'b1101
`define MOVN_OPCODE 4'b1111
`define ADD_OPCODE 4'b0100
`define ADC_OPCODE 4'b0101
`define SUB_OPCODE 4'b0010
`define SBC_OPCODE 4'b0110
`define AND_OPCODE 4'b0000
`define ORR_OPCODE 4'b1100
`define EOR_OPCODE 4'b0001
`define CMP_OPCODE 4'b1010
`define TST_OPCODE 4'b1000
`define LDR_OPCODE 4'b0100
`define STR_OPCODE 4'b0100

`define MODE_MEM 2'b01
`define MODE_BRANCH 3'b10
`define MODE_NORMAL 2'b00 

module Control_Unit(
  input[1:0] mode, input[3:0] opcode, input S_in,
  output reg[3:0] exec_cmd,
  output reg mem_read_enable, mem_write_enable, wb_en, branch_enable, S_out
);

  always@(mode, opcode, S_in) begin
      {exec_cmd, mem_read_enable, mem_write_enable, wb_en, branch_enable, S_out} <= 9'b000000000;
      case(mode)

        `MODE_MEM: begin
          exec_cmd <= `ADD_ALU_CMD;
          case(S_in)
            1'b1: begin
              mem_read_enable <= 1'b1;
              wb_en <= 1'b1;
            end
            1'b0: begin
              mem_write_enable <= 1'b1;
            end
          endcase
        end

        `MODE_BRANCH: begin
          branch_enable <= 1'b1;
        end

        `MODE_NORMAL: begin
          S_out <= S_in;
          case(opcode)

            `MOV_OPCODE: begin 
              wb_en <= 1'b1;
              exec_cmd <= `MOV_ALU_CMD;
            end
            `MOVN_OPCODE: begin 
              wb_en <= 1'b1;
              exec_cmd <= `MOVN_ALU_CMD;
            end
            `ADD_OPCODE: begin 
              wb_en <= 1'b1;
              exec_cmd <= `ADD_ALU_CMD;
            end
            `ADC_OPCODE: begin 
              wb_en <= 1'b1;
              exec_cmd <= `ADC_ALU_CMD;
            end
            `SUB_OPCODE: begin 
              wb_en <= 1'b1;
              exec_cmd <= `SUB_ALU_CMD;
            end
            `SBC_OPCODE: begin 
              wb_en <= 1'b1;
              exec_cmd <= `SBC_ALU_CMD;
            end
            `AND_OPCODE: begin 
              wb_en <= 1'b1;
              exec_cmd <= `AND_ALU_CMD;
            end
            `ORR_OPCODE: begin 
              wb_en <= 1'b1;
              exec_cmd <= `ORR_ALU_CMD;
            end
            `EOR_OPCODE: begin 
              wb_en <= 1'b1;
              exec_cmd <= `EOR_ALU_CMD;
            end
            `CMP_OPCODE: begin 
              S_out <= 1'b1;
              exec_cmd <= `CMP_ALU_CMD;
            end 
            `TST_OPCODE: begin
              S_out <= 1'b1;
              exec_cmd <= `TST_ALU_CMD;
            end
            `LDR_OPCODE: begin 
              wb_en <= 1'b1;
              exec_cmd <= `LDR_OPCODE;              
            end
            `STR_OPCODE: begin 
              exec_cmd <= `STR_ALU_CMD;
            end
        endcase 
      end
    endcase
  end
endmodule
