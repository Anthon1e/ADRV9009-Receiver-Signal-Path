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
    input clk,
    input reset,
    input signed [15:0] in,
    output signed [15:0] out
    );
    
    wire [15:0] out_rhb3, out_rhb2;
    
    adrv9009_rhb3 rhb3 (.clk (clk), .reset (reset), .in (in), .out (out_rhb3));
    adrv9009_rhb2 rhb2 (.clk (clk), .reset (reset), .in (out_rhb3), .out (out_rhb2)); 
    adrv9009_rfir rfir (.clk (clk), .reset (reset), .in (out_rhb2), .out (out));
    
endmodule
