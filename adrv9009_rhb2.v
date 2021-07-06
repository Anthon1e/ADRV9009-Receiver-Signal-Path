`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/29/2021 08:16:45 AM
// Design Name: 
// Module Name: adrv9009_rhb2
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


module adrv9009_rhb2(
    input clk,
    input reset,
    input signed [15:0] in,
    output reg signed [15:0] out
    );
    
    // RHB2 filter coefficient, MSB is signed bit
    wire signed [15:0] coeff00, coeff02, coeff04, coeff06, coeff08;
    wire signed [15:0] coeff09, coeff10, coeff12, coeff14, coeff16, coeff18;
    assign coeff00 = 16'h0068; // 0.003174 * 2^15 = 104
    assign coeff02 = 16'hfe6a; // (-0.01239) * 2^15 = -406
    assign coeff04 = 16'h0460; // 0.03418 * 2^15 = 1120
    assign coeff06 = 16'hf50e; // (-0.08551) * 2^15 = -2802
    assign coeff08 = 16'h27cc; // 0.310913 * 2^15 = 10188
    assign coeff09 = 16'h4000; // 0.5 * 2^15 = 16384
    assign coeff10 = 16'h27cc; // 0.310913 * 2^15 = 10188
    assign coeff12 = 16'hf50e; // (-0.08551) * 2^15 = -2802
    assign coeff14 = 16'h0460; // 0.03418 * 2^15 = 1120
    assign coeff16 = 16'hfe6a; // (-0.01239) * 2^15 = -406
    assign coeff18 = 16'h0068; // 0.003174 * 2^15 = 104
    
    // Save previous input data
    reg signed [15:0] zin01, zin02, zin03, zin04, zin05, zin06, zin07, zin08, zin09;
    reg signed [15:0] zin10, zin11, zin12, zin13, zin14, zin15, zin16, zin17, zin18;
    always @(posedge clk) begin
        if (reset) begin
            {zin01, zin02, zin03, zin04, zin05, zin06, zin07, zin08, zin09} <= {9{32'b0}};
            {zin10, zin11, zin12, zin13, zin14, zin15, zin16, zin17, zin18} <= {9{32'b0}};
        end else begin
            {zin01, zin02, zin03, zin04, zin05, zin06} <= {in, zin01, zin02, zin03, zin04, zin05};
            {zin07, zin08, zin09, zin10, zin11, zin12} <= {zin06, zin07, zin08, zin09, zin10, zin11};
            {zin13, zin14, zin15, zin16, zin17, zin18} <= {zin12, zin13, zin14, zin15, zin16, zin17};
        end
    end
    
    // Coefficient multiplation
    reg signed [31:0] xh00, xh02, xh04, xh06, xh08, xh09;
    reg signed [31:0] xh10, xh12, xh14, xh16, xh18;
    always @(posedge clk) begin
        if (reset) begin
            {xh00, xh02, xh04, xh06, xh08, xh09} <= {6{48'b0}};
            {xh10, xh12, xh14, xh16, xh18} <= {5{48'b0}};
        end else begin
            xh00 <= coeff00 * in;
            xh02 <= coeff02 * zin02;
            xh04 <= coeff04 * zin04;
            xh06 <= coeff06 * zin06;
            xh08 <= coeff08 * zin08;
            xh09 <= coeff09 * zin09;
            xh10 <= coeff10 * zin10;
            xh12 <= coeff12 * zin12;
            xh14 <= coeff14 * zin14;
            xh16 <= coeff16 * zin16;
            xh18 <= coeff18 * zin18;
        end
    end
    
    // Output
    reg signed [31:0] xxh00, xxh02, xxh04, xxh06, xxh08, xxh09;
    reg signed [31:0] xxh10, xxh12, xxh14, xxh16, xxh18;
    reg signed [31:0] out1, out2, out3, out4, out5, out6, out7, out8, out9, out0, out11, out12;
    always @(posedge clk) begin
        if (reset) begin
            out <= 48'b0;
        end else begin 
            // Cycle delay 1: Allow for multiplication process
            {xxh00, xxh02, xxh04, xxh06, xxh08, xxh09} <= {xh00, xh02, xh04, xh06, xh08, xh09};
            {xxh10, xxh12, xxh14, xxh16, xxh18} <= {xh10, xh12, xh14, xh16, xh18};
            // Cycle delay 2: Allow for summation process
            out1 <= xxh00 + xxh18;
            out2 <= xxh02 + xxh04;
            out3 <= xxh06 + xxh08;
            out4 <= xxh10 + xxh12;
            out5 <= xxh14 + xxh16;
            out6 <= xxh09;
            // Cycle delay 3
            out7 <= out1 + out4;
            out8 <= out2 + out5;
            out9 <= out3 + out6;
            // Cycle delay 4
            out0 <= out7 + out8;
            out11 <= out9;
            // Cycle delay 5
            out12 <= out0 + out11; 
            // Finally output
            out <= out12[31:16];
        end
    end
endmodule
