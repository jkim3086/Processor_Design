onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /Alu_tb/a
add wave -noupdate -radix hexadecimal /Alu_tb/b
add wave -noupdate /Alu_tb/alu_func
add wave -noupdate /Alu_tb/cmp_func
add wave -noupdate -divider Outputs
add wave -noupdate -radix hexadecimal /Alu_tb/out
add wave -noupdate -radix hexadecimal /Alu_tb/out_expected
add wave -noupdate /Alu_tb/out_pass
add wave -noupdate /Alu_tb/flag
add wave -noupdate /Alu_tb/flag_expected
add wave -noupdate /Alu_tb/flag_pass
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {249 ps} 0}
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
WaveRestoreZoom {0 ps} {76 ps}
