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
    parameter period = 9 // clock cycles
    ) ();
    reg clk, reset;
    reg signed [15:0] in;
    wire signed [31:0] out;
    
    adrv9009_rsp DUT (
    .clk (clk),
    .reset (reset),
    .in (in),
    .out (out)
    );

    // Set up for the rise of clock every 2 seconds
    initial begin
        clk <= 1'b1;
        #1;
        forever begin
            clk <= 1'b0;
            #1;
            clk <= 1'b1;
            #1;
        end
    end
    
    // Set up for reset stage at the beginning
    initial begin
        reset <= 1;
        #4;
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
    
    reg [3:0] cs;
    reg [3:0] count;
    always @(posedge clk) begin
        if (reset) begin
            in <= 16'b0;
            cs <= `STATE0;
            count <= 0;  
        end else begin
            case (cs)
                `STATE0: begin 
                    in <= 0;
                    if (count < period) begin cs <= `STATE0; count <= count + 1; end 
                    else                begin cs <= `STATE1; count <= 0; end                            
                end
                `STATE1: begin
                    in <= 23170;
                    if (count < period) begin cs <= `STATE1; count <= count + 1; end   
                    else                begin cs <= `STATE2; count <= 0; end           
                end
                `STATE2: begin
                    in <= 32767;
                    if (count < period) begin cs <= `STATE2; count <= count + 1; end   
                    else                begin cs <= `STATE3; count <= 0; end           
                end
                `STATE3: begin
                    in <= 23170;
                    if (count < period) begin cs <= `STATE3; count <= count + 1; end   
                    else                begin cs <= `STATE4; count <= 0; end           
                end
                `STATE4: begin
                    in <= 0;
                    if (count < period) begin cs <= `STATE4; count <= count + 1; end   
                    else                begin cs <= `STATE5; count <= 0; end           
                end
                `STATE5: begin
                    in <= -23170;
                    if (count < period) begin cs <= `STATE5; count <= count + 1; end   
                    else                begin cs <= `STATE6; count <= 0; end           
                end
                `STATE6: begin
                    in <= -32768;
                    if (count < period) begin cs <= `STATE6; count <= count + 1; end   
                    else                begin cs <= `STATE7; count <= 0; end           
                end
                `STATE7: begin
                    in <= -23170;
                    if (count < period) begin cs <= `STATE7; count <= count + 1; end   
                    else                begin cs <= `STATE0; count <= 0; end           
                end
            endcase
        end
    end
endmodule
