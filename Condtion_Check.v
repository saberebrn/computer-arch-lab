`define COND_EQ 4'b0000
`define COND_NE 4'b0001
`define COND_CS_HS 4'b0010
`define COND_CC_LO 4'b0011
`define COND_MI 4'b0100
`define COND_PL 4'b0101
`define COND_VS 4'b0110
`define COND_VC 4'b0111
`define COND_HI 4'b1000
`define COND_LS 4'b1001
`define COND_GE 4'b1010
`define COND_LT 4'b1011
`define COND_GT 4'b1100
`define COND_LE 4'b1101
`define COND_AL 4'b1110
`define COND_NK 4'b1111 

module Condition_Check(input[3:0] status, input[3 : 0] Condition, output reg Out);
  wire N, zero,C,V;
	assign zero = status[3];
	assign C = status[2];
	assign N = status[1];
	assign V = status[0];
	always@(status, Condition)begin
	  case(Condition)
	    `COND_EQ : Out = zero ;
			`COND_NE : Out = ~zero ;
			`COND_CS_HS : Out = C ;
			`COND_CC_LO : Out = ~C ;
			`COND_MI : Out = N ;
			`COND_PL : Out = ~N ;
			`COND_VS : Out = V ;
			`COND_VC : Out = ~V ;
			`COND_HI : Out = ((C) & (~zero)) ;
			`COND_LS : Out = ((~C) | (zero)) ;
			`COND_GE : Out = (N == V) ;
			`COND_LT : Out = (N != V) ;
			`COND_GT : Out = ((zero == 0) & (N == V)) ;
			`COND_LE : Out = ((zero == 1) & (N != V)) ;
			`COND_AL : Out = 1'b1;
			`COND_NK : Out = 1'b0;
		endcase
	end
endmodule