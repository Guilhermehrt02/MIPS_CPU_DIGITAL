transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/ghori/Documents/UNIFEI/digital/MIPS_CPU/Multiplicador/Counter {C:/Users/ghori/Documents/UNIFEI/digital/MIPS_CPU/Multiplicador/Counter/Counter.v}
vlog -vlog01compat -work work +incdir+C:/Users/ghori/Documents/UNIFEI/digital/MIPS_CPU/Multiplicador/Control {C:/Users/ghori/Documents/UNIFEI/digital/MIPS_CPU/Multiplicador/Control/Control_MUL.v}
vlog -vlog01compat -work work +incdir+C:/Users/ghori/Documents/UNIFEI/digital/MIPS_CPU/Multiplicador/Adder {C:/Users/ghori/Documents/UNIFEI/digital/MIPS_CPU/Multiplicador/Adder/Adder.v}
vlog -vlog01compat -work work +incdir+C:/Users/ghori/Documents/UNIFEI/digital/MIPS_CPU/Multiplicador/ACC {C:/Users/ghori/Documents/UNIFEI/digital/MIPS_CPU/Multiplicador/ACC/ACC.v}
vlog -vlog01compat -work work +incdir+C:/Users/ghori/Documents/UNIFEI/digital/MIPS_CPU/Multiplicador {C:/Users/ghori/Documents/UNIFEI/digital/MIPS_CPU/Multiplicador/multiplicador.v}

vlog -vlog01compat -work work +incdir+C:/Users/ghori/Documents/UNIFEI/digital/MIPS_CPU/Multiplicador {C:/Users/ghori/Documents/UNIFEI/digital/MIPS_CPU/Multiplicador/multiplicador_TB.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneiv_hssi_ver -L cycloneiv_pcie_hip_ver -L cycloneiv_ver -L rtl_work -L work -voptargs="+acc"  multiplicador_TB

add wave *
view structure
view signals
run -all
