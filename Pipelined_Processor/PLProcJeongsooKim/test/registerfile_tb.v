module registerfile_tb();
   parameter bitwidth=32;
   reg clk, reset, reg_wr_en;
   reg[3:0] reg_select1, reg_select2, wr_select;
   reg[bitwidth-1:0] wr_data;
   wire[bitwidth-1:0]reg_data1, reg_data2;

   RegisterFile #(bitwidth) reg_file(
         .clk (clk), 
         .reset (reset), 
         .reg_wr_en (reg_wr_en), 
         .wr_select (wr_select[3:0]),
         .reg_select1 (reg_select1[3:0]), 
         .reg_select2 (reg_select2[3:0]), 
         .reg_data1 (reg_data1[bitwidth-1:0]), 
         .reg_data2 (reg_data2[bitwidth-1:0]), 
         .wr_data (wr_data[bitwidth-1:0])   
      );
   
   reg[bitwidth-1:0] reg1_expected, reg2_expected;
   wire reg1_pass, reg2_pass;
   assign reg1_pass = (reg_data1 == reg1_expected);   
   assign reg2_pass = (reg_data2 == reg2_expected);

   
   initial clk = 1'b0;
   always #(5)
     clk = ~clk;
   


   task verify_output;
      begin
         if (!reg1_pass) begin
            $display("Testcase failed: unexpected register 1 value");
            $stop;
         end
         if (!reg2_pass) begin
            $display("Testcase failed: unexpected register 2 value");
            $stop;
         end
      end
   endtask
     
   initial begin
      //R0, R1
      reg_wr_en = 1'b1;
      wr_select = 4'b0000;
      wr_data = 32'd1;
      
      #10 
      wr_select = 4'b0001;
      wr_data = 32'd5;
      
      #10 
      reg_wr_en = 1'b0;
      reg_select1 = 4'b0000;
      reg_select2 = 4'b0001;
      reg1_expected = 32'd1;
      reg2_expected = 32'd5;
      #10 verify_output();
      
      //R2,R3
      reg_wr_en = 1'b1;
      wr_select = 4'b0010;
      wr_data = 32'd10;
      
      #10 
      wr_select = 4'b0011;
      wr_data = 32'd15;
      
      #10 
      reg_wr_en = 1'b0;
      reg_select1 = 4'b0010;
      reg_select2 = 4'b0011;
      reg1_expected = 32'd10;
      reg2_expected = 32'd15;
      #10 verify_output();
      
      //R4,R5
      reg_wr_en = 1'b1;
      wr_select = 4'b0100;
      wr_data = 32'd20;
      
      #10 
      wr_select = 4'b0101;
      wr_data = 32'd25;
      
      #10 
      reg_wr_en = 1'b0;
      reg_select1 = 4'b0100;
      reg_select2 = 4'b0101;
      reg1_expected = 32'd20;
      reg2_expected = 32'd25;
      #10 verify_output();
      
      //R6,R7
      reg_wr_en = 1'b1;
      wr_select = 4'b0110;
      wr_data = 32'd30;
      
      #10 
      wr_select = 4'b0111;
      wr_data = 32'd35;
      
      #10 
      reg_wr_en = 1'b0;
      reg_select1 = 4'b0110;
      reg_select2 = 4'b0111;
      reg1_expected = 32'd30;
      reg2_expected = 32'd35;
      #10 verify_output();
      
            
      //R8,R9
      reg_wr_en = 1'b1;
      wr_select = 4'b1000;
      wr_data = 32'd40;
      
      #10 
      wr_select = 4'b1001;
      wr_data = 32'd45;
      
      #10 
      reg_wr_en = 1'b0;
      reg_select1 = 4'b1000;
      reg_select2 = 4'b1001;
      reg1_expected = 32'd40;
      reg2_expected = 32'd45;
      #10 verify_output();
      
                  
      //R10,R11
      reg_wr_en = 1'b1;
      wr_select = 4'b1010;
      wr_data = 32'd50;
      
      #10 
      wr_select = 4'b1011;
      wr_data = 32'd55;
      
      #10 
      reg_wr_en = 1'b0;
      reg_select1 = 4'b1010;
      reg_select2 = 4'b1011;
      reg1_expected = 32'd50;
      reg2_expected = 32'd55;
      #10 verify_output();
      
      //R12,R13
      reg_wr_en = 1'b1;
      wr_select = 4'b1100;
      wr_data = 32'd60;
      
      #10 
      wr_select = 4'b1101;
      wr_data = 32'd65;
      
      #10 
      reg_wr_en = 1'b0;
      reg_select1 = 4'b1100;
      reg_select2 = 4'b1101;
      reg1_expected = 32'd60;
      reg2_expected = 32'd65;
      #10 verify_output();
      
      //R14,R15
      reg_wr_en = 1'b1;
      wr_select = 4'b1110;
      wr_data = 32'd70;
      
      #10 
      wr_select = 4'b1111;
      wr_data = 32'd75;
      
      #10 
      reg_wr_en = 1'b0;
      reg_select1 = 4'b1110;
      reg_select2 = 4'b1111;
      reg1_expected = 32'd70;
      reg2_expected = 32'd75;
      #10 verify_output();
      
      $display("All tests finished");
      
      //Test write enable 
      reg_wr_en = 1'b0;
      wr_select = 4'b0000;
      wr_data = 32'd10;
            
      reg_wr_en = 1'b0;
      wr_select = 4'b0001;
      wr_data = 32'd10;
                  
      #10 
      reg_select1 = 4'b0000;
      reg_select2 = 4'b0001;
      reg1_expected = 32'd1;
      reg2_expected = 32'd5;
      
      #10 verify_output();

      //test reset
      reset = 1'b1;
      
      #10
      reg_select1 = 4'b0000;
      reg_select2 = 4'b0001;
      reg1_expected = 32'd0;
      reg2_expected = 32'd0;
      
      #10 verify_output();


   end
   
endmodule
