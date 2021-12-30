module test_bench();
  reg clk = 0;
  reg rst = 1;
  reg CLK = 0;
  reg forwardin_en = 1;
  always #20 clk = ~clk;
  always #40 CLK = ~CLK;

  initial begin
    #10 rst = 0;
    #20000 $stop;
  end
  top_level arm(clk, rst, CLK, rst, forwardin_en);
endmodule
