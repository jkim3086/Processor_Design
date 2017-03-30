transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/JK/Desktop/folder/Gatech/2016_Fall/CS3220/Project/3/SCProcChenkaiShao {C:/Users/JK/Desktop/folder/Gatech/2016_Fall/CS3220/Project/3/SCProcChenkaiShao/ClockDivider.v}

