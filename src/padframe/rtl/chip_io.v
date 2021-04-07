// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

// `default_nettype none
module chip_io(inout 	 vddio,                                                // Common padframe/ESD supply
               inout 	 vssio,                                                // Common padframe/ESD ground
               inout 	 vdda,
               inout 	 vssa,
               inout 	 vccd,                                                 // Common 1.8V supply
               inout 	 vssd,                                                 // Common digital ground
               input 	 clock,
               output 	 clock_core,
               input 	 resetb,
               output 	 resetb_core_h,
               inout [15:0] io,
               input [15:0] io_out,
               input [15:0] oeb,
               input [15:0] hldh_n,
               input [15:0] enh,
               input [15:0] inp_dis,
               input [15:0] ib_mode_sel,
               input [15:0] vtrip_sel,
               input [15:0] slow_sel,
               input [15:0] holdover,
               input [15:0] analog_en,
               input [15:0] analog_sel,
               input [15:0] analog_pol,
               input [(3*16)-1:0] dm, 
			   input [15:0] io_in, 
			   input 	 porb_h,);
    
    wire analog_a, analog_b;
    wire vddio_q, vssio_q;
    
    // Instantiate power and ground pads for management domain
    // 12 pads:  vddio, vssio, vdda, vssa, vccd, vssd
    // One each HV and LV clamp.
    
    // HV clamps connect between one HV power rail and one ground
    // LV clamps have two clamps connecting between any two LV power
    // rails and grounds, and one back-to-back diode which connects
    // between the first LV clamp ground and any other ground.
    
    sky130_ef_io__vddio_hvc_pad vddio_hvclamp_pad  (
    `ABUTMENT_PINS
    `ifdef TOP_ROUTING
    .VDDIO(vddio),
    `endif
    `HVCLAMP_PINS(vddio, vssio)
    );
    
    sky130_ef_io__vdda_hvc_pad vdda_hvclamp_pad (
    `ABUTMENT_PINS
    `ifdef TOP_ROUTING
    .VDDA(vdda),
    `endif
    `HVCLAMP_PINS(vdda, vssa)
    );
    
    sky130_ef_io__vccd_lvc_pad vccd_lvclamp_pad (
    `ABUTMENT_PINS
    `ifdef TOP_ROUTING
    .VCCD(vccd),
    `endif
    `LVCLAMP_PINS(vccd, vssio, vccd, vssd, vssa)
    );
    
    sky130_ef_io__vssio_hvc_pad vssio_hvclamp_pad  (
    `ABUTMENT_PINS
    `ifdef TOP_ROUTING
    .VSSIO(vssio),
    `endif
    `HVCLAMP_PINS(vddio, vssio)
    );
    
    sky130_ef_io__vssa_hvc_pad vssa_hvclamp_pad (
    `ABUTMENT_PINS
    `ifdef TOP_ROUTING
    .VSSA(vssa),
    `endif
    `HVCLAMP_PINS(vdda, vssa)
    );
    
    sky130_ef_io__vssd_lvc_pad vssd_lvclmap_pad (
    `ABUTMENT_PINS
    `ifdef TOP_ROUTING
    .VSSD(vssd),
    `endif
    `LVCLAMP_PINS(vccd, vssio, vccd, vssd, vssa)
    );
    
    `INPUT_PAD(clock, clock_core);
    
    wire xresloop;
    sky130_fd_io__top_xres4v2 resetb_pad (
    `ABUTMENT_PINS
    `ifndef	TOP_ROUTING
    .PAD(resetb),
    `endif
    .TIE_WEAK_HI_H(xresloop),   // Loop-back connection to pad through pad_a_esd_h
    .TIE_HI_ESD(),
    .TIE_LO_ESD(),
    .PAD_A_ESD_H(xresloop),
    .XRES_H_N(resetb_core_h),
    .DISABLE_PULLUP_H(vssio),    // 0 = enable pull-up on reset pad
    .ENABLE_H(porb_h),	    // Power-on-reset
    .EN_VDDIO_SIG_H(vssio),	    // No idea.
    .INP_SEL_H(vssio),	    // 1 = use filt_in_h else filter the pad input
    .FILT_IN_H(vssio),	    // Alternate input for glitch filter
    .PULLUP_H(vssio),	    // Pullup connection for alternate filter input
    .ENABLE_VDDIO(vccd)
    );
    
    sky130_ef_io__corner_pad corner [3:0] (
    `ifndef TOP_ROUTING
    .VSSIO(vssio),
    .VDDIO(vddio),
    .VDDIO_Q(vddio_q),
    .VSSIO_Q(vssio_q),
    .AMUXBUS_A(analog_a),
    .AMUXBUS_B(analog_b),
    .VSSD(vssd),
    .VSSA(vssa),
    .VSWITCH(vddio),
    .VDDA(vdda),
    .VCCD(vccd),
    .VCCHIB(vccd),
    `else
    .VCCHIB()
    `endif
    );
    
    
    wire [15:0] loop1_io;
    
    sky130_ef_io__gpiov2_pad_wrapped core_io_pad [15:0] (
    `ABUTMENT_PINS
    `ifndef TOP_ROUTING
    .PAD(io[15:0]),
    `endif
    .OUT(io_out[15:0]),
    .OE_N(oeb[15:0]),
    .HLD_H_N(hldh_n[15:0]),
    .ENABLE_H(enh[15:0]),
    .ENABLE_INP_H(loop1_io[15:0]),
    .ENABLE_VDDA_H(porb_h),
    .ENABLE_VSWITCH_H(vssio),
    .ENABLE_VDDIO(vccd),
    .INP_DIS(inp_dis[15:0]),
    .IB_MODE_SEL(ib_mode_sel[15:0]),
    .VTRIP_SEL(vtrip_sel[15:0]),
    .SLOW(slow_sel[15:0]),
    .HLD_OVR(holdover[15:0]),
    .ANALOG_EN(analog_en[15:0]),
    .ANALOG_SEL(analog_sel[15:0]),
    .ANALOG_POL(analog_pol[15:0]),
    .DM(dm[(3*16)-1:0]),
    .PAD_A_NOESD_H(),
    .PAD_A_ESD_0_H(),
    .PAD_A_ESD_1_H(),
    .IN(io_in[15:0]),
    .IN_H(),
    .TIE_HI_ESD(),
    .TIE_LO_ESD(loop1_io[15:0])
    );
    
    
    
    
endmodule
    // `default_nettype wire
