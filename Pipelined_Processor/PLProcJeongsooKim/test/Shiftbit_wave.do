onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Input
add wave -noupdate /Shiftbit_tb/din
add wave -noupdate -divider Output
add wave -noupdate /Shiftbit_tb/dout
add wave -noupdate -divider Verify
add wave -noupdate /Shiftbit_tb/dout_expected
add wave -noupdate /Shiftbit_tb/pass
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
