module Controller_tb();
   parameter bitwidth = 32;
   
   reg [3:0] opcode;
   reg [3:0] func;

   wire allowBr;
   wire brBaseMux;
   wire rs1Mux;
   wire [1:0] rs2Mux;
   wire [1:0] alu2Mux;
   wire [3:0] aluOp;
   wire [3:0] cmpOp;
   wire wrReg;
   wire wrMem;
   wire [1:0] dstRegMux;
   
   wire [18:0] outputSignals;
   reg [18:0] output_expected;
   
   assign outputSignals = {allowBr,brBaseMux,rs1Mux,rs2Mux,alu2Mux,aluOp,cmpOp,wrReg,wrMem,dstRegMux};
   
   assign out_pass = (outputSignals == output_expected);

   task verify_output;
      begin
         if (!out_pass) begin
            $display("Testcase failed: unexpected signal output");
            $stop;
         end
      end
   endtask
   SCProcController controller(/*AUTOINST*/
                       // inputs
                       .opcode           (opcode[3:0]),
                       .func             (func[3:0]),
                       
                       // outputs
                       .allowBr           (allowBr),
                       .brBaseMux        (brBaseMux),
                       .rs1Mux           (rs1Mux),
                       .rs2Mux		 (rs2Mux[1:0]),
                       .alu2Mux          (alu2Mux[1:0]),
                       .aluOp            (aluOp[3:0]),
                       .cmpOp            (cmpOp[3:0]),
                       .wrReg            (wrReg),
                       .wrMem            (wrMem),
                       .dstRegMux        (dstRegMux[1:0]));
   initial begin
      opcode = 4'b1100;
      func = 4'b0111;
      output_expected = 19'b0_0_0_00_00_0111_0000_1_0_00;
      #10 verify_output();

      opcode = 4'b1100;
      func = 4'b0110;
      output_expected = 19'b0_0_0_00_00_0110_0000_1_0_00;
      #10 verify_output();

      opcode = 4'b1100;
      func = 4'b0000;
      output_expected = 19'b0_0_0_00_00_0000_0000_1_0_00;
      #10 verify_output();

      opcode = 4'b1100;
      func = 4'b0001;
      output_expected = 19'b0_0_0_00_00_0001_0000_1_0_00;
      #10 verify_output();

      opcode = 4'b1100;
      func = 4'b0010;
      output_expected = 19'b0_0_0_00_00_0010_0000_1_0_00;
      #10 verify_output();

      opcode = 4'b1100;
      func = 4'b1000;
      output_expected = 19'b0_0_0_00_00_1000_0000_1_0_00;
      #10 verify_output();

      opcode = 4'b1100;
      func = 4'b1001;
      output_expected = 19'b0_0_0_00_00_1001_0000_1_0_00;
      #10 verify_output();

      opcode = 4'b1100;
      func = 4'b1010;
      output_expected = 19'b0_0_0_00_00_1010_0000_1_0_00;
      #10 verify_output();

      opcode = 4'b0100;
      func = 4'b0111;
      output_expected = 19'b0_0_0_00_01_0111_0000_1_0_00;
      #10 verify_output();

      opcode = 4'b0100;
      func = 4'b0110;
      output_expected = 19'b0_0_0_00_01_0110_0000_1_0_00;
      #10 verify_output();

      opcode = 4'b0100;
      func = 4'b0000;
      output_expected = 19'b0_0_0_00_01_0000_0000_1_0_00;
      #10 verify_output();

      opcode = 4'b0100;
      func = 4'b0001;
      output_expected = 19'b0_0_0_00_01_0001_0000_1_0_00;
      #10 verify_output();

      opcode = 4'b0100;
      func = 4'b0010;
      output_expected = 19'b0_0_0_00_01_0010_0000_1_0_00;
      #10 verify_output();

      opcode = 4'b0100;
      func = 4'b1000;
      output_expected = 19'b0_0_0_00_01_1000_0000_1_0_00;
      #10 verify_output();

      opcode = 4'b0100;
      func = 4'b1001;
      output_expected = 19'b0_0_0_00_01_1001_0000_1_0_00;
      #10 verify_output();

      opcode = 4'b0100;
      func = 4'b1010;
      output_expected = 19'b0_0_0_00_01_1010_0000_1_0_00;
      #10 verify_output();

      opcode = 4'b0100;
      func = 4'b1111;
      output_expected = 19'b0_0_0_00_01_1111_0000_1_0_00;
      #10 verify_output();

      opcode = 4'b1101;
      func = 4'b0000;
      output_expected = 19'b0_0_0_00_00_0110_0000_1_0_11;
      #10 verify_output();

      opcode = 4'b1101;
      func = 4'b0011;
      output_expected = 19'b0_0_0_00_00_0110_0011_1_0_11;
      #10 verify_output();

      opcode = 4'b1101;
      func = 4'b0101;
      output_expected = 19'b0_0_0_00_00_0110_0101_1_0_11;
      #10 verify_output();

      opcode = 4'b1101;
      func = 4'b0110;
      output_expected = 19'b0_0_0_00_00_0110_0110_1_0_11;
      #10 verify_output();

      opcode = 4'b1101;
      func = 4'b1001;
      output_expected = 19'b0_0_0_00_00_0110_1001_1_0_11;
      #10 verify_output();

      opcode = 4'b1101;
      func = 4'b1010;
      output_expected = 19'b0_0_0_00_00_0110_1010_1_0_11;
      #10 verify_output();

      opcode = 4'b1101;
      func = 4'b1100;
      output_expected = 19'b0_0_0_00_00_0110_1100_1_0_11;
      #10 verify_output();

      opcode = 4'b1101;
      func = 4'b1111;
      output_expected = 19'b0_0_0_00_00_0110_1111_1_0_11;
      #10 verify_output();

      opcode = 4'b0101;
      func = 4'b0000;
      output_expected = 19'b0_0_0_00_01_0110_0000_1_0_11;
      #10 verify_output();

      opcode = 4'b0101;
      func = 4'b0011;
      output_expected = 19'b0_0_0_00_01_0110_0011_1_0_11;
      #10 verify_output();

      opcode = 4'b0101;
      func = 4'b0101;
      output_expected = 19'b0_0_0_00_01_0110_0101_1_0_11;
      #10 verify_output();

      opcode = 4'b0101;
      func = 4'b0110;
      output_expected = 19'b0_0_0_00_01_0110_0110_1_0_11;
      #10 verify_output();

      opcode = 4'b0101;
      func = 4'b1001;
      output_expected = 19'b0_0_0_00_01_0110_1001_1_0_11;
      #10 verify_output();

      opcode = 4'b0101;
      func = 4'b1010;
      output_expected = 19'b0_0_0_00_01_0110_1010_1_0_11;
      #10 verify_output();

      opcode = 4'b0101;
      func = 4'b1100;
      output_expected = 19'b0_0_0_00_01_0110_1100_1_0_11;
      #10 verify_output();

      opcode = 4'b0101;
      func = 4'b1111;
      output_expected = 19'b0_0_0_00_01_0110_1111_1_0_11;
      #10 verify_output();

      opcode = 4'b0111;
      func = 4'b0000;
      output_expected = 19'b0_0_0_00_01_0111_0000_1_0_01;
      #10 verify_output();

      opcode = 4'b0011;
      func = 4'b0000;
      output_expected = 19'b0_0_0_01_01_0111_0000_0_1_00;
      #10 verify_output();

      opcode = 4'b0010;
      func = 4'b0000;
      output_expected = 19'b1_0_1_10_00_0110_0000_0_0_00;
      #10 verify_output();

      opcode = 4'b0010;
      func = 4'b0001;
      output_expected = 19'b1_0_1_10_10_0110_0101_0_0_00;
      #10 verify_output();

      opcode = 4'b0010;
      func = 4'b0010;
      output_expected = 19'b1_0_1_10_10_0110_0110_0_0_00;
      #10 verify_output();

      opcode = 4'b0010;
      func = 4'b0011;
      output_expected = 19'b1_0_1_10_00_0110_0011_0_0_00;
      #10 verify_output();

      opcode = 4'b0010;
      func = 4'b0101;
      output_expected = 19'b1_0_1_10_00_0110_0101_0_0_00;
      #10 verify_output();

      opcode = 4'b0010;
      func = 4'b0110;
      output_expected = 19'b1_0_1_10_00_0110_0110_0_0_00;
      #10 verify_output();

      opcode = 4'b0010;
      func = 4'b1000;
      output_expected = 19'b1_0_1_10_10_0110_1100_0_0_00;
      #10 verify_output();

      opcode = 4'b0010;
      func = 4'b1001;
      output_expected = 19'b1_0_1_10_00_0110_1001_0_0_00;
      #10 verify_output();

      opcode = 4'b0010;
      func = 4'b1010;
      output_expected = 19'b1_0_1_10_00_0110_1010_0_0_00;
      #10 verify_output();

      opcode = 4'b0010;
      func = 4'b1011;
      output_expected = 19'b1_0_1_10_00_0110_1111_0_0_00;
      #10 verify_output();

      opcode = 4'b0010;
      func = 4'b1100;
      output_expected = 19'b1_0_1_10_11_0110_1100_0_0_00;
      #10 verify_output();

      opcode = 4'b0010;
      func = 4'b1101;
      output_expected = 19'b1_0_1_10_10_0110_1001_0_0_00;
      #10 verify_output();

      opcode = 4'b0010;
      func = 4'b1110;
      output_expected = 19'b1_0_1_10_10_0110_1010_0_0_00;
      #10 verify_output();

      opcode = 4'b0010;
      func = 4'b1111;
      output_expected = 19'b1_0_1_10_10_0110_1111_0_0_00;
      #10 verify_output();

      opcode = 4'b0110;
      func = 4'b0000;
      output_expected = 19'b1_1_0_00_00_0000_0000_1_0_10;
      #10 verify_output();

   end



endmodule