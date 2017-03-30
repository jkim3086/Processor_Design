module multiplexer4bit_tb();

   parameter bitwidth=32;
   /*AUTOREGINPUT*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg [bitwidth-1:0]   a,b,c,d;                    
   reg[1:0] selector;
   // End of automatics
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [bitwidth-1:0]  out;                   
   // End of automatics
   
    Multiplexer4bit #(bitwidth) mult4(/*AUTOINST*/
                            // input
                            .a              (a[bitwidth-1:0]),
                            .b              (b[bitwidth-1:0]),
                            .c              (c[bitwidth-1:0]),
                            .d              (d[bitwidth-1:0]),
                            // output
                            .selector       (selector[1:0]),
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
      c = 32'b00110011001100110011001100110011;
      d = 32'b01000100010001000100010001000100;
      selector = 2'b00;
      out_expected = 32'b00010001000100010001000100010001;
      #10 verify_output();

      selector = 2'b01;
      out_expected = 32'b00100010001000100010001000100010;

      #10 verify_output();
      
      selector = 2'b10;
      out_expected = 32'b00110011001100110011001100110011;

      #10 verify_output();
      
      selector = 2'b11;
      out_expected = 32'b01000100010001000100010001000100;

      #10 verify_output();

      $display("All tests finished");
   end

endmodule