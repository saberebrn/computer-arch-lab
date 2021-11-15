module ALU(
    input c,
    input [31:0] alu_in1, alu_in2,
    input [3:0] alu_command,
    output reg [31:0] alu_out,
    output reg [3:0] status_register
);

    always@(alu_in1, alu_in2, alu_command)begin
        alu_out = 32'b0; 
        status_register = 4'b0;

        case(alu_command)
            4'b0001 : begin 
                alu_out = alu_in2;  
            end
            4'b1001 : begin 
                alu_out = ~alu_in2; 
            end
            4'b0010 : begin 
                {status_register[2], alu_out} = alu_in1 + alu_in2; 
                status_register[0] = (
                    (
                        (~alu_out[31]) & alu_in1[31] & alu_in2[31]
                    ) | (
                        alu_out[31] & (~alu_in1[31]) & (~alu_in2[31])
                    )
                ); 
            end
            4'b0011 : begin 
                {status_register[2], alu_out} = alu_in1 + alu_in2 + c;  
                status_register[0] = (
                    (
                        (~alu_out[31]) & alu_in1[31] & alu_in2[31]
                    ) | (
                        alu_out[31] & (~alu_in1[31]) & (~alu_in2[31])
                    )
                ); 
            end
            4'b0100 : begin 
                {status_register[2], alu_out} = alu_in1 - alu_in2; 
                status_register[0] = (
                    (
                        (~alu_out[31]) & alu_in1[31] & (~alu_in2[31])
                    ) | (
                        alu_out[31] & (~alu_in1[31]) & (alu_in2[31])
                    )
                ); 
            end
            4'b0101 : begin 
                {status_register[2], alu_out} = alu_in1 - alu_in2 - (~c); 
                status_register[0] = (
                    (
                        (~alu_out[31]) & alu_in1[31] & (~alu_in2[31])
                    ) | (
                        alu_out[31] & (~alu_in1[31]) & (alu_in2[31])
                    )
                );
            end
            4'b0110 : begin 
                alu_out = alu_in1 & alu_in2; 
            end
            4'b0111 : begin 
                alu_out = alu_in1 | alu_in2;  
            end
            4'b1000 : begin 
                alu_out = alu_in1 ^ alu_in2;  
            end
        endcase

        status_register[3] = (alu_out == 32'b0);
        status_register[1] = alu_out[31] ;

    end

endmodule
