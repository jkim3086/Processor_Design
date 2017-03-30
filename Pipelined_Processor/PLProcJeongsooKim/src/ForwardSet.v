module ForwardSet(reg_forward_sel,
			      regData,
				  aluResult_EX, pcIncremented_EX, condRegResult_EX, dstRegMuxSel_EX,
				  dataMemOut, 
				  wrRegData_WB,
				  dataOut);
				  
   parameter bitwidth = 32;

   input[bitwidth-1:0] regData;
   input[bitwidth-1:0] aluResult_EX;
   input[bitwidth-1:0] pcIncremented_EX;
   input[bitwidth-1:0] condRegResult_EX;
   input[1:0] dstRegMuxSel_EX;
   input[bitwidth-1:0] dataMemOut;
   input[bitwidth-1:0] wrRegData_WB;
   
   input[1:0] reg_forward_sel;
   
   reg [bitwidth-1:0] Ex_result;
   reg[bitwidth-1:0] out;
   
   output reg [bitwidth-1:0] dataOut;
   // 0: no forwarding; 1: from exe; 2: from mem; 3: from wb
   
   always @ (*) begin
		case (dstRegMuxSel_EX)
          4'b00 : Ex_result <= aluResult_EX;
          //4'b01 : 
		  4'b10 : Ex_result <= pcIncremented_EX; 
          4'b11 : Ex_result <= condRegResult_EX;
          default: out <= {bitwidth{1'b0}};
        endcase
        case (reg_forward_sel)
          4'b00 : dataOut <= regData;
		  4'b01 : dataOut <= Ex_result;	
          4'b10 : dataOut <= dataMemOut;
          4'b11 : dataOut <= wrRegData_WB;		  
          default: out <= {bitwidth{1'b0}};
        endcase
   end

endmodule
