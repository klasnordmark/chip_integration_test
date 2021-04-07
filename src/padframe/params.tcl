
set ::env(DESIGN_NAME) chip_io
# The removal of this line is pending the IO verilog files being parsable by yosys...
set ::env(DESIGN_IS_PADFRAME) 1
set ::env(SYNTH_FLAT_TOP) 1
set ::env(USE_GPIO_PADS) 1
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 3588 5188"
set ::env(MAGIC_WRITE_FULL_LEF) 1
set ::env(DIODE_INSERTION_STRATEGY) 0
set ::env(GLB_RT_TILES) 30
set ::env(GLB_RT_UNIDIRECTIONAL) 0
