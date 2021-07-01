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
    parameter period1 = 9, 
    parameter period2 = 4 
    ) ();
    reg clk, reset;
    reg signed [15:0] in;
    wire signed [15:0] out;
    
    adrv9009_rsp DUT (
    .clk (clk),
    .reset (reset),
    .in (in),
    .out (out)
    );

    // Set up for the rise of clock every 10ns (100MHz)
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
    
    // First sin wave
    reg [3:0] cs1;
    reg [3:0] count1;
    reg signed [15:0] in1;
    always @(posedge clk) begin
        if (reset) begin
            in1 <= 16'b0;
            cs1 <= `STATE0;
            count1 <= 0;  
        end else begin
            case (cs1)
                `STATE0: begin 
                    in1 <= 0;
                    if (count1 < period1)   begin cs1 <= `STATE0; count1 <= count1 + 1; end 
                    else                    begin cs1 <= `STATE1; count1 <= 0; end                            
                end
                `STATE1: begin
                    in1 <= 23170;
                    if (count1 < period1)   begin cs1 <= `STATE1; count1 <= count1 + 1; end   
                    else                    begin cs1 <= `STATE2; count1 <= 0; end           
                end
                `STATE2: begin
                    in1 <= 32767;
                    if (count1 < period1)   begin cs1 <= `STATE2; count1 <= count1 + 1; end   
                    else                    begin cs1 <= `STATE3; count1 <= 0; end           
                end
                `STATE3: begin
                    in1 <= 23170;
                    if (count1 < period1)   begin cs1 <= `STATE3; count1 <= count1 + 1; end   
                    else                    begin cs1 <= `STATE4; count1 <= 0; end           
                end
                `STATE4: begin
                    in1 <= 0;
                    if (count1 < period1)   begin cs1 <= `STATE4; count1 <= count1 + 1; end   
                    else                    begin cs1 <= `STATE5; count1 <= 0; end           
                end
                `STATE5: begin
                    in1 <= -23170;
                    if (count1 < period1)   begin cs1 <= `STATE5; count1 <= count1 + 1; end   
                    else                    begin cs1 <= `STATE6; count1 <= 0; end           
                end
                `STATE6: begin
                    in1 <= -32768;
                    if (count1 < period1)   begin cs1 <= `STATE6; count1 <= count1 + 1; end   
                    else                    begin cs1 <= `STATE7; count1 <= 0; end           
                end
                `STATE7: begin
                    in1 <= -23170;
                    if (count1 < period1)   begin cs1 <= `STATE7; count1 <= count1 + 1; end   
                    else                    begin cs1 <= `STATE0; count1 <= 0; end           
                end
            endcase
        end
    end
    
    // Second sin wave
    reg [3:0] cs2;
    reg [3:0] count2;
    reg signed [15:0] in2;
    always @(posedge clk) begin
        if (reset) begin
            in2 <= 16'b0;
            cs2 <= `STATE0;
            count2 <= 0;  
        end else begin
            case (cs2)
                `STATE0: begin 
                    in2 <= 0;
                    if (count2 < period2)   begin cs2 <= `STATE0; count2 <= count2 + 1; end 
                    else                    begin cs2 <= `STATE1; count2 <= 0; end                            
                end
                `STATE1: begin
                    in2 <= 23170;
                    if (count2 < period2)   begin cs2 <= `STATE1; count2 <= count2 + 1; end   
                    else                    begin cs2 <= `STATE2; count2 <= 0; end           
                end
                `STATE2: begin
                    in2 <= 32767;
                    if (count2 < period2)   begin cs2 <= `STATE2; count2 <= count2 + 1; end   
                    else                    begin cs2 <= `STATE3; count2 <= 0; end           
                end
                `STATE3: begin
                    in2 <= 23170;
                    if (count2 < period2)   begin cs2 <= `STATE3; count2 <= count2 + 1; end   
                    else                    begin cs2 <= `STATE4; count2 <= 0; end           
                end
                `STATE4: begin
                    in2 <= 0;
                    if (count2 < period2)   begin cs2 <= `STATE4; count2 <= count2 + 1; end   
                    else                    begin cs2 <= `STATE5; count2 <= 0; end           
                end
                `STATE5: begin
                    in2 <= -23170;
                    if (count2 < period2)   begin cs2 <= `STATE5; count2 <= count2 + 1; end   
                    else                    begin cs2 <= `STATE6; count2 <= 0; end           
                end
                `STATE6: begin
                    in2 <= -32768;
                    if (count2 < period2)   begin cs2 <= `STATE6; count2 <= count2 + 1; end   
                    else                    begin cs2 <= `STATE7; count2 <= 0; end           
                end
                `STATE7: begin
                    in2 <= -23170;
                    if (count2 < period2)   begin cs2 <= `STATE7; count2 <= count2 + 1; end   
                    else                    begin cs2 <= `STATE0; count2 <= 0; end           
                end
            endcase
        end
    end
    
    // Choosing between 2 inputs
    reg [12:0] counter;
    always @(posedge clk) begin
        if (reset) begin 
            in <= 16'b0;
            counter <= 13'b0;
        end else begin
            if (counter < 15) begin
                counter <= counter + 1;
            end else if (counter < 300) begin
                counter <= counter + 1;
                in <= in1;
            end else if (counter < 600) begin
                counter <= counter + 1;
                in <= in2;
            end else begin
                in <= in1 + in2;
            end
        end
    end
endmodule
