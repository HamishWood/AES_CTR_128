`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2023 07:28:34 PM
// Design Name: 
// Module Name: MixColumns
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


module MixColumns(
    input [7:0] Row,
    input [31:0] Column,
    output [7:0] Yout
    );
    
    reg [31:0] hold;
    assign Yout = (((hold[31:24]^hold[23:16])^hold[15:8])^hold[7:0]);
    
    always @ (Row or Column) begin
        if (Row[7:6] == 2'b01) begin    /*1 GF2^3*/
            hold[31:24] = Column[31:24];
        end
        if (Row[7:6] == 2'b10) begin    /*x GF2^3*/
            if (Column[31]) begin
                hold[31:24] = {Column[30:24],1'b0}^8'b00011011;
            end else begin
                hold[31:24] = {Column[30:24],1'b0};
            end
        end
        if (Row[7:6] == 2'b11) begin   /*x+1 GF2^3*/
            if (Column[31]) begin
                hold[31:24] = ({Column[30:24],1'b0}^8'b00011011)^Column[31:24];
            end else begin
                hold[31:24] = {Column[30:24],1'b0}^Column[31:24];
            end
        end
        
        if (Row[5:4] == 2'b01) begin    /*1 GF2^3*/
            hold[23:16] = Column[23:16];
        end
        if (Row[5:4] == 2'b10) begin    /*x GF2^3*/
            if (Column[23]) begin
                hold[23:16] = {Column[22:16],1'b0}^8'b00011011;
            end else begin
                hold[23:16] = {Column[22:16],1'b0};
            end
        end
        if (Row[5:4] == 2'b11) begin   /*x+1 GF2^3*/
            if (Column[23]) begin
                hold[23:16] = ({Column[22:16],1'b0}^8'b00011011)^Column[23:16];
            end else begin
                hold[23:16] = {Column[22:16],1'b0}^Column[23:16];
            end
        end
        
        if (Row[3:2] == 2'b01) begin    /*1 GF2^3*/
            hold[15:8] = Column[15:8];
        end
        if (Row[3:2] == 2'b10) begin    /*x GF2^3*/
            if (Column[15]) begin
                hold[15:8] = {Column[14:8],1'b0}^8'b00011011;
            end else begin
                hold[15:8] = {Column[14:8],1'b0};
            end
        end
        if (Row[3:2] == 2'b11) begin   /*x+1 GF2^3*/
            if (Column[15]) begin
                hold[15:8] = ({Column[14:8],1'b0}^8'b00011011)^Column[15:8];
            end else begin
                hold[15:8] = {Column[14:8],1'b0}^Column[15:8];
            end
        end
                
        if (Row[1:0] == 2'b01) begin    /*1 GF2^3*/
            hold[7:0] = Column[7:0];
        end
        if (Row[1:0] == 2'b10) begin    /*x GF2^3*/
            if (Column[7]) begin
                hold[7:0] = {Column[6:0],1'b0}^8'b00011011;
            end else begin
                hold[7:0] = {Column[6:0],1'b0};
            end
        end
        if (Row[1:0] == 2'b11) begin   /*x+1 GF2^3*/
            if (Column[7]) begin
                hold[7:0] = ({Column[6:0],1'b0}^8'b00011011)^Column[7:0];
            end else begin
                hold[7:0] = {Column[6:0],1'b0}^Column[7:0];
            end
        end
    end
endmodule
