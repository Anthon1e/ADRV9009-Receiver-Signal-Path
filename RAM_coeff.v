`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/12/2021 02:28:35 PM
// Design Name: 
// Module Name: RAM_coeff
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


module RAM_coeff(
    input clk_m,
    input clk_r,
    input wr_en,
    input [6:0] addr_in,
    input [6:0] addr_out,
    input signed [15:0] in,
    output reg signed [15:0] out
    );
    
    reg [6:0] addr_out_r;
    reg [15:0] mem [0:71]; 
    
    always @(posedge clk_r) begin
        if (wr_en)
            mem[addr_in] <= in;
    end
    
    always @(posedge clk_m) begin
        out <= mem[addr_out_r];
        addr_out_r <= addr_out;
    end
endmodule
