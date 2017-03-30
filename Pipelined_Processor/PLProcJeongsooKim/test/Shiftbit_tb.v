module Shiftbit_tb ();
   parameter bitwidth = 16;

   /*AUTOREGINPUT*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg [bitwidth-1:0]   din;                    // To dut of Shiftbit.v
   // End of automatics
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [bitwidth-1:0]  dout;                   // From dut of Shiftbit.v
   // End of automatics

   Shiftbit #(bitwidth) dut(/*AUTOINST*/
                            // Outputs
                            .dout               (dout[bitwidth-1:0]),
                            // Inputs
                            .din                (din[bitwidth-1:0]));

   reg [bitwidth-1:0]   dout_expected;
   wire pass;

   assign pass = (dout == dout_expected);

   task verify_output;
      if (!pass) begin
         $display("Testcase failed: unexpected shift output");
         $stop;
      end
   endtask

   initial begin
      din = 16'b0000_0001_0100_0001;
      dout_expected = 16'b0000_0101_0000_0100;

      #10 verify_output();

      din = 16'b1000_0000_0000_1100;
      dout_expected = 16'b0000_0000_0011_0000;

      #10 verify_output();

      $display("All tests finished");
   end

endmodule // Shiftbit_tb

// Local Variables:
// verilog-library-directories:("../src" ".")
// verilog-library-extensions:(".v" ".h")
// End:
