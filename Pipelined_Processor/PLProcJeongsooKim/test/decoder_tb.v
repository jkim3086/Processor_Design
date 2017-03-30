module decoder_tb ();
   parameter bitwidth = 32;

   /*AUTOREGINPUT*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg [bitwidth-1:0]   inst;                    
   // End of automatics
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [3:0]  op_code;                   
   wire [3:0]  func_code;                   
   wire [3:0]  rd;                   
   wire [3:0]  rs1;                   
   wire [3:0]  rs2;
   wire[15:0] imm;
   

   // End of automatics

   Decoder #(bitwidth) decoder(/*AUTOINST*/
                            // input
                            .inst               (inst[bitwidth-1:0]),
                            // output
                            .op_code            (op_code[3:0]),
                            .func_code          (func_code[3:0]),
                            .rd                (rd[3:0]),
                            .rs1                (rs1[3:0]),
                            .rs2                (rs2[3:0]),
                            .imm		(imm[15:0])
                            );

   reg [3:0]   op_code_expected;
   reg [3:0]   func_code_expected;
   reg [3:0]   rd_expected;
   reg [3:0]   rs1_expected;
   reg [3:0]   rs2_expected;
   reg [15:0]  imm_expected;
   wire op_code_pass;
   wire func_code_pass;
   wire rd_pass;
   wire rs1_pass;
   wire rs2_pass;
   wire imm_pass;


   assign op_code_pass = (op_code == op_code_expected);
   assign func_code_pass = (func_code == func_code_expected);
   assign rd_pass = (rd == rd_expected);
   assign rs1_pass = (rs1 == rs1_expected);
   assign rs2_pass = (rs2 == rs2_expected);
   assign imm_pass = (imm == imm_expected);

   task verify_output;
      begin
         if (!op_code_pass) begin
            $display("Testcase failed: unexpected opcode value");
            $stop;
         end
         if (!func_code_pass) begin
            $display("Testcase failed: unexpected function code value");
            $stop;
         end
         if (!rd_pass) begin
            $display("Testcase failed: unexpected rd value");
            $stop;
         end      
         if (!rs1_pass) begin
             $display("Testcase failed: unexpected rs1 value");
            $stop;
         end     
         if (!rs2_pass) begin
            $display("Testcase failed: unexpected rs2 value");
            $stop;
         end
         if (!imm_pass) begin
            $display("Testcase failed: unexpected imm value");
	    $stop;
         end
      end
   endtask

   initial begin
      //ADD
      inst = 32'b1100_0111_0001_0010_0100_0000_0000_0000;
      op_code_expected = 4'b1100;
      func_code_expected = 4'b0111;
      rd_expected = 4'b0001;
      rs1_expected = 4'b0010;
      rs2_expected = 4'b0100;
      imm_expected = 16'b0100_0000_0000_0000;

      #10 verify_output();
      
      //ADDI
      inst = 32'b0100_0111_0001_0010_1111_1111_1111_1111;
      op_code_expected = 4'b0100;
      func_code_expected = 4'b0111;
      rd_expected = 4'b0001;
      rs1_expected = 4'b0010;
      rs2_expected = 4'b1111;
      imm_expected = 16'b1111_1111_1111_1111;
      
      #10 verify_output();
      
      //F
      inst = 32'b1101_0011_0001_0010_1111_1111_1111_1111;
      op_code_expected = 4'b1101;
      func_code_expected = 4'b0011;
      rd_expected = 4'b0001;
      rs1_expected = 4'b0010;
      rs2_expected = 4'b1111;
      imm_expected = 16'b1111_1111_1111_1111;
      
      #10 verify_output();


      //TI
      inst = 32'b0101_1111_0001_0010_1111_1111_1111_1111;
      op_code_expected = 4'b0101;
      func_code_expected = 4'b1111;
      rd_expected = 4'b0001;
      rs1_expected = 4'b0010;
      rs2_expected = 4'b1111;
      imm_expected = 16'b1111_1111_1111_1111;
      
      
      #10 verify_output();   
      
      //BEQ
      inst = 32'b0010_0101_0001_0010_1111_1111_1111_1111;
      op_code_expected = 4'b0010;
      func_code_expected = 4'b0101;
      rd_expected = 4'b0001;
      rs1_expected = 4'b0010;
      rs2_expected = 4'b1111;
      imm_expected = 16'b1111_1111_1111_1111;
      
      #10 verify_output();
      
      //SW
      inst = 32'b0011_0000_0001_0010_1111_1111_1111_1111;
      op_code_expected = 4'b0011;
      func_code_expected = 4'b0000;
      rd_expected = 4'b0001;
      rs1_expected = 4'b0010;
      rs2_expected = 4'b1111;
      imm_expected = 16'b1111_1111_1111_1111;

     
      #10 verify_output();

      //LW
      inst = 32'b0111_0000_0001_0010_1111_1111_1111_1111;
      op_code_expected = 4'b0111;
      func_code_expected = 4'b0000;
      rd_expected = 4'b0001;
      rs1_expected = 4'b0010;
      rs2_expected = 4'b1111;
      imm_expected = 16'b1111_1111_1111_1111;

     
      #10 verify_output();
      
      //JAL
      inst = 32'b0110_0000_0001_0010_1111_1111_1111_1111;
      op_code_expected = 4'b0110;
      func_code_expected = 4'b0000;
      rd_expected = 4'b0001;
      rs1_expected = 4'b0010;
      rs2_expected = 4'b1111;
      imm_expected = 16'b1111_1111_1111_1111;

      #10 verify_output();
      $display("All tests finished");
   end

endmodule // Shiftbit_tb

// Local Variables:
// verilog-library-directories:("../src" ".")
// verilog-library-extensions:(".v" ".h")
// End:
