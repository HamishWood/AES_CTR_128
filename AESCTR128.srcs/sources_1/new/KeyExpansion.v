`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2023 02:16:52 PM
// Design Name: 
// Module Name: KeyExpansion
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


module KeyExpansion(
    input [127:0] KeyIn,
    input CLK100MHZ, reset, enable,
    output reg [127:0] KeyOut
    );
    
    reg [31:0] hold0 = 0;
    reg [31:0] hold1 = 0,hold2 = 0, clkHz = 0;
    reg [3:0] round = 0;
    wire [31:0] hold;
    gFunction G0(.Xin(KeyIn[31:0]),.Yout(hold[31:24]), .round(round), .Yout2(hold[23:0]));
    
    
    always @ (posedge CLK100MHZ) begin
        if (reset) begin
            clkHz = 0;
            KeyOut = 0;
            hold0 = KeyIn[127:96];
            hold1 = KeyIn[95:64];
            hold2 = KeyIn[63:32];
        end
        if (enable) begin
            if (clkHz <= 4) begin
                clkHz = clkHz + 1;
            end
            if (clkHz == 4) begin
                round = round + 1;
                if (round == 10) begin
                    round = 0;
                end
            end
            if (clkHz == 1) begin
                KeyOut[127:96] = hold0^hold;
            end
            if (clkHz == 2) begin
                KeyOut[95:64] = KeyOut[127:96]^hold1;
            end
            if (clkHz == 3) begin
                KeyOut[63:32] = KeyOut[95:64]^hold2;
            end
            if (clkHz == 4) begin
                KeyOut[31:0] = KeyIn[31:0]^KeyOut[63:32];
            end
        end
    end
    
endmodule
