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
    output reg signed [31:0] out
    );
    
    // RHB3 filter coefficient, MSB is signed bit
    wire signed [15:0] coeff [0:8];
    assign coeff[0] = 16'hfd9a; // (-0.01874) * 2^15 = -614
    assign coeff[1] = 16'hfa9a; // (?0.04218) * 2^15 = -1382
    assign coeff[2] = 16'h0676; // 0.050476 * 2^15 = 1654
    assign coeff[3] = 16'h259e; // 0.293884 * 2^15 = 9630
    assign coeff[4] = 16'h3846; // 0.439636 * 2^15 = 14406
    assign coeff[5] = 16'h259e; // 0.293884 * 2^15 = 9630
    assign coeff[6] = 16'h0676; // 0.050476 * 2^15 = 1654
    assign coeff[7] = 16'hfa9a; // (-0.04218) * 2^15 = -1382
    assign coeff[8] = 16'hfd9a; // (-0.01874) * 2^15 = -614
    
    // Save previous input data
    reg signed [15:0] zin [0:7];
    genvar i;
    generate
    for (i = 0; i < 8; i = i + 1) begin
        always @(posedge clk) begin
            if (reset) begin
                zin[i] <= 16'b0; 
            end else begin
                if (i > 0) 
                    zin[i] <= zin[i-1];
                if (i == 0) 
                    zin[i] <= in;
            end
        end
    end
    endgenerate
    
    // Coefficient multiplation
    reg signed [31:0] xtimesh [0:8];
    genvar j;
    generate
    for (j = 0; j < 9; j = j + 1) begin
        always @(posedge clk) begin
            if (reset) begin
                xtimesh[j] <= 32'b0;
            end else begin
                if (j > 0)
                    xtimesh[j] <= coeff[j] * zin[j-1];
                else 
                    xtimesh[j] <= coeff[j] * in;
            end
        end
    end
    endgenerate
    
    // Output
    integer k;
    /*always @(*) begin
        out = 32'b0;
        for (k = 0; k < 9; k = k + 1) begin
            out = out + xtimesh[k];
        end
    end*/
    always @(posedge clk) 
        out <= xtimesh[0] + xtimesh[1] + xtimesh[2] + xtimesh[3] + xtimesh[4] + xtimesh[5] + xtimesh[6] + xtimesh[7] + xtimesh[8];
endmodule
