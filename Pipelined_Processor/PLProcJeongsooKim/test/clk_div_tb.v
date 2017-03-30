module clk_div_tb();
   reg clk;
   reg reset;
   wire clk_out;

   ClockDivider #(2,2'b10) dut(clk, reset, clk_out);

   // Generate test clock
   initial clk = 1'b0;
   always #(1)
     clk = ~clk;

   // Run some test signals
   initial begin
      reset = 1'b1;

      #5 reset = 1'b0;          // release the reset and start

      #40 $stop;
   end // initial begin
endmodule // clk_div_tb
