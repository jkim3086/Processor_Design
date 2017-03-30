module SetFlushStall(reg1_forward_sel, reg2_forward_sel, takeBr, opcode_EX,
					 stall, flush);

   input reg1_forward_sel;
   input reg2_forward_sel;
   input takeBr;
   input [3:0] opcode_EX;
   
   output reg stall;
   output reg flush;
   
   // 0: no forwarding; 1: from exe; 2: from mem; 3: from wb
   
   always @(*) begin
		if(opcode_EX == 4'b0111) begin
			if(reg1_forward_sel == 1 || reg2_forward_sel == 1) begin
				stall <= 1'b1;
				flush <= 1'b1;
			end
		end
		else if(takeBr == 1'b1) begin
				flush <= 1'b1;
		end
		else begin
		    stall <= 1'b0;
				flush <= 1'b0;
		end
   end
endmodule
