vlib work
vlog TL.v TL_tb.v
vsim -fsmdebug -voptargs=+acc work.TL_tb
add wave -position insertpoint sim:/TL_tb/dut/*
run -all
