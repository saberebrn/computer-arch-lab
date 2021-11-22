
module Hazard_Detection_Unit (
    input exe_wb_en, mem_wb_en, two_src,
    input [3:0] src1, src2, exe_dest, mem_dest,
    output hazard_detected
);

    assign hazard_detected = ((src1 == exe_dest) && (exe_wb_en == 1'b1)) ? 1'b1
            : ((src1 == mem_dest) && (mem_wb_en == 1'b1)) ? 1'b1
            : ((src2 == exe_dest) && (exe_wb_en == 1'b1) && (two_src == 1'b1)) ? 1'b1
            : ((src2 == mem_dest) && (mem_wb_en == 1'b1) && (two_src == 1'b1)) ? 1'b1
            : 1'b0;
endmodule