`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/30/2023 02:08:56 PM
// Design Name: 
// Module Name: gFunction
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


module gFunction(
    input [31:0] Xin,
    input [3:0] round,
    output [23:0] Yout2,
    output reg [31:24] Yout
    );
    
    wire [8:0] hold;
    
    Sbox S0(.Xin(Xin[23:16]),.Yout(hold));
    Sbox S1(.Xin(Xin[15:8]),.Yout(Yout2[23:16]));
    Sbox S2(.Xin(Xin[7:0]),.Yout(Yout2[15:8]));
    Sbox S3(.Xin(Xin[31:24]),.Yout(Yout2[7:0]));
    
    always @ (hold) begin
        case (round)
            0:begin Yout[31:24] = hold^8'h01; end
            1:begin Yout[31:24] = hold^8'h02; end
            2:begin Yout[31:24] = hold^8'h04; end
            3:begin Yout[31:24] = hold^8'h08; end
            4:begin Yout[31:24] = hold^8'h10; end
            5:begin Yout[31:24] = hold^8'h20; end
            6:begin Yout[31:24] = hold^8'h40; end
            7:begin Yout[31:24] = hold^8'h80; end
            8:begin Yout[31:24] = hold^8'h1B; end
            9:begin Yout[31:24] = hold^8'h36; end
        endcase
    end
    
endmodule
