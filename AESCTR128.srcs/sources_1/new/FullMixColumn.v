`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2023 10:59:32 AM
// Design Name: 
// Module Name: FullMixColumn
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


module FullMixColumn(
    input [127:0] Xin,
    output [127:0] Yout
    );
    
    MixColumns M0(.Row(8'b10110101),.Column(Xin[127:96]),.Yout(Yout[127:120]));
    MixColumns M1(.Row(8'b01101101),.Column(Xin[127:96]),.Yout(Yout[119:112]));
    MixColumns M2(.Row(8'b01011011),.Column(Xin[127:96]),.Yout(Yout[111:104]));
    MixColumns M3(.Row(8'b11010110),.Column(Xin[127:96]),.Yout(Yout[103:96]));
    MixColumns M4(.Row(8'b10110101),.Column(Xin[95:64]),.Yout(Yout[95:88]));
    MixColumns M5(.Row(8'b01101101),.Column(Xin[95:64]),.Yout(Yout[87:80]));
    MixColumns M6(.Row(8'b01011011),.Column(Xin[95:64]),.Yout(Yout[79:72]));
    MixColumns M7(.Row(8'b11010110),.Column(Xin[95:64]),.Yout(Yout[71:64]));
    MixColumns M8(.Row(8'b10110101),.Column(Xin[63:32]),.Yout(Yout[63:56]));
    MixColumns M9(.Row(8'b01101101),.Column(Xin[63:32]),.Yout(Yout[55:48]));
    MixColumns M10(.Row(8'b01011011),.Column(Xin[63:32]),.Yout(Yout[47:40]));
    MixColumns M11(.Row(8'b11010110),.Column(Xin[63:32]),.Yout(Yout[39:32]));
    MixColumns M12(.Row(8'b10110101),.Column(Xin[31:0]),.Yout(Yout[31:24]));
    MixColumns M13(.Row(8'b01101101),.Column(Xin[31:0]),.Yout(Yout[23:16]));
    MixColumns M14(.Row(8'b01011011),.Column(Xin[31:0]),.Yout(Yout[15:8]));
    MixColumns M15(.Row(8'b11010110),.Column(Xin[31:0]),.Yout(Yout[7:0]));
    
endmodule
