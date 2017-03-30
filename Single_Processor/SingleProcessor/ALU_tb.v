`timescale 1ns / 1ps

module testbench();
	
	parameter data_bit_width = 32;
	parameter op_bit_width = 5;
	
	reg [data_bit_width-1:0] src1;
	reg [data_bit_width-1:0] src2;	
	reg [op_bit_width-1:0] opcode;
	wire [data_bit_width-1:0] data_out;
	
	ALU test1(src1, src2, opcode, data_out);
	
	initial begin
		src1 = 32'd10;
		src2 = 32'd8;
		#20;
		
		// ADD, ADDI, LW, SW,  JAL
		opcode = 5'b00000;
		#20
		
		// SUB, SUBI
		opcode = 5'b00001;
		#20
		
		// AND, ANDI
		opcode = 5'b00010;
		#20
		
		// OR, ORI
		opcode = 5'b00011;
		#20
		
		// XOR, XORI
		opcode = 5'b00100;
		#20
		
		// NAND, NANDI
		opcode = 5'b00101;
		#20
		
		// NOR, NORI
		opcode = 5'b00110;
		#20
		
		// XNOR, XNORI
		opcode = 5'b00111;
		#20
		
		// F, FI, BF
		opcode = 5'b01000;
		#20
		
		// EQ, EQI, BEQ, BEQZ
		opcode = 5'b01001;
		#20
		
		// LT, LTI, BLT, BLTZ
		opcode = 5'b01010;
		#20
		
		// LTE, LTEI, BLTE, BLTEZ
		opcode = 5'b01011;
		#20
		
		// T, TI, BT
		opcode = 5'b01100;
		#20
		
		// NE, NEI, BNE, BNEZ
		opcode = 5'b01101;
		#20
		
		// GTE, GTEI, BGTE, BGTEZ
		opcode = 5'b01110;
		#20
		
		// GT, GTI, BGT, BGTZ
		opcode = 5'b01111;
		#20
		
		// MVHI
		opcode = 5'b10000;
		#20
			
		#50; $stop;
	end
	
endmodule