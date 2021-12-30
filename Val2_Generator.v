module Val2_Generator(
    input [31:0] instruction, rm,
    input [11:0] shift_operand,
    input immd, immadiate_32_enable, is_mem_command,
    output reg [31:0] val2_out
);

    reg [31:0] imd_shifted;
    reg [31:0] rm_rotated;
    integer i;
    integer j;

    always @(*) begin
        val2_out = 32'b0;
        if (immadiate_32_enable == 1) begin
            val2_out <= instruction;
        end
        else if (is_mem_command == 1) begin
            val2_out = {20'b0, shift_operand};
        end
        else begin
            if (immd == 1) begin 
                if (shift_operand[11:8] == 0) begin 
                    val2_out = {24'b0, shift_operand[7:0]};
                end
                else begin
                    val2_out = imd_shifted;
                end
            end
            else begin
                case(shift_operand[6:5])
                    2'b00: begin
                        val2_out = rm << {1'b0, shift_operand[11:7]};
                    end
                    2'b01: begin
                        val2_out = rm >> {1'b0, shift_operand[11:7]};
                    end
                    2'b10: begin
                        val2_out = rm >>> {1'b0, shift_operand[11:7]};
                    end
                    2'b11: begin
                        if (shift_operand[11:8] == 0) begin
                            val2_out = rm;
                        end
                        else begin
                            val2_out = rm_rotated;
                        end
                    end
                endcase
            end
        end
    end

    always @(*) begin
        rm_rotated = rm;
        for (i = 0; i < {1'b0, shift_operand[11:7]}; i = i + 1) begin
            rm_rotated = {rm_rotated[0], rm_rotated[31:1]}; 
        end
    end


    always @(*) begin
        imd_shifted = {24'b0, shift_operand[7:0]};
        for (j = 0; j < {1'b0, shift_operand[11:8]}; j = j + 1) begin
            imd_shifted = {imd_shifted[1], imd_shifted[0], imd_shifted[31:2]}; 
        end
    end

endmodule