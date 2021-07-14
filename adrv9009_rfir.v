`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
// 
// Create Date: 07/09/2021 08:45:57 AM
// Design Name:
// Module Name: adrv9009_rfir
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


module adrv9009_rfir(
    // General stuff
    input clk,
    input reset,
    input en_rfir,
    input [1:0] mode_rfir,
    input [1:0] gain_rfir,
    input [1:0] deci_rfir,
    input signed [15:0] in,
    output reg signed [15:0] out,
    output reg out_valid,
    // Coefficients loading from RAM
    input signed [15:0] ram_coeff,
    output reg [6:0] addr_out
    );
    
    // Corresponding mode for taps
    localparam MODE24T = 2'b01;
    localparam MODE48T = 2'b10;
    localparam MODE72T = 2'b11;
    // Corresponding decimation rate
    localparam DECI1 = 2'b01;
    localparam DECI2 = 2'b10;
    localparam DECI4 = 2'b11;
    
    // Load filter coefficient into registers
    reg coeff24_rdy, coeff48_rdy, coeff72_rdy;
    reg [6:0] addr, addr_cnt;
    reg signed [15:0] coeff00, coeff01, coeff02, coeff03, coeff04, coeff05, coeff06, coeff07, coeff08, coeff09, coeff10, coeff11;
    reg signed [15:0] coeff12, coeff13, coeff14, coeff15, coeff16, coeff17, coeff18, coeff19, coeff20, coeff21, coeff22, coeff23;
    reg signed [15:0] coeff24, coeff25, coeff26, coeff27, coeff28, coeff29, coeff30, coeff31, coeff32, coeff33, coeff34, coeff35;
    reg signed [15:0] coeff36, coeff37, coeff38, coeff39, coeff40, coeff41, coeff42, coeff43, coeff44, coeff45, coeff46, coeff47;
    reg signed [15:0] coeff48, coeff49, coeff50, coeff51, coeff52, coeff53, coeff54, coeff55, coeff56, coeff57, coeff58, coeff59;
    reg signed [15:0] coeff60, coeff61, coeff62, coeff63, coeff64, coeff65, coeff66, coeff67, coeff68, coeff69, coeff70, coeff71;
    
    always @(posedge clk) begin
        if (reset) begin
            addr_out <= 0;
            addr_cnt <= 0;
            coeff24_rdy <= 0;
            coeff48_rdy <= 0;
            coeff72_rdy <= 0;
        end else begin
            if (~(coeff24_rdy || coeff48_rdy || coeff72_rdy) && en_rfir) begin
                case (addr_cnt)
                7'd00: begin addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd01: begin addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd02: begin coeff00 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd03: begin coeff01 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd04: begin coeff02 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd05: begin coeff03 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd06: begin coeff04 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd07: begin coeff05 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd08: begin coeff06 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd09: begin coeff07 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd10: begin coeff08 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd11: begin coeff09 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd12: begin coeff10 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd13: begin coeff11 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd14: begin coeff12 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd15: begin coeff13 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd16: begin coeff14 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd17: begin coeff15 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd18: begin coeff16 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd19: begin coeff17 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd20: begin coeff18 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd21: begin coeff19 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd22: begin coeff20 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd23: begin coeff21 <= ram_coeff; addr_cnt <= addr_cnt + 1;
                    if (mode_rfir != MODE24T) addr_out <= addr_out + 1; end  
                7'd24: begin coeff22 <= ram_coeff; addr_cnt <= addr_cnt + 1;
                    if (mode_rfir != MODE24T) addr_out <= addr_out + 1; end 
                7'd25: begin coeff23 <= ram_coeff; 
                    if (mode_rfir != MODE24T) begin
                        addr_out <= addr_out + 1;
                        addr_cnt <= addr_cnt + 1; 
                    end else coeff24_rdy <= 1; end 
                7'd26: begin coeff24 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd27: begin coeff25 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd28: begin coeff26 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd29: begin coeff27 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd30: begin coeff28 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd31: begin coeff29 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd32: begin coeff30 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd33: begin coeff31 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd34: begin coeff32 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd35: begin coeff33 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd36: begin coeff34 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd37: begin coeff35 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd38: begin coeff36 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd39: begin coeff37 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd40: begin coeff38 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd41: begin coeff39 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd42: begin coeff40 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd43: begin coeff41 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd44: begin coeff42 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd45: begin coeff43 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd46: begin coeff44 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd47: begin coeff45 <= ram_coeff; addr_cnt <= addr_cnt + 1;
                    if (mode_rfir != MODE48T) addr_out <= addr_out + 1; end
                7'd48: begin coeff46 <= ram_coeff; addr_cnt <= addr_cnt + 1;
                    if (mode_rfir != MODE48T) addr_out <= addr_out + 1; end
                7'd49: begin coeff47 <= ram_coeff;
                    if (mode_rfir != MODE48T) begin
                        addr_out <= addr_out + 1;
                        addr_cnt <= addr_cnt + 1;
                    end else coeff48_rdy <= 1; end
                7'd50: begin coeff48 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd51: begin coeff49 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd52: begin coeff52 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd53: begin coeff53 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd54: begin coeff52 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd55: begin coeff53 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd56: begin coeff54 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd57: begin coeff55 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd58: begin coeff56 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd59: begin coeff57 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd60: begin coeff58 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd61: begin coeff59 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd62: begin coeff60 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd63: begin coeff61 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd64: begin coeff62 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd65: begin coeff63 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd66: begin coeff64 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd67: begin coeff65 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd68: begin coeff66 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd69: begin coeff67 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd70: begin coeff68 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd71: begin coeff69 <= ram_coeff; addr_cnt <= addr_cnt + 1; end
                7'd72: begin coeff70 <= ram_coeff; addr_cnt <= addr_cnt + 1; end
                7'd73: begin coeff71 <= ram_coeff; coeff72_rdy <= 1; end
                endcase           
            end                   
        end
    end
    
    // Save previous input data
    reg signed [15:0] zin01, zin02, zin03, zin04, zin05, zin06, zin07, zin08, zin09, zin10, zin11, zin12;
    reg signed [15:0] zin13, zin14, zin15, zin16, zin17, zin18, zin19, zin20, zin21, zin22, zin23, zin24;
    reg signed [15:0] zin25, zin26, zin27, zin28, zin29, zin30, zin31, zin32, zin33, zin34, zin35, zin36;
    reg signed [15:0] zin37, zin38, zin39, zin40, zin41, zin42, zin43, zin44, zin45, zin46, zin47, zin48;
    reg signed [15:0] zin49, zin50, zin51, zin52, zin53, zin54, zin55, zin56, zin57, zin58, zin59, zin60;
    reg signed [15:0] zin61, zin62, zin63, zin64, zin65, zin66, zin67, zin68, zin69, zin70, zin71, zin72;
    always @(posedge clk) begin
        if (reset) begin
            {zin01, zin02, zin03, zin04, zin05, zin06, zin07, zin08, zin09, zin10, zin11, zin12} <= {12{16'b0}};
            {zin13, zin14, zin15, zin16, zin17, zin18, zin19, zin20, zin21, zin22, zin23, zin24} <= {12{16'b0}};
            {zin25, zin26, zin27, zin28, zin29, zin30, zin31, zin32, zin33, zin34, zin35, zin36} <= {12{16'b0}};
            {zin37, zin38, zin39, zin40, zin41, zin42, zin43, zin44, zin45, zin46, zin47, zin48} <= {12{16'b0}};
            {zin49, zin50, zin51, zin52, zin53, zin54, zin55, zin56, zin57, zin58, zin59, zin60} <= {12{16'b0}};
            {zin61, zin62, zin63, zin64, zin65, zin66, zin67, zin68, zin69, zin70, zin71, zin72} <= {12{16'b0}};
        end else begin
            {zin01, zin02, zin03, zin04, zin05, zin06, zin07, zin08} <= {in, zin01, zin02, zin03, zin04, zin05, zin06, zin07};
            {zin09, zin10, zin11, zin12, zin13, zin14, zin15, zin16} <= {zin08, zin09, zin10, zin11, zin12, zin13, zin14, zin15};
            {zin17, zin18, zin19, zin20, zin21, zin22, zin23, zin24} <= {zin16, zin17, zin18, zin19, zin20, zin21, zin22, zin23};
            if ((mode_rfir == MODE48T) || (mode_rfir == MODE72T)) begin
                {zin25, zin26, zin27, zin28, zin29, zin30, zin31, zin32} <= {zin24, zin25, zin26, zin27, zin28, zin29, zin30, zin31};
                {zin33, zin34, zin35, zin36, zin37, zin38, zin39, zin40} <= {zin32, zin33, zin34, zin35, zin36, zin37, zin38, zin39};
                {zin41, zin42, zin43, zin44, zin45, zin46, zin47, zin48} <= {zin40, zin41, zin42, zin43, zin44, zin45, zin46, zin47};
            end
            if (mode_rfir == MODE72T) begin
                {zin49, zin50, zin51, zin52, zin53, zin54, zin55, zin56} <= {zin48, zin49, zin50, zin51, zin52, zin53, zin54, zin55};
                {zin57, zin58, zin59, zin60, zin61, zin62, zin63, zin64} <= {zin56, zin57, zin58, zin59, zin60, zin61, zin62, zin63};
                {zin65, zin66, zin67, zin68, zin69, zin70, zin71, zin72} <= {zin64, zin65, zin66, zin67, zin68, zin69, zin70, zin71};
            end
        end
    end
    
    // Coefficient multiplation
    reg signed [31:0] xh00, xh01, xh02, xh03, xh04, xh05, xh06, xh07, xh08, xh09, xh10, xh11;
    reg signed [31:0] xh12, xh13, xh14, xh15, xh16, xh17, xh18, xh19, xh20, xh21, xh22, xh23;
    reg signed [31:0] xh24, xh25, xh26, xh27, xh28, xh29, xh30, xh31, xh32, xh33, xh34, xh35;
    reg signed [31:0] xh36, xh37, xh38, xh39, xh40, xh41, xh42, xh43, xh44, xh45, xh46, xh47;
    reg signed [31:0] xh48, xh49, xh50, xh51, xh52, xh53, xh54, xh55, xh56, xh57, xh58, xh59;
    reg signed [31:0] xh60, xh61, xh62, xh63, xh64, xh65, xh66, xh67, xh68, xh69, xh70, xh71;
    
    always @(posedge clk) begin
        if (reset || ~(coeff24_rdy || coeff48_rdy || coeff72_rdy)) begin
            {xh00, xh01, xh02, xh03, xh04, xh05, xh06, xh07, xh08, xh09, xh10, xh11} <= {12{32'b0}};
            {xh12, xh13, xh14, xh15, xh16, xh17, xh18, xh19, xh20, xh21, xh22, xh23} <= {12{32'b0}};
            {xh24, xh25, xh26, xh27, xh28, xh29, xh30, xh31, xh32, xh33, xh34, xh35} <= {12{32'b0}};
            {xh36, xh37, xh38, xh39, xh40, xh41, xh42, xh43, xh44, xh45, xh46, xh47} <= {12{32'b0}};
            {xh48, xh49, xh50, xh51, xh52, xh53, xh54, xh55, xh56, xh57, xh58, xh59} <= {12{32'b0}};
            {xh60, xh61, xh62, xh63, xh64, xh65, xh66, xh67, xh68, xh69, xh70, xh71} <= {12{32'b0}};
        end else begin
            xh00 <= coeff00 * in;
            xh01 <= coeff01 * zin01;
            xh02 <= coeff02 * zin02;
            xh03 <= coeff03 * zin03;
            xh04 <= coeff04 * zin04;
            xh05 <= coeff05 * zin05;
            xh06 <= coeff06 * zin06;
            xh07 <= coeff07 * zin07;
            xh08 <= coeff08 * zin08;
            xh09 <= coeff09 * zin09;
            xh10 <= coeff10 * zin10;
            xh11 <= coeff11 * zin11;
            xh12 <= coeff12 * zin12;
            xh13 <= coeff13 * zin13;
            xh14 <= coeff14 * zin14;
            xh15 <= coeff15 * zin15;
            xh16 <= coeff16 * zin16;
            xh17 <= coeff17 * zin17;
            xh18 <= coeff18 * zin18;
            xh19 <= coeff19 * zin19;
            xh20 <= coeff20 * zin20;
            xh21 <= coeff21 * zin21;
            xh22 <= coeff22 * zin22;
            xh23 <= coeff23 * zin23;
            if ((mode_rfir == MODE48T) || (mode_rfir == MODE72T)) begin
                xh24 <= coeff24 * zin24;
                xh25 <= coeff25 * zin25;
                xh26 <= coeff26 * zin26;
                xh27 <= coeff27 * zin27;
                xh28 <= coeff28 * zin28;
                xh29 <= coeff29 * zin29;
                xh30 <= coeff30 * zin30;
                xh31 <= coeff31 * zin31;
                xh32 <= coeff32 * zin32;
                xh33 <= coeff33 * zin33;
                xh34 <= coeff34 * zin34;
                xh35 <= coeff35 * zin35;
                xh36 <= coeff36 * zin36;
                xh37 <= coeff37 * zin37;
                xh38 <= coeff38 * zin38;
                xh39 <= coeff39 * zin39;
                xh40 <= coeff40 * zin40;
                xh41 <= coeff41 * zin41;
                xh42 <= coeff42 * zin42;
                xh43 <= coeff43 * zin43;
                xh44 <= coeff44 * zin44;
                xh45 <= coeff45 * zin45;
                xh46 <= coeff46 * zin46;
                xh47 <= coeff47 * zin47;
            end if (mode_rfir == MODE72T) begin
                xh48 <= coeff48 * zin48;
                xh49 <= coeff49 * zin49;
                xh50 <= coeff50 * zin50;
                xh51 <= coeff51 * zin51;
                xh52 <= coeff52 * zin52;
                xh53 <= coeff53 * zin53;
                xh54 <= coeff54 * zin54;
                xh55 <= coeff55 * zin55;
                xh56 <= coeff56 * zin56;
                xh57 <= coeff57 * zin57;
                xh58 <= coeff58 * zin58;
                xh59 <= coeff59 * zin59;
                xh60 <= coeff60 * zin60;
                xh61 <= coeff61 * zin61;
                xh62 <= coeff62 * zin62;
                xh63 <= coeff63 * zin63;
                xh64 <= coeff64 * zin64;
                xh65 <= coeff65 * zin65;
                xh66 <= coeff66 * zin66;
                xh67 <= coeff67 * zin67;
                xh68 <= coeff68 * zin68;
                xh69 <= coeff69 * zin69;
                xh70 <= coeff70 * zin70;
                xh71 <= coeff71 * zin71;
            end
        end
    end

    // Flip flop to delay to wait for the multiplication process
    reg signed [31:0] xxh00, xxh01, xxh02, xxh03, xxh04, xxh05, xxh06, xxh07, xxh08, xxh09, xxh10, xxh11;
    reg signed [31:0] xxh12, xxh13, xxh14, xxh15, xxh16, xxh17, xxh18, xxh19, xxh20, xxh21, xxh22, xxh23;
    reg signed [31:0] xxh24, xxh25, xxh26, xxh27, xxh28, xxh29, xxh30, xxh31, xxh32, xxh33, xxh34, xxh35;
    reg signed [31:0] xxh36, xxh37, xxh38, xxh39, xxh40, xxh41, xxh42, xxh43, xxh44, xxh45, xxh46, xxh47;
    reg signed [31:0] xxh48, xxh49, xxh50, xxh51, xxh52, xxh53, xxh54, xxh55, xxh56, xxh57, xxh58, xxh59;
    reg signed [31:0] xxh60, xxh61, xxh62, xxh63, xxh64, xxh65, xxh66, xxh67, xxh68, xxh69, xxh70, xxh71;
    // Flip flop to delay to wait for the summation process
    reg signed [31:0] out01, out02, out03, out04, out05, out06, out07, out08, out09, out10, out11, out12;
    reg signed [31:0] out13, out14, out15, out16, out17, out18, out19, out20, out21, out22, out23, out24;
    reg signed [31:0] out25, out26, out27, out28, out29, out30, out31, out32, out33, out34, out35, out36;
    reg signed [31:0] out37, out38, out39, out40, out41, out42, out43, out44, out45, out46, out47, out48;
    reg signed [31:0] out49, out50, out51, out52, out53, out54, out55, out56, out57, out58, out59, out60;
    reg signed [31:0] out61, out62, out63, out64, out65, out66, out67, out68, out69, out70, out71, out72;
    reg signed [31:0] out73, out74, out_sum;
    always @(posedge clk) begin
        if (reset) begin
            {xxh00, xxh01, xxh02, xxh03, xxh04, xxh05, xxh06, xxh07, xxh08, xxh09, xxh10, xxh11} <= {12{32'b0}};
            {xxh12, xxh13, xxh14, xxh15, xxh16, xxh17, xxh18, xxh19, xxh20, xxh21, xxh22, xxh23} <= {12{32'b0}};
            {xxh24, xxh25, xxh26, xxh27, xxh28, xxh29, xxh30, xxh31, xxh32, xxh33, xxh34, xxh35} <= {12{32'b0}};
            {xxh36, xxh37, xxh38, xxh39, xxh40, xxh41, xxh42, xxh43, xxh44, xxh45, xxh46, xxh47} <= {12{32'b0}};
            {xxh48, xxh49, xxh50, xxh51, xxh52, xxh53, xxh54, xxh55, xxh56, xxh57, xxh58, xxh59} <= {12{32'b0}};
            {xxh60, xxh61, xxh62, xxh63, xxh64, xxh65, xxh66, xxh67, xxh68, xxh69, xxh70, xxh71} <= {12{32'b0}};
            {out01, out02, out03, out04, out05, out06, out07, out08, out09, out10, out11, out12} <= {12{32'b0}};
            {out13, out14, out15, out16, out17, out18, out19, out20, out21, out22, out23, out24} <= {12{32'b0}};
            {out25, out26, out27, out28, out29, out30, out31, out32, out33, out34, out35, out36} <= {12{32'b0}};
            {out37, out38, out39, out40, out41, out42, out43, out44, out45, out46, out47, out48} <= {12{32'b0}};
            {out49, out50, out51, out52, out53, out54, out55, out56, out57, out58, out59, out60} <= {12{32'b0}};
            {out61, out62, out63, out64, out65, out66, out67, out68, out69, out70, out71, out72} <= {12{32'b0}};    
            {out73, out74, out_sum} <= {3{32'b0}};
        end else begin
            // Cycle delay 1: Allow for multiplication process
            {xxh00, xxh01, xxh02, xxh03, xxh04, xxh05, xxh06, xxh07, xxh08, xxh09, xxh10, xxh11}
            <= {xh00, xh01, xh02, xh03, xh04, xh05, xh06, xh07, xh08, xh09, xh10, xh11};
            {xxh12, xxh13, xxh14, xxh15, xxh16, xxh17, xxh18, xxh19, xxh20, xxh21, xxh22, xxh23}
            <= {xh12, xh13, xh14, xh15, xh16, xh17, xh18, xh19, xh20, xh21, xh22, xh23};
            if ((mode_rfir == MODE48T) || (mode_rfir == MODE72T)) begin
                {xxh24, xxh25, xxh26, xxh27, xxh28, xxh29, xxh30, xxh31, xxh32, xxh33, xxh34, xxh35}
                <= {xh24, xh25, xh26, xh27, xh28, xh29, xh30, xh31, xh32, xh33, xh34, xh35};
                {xxh36, xxh37, xxh38, xxh39, xxh40, xxh41, xxh42, xxh43, xxh44, xxh45, xxh46, xxh47}
                <= {xh36, xh37, xh38, xh39, xh40, xh41, xh42, xh43, xh44, xh45, xh46, xh47};
            end if (mode_rfir == MODE72T) begin
                {xxh48, xxh49, xxh50, xxh51, xxh52, xxh53, xxh54, xxh55, xxh56, xxh57, xxh58, xxh59}
                <= {xh48, xh49, xh50, xh51, xh52, xh53, xh54, xh55, xh56, xh57, xh58, xh59};
                {xxh60, xxh61, xxh62, xxh63, xxh64, xxh65, xxh66, xxh67, xxh68, xxh69, xxh70, xxh71}
                <= {xh60, xh61, xh62, xh63, xh64, xh65, xh66, xh67, xh68, xh69, xh70, xh71};
            end
            // Cycle delay 2: Allow for summation process
            out01 <= xxh00 + xxh01;
            out02 <= xxh02 + xxh03;
            out03 <= xxh04 + xxh05;
            out04 <= xxh06 + xxh07;
            out05 <= xxh08 + xxh09;
            out06 <= xxh10 + xxh11;
            out07 <= xxh12 + xxh13;
            out08 <= xxh14 + xxh15;
            out09 <= xxh16 + xxh17;
            out10 <= xxh18 + xxh19;
            out11 <= xxh20 + xxh21;
            out12 <= xxh22 + xxh23;
            if ((mode_rfir == MODE48T) || (mode_rfir == MODE72T)) begin
                out13 <= xxh24 + xxh25;
                out14 <= xxh26 + xxh27;
                out15 <= xxh28 + xxh29;
                out16 <= xxh30 + xxh31;
                out17 <= xxh32 + xxh33;
                out18 <= xxh34 + xxh35;
                out19 <= xxh36 + xxh37;
                out20 <= xxh38 + xxh39;
                out21 <= xxh40 + xxh41;
                out22 <= xxh42 + xxh43;
                out23 <= xxh44 + xxh45;
                out24 <= xxh46 + xxh47;
            end if (mode_rfir == MODE72T) begin
                out25 <= xxh48 + xxh49;
                out26 <= xxh50 + xxh51;
                out27 <= xxh52 + xxh53;
                out28 <= xxh54 + xxh55;
                out29 <= xxh56 + xxh57;
                out30 <= xxh58 + xxh59;
                out31 <= xxh60 + xxh61;
                out32 <= xxh62 + xxh63;
                out33 <= xxh64 + xxh65;
                out34 <= xxh66 + xxh67;
                out35 <= xxh68 + xxh69;
                out36 <= xxh70 + xxh71;
            end
            // Cycle delay 3
            out37 <= out01 + out02;
            out38 <= out03 + out04;
            out39 <= out05 + out06;
            out40 <= out07 + out08;
            out41 <= out09 + out10;
            out42 <= out11 + out12;
            if ((mode_rfir == MODE48T) || (mode_rfir == MODE72T)) begin
                out43 <= out13 + out14;
                out44 <= out15 + out16;
                out45 <= out17 + out18;
                out46 <= out19 + out20;
                out47 <= out21 + out22;
                out48 <= out23 + out24;
            end if (mode_rfir == MODE72T) begin
                out49 <= out25 + out26;
                out50 <= out27 + out28;
                out51 <= out29 + out30;
                out52 <= out31 + out32;
                out53 <= out33 + out34;
                out54 <= out35 + out36;
            end
            // Cycle delay 4
            out55 <= out37 + out38;
            out56 <= out39 + out40;
            out57 <= out41 + out42;
            if ((mode_rfir == MODE48T) || (mode_rfir == MODE72T)) begin
                out58 <= out43 + out44;
                out59 <= out45 + out46;
                out60 <= out47 + out48;
            end if (mode_rfir == MODE72T) begin
                out61 <= out49 + out50;
                out62 <= out51 + out52;
                out63 <= out53 + out54;
            end
            // Cycle delay 5
            out64 <= out55 + out56;
            out65 <= out57;
            if ((mode_rfir == MODE48T) || (mode_rfir == MODE72T)) begin
                out66 <= out58 + out59;
                out67 <= out60;
            end if (mode_rfir == MODE72T) begin
                out68 <= out61 + out62;
                out69 <= out63;
            end
            // Potential output (for t24) or Cycle delay 6 (for t48 and t72)
            if (mode_rfir == MODE24T)
                out_sum <= out64[31:16] + out65[31:16];
            else begin
                out70 <= out64 + out65;
                out71 <= out66 + out67;
                if (mode_rfir == MODE72T) begin
                    out72 <= out68 + out69;
                end
            end
            // Potential output (for t48) or Cycle delay 7 (for t72)
            if (mode_rfir == MODE48T)
                out_sum <= out70[31:16] + out71[31:16];
            else begin
                out73 <= out70 + out71;
                out74 <= out72;
            end
            // Potential output (for t72)
            if (mode_rfir == MODE72T)
                out_sum <= out73[31:16] + out74[31:16];
        end
    end
    
    // Output which is dependent on gain settings
    reg signed [31:0] out_gain;
    always @(posedge clk) begin
        if (reset) begin
            out_gain <= 32'b0;
        end else begin
            if (gain_rfir == 2'b00)         // +6 db
                out_gain <= out_sum <<< 1;
            else if (gain_rfir == 2'b01)    // 0 db
                out_gain <= out_sum;
            else if (gain_rfir == 2'b10)    // -6 db
                out_gain <= out_sum >>> 1;
            else if (gain_rfir == 2'b11)    // -12 db
                out_gain <= out_sum >>> 2;
        end
    end
    
    // Final output which is dependent on decimation rate
    integer deci_cnt;
    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0;
            out_valid <= 0;
            deci_cnt <= 0;
        end else begin
            if (~en_rfir) begin
                out <= in;
                deci_cnt <= 0;
            end else begin
                case (deci_rfir)
                DECI1: begin out <= out_gain; out_valid <= 1; deci_cnt <= 0; end
                DECI2: begin
                    if (deci_cnt == 1) begin
                        out <= out_gain;
                        out_valid <= 1;
                        deci_cnt <= 0;
                    end else begin
                        out_valid <= 0;
                        deci_cnt <= deci_cnt + 1;
                    end end
                DECI4: begin
                    if (deci_cnt == 3) begin
                        out <= out_gain;
                        out_valid <= 1;
                        deci_cnt <= 0;
                    end else begin
                        out_valid <= 0;
                        deci_cnt <= deci_cnt + 1;
                    end end
                default: begin out <= 0; out_valid <= 0; deci_cnt <= 0; end
                endcase
            end
        end
    end
endmodule
