transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/ghori/Documents/UNIFEI/digital/MIPS_CPU/Multiplicador/Adder {C:/Users/ghori/Documents/UNIFEI/digital/MIPS_CPU/Multiplicador/Adder/Adder.v}

