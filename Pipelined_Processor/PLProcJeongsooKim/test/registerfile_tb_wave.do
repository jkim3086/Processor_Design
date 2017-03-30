onerror {resume}

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

quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Inputs
add wave -noupdate /registerfile_tb/clk
add wave -noupdate /registerfile_tb/reset
add wave -noupdate /registerfile_tb/reg_wr_en
add wave -noupdate -radix regno /registerfile_tb/reg_select1
add wave -noupdate -radix regno /registerfile_tb/reg_select2
add wave -noupdate -radix regno /registerfile_tb/wr_select
add wave -noupdate -radix decimal /registerfile_tb/wr_data

add wave -noupdate -divider Outputs
add wave -noupdate -radix decimal /registerfile_tb/reg_data1
add wave -noupdate -radix decimal /registerfile_tb/reg_data2

add wave -noupdate -divider verify
add wave -noupdate -radix decimal /registerfile_tb/reg1_expected
add wave -noupdate -radix decimal /registerfile_tb/reg2_expected
add wave -noupdate /registerfile_tb/reg1_pass
add wave -noupdate /registerfile_tb/reg2_pass

add wave -noupdate -divider Registers
add wave -noupdate -label {Register 0 (A0)} -radix decimal /registerfile_tb/reg_file/R0/dataOut
add wave -noupdate -label {Register 1 (A1)} -radix decimal /registerfile_tb/reg_file/R1/dataOut
add wave -noupdate -label {Register 2 (A2)} -radix decimal /registerfile_tb/reg_file/R2/dataOut
add wave -noupdate -label {Register 3 (A3)} -radix decimal /registerfile_tb/reg_file/R3/dataOut
add wave -noupdate -label {Register 4 (T0)} -radix decimal /registerfile_tb/reg_file/R4/dataOut
add wave -noupdate -label {Register 5 (T1)} -radix decimal /registerfile_tb/reg_file/R5/dataOut
add wave -noupdate -label {Register 6 (S0)} -radix decimal /registerfile_tb/reg_file/R6/dataOut
add wave -noupdate -label {Register 7 (S1)} -radix decimal /registerfile_tb/reg_file/R7/dataOut
add wave -noupdate -label {Register 8 (S2)} -radix decimal /registerfile_tb/reg_file/R8/dataOut
add wave -noupdate -label {Register 9} -radix decimal /registerfile_tb/reg_file/R9/dataOut
add wave -noupdate -label {Register 10} -radix decimal /registerfile_tb/reg_file/R10/dataOut
add wave -noupdate -label {Register 11} -radix decimal /registerfile_tb/reg_file/R11/dataOut
add wave -noupdate -label {Register 12 (GP)} -radix decimal /registerfile_tb/reg_file/R12/dataOut
add wave -noupdate -label {Register 13 (FP)} -radix decimal /registerfile_tb/reg_file/R13/dataOut
add wave -noupdate -label {Register 14 (SP)} -radix decimal /registerfile_tb/reg_file/R14/dataOut
add wave -noupdate -label {Register 15 (RA)} -radix decimal /registerfile_tb/reg_file/R15/dataOut

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
