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


module adrv9009_rsp_tb2 #(
    parameter period1 = 24, 
    parameter period2 = 9, 
    parameter period3 = 0
    ) ();
    reg clk_m, clk_r, reset, en_rfir, wr_en, wr_done;
    reg [1:0] mode_rfir, gain_rfir, deci_rfir;
    reg [6:0] addr_in;
    reg signed [15:0] coeff_list [0:71]; 
    reg signed [15:0] in, coeff_in;
    wire signed [15:0] out;
    wire out_valid;
    
    adrv9009_rsp DUT (
    .clk_m (clk_m),
    .reset (reset),
    .in (in),
    .out (out),
    .out_valid (out_valid),
    .en_rfir (en_rfir),
    .mode_rfir (mode_rfir),
    .gain_rfir (gain_rfir),
    .deci_rfir (deci_rfir),
    .clk_r (clk_r),
    .wr_en (wr_en),
    .addr_in (addr_in),
    .coeff_in (coeff_in)
    );
    
    // Set up for the rise of clk_m every 2ns (500MHz)
    initial begin
        clk_m <= 1'b1;
        #1;
        forever begin
            clk_m <= 1'b0;
            #1;
            clk_m <= 1'b1;
            #1;
        end
    end
    
    // Set up for the rise of clk_m every 10ns (100MHz)
    initial begin
        clk_r <= 1'b1;
        #5;
        forever begin
            clk_r <= 1'b0;
            #5;
            clk_r <= 1'b1;
            #5;
        end
    end
    
    // Set up for reset stage and choosing the mode
    localparam MODE24T = 1;
    localparam MODE48T = 0;
    initial begin
        if (MODE24T)
            $readmemh("coeff24.txt", coeff_list);
        if (MODE48T)
            $readmemh("coeff48.txt", coeff_list);
        reset <= 1;
        #110;
        reset <= 0;
        #100000;
    end
    
    // Initialize RAM with filter coefficients
    integer i;
    always @(posedge clk_r) begin
        if (reset) begin
            wr_done <= 0;
            i <= 0;
        end else begin
            if (~wr_done) begin
                wr_en <= 1;
                addr_in <= i;
                coeff_in <= coeff_list[i];
                i <= i + 1;
                if ((i == 'd24) && (MODE24T)) begin
                    wr_done <= 1;
                    wr_en <= 0;
                    en_rfir <= 1;
                    mode_rfir <= 2'b01;
                    gain_rfir <= 2'b01;
                    deci_rfir <= 2'b11;
                end else if ((i == 'd48) && (MODE48T)) begin
                    wr_done <= 1;
                    wr_en <= 0;
                    en_rfir <= 1;
                    mode_rfir <= 2'b01;
                    gain_rfir <= 2'b01;
                    deci_rfir <= 2'b11;
                end
            end
        end
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
    reg [9:0] count1;
    reg signed [15:0] in1;
    always @(posedge clk_m) begin
        if (reset) begin
            in1 <= 16'b0;
            cs1 <= `STATE0;
            count1 <= 0;
        end else begin
            case (cs1)
                `STATE0: begin
                    in1 <= 0;
                    if (count1 < period1)   begin cs1 <= `STATE0; count1 <= count1 + 1; end
                    else                    begin cs1 <= `STATE1; count1 <= 0; end end
                `STATE1: begin
                    in1 <= 23170;
                    if (count1 < period1)   begin cs1 <= `STATE1; count1 <= count1 + 1; end
                    else                    begin cs1 <= `STATE2; count1 <= 0; end end
                `STATE2: begin
                    in1 <= 32767;
                    if (count1 < period1)   begin cs1 <= `STATE2; count1 <= count1 + 1; end
                    else                    begin cs1 <= `STATE3; count1 <= 0; end end
                `STATE3: begin
                    in1 <= 23170;
                    if (count1 < period1)   begin cs1 <= `STATE3; count1 <= count1 + 1; end
                    else                    begin cs1 <= `STATE4; count1 <= 0; end end
                `STATE4: begin
                    in1 <= 0;
                    if (count1 < period1)   begin cs1 <= `STATE4; count1 <= count1 + 1; end
                    else                    begin cs1 <= `STATE5; count1 <= 0; end end
                `STATE5: begin
                    in1 <= -23170;
                    if (count1 < period1)   begin cs1 <= `STATE5; count1 <= count1 + 1; end
                    else                    begin cs1 <= `STATE6; count1 <= 0; end end
                `STATE6: begin
                    in1 <= -32768;
                    if (count1 < period1)   begin cs1 <= `STATE6; count1 <= count1 + 1; end
                    else                    begin cs1 <= `STATE7; count1 <= 0; end end
                `STATE7: begin
                    in1 <= -23170;
                    if (count1 < period1)   begin cs1 <= `STATE7; count1 <= count1 + 1; end
                    else                    begin cs1 <= `STATE0; count1 <= 0; end end
            endcase
        end
    end
    
    // Second sin wave
    reg [3:0] cs2;
    reg [5:0] count2;
    reg signed [15:0] in2;
    always @(posedge clk_m) begin
        if (reset) begin
            in2 <= 16'b0;
            cs2 <= `STATE0;
            count2 <= 0;
        end else begin
            case (cs2)
                `STATE0: begin
                    in2 <= 0;
                    if (count2 < period2)   begin cs2 <= `STATE0; count2 <= count2 + 1; end
                    else                    begin cs2 <= `STATE1; count2 <= 0; end end
                `STATE1: begin
                    in2 <= 23170;
                    if (count2 < period2)   begin cs2 <= `STATE1; count2 <= count2 + 1; end
                    else                    begin cs2 <= `STATE2; count2 <= 0; end end
                `STATE2: begin
                    in2 <= 32767;
                    if (count2 < period2)   begin cs2 <= `STATE2; count2 <= count2 + 1; end
                    else                    begin cs2 <= `STATE3; count2 <= 0; end end
                `STATE3: begin
                    in2 <= 23170;
                    if (count2 < period2)   begin cs2 <= `STATE3; count2 <= count2 + 1; end
                    else                    begin cs2 <= `STATE4; count2 <= 0; end end
                `STATE4: begin
                    in2 <= 0;
                    if (count2 < period2)   begin cs2 <= `STATE4; count2 <= count2 + 1; end
                    else                    begin cs2 <= `STATE5; count2 <= 0; end end
                `STATE5: begin
                    in2 <= -23170;
                    if (count2 < period2)   begin cs2 <= `STATE5; count2 <= count2 + 1; end
                    else                    begin cs2 <= `STATE6; count2 <= 0; end end
                `STATE6: begin
                    in2 <= -32768;
                    if (count2 < period2)   begin cs2 <= `STATE6; count2 <= count2 + 1; end
                    else                    begin cs2 <= `STATE7; count2 <= 0; end end
                `STATE7: begin
                    in2 <= -23170;
                    if (count2 < period2)   begin cs2 <= `STATE7; count2 <= count2 + 1; end
                    else                    begin cs2 <= `STATE0; count2 <= 0; end end
            endcase
        end
    end
    
    // Third sin wave
    reg [3:0] cs3;
    reg [5:0] count3;
    reg signed [15:0] in3;
    always @(posedge clk_m) begin
        if (reset) begin
            in3 <= 16'b0;
            cs3 <= `STATE0;
            count3 <= 0;
        end else begin
            case (cs3)
                `STATE0: begin
                    in3 <= 0;
                    if (count3 < period3)   begin cs3 <= `STATE0; count3 <= count3 + 1; end 
                    else                    begin cs3 <= `STATE1; count3 <= 0; end end
                `STATE1: begin
                    in3 <= 32767;
                    if (count3 < period3)   begin cs3 <= `STATE1; count3 <= count3 + 1; end   
                    else                    begin cs3 <= `STATE2; count3 <= 0; end end      
                `STATE2: begin
                    in3 <= 0;
                    if (count3 < period3)   begin cs3 <= `STATE2; count3 <= count3 + 1; end   
                    else                    begin cs3 <= `STATE3; count3 <= 0; end end
                `STATE3: begin
                    in3 <= -32768;
                    if (count3 < period3)   begin cs3 <= `STATE3; count3 <= count3 + 1; end   
                    else                    begin cs3 <= `STATE0; count3 <= 0; end end
            endcase
        end
    end
    
    // Fourth sin wave
    reg [3:0] cs4;
    reg [5:0] count4;
    reg signed [15:0] in4;
    always @(posedge clk_m) begin
        if (reset) begin
            in4 <= 16'b0;
            cs4 <= `STATE0;
            count4 <= 0;
        end else begin
            case (cs4)
                `STATE0: begin
                    in4 <= -32768;
                    if (count4 < period3)   begin cs4 <= `STATE0; count4 <= count4 + 1; end 
                    else                    begin cs4 <= `STATE1; count4 <= 0; end end
                `STATE1: begin
                    in4 <= 32767;
                    if (count4 < period3)   begin cs4 <= `STATE1; count4 <= count4 + 1; end   
                    else                    begin cs4 <= `STATE0; count4 <= 0; end end 
            endcase
        end
    end
    
    // Choosing between 2 inputs
    reg [13:0] counter;
    always @(posedge clk_m) begin
        if (reset) begin
            in <= 16'b0;
            counter <= 13'b0;
        end else begin
            if (counter < 15) begin
                counter <= counter + 1;
            end else if (counter < 990) begin
                counter <= counter + 1;
                in <= in1;
            end else if (counter < 1500) begin
                counter <= counter + 1;
                in <= in2;
            end else if (counter < 1750) begin
                counter <= counter + 1;
                in <= in3;
            end else if (counter < 2000) begin
                counter <= counter + 1;
                in <= in4;
            end else
                in <= in3 + in1;
        end
    end
endmodule
