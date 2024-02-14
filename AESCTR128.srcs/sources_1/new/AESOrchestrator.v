`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2023 02:33:32 PM
// Design Name: 
// Module Name: AESOrchestrator
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


module AESOrchestrator(
    input [127:0] KeyIn,
    input [127:0] Xin,
    input CLK100MHZ,
    input reset,
    input enable,
    output reg [127:0] Yout
    );
    
    reg [127:0] hold = 0;
    reg [127:0] keyHold = 0;
    reg keyEnable = 0;
    reg keyReset = 0;
    wire [127:0] sboxOut, shiftOut, mixOut, keyExpOut;
    
    FullSbox M0(.Xin(hold),.Yout(sboxOut));
    ShiftRows M1(.Xin(hold),.Yout(shiftOut));
    FullMixColumn M2(.Xin(hold),.Yout(mixOut));
    KeyExpansion M3(.KeyIn(keyHold),.KeyOut(keyExpOut), .reset(keyReset), .enable(keyEnable), .CLK100MHZ(CLK100MHZ));
    
    reg [31:0] clkHz = 0;
    
    always @ (posedge CLK100MHZ) begin
        if (reset) begin
            clkHz = 0;
            hold = Xin;
            keyHold = KeyIn;
        end
         if (enable) begin
               if (clkHz <= 100) begin
                   clkHz = clkHz + 1;
               end
               else begin
                    Yout = hold;
               end
               
               case (clkHz)
                1: begin hold = hold^keyHold; keyReset = 1; keyEnable = 0; end
                2: begin hold = sboxOut; keyReset = 0; keyEnable = 1; end
                3: begin hold = shiftOut; end
                4: begin hold = mixOut; end
                10: begin hold = keyExpOut^hold; keyHold = keyExpOut; keyReset = 1; keyEnable = 0; end
                11: begin hold = sboxOut; keyReset = 0; keyEnable = 1; end
                12: begin hold = shiftOut; end
                13: begin hold = mixOut; end
                20: begin hold = keyExpOut^hold; keyHold = keyExpOut; keyReset = 1; keyEnable = 0; end
                21: begin hold = sboxOut; keyReset = 0; keyEnable = 1; end
                22: begin hold = shiftOut; end
                23: begin hold = mixOut; end
                30: begin hold = keyExpOut^hold; keyHold = keyExpOut; keyReset = 1; keyEnable = 0; end
                31: begin hold = sboxOut; keyReset = 0; keyEnable = 1; end
                32: begin hold = shiftOut; end
                33: begin hold = mixOut; end
                40: begin hold = keyExpOut^hold; keyHold = keyExpOut; keyReset = 1; keyEnable = 0; end
                41: begin hold = sboxOut; keyReset = 0; keyEnable = 1; end
                42: begin hold = shiftOut; end
                43: begin hold = mixOut; end
                50: begin hold = keyExpOut^hold; keyHold = keyExpOut; keyReset = 1; keyEnable = 0; end
                51: begin hold = sboxOut; keyReset = 0; keyEnable = 1; end
                52: begin hold = shiftOut; end
                53: begin hold = mixOut; end
                60: begin hold = keyExpOut^hold; keyHold = keyExpOut; keyReset = 1; keyEnable = 0; end
                61: begin hold = sboxOut; keyReset = 0; keyEnable = 1; end
                62: begin hold = shiftOut; end
                63: begin hold = mixOut; end
                70: begin hold = keyExpOut^hold; keyHold = keyExpOut; keyReset = 1; keyEnable = 0; end
                71: begin hold = sboxOut; keyReset = 0; keyEnable = 1; end
                72: begin hold = shiftOut; end
                73: begin hold = mixOut; end
                80: begin hold = keyExpOut^hold; keyHold = keyExpOut; keyReset = 1; keyEnable = 0; end
                81: begin hold = sboxOut; keyReset = 0; keyEnable = 1; end
                82: begin hold = shiftOut; end
                83: begin hold = mixOut; end
                90: begin hold = keyExpOut^hold; keyHold = keyExpOut; keyReset = 1; keyEnable = 0; end
                91: begin hold = sboxOut; keyReset = 0; keyEnable = 1; end
                92: begin hold = shiftOut; end
                100: begin hold = keyExpOut^hold; keyHold = keyExpOut; keyReset = 1; keyEnable = 0; end
               endcase
         end
    end
endmodule
