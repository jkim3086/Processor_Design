
module ALU(src1, src2, opcode, data_out, cond_flag);
	parameter data_bit_width = 32;
	parameter op_bit_width = 5;
	
	input signed [data_bit_width-1:0] src1;
	input signed [data_bit_width-1:0] src2;	
	input [op_bit_width-1:0] opcode;
	output signed [data_bit_width-1:0] data_out;
	output cond_flag;
	
	reg signed [data_bit_width-1:0] result;
	reg branch_result;

	always @ (*) begin
		case (opcode)
			// ADD, ADDI, LW, SW,  JAL
			5'b00000:begin 
						result <= src1 + src2;
					end
			// SUB, SUBI
			5'b00001:begin 
						result <= src1 - src2;
					end
			// AND, ANDI
			5'b00010:begin 
						result <= (src1 & src2);
					end
			// OR, ORI
			5'b00011:begin 
						result <= src1 | src2;
					end
			// XOR, XORI
			5'b00100:begin 
						result <= src1 ^ src2;
					end
			// NAND, NANDI
			5'b00101:begin 
						result <= ~(src1 & src2);
					end
			// NOR, NORI
			5'b00110:begin 
						result <= ~(src1 | src2);
					end
			// XNOR, XNORI
			5'b00111:begin 
						result <= ~(src1 ^ src2);
					end
			// F, FI, BF
			5'b01000:begin
						result <= 32'b0;
					end
			// EQ, EQI, BEQ, BEQZ
			5'b01001:begin 
						if(src1 == src2) begin
							result <= 1;
						end
						else begin	
							result <= 0;
						end
						branch_result <= result[0];
					end
			// LT, LTI, BLT, BLTZ
			5'b01010:begin 
						if(src1 < src2) begin
							result <= 1;
						end
						else begin	
							result <= 0;
						end
						branch_result <= result[0];						
					end
			// LTE, LTEI, BLTE, BLTEZ
			5'b01011:begin 
						if(src1 <= src2) begin
							result <= 1;
						end
						else begin	
							result <= 0;
						end	
						branch_result <= result[0];
					end
			// T, TI, BT
			5'b01100:begin 
						result <= 1;
						branch_result <= result[0];
					end
			// NE, NEI, BNE, BNEZ
			5'b01101:begin 
						if(src1 != src2) begin
							result <= 1;
						end
						else begin	
							result <= 0;
						end
						branch_result <= result[0];
					end
			// GTE, GTEI, BGTE, BGTEZ
			5'b01110:begin 
						if(src1 >= src2) begin
							result <= 1;
						end
						else begin	
							result <= 0;
						end
						branch_result <= result[0];		
					end
			// GT, GTI, BGT, BGTZ
			5'b01111:begin 
						if(src1 > src2) begin
							result <= 1;
						end else
						begin	
							result <= 0;
						end
						branch_result <= result[0];
					end
			// MVHI
			5'b10000:begin 
						result <= ((src2 & 32'h0000FFFF) << 16);
					end
			// BLTZ
			5'b10001:begin 
						// Checking 2's complement bit 
						if(src1[31]) begin
							result <= 1;
						end
						else begin
							result <= 0;
						end
						branch_result <= result[0];
					end
			// BLTEZ
			5'b10010:begin 
						// Checking 2's complement bit 
						if(src1[31] == 1'b1 || src1 == 32'd0) begin
							result <= 1;
						end
						else begin
							result <= 0;
						end
						branch_result <= result[0];
					end
			default:begin
						result <= 0;
						branch_result <= 0;
					end
		endcase
	end

	assign data_out = result;
	assign cond_flag = branch_result;
		
endmodule
				 
