`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2023 07:17:35 PM
// Design Name: 
// Module Name: ShiftRows
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


module ShiftRows(
    input [127:0] Xin,
    output [127:0] Yout
    );
    
    assign Yout[127:96] = {Xin[127:120], Xin[87:80], Xin[47:40], Xin[7:0]};
    assign Yout[95:64] = {Xin[95:88], Xin[55:48], Xin[15:8], Xin[103:96]};
    assign Yout[63:32] = {Xin[63:56], Xin[23:16], Xin[111:104], Xin[71:64]};
    assign Yout[31:0] = {Xin[31:24], Xin[119:112], Xin[79:72], Xin[39:32]};
    
endmodule
