module SRAM_controller(
    input clk, rst, write_en, read_en,
    input [31:0] address, write_data,
    inout [31:0] sram_dq,
    output ready, sram_ub_n, sram_lb_n, sram_we_n, sram_ce_n, sram_oe_n,
    output [16:0] sram_addr,
    output [31:0] read_data
);
    assign sram_ub_n = 1'b0;   
    assign sram_lb_n = 1'b0;
    assign sram_ce_n = 1'b0;
    assign sram_oe_n = 1'b0;

    reg ready_reg, sram_we_n_reg;
    reg [31:0] read_data_reg;
    wire [31:0] addr_tmp;

    assign addr_tmp = address - 32'd1024;  
    assign sram_addr = addr_tmp[18:2];
    assign ready = ready_reg;
    assign sram_we_n = sram_we_n_reg;
    assign #30 sram_dq = ~sram_we_n ? write_data : 32'bzzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz_zzzz;
    assign read_data = read_data_reg;
    parameter IDLE = 2'b00, READ_STATE = 2'b01, WRITE_STATE = 2'b10;

    reg [1 : 0] ps, ns;
    reg [2 : 0] sram_counter;

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            ps <= IDLE;
        end else
            ps <= ns;
    end

    always @(posedge clk, posedge rst) begin
        case (ps)
            IDLE: begin
                sram_counter <= 3'd0;
            end

            READ_STATE: begin  
                if (sram_counter == 3'd6)
                    sram_counter <= 3'd0;
                else
                    sram_counter <= sram_counter + 1;
            end
            
            WRITE_STATE: begin  
                if (sram_counter == 3'd6)
                    sram_counter <= 3'd0;
                else
                    sram_counter <= sram_counter + 1;
            end
        endcase
    end

    always @(ps, read_en, write_en, sram_counter, rst) begin
        if (rst) begin
            ready_reg <= 1'b1;
            sram_we_n_reg <= 1'b1;
            read_data_reg <= 32'b0;
            ns <= IDLE;
        end
        else begin
            case (ps)
                IDLE: begin
                    ready_reg = 1'b1;
                    sram_we_n_reg = 1'b1;
                    if (read_en) begin
                        ns = READ_STATE;
                        ready_reg = 1'b0;
                    end
                    else if (write_en) begin
                        ns = WRITE_STATE;
                        ready_reg = 1'b0;
                    end
                end

                READ_STATE: begin  
                    sram_we_n_reg = 1'b1;              
                    case (sram_counter)
                        3'd6: begin
                            ns = IDLE;
                            ready_reg = 1'b1;
                            read_data_reg <= sram_dq;
                        end
                        default: begin
                            ready_reg = 1'b0;
                        end
                    endcase
                end

                WRITE_STATE: begin       
                    sram_we_n_reg = 1'b0;
                    case (sram_counter)
                        3'd6: begin
                            ns = IDLE;
                            ready_reg = 1'b1;
                            sram_we_n_reg <= 1'b1;
                        end
                        default: begin
                            ready_reg = 1'b0;
                        end
                    endcase
                end
            endcase
        end
    end
endmodule