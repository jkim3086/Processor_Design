onerror {resume}

quietly WaveActivateNextPane {} 0
add wave -noupdate -divider Parameter
add wave -noupdate clk_div_tb/dut/cycle_width
add wave -noupdate clk_div_tb/dut/cycle_time
add wave -noupdate -divider Input
add wave -noupdate clk_div_tb/clk
add wave -noupdate clk_div_tb/reset
add wave -noupdate -divider output
add wave -noupdate clk_div_tb/clk_out
add wave -noupdate -divider counter
add wave -noupdate clk_div_tb/dut/counter



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
