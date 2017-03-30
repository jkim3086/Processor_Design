onerror {resume}
radix define alufunc {
    "4'b0000" "AND",
    "4'b0001" "OR",
    "4'b0010" "XOR",
    "4'b0110" "SUB",
    "4'b0111" "ADD",
    "4'b1000" "NAND",
    "4'b1010" "NOR",
    "4'b1001" "XNOR",
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
add wave -noupdate -radix decimal /Alu_tb/a
add wave -noupdate -radix decimal /Alu_tb/b
add wave -noupdate -radix cmpfunc /Alu_tb/cmp_func
add wave -noupdate -radix alufunc /Alu_tb/alu_func
add wave -noupdate -divider Output
add wave -noupdate /Alu_tb/flag
add wave -noupdate -radix decimal /Alu_tb/out
add wave -noupdate -divider Verify
add wave -noupdate /Alu_tb/flag_expected
add wave -noupdate -radix decimal /Alu_tb/out_expected
add wave -noupdate /Alu_tb/out_pass
add wave -noupdate /Alu_tb/flag_pass

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








