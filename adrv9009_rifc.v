`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2021 08:13:17 AM
// Design Name: 
// Module Name: adrv9009_rifc
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


module adrv9009_rifc(
    input clk,
    input reset,
    input signed [15:0] in,
    output reg signed [15:0] out
    );
    
    // Filter coefficients
    wire signed [15:0] coeff00, coeff02, coeff04, coeff06, coeff08, coeff10, coeff12, coeff14, coeff16, coeff18;
    wire signed [15:0] coeff20, coeff22, coeff24, coeff26, coeff27, coeff28, coeff30, coeff32, coeff34, coeff36;
    wire signed [15:0] coeff38, coeff40, coeff42, coeff44, coeff46, coeff48, coeff50, coeff52, coeff54;
    assign coeff00 = 16'hFFFD; // 2^15 * (-9.1553*10^-5)
    assign coeff02 = 16'h0007; // 2^15 * 2.4414*10^-4
    assign coeff04 = 16'hFFEE; // 2^15 * (-5.7983*10^-4)
    assign coeff06 = 16'h0027; // 2^15 * 0.0012
    assign coeff08 = 16'hFFB5; // 2^15 * -0.0023
    assign coeff10 = 16'h0083; // 2^15 * 0.004
    assign coeff12 = 16'hFF2C; // 2^15 * -0.0065
    assign coeff14 = 16'h0151; // 2^15 * 0.0103
    assign coeff16 = 16'hFDFE; // 2^15 * -0.0157
    assign coeff18 = 16'h0305; // 2^15 * 0.0236
    assign coeff20 = 16'hFB6F; // 2^15 * -0.0357
    assign coeff22 = 16'h0734; // 2^15 * 0.0563
    assign coeff24 = 16'hF303; // 2^15 * -0.1015
    assign coeff26 = 16'h288C; // 2^15 * 0.3168
    assign coeff27 = 16'h4000; // 2^15 * 0.5
    assign coeff28 = 16'h288C; // 2^15 * 0.3168
    assign coeff30 = 16'hF303; // 2^15 * -0.1015
    assign coeff32 = 16'h0734; // 2^15 * 0.0563
    assign coeff34 = 16'hFB6F; // 2^15 * -0.0357
    assign coeff36 = 16'h0305; // 2^15 * 0.0236
    assign coeff38 = 16'hFDFE; // 2^15 * -0.0157
    assign coeff40 = 16'h0151; // 2^15 * 0.0103
    assign coeff42 = 16'hFF2C; // 2^15 * -0.0065
    assign coeff44 = 16'h0083; // 2^15 * 0.004
    assign coeff46 = 16'hFFB5; // 2^15 * -0.0023
    assign coeff48 = 16'h0027; // 2^15 * 0.0012
    assign coeff50 = 16'hFFEE; // 2^15 * (-5.7983*10^-4)
    assign coeff52 = 16'h0007; // 2^15 * 2.4414*10^-4
    assign coeff54 = 16'hFFFD; // 2^15 * (-9.1553*10^-5)
    
    // Save previous input data
    reg signed [15:0] zin01, zin02, zin03, zin04, zin05, zin06, zin07, zin08, zin09, zin10, zin11, zin12;
    reg signed [15:0] zin13, zin14, zin15, zin16, zin17, zin18, zin19, zin20, zin21, zin22, zin23, zin24;
    reg signed [15:0] zin25, zin26, zin27, zin28, zin29, zin30, zin31, zin32, zin33, zin34, zin35, zin36;
    reg signed [15:0] zin37, zin38, zin39, zin40, zin41, zin42, zin43, zin44, zin45, zin46, zin47, zin48;
    reg signed [15:0] zin49, zin50, zin51, zin52, zin53, zin54;
    always @(posedge clk) begin
        if (reset) begin
            {zin01, zin02, zin03, zin04, zin05, zin06, zin07, zin08, zin09, zin10, zin11, zin12} <= {12{16'b0}};
            {zin13, zin14, zin15, zin16, zin17, zin18, zin19, zin20, zin21, zin22, zin23, zin24} <= {12{16'b0}};
            {zin25, zin26, zin27, zin28, zin29, zin30, zin31, zin32, zin33, zin34, zin35, zin36} <= {12{16'b0}};
            {zin37, zin38, zin39, zin40, zin41, zin42, zin43, zin44, zin45, zin46, zin47, zin48} <= {12{16'b0}};
            {zin49, zin50, zin51, zin52, zin53, zin54} <= {6{16'b0}};
        end else begin
            {zin01, zin02, zin03, zin04, zin05, zin06, zin07, zin08} <= {in, zin01, zin02, zin03, zin04, zin05, zin06, zin07};
            {zin09, zin10, zin11, zin12, zin13, zin14, zin15, zin16} <= {zin08, zin09, zin10, zin11, zin12, zin13, zin14, zin15};
            {zin17, zin18, zin19, zin20, zin21, zin22, zin23, zin24} <= {zin16, zin17, zin18, zin19, zin20, zin21, zin22, zin23};
            {zin25, zin26, zin27, zin28, zin29, zin30, zin31, zin32} <= {zin24, zin25, zin26, zin27, zin28, zin29, zin30, zin31};
            {zin33, zin34, zin35, zin36, zin37, zin38, zin39, zin40} <= {zin32, zin33, zin34, zin35, zin36, zin37, zin38, zin39};
            {zin41, zin42, zin43, zin44, zin45, zin46, zin47, zin48} <= {zin40, zin41, zin42, zin43, zin44, zin45, zin46, zin47};
            {zin49, zin50, zin51, zin52, zin53, zin54} <= {zin48, zin49, zin50, zin51, zin52, zin53};
        end
    end
    
    // Coefficient multiplation
    reg signed [31:0] xh00, xh02, xh04, xh06, xh08, xh10, xh12, xh14, xh16, xh18, xh20, xh22;
    reg signed [31:0] xh24, xh26, xh27, xh28, xh30, xh32, xh34, xh36, xh38, xh40, xh42, xh44;
    reg signed [31:0] xh46, xh48, xh50, xh52, xh54;
    
    always @(posedge clk) begin
        if (reset) begin
            {xh00, xh02, xh04, xh06, xh08, xh10, xh12, xh14, xh16, xh18, xh20, xh22} <= {12{32'b0}};
            {xh24, xh26, xh27, xh28, xh30, xh32, xh34, xh36, xh38, xh40, xh42, xh44} <= {12{32'b0}};
            {xh46, xh48, xh50, xh52, xh54} <= {5{32'b0}};
        end else begin
            xh00 <= coeff00 * in;
            xh02 <= coeff02 * zin02;
            xh04 <= coeff04 * zin04;
            xh06 <= coeff06 * zin06;
            xh08 <= coeff08 * zin08;
            xh10 <= coeff10 * zin10;
            xh12 <= coeff12 * zin12;
            xh14 <= coeff14 * zin14;
            xh16 <= coeff16 * zin16;
            xh18 <= coeff18 * zin18;
            xh20 <= coeff20 * zin20;
            xh22 <= coeff22 * zin22;
            xh24 <= coeff24 * zin24;
            xh26 <= coeff26 * zin26;
            xh27 <= coeff27 * zin27;
            xh28 <= coeff28 * zin28;
            xh30 <= coeff30 * zin30;
            xh32 <= coeff32 * zin32;
            xh34 <= coeff34 * zin34;
            xh36 <= coeff36 * zin36;
            xh38 <= coeff38 * zin38;
            xh40 <= coeff40 * zin40;
            xh42 <= coeff42 * zin42;
            xh44 <= coeff44 * zin44;
            xh46 <= coeff46 * zin46;
            xh48 <= coeff48 * zin48;
            xh50 <= coeff50 * zin50;
            xh52 <= coeff52 * zin52;
            xh54 <= coeff54 * zin54;
        end
    end
    
    // Flip flop to delay to wait for the multiplication process
    reg signed [31:0] xxh00, xxh02, xxh04, xxh06, xxh08, xxh10, xxh12, xxh14, xxh16, xxh18, xxh20, xxh22;
    reg signed [31:0] xxh24, xxh26, xxh27, xxh28, xxh30, xxh32, xxh34, xxh36, xxh38, xxh40, xxh42, xxh44;
    reg signed [31:0] xxh46, xxh48, xxh50, xxh52, xxh54;
    // Flip flop to delay to wait for the summation process
    reg signed [31:0] out01, out02, out03, out04, out05, out06, out07, out08, out09, out10, out11, out12;
    reg signed [31:0] out13, out14, out15, out16, out17, out18, out19, out20, out21, out22, out23, out24;
    reg signed [31:0] out25, out26, out27, out28, out29;
    reg signed [15:0] out_sum;
    always @(posedge clk) begin
        if (reset) begin
            {xxh00, xxh02, xxh04, xxh06, xxh08, xxh10, xxh12, xxh14, xxh16, xxh18, xxh20, xxh22} <= {12{32'b0}};
            {xxh24, xxh26, xxh27, xxh28, xxh30, xxh32, xxh34, xxh36, xxh38, xxh40, xxh42, xxh44} <= {12{32'b0}};
            {xxh46, xxh48, xxh50, xxh52, xxh54} <= {5{32'b0}};
            {out01, out02, out03, out04, out05, out06, out07, out08, out09, out10, out11, out12} <= {12{32'b0}};
            {out13, out14, out15, out16, out17, out18, out19, out20, out21, out22, out23, out24} <= {12{32'b0}};
            {out25, out26, out27, out28, out29} <= {5{32'b0}};
            out_sum <= 16'b0;
        end else begin
            // Cycle delay 1: Allow for multiplication process
            {xxh00, xxh02, xxh04, xxh06, xxh08, xxh10, xxh12, xxh14, xxh16, xxh18, xxh20, xxh22}
            <= {xh00, xh02, xh04, xh06, xh08, xh10, xh12, xh14, xh16, xh18, xh20, xh22};
            {xxh24, xxh26, xxh27, xxh28, xxh30, xxh32, xxh34, xxh36, xxh38, xxh40, xxh42, xxh44}
            <= {xh24, xh26, xh27, xh28, xh30, xh32, xh34, xh36, xh38, xh40, xh42, xh44};
            {xxh46, xxh48, xxh50, xxh52, xxh54} <= {xh46, xh48, xh50, xh52, xh54};
            // Cycle delay 2: Allow for summation process
            out01 <= xxh00 + xxh02;
            out02 <= xxh04 + xxh06;
            out03 <= xxh08 + xxh10;
            out04 <= xxh12 + xxh14;
            out05 <= xxh16 + xxh18;
            out06 <= xxh20 + xxh22;
            out07 <= xxh24 + xxh26;
            out08 <= xxh27 + xxh28;
            out09 <= xxh30 + xxh32;
            out10 <= xxh34 + xxh36;
            out11 <= xxh38 + xxh40;
            out12 <= xxh42 + xxh44;
            out13 <= xxh46 + xxh48;
            out14 <= xxh50 + xxh52;
            out15 <= xxh54;
            // Cycle delay 3
            out16 <= out01 + out02;
            out17 <= out03 + out04;
            out18 <= out05 + out06;
            out19 <= out07 + out08;
            out20 <= out09 + out10;
            out21 <= out11 + out12;
            out22 <= out13 + out14;
            out23 <= out15;
            // Cycle delay 4
            out24 <= out16 + out17;
            out25 <= out18 + out19;
            out26 <= out20 + out21;
            out27 <= out22 + out23; 
            // Cycle delay 5
            out28 <= out24 + out25;
            out29 <= out26 + out27;
            // Final output
            out_sum <= out28[31:15] + out29[31:15];
        end
    end
    
    reg half_cnt;
    always @(posedge clk) begin
        if (reset) begin
            out <= 16'b0;
            half_cnt <= 1;
        end else begin
            if (half_cnt == 0) begin
                out <= out_sum;
                half_cnt <= 1;
            end else
                half_cnt <= 0; 
        end
    end
endmodule
