module Multiplexer2bit_tb();
   parameter bitwidth=32;
   /*AUTOREGINPUT*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg [bitwidth-1:0]   a,b;                    
   reg selector;
   // End of automatics
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [bitwidth-1:0]  out;                   
   // End of automatics
   
    Multiplexer2bit #(bitwidth) mult2(/*AUTOINST*/
                            // input
                            .a              (a[bitwidth-1:0]),
                            .b              (b[bitwidth-1:0]),
                            // output
                            .selector       (selector),
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
      a = 32'b00010001000100010001000100010001;
      b = 32'b00100010001000100010001000100010;
      selector = 1'b0;
      out_expected = 32'b00010001000100010001000100010001;
      #10 verify_output();

      a = 32'b00010001000100010001000100010001;
      b = 32'b00100010001000100010001000100010;
      selector = 1'b1;
      out_expected = 32'b00100010001000100010001000100010;

      #10 verify_output();

      $display("All tests finished");
   end

endmodule