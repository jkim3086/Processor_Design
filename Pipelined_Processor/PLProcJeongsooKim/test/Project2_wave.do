onerror {resume}
radix define opcode {
    "4'b0010" "BR" -color "purple",
    "4'b0011" "SW" -color "green",
    "4'b0100" "ALU-I" -color "yellow",
    "4'b0101" "CMP-I" -color "orange",
    "4'b0110" "JAL" -color "purple",
    "4'b0111" "LW" -color "green",
    "4'b1100" "ALU-R" -color "yellow",
    "4'b1101" "CMP-R" -color "orange",
    -default default
}
radix define func {
    "4'b0000" "AND/T/BT",
    "4'b0001" "OR/BNEZ",
    "4'b0010" "XOR/BEQZ",
    "4'b0011" "F/BF",
    "4'b0101" "NE/BNE",
    "4'b0110" "SUB/EQ/BEQ",
    "4'b0111" "ADD",
    "4'b1000" "NAND/BLTEZ",
    "4'b1001" "NOR/LT/BLT",
    "4'b1010" "XNOR/GTE/BGTE",
    "4'b1011" "BGT",
    "4'b1100" "LTE/BLTE",
    "4'b1101" "BLTZ",
    "4'b1110" "BGTEZ",
    "4'b1111" "MVHI/GT/GTZ",
    -default default
}
radix define regno {
    "4'd0" "R0/A0",
    "4'd1" "R1/A1",
    "4'd2" "R2/A2",
    "4'd3" "R3/A3/RV",
    "4'd4" "R4/T0",
    "4'd5" "R5/T1",
    "4'd6" "R6/S0",
    "4'd7" "R7/S1",
    "4'd8" "R8/S2",
    "4'd9" "R9",
    "4'd10" "R10",
    "4'd11" "R11",
    "4'd12" "R12/GP",
    "4'd13" "R13/FP",
    "4'd14" "R14/SP",
    "4'd15" "R15/RA",
    -default default
}
radix define alufunc {
    "4'b0000" "AND",
    "4'b0001" "OR",
    "4'b0010" "XOR",
    "4'b0110" "SUB",
    "4'b0111" "ADD",
    "4'b1000" "NAND",
    "4'b1010" "NOR",
    "4'b1111" "MVHI",
    -default default
}
radix define cmpfunc {
    "4'b0000" "T",
    "4'b0011" "F",
    "4'b0101" "A!=B",
    "4'b0110" "A==B",
    "4'b1001" "A<B",
    "4'b1010" "A>=B",
    "4'b1100" "A<=B",
    "4'b1111" "A>B",
    -default default
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /Project2/clk
add wave -noupdate /Project2/reset
add wave -noupdate -divider Inputs
add wave -noupdate /Project2/KEY
add wave -noupdate /Project2/SW
add wave -noupdate -divider Outputs
add wave -noupdate /Project2/LEDR
add wave -noupdate /Project2/HEX0
add wave -noupdate /Project2/HEX1
add wave -noupdate /Project2/HEX2
add wave -noupdate /Project2/HEX3
add wave -noupdate -radix unsigned /Project2/hex
add wave -noupdate -divider PC
add wave -noupdate -radix hexadecimal /Project2/pcOut
add wave -noupdate -radix hexadecimal /Project2/pcIncremented
add wave -noupdate -radix hexadecimal /Project2/pcIn
add wave -noupdate -divider Decoding
add wave -noupdate -radix hexadecimal /Project2/instWord
add wave -noupdate -radix opcode /Project2/opcode
add wave -noupdate -radix func /Project2/func
add wave -noupdate -radix regno /Project2/rd
add wave -noupdate -radix regno /Project2/rs1
add wave -noupdate -radix regno /Project2/rs2
add wave -noupdate -radix decimal /Project2/immval
add wave -noupdate -divider {Register File}
add wave -noupdate /Project2/rs1MuxSel
add wave -noupdate /Project2/rs2MuxSel
add wave -noupdate -radix regno /Project2/regRead1No
add wave -noupdate -radix regno /Project2/regRead2No
add wave -noupdate -radix hexadecimal /Project2/regData1
add wave -noupdate -radix hexadecimal /Project2/regData2
add wave -noupdate /Project2/dstRegMuxSel
add wave -noupdate -radix regno /Project2/regWriteNo
add wave -noupdate -radix hexadecimal /Project2/wrRegData
add wave -noupdate /Project2/wrReg
add wave -noupdate -divider ALU
add wave -noupdate -radix alufunc /Project2/aluOp
add wave -noupdate -radix cmpfunc /Project2/cmpOp
add wave -noupdate -radix decimal /Project2/a
add wave -noupdate -radix decimal /Project2/b
add wave -noupdate /Project2/alu2MuxSel
add wave -noupdate -radix decimal /Project2/aluResult
add wave -noupdate /Project2/condFlag
add wave -noupdate -divider Memory
add wave -noupdate -radix hexadecimal /Project2/datamem/addr
add wave -noupdate /Project2/wrMem
add wave -noupdate -radix decimal /Project2/dataMemOut
add wave -noupdate -divider Branching
add wave -noupdate /Project2/takeBr
add wave -noupdate /Project2/allowBr
add wave -noupdate /Project2/brBaseMuxSel
add wave -noupdate -radix hexadecimal /Project2/brBase
add wave -noupdate -radix hexadecimal /Project2/instOffset
add wave -noupdate -radix hexadecimal /Project2/brBaseOffset
add wave -noupdate -divider {Register Contents}
add wave -noupdate -label {Register 0 (A0)} -radix decimal /Project2/regFile/R0/dataOut
add wave -noupdate -label {Register 1 (A1)} -radix decimal /Project2/regFile/R1/dataOut
add wave -noupdate -label {Register 2 (A2)} -radix decimal /Project2/regFile/R2/dataOut
add wave -noupdate -label {Register 3 (A3)} -radix decimal /Project2/regFile/R3/dataOut
add wave -noupdate -label {Register 4 (T0)} -radix decimal /Project2/regFile/R4/dataOut
add wave -noupdate -label {Register 5 (T1)} -radix decimal /Project2/regFile/R5/dataOut
add wave -noupdate -label {Register 6 (S0)} -radix decimal /Project2/regFile/R6/dataOut
add wave -noupdate -label {Register 7 (S1)} -radix decimal /Project2/regFile/R7/dataOut
add wave -noupdate -label {Register 8 (S2)} -radix decimal /Project2/regFile/R8/dataOut
add wave -noupdate -label {Register 9} -radix decimal /Project2/regFile/R9/dataOut
add wave -noupdate -label {Register 10} -radix decimal /Project2/regFile/R10/dataOut
add wave -noupdate -label {Register 11} -radix decimal /Project2/regFile/R11/dataOut
add wave -noupdate -label {Register 12 (GP)} -radix decimal /Project2/regFile/R12/dataOut
add wave -noupdate -label {Register 13 (FP)} -radix decimal /Project2/regFile/R13/dataOut
add wave -noupdate -label {Register 14 (SP)} -radix decimal /Project2/regFile/R14/dataOut
add wave -noupdate -label {Register 15 (RA)} -radix decimal /Project2/regFile/R15/dataOut
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {20000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {224 ps}
