`default_nettype none
`timescale 1ns/1ns

module testdesign (
    `ifdef USE_POWER_PINS 
        inout vdda,
        inout vssa,
        inout vccd,
        inout vssd,
    `endif input wire clk,
    input wire reset,
    input wire [7:0] in,
    output reg [7:0] out,
    output reg [15:0] oeb);
    
    always @(posedge clk) begin
        out       <= in;
        oeb[15:8] <= 1;
        oeb[7:0]  <= 0;
        if (reset) begin
            oeb[15:8] <= 0;
            out       <= 0;
        end
    end
    
endmodule
`default_nettype wire