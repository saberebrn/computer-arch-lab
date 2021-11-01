module test_bench();
  reg clk = 0;
  reg rst = 1;
  always #20 clk = ~clk;

  initial begin
    #30 rst = 0;
    #20000 $stop;
  end
  top_level arm(clk, rst);
endmodule
