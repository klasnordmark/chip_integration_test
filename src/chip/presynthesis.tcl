set script_dir [pwd]

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

li1_hack_start
global_routing
detailed_routing
li1_hack_end
