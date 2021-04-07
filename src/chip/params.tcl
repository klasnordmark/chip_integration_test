#set script_dir [file dirname [file normalize [info script]]]
set script_dir [pwd]

set ::env(PDK) "sky130A"
set ::env(STD_CELL_LIBRARY) "sky130_fd_sc_hvl"

#set verilog_root $script_dir/../../verilog/
#set lef_root $script_dir/../../lef/
#set gds_root $script_dir/../../gds/

#set ::env(VERILOG_FILES) "rtl/*.v"

set ::env(SYNTH_READ_BLACKBOX_LIB) 1

set ::env(VERILOG_FILES_BLACKBOX) "\
    $script_dir/../padframe-openlane/verilog/gl/chip_io.v \
    $script_dir/../core-openlane/verilog/gl/testdesign.v"

# $lef_root/user_project_wrapper.obstructed.lef \
    # $script_dir/../rgb_encoder/runs/06-04_06-49/results/magic/user_project_wrapper.lef"

set ::env(EXTRA_LEFS) "\
    $script_dir/../padframe-openlane/lef/chip_io.lef \
    $script_dir/../core-openlane/lef/testdesign.lef"
    

set ::env(EXTRA_GDS_FILES) "\
    $script_dir/../padframe-openlane/gds/chip_io.gds \
    $script_dir/../core-openlane/gds/testdesign.gds"

set ::env(SYNTH_TOP_LEVEL) 1
set ::env(SYNTH_FLAT_TOP) 1
set ::env(LEC_ENABLE) 0

set ::env(FP_SIZING) absolute

#set fd [open "$script_dir/../chip_dimensions.txt" "r"]
#set ::env(DIE_AREA) [read $fd]
#close $fd

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
