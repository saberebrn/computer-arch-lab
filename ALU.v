module ALU(
    input c,
    input [31:0] alu_in1, alu_in2,
    input [3:0] alu_command,
    output reg [31:0] alu_out,
    output [3:0] status_register
);
    reg n, zero, c1, v;
    assign status_register = {zero, c1, n, v};
    always@(alu_in1, alu_in2, alu_command)begin
        alu_out <= 32'b0; 
         {c1, v} <= 4'b0;

        case(alu_command)
            4'b0001 : begin 
                alu_out <= alu_in2;  
            end
            4'b1001 : begin 
                alu_out <= ~alu_in2; 
            end
            4'b0010 : begin 
                {c1, alu_out} <= alu_in1 + alu_in2; 
                v = ((alu_in1[31] == alu_in2[31]) & (alu_out[31] != alu_in1[31]));
            end
            4'b0011 : begin 
                {c1, alu_out} <= alu_in1 + alu_in2 + c;  
                v = ((alu_in1[31] == alu_in2[31]) & (alu_out[31] != alu_in1[31]));
            end
            4'b0100 : begin 
                {c1, alu_out} <= {alu_in1[31], alu_in1} - {alu_in2[31], alu_in2} ; 
                v = ((alu_in1[31] != alu_in2[31]) & (alu_out[31] != alu_in1[31]));
            end
            4'b0101 : begin 
                {c1, alu_out} <= {alu_in1[31], alu_in1} - {alu_in2[31], alu_in2} - ((c) ? 33'd0 : 33'd1); 
                v = ((alu_in1[31] != alu_in2[31]) & (alu_out[31] != alu_in1[31]));
            end
            4'b0110 : begin 
                alu_out <= alu_in1 & alu_in2; 
            end
            4'b0111 : begin 
                alu_out <= alu_in1 | alu_in2;  
            end
            4'b1000 : begin 
                alu_out <= alu_in1 ^ alu_in2;  
            end
        endcase
    end

    always @(alu_out, alu_in1, alu_in2) begin
        zero <= (alu_out == 32'b0);
        n <= alu_out[31];
        case(alu_command)
            4'b0010 : begin 
                v = ((alu_in1[31] == alu_in2[31]) & (alu_out[31] != alu_in1[31]));
            end
            4'b0011 : begin 
                v = ((alu_in1[31] == alu_in2[31]) & (alu_out[31] != alu_in1[31]));
            end
            4'b0100 : begin 
                v = ((alu_in1[31] != alu_in2[31]) & (alu_out[31] != alu_in1[31]));
            end
            4'b0101 : begin 
                v = ((alu_in1[31] != alu_in2[31]) & (alu_out[31] != alu_in1[31]));
            end
        endcase
    end


endmodule
