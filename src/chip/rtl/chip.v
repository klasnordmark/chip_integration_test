`timescale 1 ns / 1 ps

`define UNIT_DELAY #1

module chip (
    inout vddio,	// Common 3.3V padframe/ESD power
    inout vssio,	// Common padframe/ESD ground
    inout vdda,		// Management 3.3V power
    inout vssa,		// Common analog ground
    inout vccd,		// Management/Common 1.8V power
    inout vssd,		// Common digital ground

    inout [15:0] io,
    input clock,	    	// CMOS core clock input, not a crystal
    input resetb
);

   chip_io padframe(
	.vddio(vddio),
	.vssio(vssio),
		    .vdda(vdda),
		    .vssa(vssa),
		    .vccd(vccd),
		    .vssd(vssd),
		    .clock(clock),
		    .clock_core(clock_core),
		    .resetb(resetb),
		    .resetb_core_h(resetb_core),
		    .io(io),
		    .io_out(io_out),
		    .oeb(oeb),
		    .hldh_n(0),
		    .enh(0),
		    .inp_dis(0),
		    .ib_mode_sel(0),
		    .vtrip_sel(0),
		    .slow_sel(0),
		    .holdover(0),
		    .analog_en(0),
		    .analog_sel(0),
		    .analog_pol(0),
		    .dm(0),
		    .io_in(io_in),
		    .porb_h(porb_h)
    );

   testdesign core(
		   `ifdef USE_POWER_PINS
		   .vdda(vdda),
		   .vssa(vssa),
		   .vccd(vccd),
		   .vssd(vssd),
		   `endif
		   .clk(clock_core),
		   .reset(resetb_core),
		   .in(io_in[7:0]),
		   .out(io_out[15:8]),
		   .oeb(oeb)
		   );
   

   wire clock_core;
   wire resetb_core;
   wire [15:0] io_in;
   wire [15:0] io_out;
   wire [15:0] oeb;
   wire [15:0] porb_h;

endmodule
