`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/29/2021 08:16:45 AM
// Design Name: 
// Module Name: adrv9009_rhb3
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


module adrv9009_rhb3(
    input clk,
    input reset,
    input signed [15:0] in,
    output reg signed [15:0] out
    );
    
    // RHB3 filter coefficient, MSB is signed bit
    wire signed [15:0] coeff0, coeff1, coeff2, coeff3, coeff4, coeff5, coeff6, coeff7, coeff8;
    assign coeff0 = 16'hfd9a; // (-0.01874) * 2^15 = -614
    assign coeff1 = 16'hfa9a; // (-0.04218) * 2^15 = -1382
    assign coeff2 = 16'h0676; // 0.050476 * 2^15 = 1654
    assign coeff3 = 16'h259e; // 0.293884 * 2^15 = 9630
    assign coeff4 = 16'h3846; // 0.439636 * 2^15 = 14406
    assign coeff5 = 16'h259e; // 0.293884 * 2^15 = 9630
    assign coeff6 = 16'h0676; // 0.050476 * 2^15 = 1654
    assign coeff7 = 16'hfa9a; // (-0.04218) * 2^15 = -1382
    assign coeff8 = 16'hfd9a; // (-0.01874) * 2^15 = -614
    
    // Save previous input data
    reg signed [15:0] zin1, zin2, zin3, zin4, zin5, zin6, zin7, zin8;
    always @(posedge clk) begin
        if (reset) begin
            {zin1, zin2, zin3, zin4, zin5, zin6, zin7, zin8} <= {8{16'b0}};
        end else begin
            zin1 <= in;
            {zin2, zin3, zin4, zin5, zin6, zin7, zin8} <= {zin1, zin2, zin3, zin4, zin5, zin6, zin7};
        end
    end
    
    // Coefficient multiplation
    reg signed [31:0] xh0, xh1, xh2, xh3, xh4, xh5, xh6, xh7, xh8;
    always @(posedge clk) begin
        if (reset) begin
            {xh0, xh1, xh2, xh3, xh4, xh5, xh6, xh7, xh8} <= {9{32'b0}};
        end else begin
            xh0 <= coeff0 * in;
            xh1 <= coeff1 * zin1;
            xh2 <= coeff2 * zin2;
            xh3 <= coeff3 * zin3;
            xh4 <= coeff4 * zin4;
            xh5 <= coeff5 * zin5;
            xh6 <= coeff6 * zin6;
            xh7 <= coeff7 * zin7;
            xh8 <= coeff8 * zin8;
        end
    end
    
    // Output
    reg signed [31:0] xxh0, xxh1, xxh2, xxh3, xxh4, xxh5, xxh6, xxh7, xxh8;
    reg signed [31:0] out1, out2, out3, out4, out5, out6, out7, out8, out9, out0;
    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0;
            {xxh0, xxh1, xxh2, xxh3, xxh4, xxh5, xxh6, xxh7, xxh8} <= {9{32'b0}};
            {out0, out1, out2, out3, out4, out5, out6, out7, out8, out9} <= {10{32'b0}};
        end else begin 
            // Cycle delay 1: Allow for multiplication process
            {xxh0, xxh1, xxh2, xxh3, xxh4, xxh5, xxh6, xxh7, xxh8} <= {xh0, xh1, xh2, xh3, xh4, xh5, xh6, xh7, xh8};
            // Cycle delay 2: Allow for summation process
            out1 <= xxh0 + xxh1;
            out2 <= xxh2 + xxh3;
            out3 <= xxh4 + xxh5;
            out4 <= xxh6 + xxh7;
            out5 <= xxh8;
            // Cycle delay 3
            out6 <= out1 + out2;
            out7 <= out3 + out4;
            out8 <= out5;
            // Cycle delay 4
            out9 <= out6 + out7;
            out0 <= out8;
            // Finally output
            out <= out9[31:16] + out0[31:16];
        end
    end
endmodule
