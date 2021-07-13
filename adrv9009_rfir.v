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
    input signed [15:0] in,
    output reg signed [15:0] out,
    // Coefficients loading from RAM
    input signed [15:0] ram_coeff,
    output reg [6:0] addr_out 
    );
    
    // Corresponding mode for taps
    localparam TAP24 = 2'b01;
    localparam TAP48 = 2'b10;
    localparam TAP72 = 2'b11;
    
    // Load filter coefficient into registers
    reg coeff24_rdy, coeff48_rdy, coeff72_rdy;
    reg [6:0] addr, addr_cnt;
    reg signed [15:0] coeff00, coeff01, coeff02, coeff03, coeff04, coeff05, coeff06, coeff07, coeff08, coeff09;
    reg signed [15:0] coeff10, coeff11, coeff12, coeff13, coeff14, coeff15, coeff16, coeff17, coeff18, coeff19;
    reg signed [15:0] coeff20, coeff21, coeff22, coeff23, coeff24, coeff25, coeff26, coeff27, coeff28, coeff29;
    reg signed [15:0] coeff30, coeff31, coeff32, coeff33, coeff34, coeff35, coeff36, coeff37, coeff38, coeff39;
    reg signed [15:0] coeff40, coeff41, coeff42, coeff43, coeff44, coeff45, coeff46, coeff47, coeff48, coeff49;
    
    always @(posedge clk) begin
        if (reset) begin
            addr_out <= 0;
            addr_cnt <= 0;
            coeff24_rdy <= 0;
            coeff48_rdy <= 0;
        end else begin
            if (~coeff24_rdy && (mode_rfir == TAP24)) begin 
                case (addr_cnt)
                7'd00: begin coeff00 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd01: begin coeff01 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd02: begin coeff02 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd03: begin coeff03 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd04: begin coeff04 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd05: begin coeff05 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd06: begin coeff06 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd07: begin coeff07 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd08: begin coeff08 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd09: begin coeff09 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd10: begin coeff10 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd11: begin coeff11 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd12: begin coeff12 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd13: begin coeff13 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd14: begin coeff14 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd15: begin coeff15 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd16: begin coeff16 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd17: begin coeff17 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd18: begin coeff18 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd19: begin coeff19 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd20: begin coeff20 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd21: begin coeff21 <= ram_coeff; addr_cnt <= addr_cnt + 1; end
                7'd22: begin coeff22 <= ram_coeff; addr_cnt <= addr_cnt + 1; end
                7'd23: begin coeff23 <= ram_coeff; coeff24_rdy <= 1; end
                endcase
            end if (~coeff48_rdy && (mode_rfir == TAP48)) begin
                case (addr_cnt)
                7'd00: begin coeff00 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd01: begin coeff01 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd02: begin coeff02 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd03: begin coeff03 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd04: begin coeff04 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd05: begin coeff05 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd06: begin coeff06 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd07: begin coeff07 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd08: begin coeff08 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd09: begin coeff09 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd10: begin coeff10 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd11: begin coeff11 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd12: begin coeff12 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd13: begin coeff13 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd14: begin coeff14 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd15: begin coeff15 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd16: begin coeff16 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd17: begin coeff17 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd18: begin coeff18 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd19: begin coeff19 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd20: begin coeff20 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd21: begin coeff21 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd22: begin coeff22 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd23: begin coeff23 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd24: begin coeff24 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd25: begin coeff25 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd26: begin coeff26 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd27: begin coeff27 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd28: begin coeff28 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd29: begin coeff29 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd30: begin coeff30 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd31: begin coeff31 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd32: begin coeff32 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd33: begin coeff33 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd34: begin coeff34 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd35: begin coeff35 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd36: begin coeff36 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd37: begin coeff37 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd38: begin coeff38 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd39: begin coeff39 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd40: begin coeff40 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd41: begin coeff41 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd42: begin coeff42 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd43: begin coeff43 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd44: begin coeff44 <= ram_coeff; addr_out <= addr_out + 1; addr_cnt <= addr_cnt + 1; end
                7'd45: begin coeff45 <= ram_coeff; addr_cnt <= addr_cnt + 1; end
                7'd46: begin coeff46 <= ram_coeff; addr_cnt <= addr_cnt + 1; end
                7'd47: begin coeff47 <= ram_coeff; coeff48_rdy <= 1; end
                endcase
            end
        end
    end
    
    // Save previous input data
    reg signed [15:0] zin01, zin02, zin03, zin04, zin05, zin06, zin07, zin08, zin09, zin10;
    reg signed [15:0] zin11, zin12, zin13, zin14, zin15, zin16, zin17, zin18, zin19, zin20;
    reg signed [15:0] zin21, zin22, zin23, zin24, zin25, zin26, zin27, zin28, zin29, zin30;
    reg signed [15:0] zin31, zin32, zin33, zin34, zin35, zin36, zin37, zin38, zin39, zin40;
    reg signed [15:0] zin41, zin42, zin43, zin44, zin45, zin46, zin47, zin48, zin49, zin50;
    always @(posedge clk) begin
        if (reset) begin
            {zin01, zin02, zin03, zin04, zin05, zin06, zin07, zin08, zin09, zin10} <= {10{16'b0}};
            {zin11, zin12, zin13, zin14, zin15, zin16, zin17, zin18, zin19, zin20} <= {10{16'b0}};
            {zin21, zin22, zin23} <= {3{16'b0}};
        end else begin
            {zin01, zin02, zin03, zin04, zin05, zin06, zin07, zin08, zin09, zin10} <= {in, zin01, zin02, zin03, zin04, zin05, zin06, zin07, zin08, zin09};
            {zin11, zin12, zin13, zin14, zin15, zin16, zin17, zin18, zin19, zin20} <= {zin10, zin11, zin12, zin13, zin14, zin15, zin16, zin17, zin18, zin19};
            {zin21, zin22, zin23, zin24} <= {zin20, zin21, zin22, zin23};
            if (mode_rfir == TAP48) begin 
                {zin25, zin26, zin27, zin28, zin29, zin30} <= {zin24, zin25, zin26, zin27, zin28, zin29};
                {zin31, zin32, zin33, zin34, zin35, zin36, zin37, zin38, zin39, zin40} <= {zin30, zin31, zin32, zin33, zin34, zin35, zin36, zin37, zin38, zin39};
                {zin41, zin42, zin43, zin44, zin45, zin46, zin47, zin48} <= {zin40, zin41, zin42, zin43, zin44, zin45, zin46, zin47};
            end
        end
    end
    
    // Coefficient multiplation
    reg signed [31:0] xh00, xh01, xh02, xh03, xh04, xh05, xh06, xh07, xh08, xh09;
    reg signed [31:0] xh10, xh11, xh12, xh13, xh14, xh15, xh16, xh17, xh18, xh19;
    reg signed [31:0] xh20, xh21, xh22, xh23, xh24, xh25, xh26, xh27, xh28, xh29;
    reg signed [31:0] xh30, xh31, xh32, xh33, xh34, xh35, xh36, xh37, xh38, xh39;
    reg signed [31:0] xh40, xh41, xh42, xh43, xh44, xh45, xh46, xh47, xh48, xh49;
    always @(posedge clk) begin
        if (reset || ~(coeff24_rdy || coeff48_rdy)) begin
            {xh00, xh01, xh02, xh03, xh04, xh05, xh06, xh07, xh08, xh09, xh10, xh11} <= {12{32'b0}};
            {xh12, xh13, xh14, xh15, xh16, xh17, xh18, xh19, xh20, xh21, xh22, xh23} <= {12{32'b0}};
            {xh24, xh25, xh26, xh27, xh28, xh29, xh30, xh31, xh32, xh33, xh34, xh35} <= {12{32'b0}};
            {xh36, xh37, xh38, xh39, xh40, xh41, xh42, xh43, xh44, xh45, xh46, xh47} <= {12{32'b0}};
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
            if (mode_rfir == TAP48) begin
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
            end
        end
    end
    
    // Output
    reg signed [31:0] xxh00, xxh01, xxh02, xxh03, xxh04, xxh05, xxh06, xxh07, xxh08, xxh09, xxh10, xxh11;
    reg signed [31:0] xxh12, xxh13, xxh14, xxh15, xxh16, xxh17, xxh18, xxh19, xxh20, xxh21, xxh22, xxh23;
    reg signed [31:0] xxh24, xxh25, xxh26, xxh27, xxh28, xxh29, xxh30, xxh31, xxh32, xxh33, xxh34, xxh35;
    reg signed [31:0] xxh36, xxh37, xxh38, xxh39, xxh40, xxh41, xxh42, xxh43, xxh44, xxh45, xxh46, xxh47;
    reg signed [31:0] out01, out02, out03, out04, out05, out06, out07, out08, out09, out10, out11, out12;
    reg signed [31:0] out13, out14, out15, out16, out17, out18, out19, out20, out21, out22, out23, out24;
    reg signed [31:0] out25, out26, out27, out28, out29, out30, out31, out32, out33, out34, out35, out36;
    reg signed [31:0] out37, out38, out39, out40, out41, out42, out43, out44, out45, out46, out47, out48;
    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0;
            {xxh00, xxh01, xxh02, xxh03, xxh04, xxh05, xxh06, xxh07, xxh08, xxh09, xxh10, xxh11} <= {12{32'b0}};
            {xxh12, xxh13, xxh14, xxh15, xxh16, xxh17, xxh18, xxh19, xxh20, xxh21, xxh22, xxh23} <= {12{32'b0}};
            {xxh24, xxh25, xxh26, xxh27, xxh28, xxh29, xxh30, xxh31, xxh32, xxh33, xxh34, xxh35} <= {12{32'b0}};
            {xxh36, xxh37, xxh38, xxh39, xxh40, xxh41, xxh42, xxh43, xxh44, xxh45, xxh46, xxh47} <= {12{32'b0}};
            {out01, out02, out03, out04, out05, out06, out07, out08, out09, out10, out11, out12} <= {12{32'b0}};
            {out13, out14, out15, out16, out17, out18, out19, out20, out21, out22, out23, out24} <= {12{32'b0}};
            {out25, out26, out27, out28, out29, out30, out31, out32, out33, out34, out35, out36} <= {12{32'b0}};
            {out37, out38, out39, out40, out41, out42, out43, out44, out45, out46, out47, out48} <= {12{32'b0}};
        end else begin 
            if (~en_rfir)
                out <= in;
            else begin
                // Cycle delay 1: Allow for multiplication process
                {xxh00, xxh01, xxh02, xxh03, xxh04, xxh05, xxh06, xxh07, xxh08, xxh09, xxh10, xxh11} 
                <= {xh00, xh01, xh02, xh03, xh04, xh05, xh06, xh07, xh08, xh09, xh10, xh11};
                {xxh12, xxh13, xxh14, xxh15, xxh16, xxh17, xxh18, xxh19, xxh20, xxh21, xxh22, xxh23} 
                <= {xh12, xh13, xh14, xh15, xh16, xh17, xh18, xh19, xh20, xh21, xh22, xh23};
                if (mode_rfir == TAP48) begin
                    {xxh24, xxh25, xxh26, xxh27, xxh28, xxh29, xxh30, xxh31, xxh32, xxh33, xxh34, xxh35} 
                    <= {xh24, xh25, xh26, xh27, xh28, xh29, xh30, xh31, xh32, xh33, xh34, xh35};
                    {xxh36, xxh37, xxh38, xxh39, xxh40, xxh41, xxh42, xxh43, xxh44, xxh45, xxh46, xxh47} 
                    <= {xh36, xh37, xh38, xh39, xh40, xh41, xh42, xh43, xh44, xh45, xh46, xh47};
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
                if (mode_rfir == TAP48) begin
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
                end
                // Cycle delay 3
                out25 <= out01 + out02;
                out26 <= out03 + out04;
                out27 <= out05 + out06;
                out28 <= out07 + out08;
                out29 <= out09 + out10;
                out30 <= out11 + out12;
                if (mode_rfir == TAP48) begin
                    out31 <= out13 + out14;
                    out32 <= out15 + out16;
                    out33 <= out17 + out18;
                    out34 <= out19 + out20;
                    out35 <= out21 + out22;
                    out36 <= out23 + out24;
                end
                // Cycle delay 4
                out37 <= out25 + out26;
                out38 <= out27 + out28;
                out39 <= out29 + out30;
                if (mode_rfir == TAP48) begin
                    out40 <= out31 + out32;
                    out41 <= out33 + out34;
                    out42 <= out35 + out36;
                end
                // Cycle delay 5
                out43 <= out37 + out38;
                out44 <= out39;
                if (mode_rfir == TAP48) begin
                    out45 <= out40 + out41;
                    out46 <= out42;
                end
                // Finally output (for t24) or Cycle delay 6 (for t48)
                if (mode_rfir == TAP24)
                    out <= out43[31:16] + out44[31:16];
                else begin
                    out47 <= out43 + out44;
                    out48 <= out45 + out46;
                end
                // Finally output (for t48)
                if (mode_rfir == TAP48)
                    out <= out47[31:16] + out48[31:16];
            end
        end
    end
endmodule
