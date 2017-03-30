onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Input
add wave -noupdate -radix hex /multiplexer4bit_tb/a
add wave -noupdate -radix hex /multiplexer4bit_tb/b
add wave -noupdate -radix hex /multiplexer4bit_tb/c
add wave -noupdate -radix hex /multiplexer4bit_tb/d
add wave -noupdate /multiplexer4bit_tb/selector
add wave -noupdate -divider Output
add wave -noupdate -radix hex /multiplexer4bit_tb/out
add wave -noupdate -divider Verify
add wave -noupdate -radix hex /multiplexer4bit_tb/out_expected
add wave -noupdate /multiplexer4bit_tb/pass
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {28 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 171
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
WaveRestoreZoom {0 ps} {53 ps}
