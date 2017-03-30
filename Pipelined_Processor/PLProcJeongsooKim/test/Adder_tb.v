module Adder_tb();
   parameter bitwidth=32;
   /*AUTOREGINPUT*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg [bitwidth-1:0]   a,b;                    // To dut of Shiftbit.v
   // End of automatics
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [bitwidth-1:0]  out;                   // From dut of Shiftbit.v
   // End of automatics
   
      Adder #(bitwidth) add(/*AUTOINST*/
                            // input
                            .a              (a[bitwidth-1:0]),
                            .b              (b[bitwidth-1:0]),
                            // output
                            .out                (out[bitwidth-1:0]));

   reg [bitwidth-1:0]   out_expected;
   wire pass;

   assign pass = (out == out_expected);

   task verify_output;
      if (!pass) begin
         $display("Testcase failed: unexpected shift output");
         $stop;
      end
   endtask

   initial begin
      a = 32'b01110111011101110111011101110111;
      b = 32'b00010001000100010001000100010001;
      out_expected = 32'b10001000100010001000100010001000;
      #10 verify_output();

      a = 32'b10001000100010001000100010001000;
      b = 32'b00010001000100010001000100010001;
      out_expected = 32'b10011001100110011001100110011001;

      #10 verify_output();

      $display("All tests finished");
   end

endmodule