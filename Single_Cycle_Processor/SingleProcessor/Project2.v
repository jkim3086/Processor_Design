module Project2(SW,KEY,LEDR,HEX0,HEX1,HEX2,HEX3,CLOCK_50,reset_sim);
  input  [9:0] SW;
  input  [3:0] KEY;
  input  CLOCK_50;
  input reset_sim;
  output [9:0] LEDR;
  output [6:0] HEX0,HEX1,HEX2,HEX3;
 
  parameter DBITS         				 = 32;
  parameter INST_SIZE      			 = 32'd4;
  parameter INST_BIT_WIDTH				 = 32;
  parameter START_PC       			 = 32'h40;
  parameter REG_INDEX_BIT_WIDTH 		 = 4;
  parameter ADDR_KEY  					 = 32'hF0000010;
  parameter ADDR_SW   					 = 32'hF0000014;
  parameter ADDR_HEX  					 = 32'hF0000000;
  parameter ADDR_LEDR 					 = 32'hF0000004;

  // Added
  parameter ALU_OP_WIDTH                 = 5;
  parameter IMM_WIDTH                    = 16;
  
  parameter IMEM_INIT_FILE				 = "Test2.mif";
  parameter IMEM_ADDR_BIT_WIDTH 		 = 11;
  parameter IMEM_DATA_BIT_WIDTH 		 = INST_BIT_WIDTH;
  parameter IMEM_PC_BITS_HI     		 = IMEM_ADDR_BIT_WIDTH + 2;
  parameter IMEM_PC_BITS_LO     		 = 2;
  
  parameter DMEMADDRBITS 				 = 13;
  parameter DMEMWORDBITS				 = 2;
  parameter DMEMWORDS					 = 2048;
  
  parameter OP1_ALUR 					 = 4'b0000;
  parameter OP1_ALUI 					 = 4'b1000;
  parameter OP1_CMPR 					 = 4'b0010;
  parameter OP1_CMPI 					 = 4'b1010;
  parameter OP1_BCOND					 = 4'b0110;
  parameter OP1_SW   					 = 4'b0101;
  parameter OP1_LW   					 = 4'b1001;
  parameter OP1_JAL  					 = 4'b1011;

  wire clk;
  wire reset;
  assign reset = ~KEY[0];
  
  wire [DBITS - 1 : 0] alu_out;
  wire [ALU_OP_WIDTH - 1 : 0] alu_op;
  wire [DBITS - 1 : 0] alu_in1;
  wire [DBITS - 1 : 0] alu_in2;
  wire [1 : 0] pc_sel;
  wire [DBITS - 1 : 0] mem_out;
  wire [INST_BIT_WIDTH - 1 : 0] pc_plus_4;
  wire [IMEM_DATA_BIT_WIDTH - 1: 0] instWord;
  wire [REG_INDEX_BIT_WIDTH - 1 : 0] rd;
  wire [REG_INDEX_BIT_WIDTH - 1 : 0] rs1;
  wire [REG_INDEX_BIT_WIDTH - 1 : 0] rs2;
  wire [IMM_WIDTH - 1 : 0] imm;
  wire rf_wrt_en;
  wire [DBITS - 1 : 0] rf_wrt_data;
  wire [DBITS - 1 : 0] rf_out1;
  wire [DBITS - 1 : 0] rf_out2;
  wire [1 : 0] rf_wrt_data_sel;
  wire [DBITS - 1 : 0] imm_ext;
  wire [DBITS - 1 : 0] imm_ext_shf_2;
  wire mem_wrt_en;
  wire [1 : 0] alu_in2_sel;
  wire cond_flag;
  wire [INST_BIT_WIDTH - 1 : 0] pc_plus_4_plus_imm;
  wire [15 : 0] hex;
  // Add and modify parameters for various opcode and function code values
  
  ClockDivider	clk_divider (.inclk0 (CLOCK_50),.c0 (clk));
  //assign clk = CLOCK_50;
  
  // Create PC and its logic
  wire pcWrtEn = 1'b1;
  wire[DBITS - 1: 0] pcIn; // Implement the logic that generates pcIn; you may change pcIn to reg if necessary
  wire[DBITS - 1: 0] pcOut;

  Adder #(.BIT_WIDTH(INST_BIT_WIDTH)) pc_plus_4_adder(pcOut, 4, pc_plus_4);
  Adder #(.BIT_WIDTH(INST_BIT_WIDTH)) pc_plus_4_plus_imm_adder(pc_plus_4, imm_ext_shf_2, pc_plus_4_plus_imm);

  Mux4x1 #(.BIT_WIDTH(INST_BIT_WIDTH)) pc_mux(pc_sel, pc_plus_4, pc_plus_4_plus_imm, alu_out, 0, pcIn);
  // This PC instantiation is your starting point
  Register #(.BIT_WIDTH(DBITS), .RESET_VALUE(START_PC)) pc (clk, reset, pcWrtEn, pcIn, pcOut);

  // Creat instruction memeory
  InstMemory #(IMEM_INIT_FILE, IMEM_ADDR_BIT_WIDTH, IMEM_DATA_BIT_WIDTH) instMem (pcOut[IMEM_PC_BITS_HI - 1: IMEM_PC_BITS_LO], instWord);
  
  // Put the code for getting opcode1, rd, rs, rt, imm, etc. here 
  SCProcController #(.INST_BIT_WIDTH(INST_BIT_WIDTH), .REG_INDEX_BIT_WIDTH(REG_INDEX_BIT_WIDTH), .ALU_OP_WIDTH(ALU_OP_WIDTH)) controller(instWord, cond_flag, rd, rs1, rs2, imm, alu_op, pc_sel, rf_wrt_data_sel, alu_in2_sel, rf_wrt_en, mem_wrt_en);
  
  // Create the registers
  RegFile #(.ADDR_LEN(REG_INDEX_BIT_WIDTH), .DATA_LEN(DBITS)) reg_file(clk, reset, rd, rs1, rs2, rf_wrt_en, rf_wrt_data, rf_out1, rf_out2);
  Mux4x1 #(.BIT_WIDTH(DBITS)) rf_wrt_data_mux(rf_wrt_data_sel, alu_out, mem_out, pc_plus_4, 0, rf_wrt_data);

  // Sign extend and shift
  SignExtension #(.IN_BIT_WIDTH(IMM_WIDTH), .OUT_BIT_WIDTH(DBITS)) sign_extension(imm, imm_ext);
  Shifter #(.BIT_WIDTH(DBITS), .SHIFT_BITS(2)) shift2(imm_ext, imm_ext_shf_2);
  
  // Create ALU unit
  assign alu_in1 = rf_out1;
  Mux4x1 #(.BIT_WIDTH(DBITS)) alu_in2_mux(alu_in2_sel, rf_out2, imm_ext, imm_ext_shf_2, 0, alu_in2);
  ALU #(.data_bit_width(DBITS), .op_bit_width(ALU_OP_WIDTH)) alu(alu_in1, alu_in2, alu_op, alu_out, cond_flag);
  
  // Put the code for data memory and I/O here
  DataMemory #(.MEM_INIT_FILE(IMEM_INIT_FILE), .ADDR_BIT_WIDTH(DBITS), .DATA_BIT_WIDTH(DBITS), .TRUE_ADDR_BIT_WIDTH(DMEMADDRBITS - DMEMWORDBITS)) dataMem(clk, mem_wrt_en, alu_out, rf_out2, SW, KEY, LEDR, hex, mem_out);

  SevenSeg ss0(hex[3 : 0], HEX0);
  SevenSeg ss1(hex[3 : 0], HEX1);
  SevenSeg ss2(hex[3 : 0], HEX2);
  SevenSeg ss3(hex[3 : 0], HEX3);
  
  // KEYS, SWITCHES, HEXS, and LEDS are memeory mapped IO
    
endmodule

