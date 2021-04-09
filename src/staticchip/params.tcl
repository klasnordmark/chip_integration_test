set script_dir [pwd]
set ::env(PDK) "sky130A"
set ::env(STD_CELL_LIBRARY) "sky130_fd_sc_hvl"

set ::env(SYNTH_READ_BLACKBOX_LIB) 1

#set ::env(EXTRA_LEFS) "\
#    $script_dir/../src/chip_integration_test_1.0.0/prebuilt/padframe/lef/chip_io.lef \
#    $script_dir/../src/chip_integration_test_1.0.0/prebuilt/core/lef/testdesign.lef"
    

set ::env(EXTRA_GDS_FILES) "\
    $script_dir/../padframe-openlane/gds/chip_io.gds \
    $script_dir/../core-openlane/gds/testdesign.gds"

set ::env(SYNTH_TOP_LEVEL) 1
set ::env(SYNTH_FLAT_TOP) 1
set ::env(LEC_ENABLE) 0

set ::env(FP_SIZING) absolute

set ::env(DIE_AREA) "0 0 3588 5188"

set ::env(CELL_PAD) 0
set ::env(PL_OPENPHYSYN_OPTIMIZATIONS) 0
set ::env(DIODE_INSERTION_STRATEGY) 0
set ::env(GLB_RT_ALLOW_CONGESTION) 1
set ::env(GLB_RT_OVERFLOW_ITERS) 50
set ::env(GLB_RT_TILES) 30
set ::env(GLB_RT_MAXLAYER) 5
set ::env(FILL_INSERTION) 0
set ::env(LVS_INSERT_POWER_PINS) 0
