module Alu_tb ();
   parameter bitwidth = 32;

   /*AUTOREGINPUT*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg signed [bitwidth-1:0]   a;                      // To dut of Alu.v
   reg [3:0]            alu_func;               // To dut of Alu.v
   reg signed [bitwidth-1:0]   b;                      // To dut of Alu.v
   reg [3:0]            cmp_func;               // To dut of Alu.v
   // End of automatics
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire                 flag;                   // From dut of Alu.v
   wire signed [bitwidth-1:0]  out;                    // From dut of Alu.v
   // End of automatics

   // Expected output signals (for verification)
   reg                 flag_expected;
   reg signed [bitwidth-1:0]  out_expected;
   wire out_pass;
   wire flag_pass;

   assign out_pass = (out == out_expected);
   assign flag_pass = (flag == flag_expected);

   task verify_output;
      begin
         if (!out_pass) begin
            $display("Testcase failed: unexpected ALU output");
            $stop;
         end
         if (!flag_pass) begin
            $display("Testcase failed: unexpected ALU flag");
            $stop;
         end
      end
   endtask

   Alu #(bitwidth) dut(/*AUTOINST*/
                       // Outputs
                       .flag            (flag),
                       .out             (out[bitwidth-1:0]),
                       // Inputs
                       .a               (a[bitwidth-1:0]),
                       .b               (b[bitwidth-1:0]),
                       .alu_func        (alu_func[3:0]),
                       .cmp_func        (cmp_func[3:0]));

   initial begin
   
      //ADD TEST
      // Case 1
      a = 32'd40;
      b = 32'd20;
      alu_func = 4'b0111;
      cmp_func = 4'b0000;
      out_expected = 32'd60;
      flag_expected = 1'b1;

      #10 verify_output();
      
      // Case 2
      a = -32'd40;
      b = 32'd20;
      alu_func = 4'b0111;
      cmp_func = 4'b0000;
      out_expected = -32'd20;
      flag_expected = 1'b1;
      
      #10 verify_output();

      // Case 3
      a = -32'd40;
      b = -32'd20;
      alu_func = 4'b0111;
      cmp_func = 4'b0000;
      out_expected = -32'd60;
      flag_expected = 1'b1;

      #10 verify_output();

      // Case 4
      a = 32'd40;
      b = -32'd20;
      alu_func = 4'b0111;
      cmp_func = 4'b0000;
      out_expected = 32'd20;
      flag_expected = 1'b1;

      #10 verify_output();
      
       //SUB TEST
      // Case 5
      a = 32'd40;
      b = 32'd20;
      alu_func = 4'b0110;
      cmp_func = 4'b0000;
      out_expected = 32'd20;
      flag_expected = 1'b1;
      
      // Case 6
      a = 32'd40;
      b = -32'd20;
      alu_func = 4'b0110;
      cmp_func = 4'b0000;
      out_expected = 32'd60;
      flag_expected = 1'b1;
      #10 verify_output();
      
      // Case 7
      a = -32'd40;
      b = 32'd20;
      alu_func = 4'b0110;
      cmp_func = 4'b0000;
      out_expected = -32'd60;
      flag_expected = 1'b1;
      #10 verify_output();
      
      // Case 8
      a = -32'd40;
      b = -32'd20;
      alu_func = 4'b0110;
      cmp_func = 4'b0000;
      out_expected = -32'd20;
      flag_expected = 1'b1;
      #10 verify_output();
      
      //AND
      // Case 9
      a = 32'b01110111011101110111011101110111;
      b = 32'b00010001000100010001000100010001;
      alu_func = 4'b0000;
      cmp_func = 4'b0000;
      out_expected = 32'b00010001000100010001000100010001;
      flag_expected = 1'b1;

      #10 verify_output();
      
      //OR
      // Case 10
      a = 32'b01110111011101110111011101110111;
      b = 32'b00010001000100010001000100010001;
      alu_func = 4'b0001;
      cmp_func = 4'b0000;
      out_expected = 32'b01110111011101110111011101110111;
      flag_expected = 1'b1;

      #10 verify_output();
      //XOR
      // Case 11
      a = 32'b01110111011101110111011101110111;
      b = 32'b00010001000100010001000100010001;
      alu_func = 4'b0010;
      cmp_func = 4'b0000;
      out_expected = 32'b01100110011001100110011001100110;
      flag_expected = 1'b1;

      #10 verify_output();
      //NAND
      // Case 12
      a = 32'b01110111011101110111011101110111;
      b = 32'b00010001000100010001000100010001;
      alu_func = 4'b1000;
      cmp_func = 4'b0000;
      out_expected = 32'b11101110111011101110111011101110;
      flag_expected = 1'b1;

      #10 verify_output();
      //NOR
      // Case 13
      a = 32'b01110111011101110111011101110111;
      b = 32'b00010001000100010001000100010001;
      alu_func = 4'b1001;
      cmp_func = 4'b0000;
      out_expected = 32'b10001000100010001000100010001000;
      flag_expected = 1'b1;

      #10 verify_output();
      //XNOR
      // Case 14
      a = 32'b01110111011101110111011101110111;
      b = 32'b00010001000100010001000100010001;
      alu_func = 4'b1010;
      cmp_func = 4'b0000;
      out_expected = 32'b10011001100110011001100110011001;
      flag_expected = 1'b1;

      #10 verify_output();
      //MVHI
      // Case 15
      a = 32'b01110111011101110111011101110111;
      b = 32'b00010001000100010001000100010001;
      alu_func = 4'b1111;
      cmp_func = 4'b0000;
      out_expected = 32'b00010001000100010000000000000000;
      flag_expected = 1'b1;

      #10 verify_output();
      //TRUE
      // Case 16
      a = 32'b0000000000000000000000000000000;
      b = 32'b0000000000000000000000000000000;
      alu_func = 4'b0110;
      cmp_func = 4'b0000;
      out_expected = 32'b00000000000000000000000000000000;
      flag_expected = 1'b1;

      #10 verify_output();
      //FALSE
      // Case 17
      a = 32'b0000000000000000000000000000000;
      b = 32'b0000000000000000000000000000000;
      alu_func = 4'b0110;
      cmp_func = 4'b0011;
      out_expected = 32'b00000000000000000000000000000000;
      flag_expected = 1'b0;

      #10 verify_output();
      //A!=B
      // Case 18
      a = 32'd10;
      b = 32'd10;
      alu_func = 4'b0110;
      cmp_func = 4'b0101;
      out_expected = 32'd0;
      flag_expected = 1'b0;

      #10 verify_output();

      // Case 19
      a = 32'd9;
      b = 32'd10;
      alu_func = 4'b0110;
      cmp_func = 4'b0101;
      out_expected = -32'd1;
      flag_expected = 1'b1;

      #10 verify_output();
      
      // Case 20
      a = 32'd11;
      b = 32'd10;
      alu_func = 4'b0110;
      cmp_func = 4'b0101;
      out_expected = 32'd1;
      flag_expected = 1'b1;

      // Case 21
      a = -32'd10;
      b = 32'd10;
      alu_func = 4'b0110;
      cmp_func = 4'b0101;
      out_expected = -32'd20;
      flag_expected = 1'b1;
      #10 verify_output();
      
      // Case 22
      a = -32'd10;
      b = 32'd10;
      alu_func = 4'b0110;
      cmp_func = 4'b0101;
      out_expected = -32'd20;
      flag_expected = 1'b1;
      
      #10 verify_output();
     
      // Case 23
      a = -32'd10;
      b = -32'd10;
      alu_func = 4'b0110;
      cmp_func = 4'b0101;
      out_expected = 32'd0;
      flag_expected = 1'b0;
      
      #10 verify_output();
      //A==B
      // Case 24
      a = 32'd10;
      b = 32'd10;
      alu_func = 4'b0110;
      cmp_func = 4'b0110;
      out_expected = 32'd0;
      flag_expected = 1'b1;

      #10 verify_output();

      // Case 25
      a = -32'd10;
      b = -32'd10;
      alu_func = 4'b0110;
      cmp_func = 4'b0110;
      out_expected = -32'd0;
      flag_expected = 1'b1;
      
      // Case 26
      a = 32'd10;
      b = -32'd10;
      alu_func = 4'b0110;
      cmp_func = 4'b0110;
      out_expected = 32'd20;
      flag_expected = 1'b0;


      #10 verify_output();
     
      //A<B
      // Case 27
      a = 32'd10;
      b = 32'd10;
      alu_func = 4'b0110;
      cmp_func = 4'b1001;
      out_expected = 32'd0;
      flag_expected = 1'b0;

      #10 verify_output();

      
      // Case 28
      a = 32'd10;
      b = -32'd9;
      alu_func = 4'b0110;
      cmp_func = 4'b1001;
      out_expected = 32'd19;
      flag_expected = 1'b0;
      
      #10 verify_output();
      
      // Case 29
      a = -32'd10;
      b = -32'd9;
      alu_func = 4'b0110;
      cmp_func = 4'b1001;
      out_expected = -32'd1;
      flag_expected = 1'b1;


      #10 verify_output();
      
      
      
      // Case 30
      a = -32'd10;
      b = -32'd10;
      alu_func = 4'b0110;
      cmp_func = 4'b1010;
      out_expected = 32'd0;
      flag_expected = 1'b1;
      
      #10 verify_output();

      // Case 31
      a = -32'd10;
      b = 32'd9;
      alu_func = 4'b0110;
      cmp_func = 4'b1010;
      out_expected = -32'd19;
      flag_expected = 1'b0;

      #10 verify_output();
      
      // Case 32
      a = 32'd10;
      b = -32'd9;
      alu_func = 4'b0110;
      cmp_func = 4'b1010;
      out_expected = 32'd19;
      flag_expected = 1'b1;

      #10 verify_output();
      //A<=B
      // Case 33
      a = -32'd10;
      b = -32'd10;
      alu_func = 4'b0110;
      cmp_func = 4'b1100;
      out_expected = 32'd0;
      flag_expected = 1'b1;
      
      #10 verify_output();

      // Case 34
      a = -32'd10;
      b = 32'd9;
      alu_func = 4'b0110;
      cmp_func = 4'b1100;
      out_expected = -32'd19;
      flag_expected = 1'b1;

      #10 verify_output();
      
      // Case 35
      a = 32'd10;
      b = -32'd9;
      alu_func = 4'b0110;
      cmp_func = 4'b1100;
      out_expected = 32'd19;
      flag_expected = 1'b0;

      #10 verify_output();
      
      //A>B
      // Case 36
      a = -32'd10;
      b = -32'd10;
      alu_func = 4'b0110;
      cmp_func = 4'b1111;
      out_expected = 32'd0;
      flag_expected = 1'b0;
      
      #10 verify_output();

      // Case 37
      a = -32'd10;
      b = 32'd9;
      alu_func = 4'b0110;
      cmp_func = 4'b1111;
      out_expected = -32'd19;
      flag_expected = 1'b0;

      #10 verify_output();
      
      // Case 38
      a = 32'd10;
      b = -32'd9;
      alu_func = 4'b0110;
      cmp_func = 4'b1111;
      out_expected = 32'd19;
      flag_expected = 1'b1;

      #10 verify_output();

      

      
      $display("All tests finished");
   end

endmodule // Alu_tb

// Local Variables:
// verilog-library-directories:("../src" ".")
// verilog-library-extensions:(".v" ".h")
// End:
