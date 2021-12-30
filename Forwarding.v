module Forwarding(
  input forwarding_en, mem_wb_en, exe_wb_en,
  input [3:0]src1, src2, exe_dest, mem_dest,
  output [1:0]sel_src1, sel_src2
);

    assign sel_src1 = ~forwarding_en ? 2'b00
            : ((src1 == exe_dest) && (exe_wb_en == 1'b1)) ? 2'b01
            : ((src1 == mem_dest) && (mem_wb_en == 1'b1)) ? 2'b10
            : 2'b00;
    
    assign sel_src2 = ~forwarding_en ? 2'b00
            : ((src2 == exe_dest) && (exe_wb_en == 1'b1)) ? 2'b01
            : ((src2 == mem_dest) && (mem_wb_en == 1'b1)) ? 2'b10
            : 2'b00;

endmodule
