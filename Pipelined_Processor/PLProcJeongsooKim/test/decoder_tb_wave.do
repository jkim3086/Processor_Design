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
add wave -noupdate -divider Input
add wave -noupdate -radix hexadecimal /decoder_tb/inst
add wave -noupdate -divider Output
add wave -noupdate -radix opcode /decoder_tb/op_code
add wave -noupdate -radix func /decoder_tb/func_code
add wave -noupdate -radix regno /decoder_tb/rd
add wave -noupdate -radix regno /decoder_tb/rs1
add wave -noupdate -radix regno /decoder_tb/rs2
add wave -noupdate -radix decimal /decoder_tb/imm
add wave -noupdate -divider Verify
add wave -noupdate -radix opcode /decoder_tb/op_code_expected
add wave -noupdate -radix func /decoder_tb/func_code_expected
add wave -noupdate -radix regno /decoder_tb/rd_expected
add wave -noupdate -radix regno /decoder_tb/rs1_expected
add wave -noupdate -radix regno /decoder_tb/rs2_expected
add wave -noupdate -radix decimal /decoder_tb/imm_expected
add wave -noupdate /decoder_tb/op_code_pass
add wave -noupdate /decoder_tb/func_code_pass
add wave -noupdate /decoder_tb/rd_pass
add wave -noupdate /decoder_tb/rs1_pass
add wave -noupdate /decoder_tb/rs2_pass
add wave -noupdate /decoder_tb/imm_pass

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
