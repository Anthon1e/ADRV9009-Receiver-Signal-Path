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
    input clk,
    input reset,
    input signed [15:0] in,
    output reg signed [15:0] out
    );
    
    // Load filter coefficient into registers
    reg coeff24_rdy;
    reg [4:0] addr, addr_cnt;
    reg signed [15:0] coeff00, coeff01, coeff02, coeff03, coeff04, coeff05, coeff06, coeff07, coeff08, coeff09;
    reg signed [15:0] coeff10, coeff11, coeff12, coeff13, coeff14, coeff15, coeff16, coeff17, coeff18, coeff19;
    reg signed [15:0] coeff20, coeff21, coeff22, coeff23;
    wire signed [15:0] coeff;
    
    blk_mem_gen_0 coeff24 (clk, addr, coeff); 
    
    always @(posedge clk) begin
        if (reset) begin
            addr <= 0;
            addr_cnt <= 0;
            coeff24_rdy <= 0;
        end else begin
            if (~coeff24_rdy) begin 
                case (addr_cnt)
                5'd0: begin addr <= addr + 1; addr_cnt <= addr_cnt + 1; end
                5'd1: begin addr <= addr + 1; addr_cnt <= addr_cnt + 1; end
                5'd2: begin coeff00 <= coeff; addr <= addr + 1; addr_cnt <= addr_cnt + 1; end
                5'd3: begin coeff01 <= coeff; addr <= addr + 1; addr_cnt <= addr_cnt + 1; end
                5'd4: begin coeff02 <= coeff; addr <= addr + 1; addr_cnt <= addr_cnt + 1; end
                5'd5: begin coeff03 <= coeff; addr <= addr + 1; addr_cnt <= addr_cnt + 1; end
                5'd6: begin coeff04 <= coeff; addr <= addr + 1; addr_cnt <= addr_cnt + 1; end
                5'd7: begin coeff05 <= coeff; addr <= addr + 1; addr_cnt <= addr_cnt + 1; end
                5'd8: begin coeff06 <= coeff; addr <= addr + 1; addr_cnt <= addr_cnt + 1; end
                5'd9: begin coeff07 <= coeff; addr <= addr + 1; addr_cnt <= addr_cnt + 1; end
                5'd10: begin coeff08 <= coeff; addr <= addr + 1; addr_cnt <= addr_cnt + 1; end
                5'd11: begin coeff09 <= coeff; addr <= addr + 1; addr_cnt <= addr_cnt + 1; end
                5'd12: begin coeff10 <= coeff; addr <= addr + 1; addr_cnt <= addr_cnt + 1; end
                5'd13: begin coeff11 <= coeff; addr <= addr + 1; addr_cnt <= addr_cnt + 1; end
                5'd14: begin coeff12 <= coeff; addr <= addr + 1; addr_cnt <= addr_cnt + 1; end
                5'd15: begin coeff13 <= coeff; addr <= addr + 1; addr_cnt <= addr_cnt + 1; end
                5'd16: begin coeff14 <= coeff; addr <= addr + 1; addr_cnt <= addr_cnt + 1; end
                5'd17: begin coeff15 <= coeff; addr <= addr + 1; addr_cnt <= addr_cnt + 1; end
                5'd18: begin coeff16 <= coeff; addr <= addr + 1; addr_cnt <= addr_cnt + 1; end
                5'd19: begin coeff17 <= coeff; addr <= addr + 1; addr_cnt <= addr_cnt + 1; end
                5'd20: begin coeff18 <= coeff; addr <= addr + 1; addr_cnt <= addr_cnt + 1; end
                5'd21: begin coeff19 <= coeff; addr <= addr + 1; addr_cnt <= addr_cnt + 1; end
                5'd22: begin coeff20 <= coeff; addr <= addr + 1; addr_cnt <= addr_cnt + 1; end
                5'd23: begin coeff21 <= coeff; addr_cnt <= addr_cnt + 1; end
                5'd24: begin coeff22 <= coeff; addr_cnt <= addr_cnt + 1; end
                5'd25: begin coeff23 <= coeff; coeff24_rdy <= 1; end
                endcase
            end
        end
    end
    
    // Save previous input data
    reg signed [15:0] zin01, zin02, zin03, zin04, zin05, zin06, zin07, zin08, zin09, zin10;
    reg signed [15:0] zin11, zin12, zin13, zin14, zin15, zin16, zin17, zin18, zin19, zin20;
    reg signed [15:0] zin21, zin22, zin23;
    always @(posedge clk) begin
        if (reset) begin
            {zin01, zin02, zin03, zin04, zin05, zin06, zin07, zin08, zin09, zin10} <= {10{16'b0}};
            {zin11, zin12, zin13, zin14, zin15, zin16, zin17, zin18, zin19, zin20} <= {10{16'b0}};
            {zin21, zin22, zin23} <= {3{16'b0}};
        end else begin
            zin01 <= in;
            {zin02, zin03, zin04, zin05, zin06, zin07, zin08, zin09, zin10, zin11, zin12} <= {zin01, zin02, zin03, zin04, zin05, zin06, zin07, zin08, zin09, zin10, zin11};
            {zin13, zin14, zin15, zin16, zin17, zin18, zin19, zin20, zin21, zin22, zin23} <= {zin12, zin13, zin14, zin15, zin16, zin17, zin18, zin19, zin20, zin21, zin22};
        end
    end
    
    // Coefficient multiplation
    reg signed [31:0] xh00, xh01, xh02, xh03, xh04, xh05, xh06, xh07, xh08, xh09;
    reg signed [31:0] xh10, xh11, xh12, xh13, xh14, xh15, xh16, xh17, xh18, xh19;
    reg signed [31:0] xh20, xh21, xh22, xh23;
    always @(posedge clk) begin
        if (reset || ~coeff24_rdy) begin
            {xh00, xh01, xh02, xh03, xh04, xh05, xh06, xh07, xh08, xh09, xh10, xh11} <= {12{32'b0}};
            {xh12, xh13, xh14, xh15, xh16, xh17, xh18, xh19, xh20, xh21, xh22, xh23} <= {12{32'b0}};
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
        end
    end
    
    // Output
    reg signed [31:0] xxh00, xxh01, xxh02, xxh03, xxh04, xxh05, xxh06, xxh07, xxh08, xxh09, xxh10, xxh11;
    reg signed [31:0] xxh12, xxh13, xxh14, xxh15, xxh16, xxh17, xxh18, xxh19, xxh20, xxh21, xxh22, xxh23;
    reg signed [31:0] out01, out02, out03, out04, out05, out06, out07, out08, out09, out10, out11, out12;
    reg signed [31:0] out13, out14, out15, out16, out17, out18, out19, out20, out21, out22, out23, out24;
    always @(posedge clk) begin
        if (reset) begin
            out <= 32'b0;
            {xxh00, xxh01, xxh02, xxh03, xxh04, xxh05, xxh06, xxh07, xxh08, xxh09, xxh10, xxh11} <= {12{32'b0}};
            {xxh12, xxh13, xxh14, xxh15, xxh16, xxh17, xxh18, xxh19, xxh20, xxh21, xxh22, xxh23} <= {12{32'b0}};
            {out01, out02, out03, out04, out05, out06, out07, out08, out09, out10, out11, out12} <= {12{32'b0}};
            {out13, out14, out15, out16, out17, out18, out19, out20, out21, out22, out23, out24} <= {12{32'b0}};
        end else begin 
            // Cycle delay 1: Allow for multiplication process
            {xxh00, xxh01, xxh02, xxh03, xxh04, xxh05, xxh06, xxh07, xxh08, xxh09, xxh10, xxh11} 
            <= {xh00, xh01, xh02, xh03, xh04, xh05, xh06, xh07, xh08, xh09, xh10, xh11};
            {xxh12, xxh13, xxh14, xxh15, xxh16, xxh17, xxh18, xxh19, xxh20, xxh21, xxh22, xxh23} 
            <= {xh12, xh13, xh14, xh15, xh16, xh17, xh18, xh19, xh20, xh21, xh22, xh23};
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
            // Cycle delay 3
            out13 <= out01 + out02;
            out14 <= out03 + out04;
            out15 <= out05 + out06;
            out16 <= out07 + out08;
            out17 <= out09 + out10;
            out18 <= out11 + out12;
            // Cycle delay 4
            out19 <= out13 + out14;
            out20 <= out15 + out16;
            out21 <= out17 + out18;
            // Cycle delay 5
            out22 <= out19 + out20;
            out23 <= out21;
            // Finally output
            out <= out22[31:16] + out23[31:16];
        end
    end
endmodule
