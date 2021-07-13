`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/29/2021 08:16:45 AM
// Design Name: 
// Module Name: adrv9009_rsp
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module adrv9009_rsp (
    // General stuff
    input clk_m,
    input reset,
    input signed [15:0] in,
    output signed [15:0] out,
    // For rfir module
    input en_rfir,
    input [1:0] mode_rfir,
    // For RAM module
    input clk_r,
    input wr_en,
    input [6:0] addr_in,
    input signed [15:0] coeff_in
    );
    
    wire signed [15:0] out_rhb3, out_rhb2, coeff_out;
    wire [6:0] addr_out;
    
    // ADRV9009 Receiver signal datapath
    adrv9009_rhb3 rhb3 (.clk (clk_m), .reset (reset), .in (in), .out (out_rhb3));
    adrv9009_rhb2 rhb2 (.clk (clk_m), .reset (reset), .in (out_rhb3), .out (out_rhb2));
    adrv9009_rfir rfir (.clk (clk_m), .reset (reset), .en_rfir (en_rfir), .mode_rfir (mode_rfir), 
                        .in (out_rhb2), .out (out), .ram_coeff (coeff_out), .addr_out (addr_out));
    
    // RAM modules to hold coefficients 
    RAM_coeff ramc (.clk_m (clk_m), .clk_r (clk_r), .wr_en (wr_en), .addr_in (addr_in), 
                    .addr_out (addr_out), .in (coeff_in), .out (coeff_out)); 

endmodule
