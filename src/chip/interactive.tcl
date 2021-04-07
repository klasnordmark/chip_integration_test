package require openlane

#set script_dir [file dirname [file normalize [info script]]]
set script_dir [pwd]
prep -design $script_dir -tag chip -overwrite
#set save_path $script_dir/../..
set save_path $script_dir

puts stdout [file isdirectory $script_dir/../padframe-openlane]

if {[file isdirectory $script_dir/../padframe-openlane] != 1} {
    puts stderr "Padframe must be built."
    exit 1
}

if {[file isdirectory $script_dir/../core-openlane] != 1} {
    puts stederr "Core must be built."
    exit 1
}

set ::env(SYNTH_DEFINES) "TOP_ROUTING"
verilog_elaborate

init_floorplan

add_macro_placement padframe 0 0 N
add_macro_placement core 250 250 N

manual_macro_placement f

# modify to a different file
remove_pins -input $::env(CURRENT_DEF)
remove_empty_nets -input $::env(CURRENT_DEF)

#add_macro_obs \
#	-defFile $::env(CURRENT_DEF) \
#	-lefFile $::env(MERGED_LEF_UNPADDED) \
#	-obstruction vddio_obs \
#	-placementX 103.400 \
#	-placementY 607.150 \
#	-sizeWidth 94.500 \
#	-sizeHeight 30 \
#	-fixed 1 \
#	-layerNames "met2 met4"

#power_routing

li1_hack_start
global_routing
detailed_routing
li1_hack_end

#write_powered_verilog set_netlist $::env(lvs_result_file_tag).powered.v
run_magic
#run_magic_spice_export
#run_magic_drc
#run_lvs

save_views       -lef_path $::env(magic_result_file_tag).lef \
                 -def_path $::env(tritonRoute_result_file_tag).def \
                 -gds_path $::env(magic_result_file_tag).gds \
                 -mag_path $::env(magic_result_file_tag).mag \
				 -verilog_path $::env(CURRENT_NETLIST) \
                 -save_path $save_path \
                 -tag $::env(RUN_TAG)
