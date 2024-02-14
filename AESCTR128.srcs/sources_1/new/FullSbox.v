`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2023 07:07:28 PM
// Design Name: 
// Module Name: FullSbox
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


module FullSbox(
    input [127:0] Xin,
    output [127:0] Yout
    );
    
    Sbox S0(.Xin(Xin[127:120]),.Yout(Yout[127:120]));
    Sbox S1(.Xin(Xin[119:112]),.Yout(Yout[119:112]));
    Sbox S2(.Xin(Xin[111:104]),.Yout(Yout[111:104]));
    Sbox S3(.Xin(Xin[103:96]),.Yout(Yout[103:96]));
    Sbox S4(.Xin(Xin[95:88]),.Yout(Yout[95:88]));
    Sbox S5(.Xin(Xin[87:80]),.Yout(Yout[87:80]));
    Sbox S6(.Xin(Xin[79:72]),.Yout(Yout[79:72]));
    Sbox S7(.Xin(Xin[71:64]),.Yout(Yout[71:64]));
    Sbox S8(.Xin(Xin[63:56]),.Yout(Yout[63:56]));
    Sbox S9(.Xin(Xin[55:48]),.Yout(Yout[55:48]));
    Sbox S10(.Xin(Xin[47:40]),.Yout(Yout[47:40]));
    Sbox S11(.Xin(Xin[39:32]),.Yout(Yout[39:32]));
    Sbox S12(.Xin(Xin[31:24]),.Yout(Yout[31:24]));
    Sbox S13(.Xin(Xin[23:16]),.Yout(Yout[23:16]));
    Sbox S14(.Xin(Xin[15:8]),.Yout(Yout[15:8]));
    Sbox S15(.Xin(Xin[7:0]),.Yout(Yout[7:0]));
    
endmodule
