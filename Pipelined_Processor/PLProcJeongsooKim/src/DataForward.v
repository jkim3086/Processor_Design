module DataForward(dcd_rs1, dcd_rs2, 
				   wrReg_EX, exe_rd, 
				   wrReg_MEM, mem_rd, 
				   wrReg_WB, wb_rd, 
				   dcd_data1_sel, dcd_data2_sel);
    input [3:0] dcd_rs1;    //rs1 index in decode stage
    input [3:0] dcd_rs2;    //rs2 index in decode stage

    input [3:0] exe_rd;     //rd index in execute stage
	input wrReg_EX;
	
    input [3:0] mem_rd;     //rd index in memory stage
	input wrReg_MEM;
	
    input [3:0] wb_rd;      //rd index in writeback stage
	input wrReg_WB;

    // select signal for a mux in the decode stage
    output reg [1:0] dcd_data1_sel; // 0: no forwarding; 1: from exe; 2: from mem; 3: from wb
    output reg [1:0] dcd_data2_sel; // 0: no forwarding; 1: from exe; 2: from mem; 3: from wb

    always @(*) begin
        if (wrReg_EX && dcd_rs1 == exe_rd) begin
            dcd_data1_sel <= 1;
        end else if (wrReg_MEM && dcd_rs1 == mem_rd) begin
            dcd_data1_sel <= 2;
        end else if (wrReg_WB && dcd_rs1 == wb_rd) begin
            dcd_data1_sel <= 3;
        end else begin
            dcd_data1_sel <= 0;
        end

        if (wrReg_EX && dcd_rs2 == exe_rd) begin
            dcd_data2_sel <= 1;
        end else if (wrReg_MEM && dcd_rs2 == mem_rd) begin
            dcd_data2_sel <= 2;
        end else if (wrReg_WB && dcd_rs2 == wb_rd) begin
            dcd_data2_sel <= 3;
        end else begin
            dcd_data2_sel <= 0;
        end
    end
endmodule




/*
module DataForward(clk, dcd_rs1, dcd_rs2, exe_valid, exe_opcode, exe_reg_wrt, exe_rd, mem_valid, mem_reg_wrt, mem_rd, wb_valid, wb_reg_wrt, wb_rd, dcd_data1_sel, dcd_data2_sel, stall);
    input clk;
    input [3:0] dcd_rs1;    //rs1 index in decode stage
    input [3:0] dcd_rs2;    //rs2 index in decode stage
    input exe_valid;
    input [3:0] exe_opcode; //opcode in exe
    input exe_reg_wrt;      //register file write enable in exe
    input [3:0] exe_rd;     //rd index in execute stage
    input mem_valid;
    input mem_reg_wrt;      //register file write enable in mem
    input [3:0] mem_rd;     //rd index in memory stage
    input wb_valid;
    input wb_reg_wrt;      //register file write enable in wb
    input [3:0] wb_rd;      //rd index in writeback stage

    // select signal for a mux in the decode stage
    output [1:0] dcd_data1_sel; // 0: no forwarding; 1: from exe; 2: from mem; 3: from wb
    output [1:0] dcd_data2_sel; // 0: no forwarding; 1: from exe; 2: from mem; 3: from wb
    output stall;

    reg stall1;
    reg stall2;

    assign stall1 = exe_valid && exe_reg_wrt && dcd_rs1 == exe_rd && exe_opcode == 4'b0111; //if the instruction in exe is lw
    assign stall2 = exe_valid && exe_reg_wrt && dcd_rs2 == exe_rd && exe_opcode == 4'b0111; //if the instruction in exe is lw
    assign stall = stall1 || stall2;

    always @(posedge clk) begin
        if (exe_reg_wrt && dcd_rs1 == exe_rd) begin
            dcd_data1_sel <= 1;
        end else if (mem_reg_wrt && dcd_rs1 == mem_rd) begin
            dcd_data1_sel <= 2;
        end else if (wb_reg_wrt && dcd_rs1 == wb_rd) begin
            dcd_data1_sel <= 3;
        end else begin
            dcd_data1_sel <= 0;
        end

        if (exe_reg_wrt && dcd_rs2 == exe_rd) begin
            dcd_data2_sel <= 1;
        end else if (mem_reg_wrt && dcd_rs2 == mem_rd) begin
            dcd_data2_sel <= 2;
        end else if (wb_reg_wrt && dcd_rs2 == wb_rd) begin
            dcd_data2_sel <= 3;
        end else begin
            dcd_data2_sel <= 0;
        end
    end
endmodule
*/

