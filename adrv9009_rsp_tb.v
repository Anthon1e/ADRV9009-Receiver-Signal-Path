`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/29/2021 09:44:31 AM
// Design Name: 
// Module Name: adrv9009_rsp_tb
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


module adrv9009_rsp_tb #(
    parameter period1 = 5, 
    parameter period2 = 2 
    ) ();
    reg clk, reset;
    reg signed [15:0] in;
    wire signed [15:0] out;
    reg signed [15:0] memory [0:999];
    
    adrv9009_rsp DUT (
    .clk (clk),
    .reset (reset),
    .in (in),
    .out (out)
    );

    // Set up for the rise of clock every 10ns (100MHz)
    initial begin
        clk <= 1'b1;
        #5;
        forever begin
            clk <= 1'b0;
            #5;
            clk <= 1'b1;
            #5;
        end
    end
    
    // Set up for reset stage at the beginning
    initial begin
        $readmemh("filename.txt", memory);
        reset <= 1;
        #20;
        reset <= 0;
        #100000;
    end
    
    // Set up for the input data after reset
    `define STATE0 4'b0000 // Restart state 
    `define STATE1 4'b0001 
    `define STATE2 4'b0010 
    `define STATE3 4'b0011 
    `define STATE4 4'b0100 
    `define STATE5 4'b0101 
    `define STATE6 4'b0110 
    `define STATE7 4'b0111 
    `define STATE8 4'b1000
    `define STATE9 4'b1001 
    
    // First sin wave
    integer i;
    reg [3:0] counter;
    always @(posedge clk) begin
        if (reset) begin
            i <= 0;
            in <= 0;
            counter <= 0;
        end else begin
            if (counter < 10) begin
                if (i == 48) begin
                    in <= memory[i];
                    i <= 0;
                    counter <= counter + 1;
                end else begin
                    in <= memory[i];
                    i <= i + 1;
                end
            end else begin
                if (i == 57) begin
                    in <= memory[i];
                    i <= 49;
                end else begin
                    in <= memory[i];
                    i <= i + 1;
                end
            end
        end
    end
endmodule
