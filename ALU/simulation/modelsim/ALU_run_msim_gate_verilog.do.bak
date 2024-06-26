transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {ALU_7_1200mv_100c_slow.vo}

vlog -vlog01compat -work work +incdir+C:/Users/ghori/Documents/UNIFEI/digital/MIPS_CPU/ALU {C:/Users/ghori/Documents/UNIFEI/digital/MIPS_CPU/ALU/ALU_TB.v}

vsim -t 1ps +transport_int_delays +transport_path_delays -L altera_mf_ver -L altera_ver -L lpm_ver -L sgate_ver -L cycloneiv_hssi_ver -L cycloneiv_pcie_hip_ver -L cycloneiv_ver -L gate_work -L work -voptargs="+acc"  ALU_TB

add wave *
view structure
view signals
run -all
