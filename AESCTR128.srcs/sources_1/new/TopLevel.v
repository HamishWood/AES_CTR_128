`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2024 10:58:35 AM
// Design Name: 
// Module Name: TopLevel
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

//RealTerm Settings: 57600 baud, 8 data bits, 1 stop bit, no parity, no HW flow control, 164 ms char delay.
module TopLevel(
    input CLK100MHZ,
    input TLreset, //SW15 reset entire circuit
    input ContinuousEncrypt, //SW0 turn on to start encrypting UART input once key and IV are imported
    input KeyImport, //SW1 turn on to set next 16 byte package to key
    input IVImport,  //SW2 turn on to set next 16 byte package to IV
    input UART_TXD_IN,
    output UART_RXD_OUT,
    output reg KeyImported = 0, IVImported = 0,  //LED 0, 1 indicators that key and IV are loaded
    output [3:0] state, //LED 6:3 current state of the top level module
    
    output [7:0] DebugLED //LEDs to show the last byte that was sent via UART.
    );
    
    parameter S_idle = 4'b0000,
              S_ReceiverWait = 4'b0001,
              S_ReadReceiver = 4'b0011,
              S_AESenable = 4'b0111,
              S_AESwait = 4'b1111,
              S_ReadAES = 4'b1110,
              S_TransmitWait = 4'b1100;
              
    
    reg [3:0] currentState = S_idle;
    assign state = currentState;
    reg [127:0] CTR = 0;
    reg [31:0] clkcounter = 0;
    
    reg [127:0] TransmitMessage = 0, AESKeyIn = 0, EncryptionInput = 0, EncryptionOutput = 0;
    wire [127:0] ReceiverMessage, AEShold;
    reg AESenable = 0, AESreset = 0, ReceiverOn = 0, TransmitSend = 0;
    wire TransmitDone, ReceiverFull;
    
    AESOrchestrator S0(.KeyIn(AESKeyIn), .Xin(CTR), .reset(AESreset), .enable(AESenable), .CLK100MHZ(CLK100MHZ), .Yout(AEShold));
    Transceiver T0(.ReceiverTest(DebugLED), .CLK100MHZ(CLK100MHZ), .TransmitMessage(TransmitMessage), .ReceiverFull(ReceiverFull), .ReceiverMessage(ReceiverMessage), .TransmitSend(TransmitSend), .TransmitDone(TransmitDone), .ReceiverOn(ReceiverOn), .UART_RXD_OUT(UART_RXD_OUT), .UART_TXD_IN(UART_TXD_IN));
    
    always @ (posedge CLK100MHZ) begin 
        if (TLreset) begin  //Top level reset, constrained to SW15
            currentState = S_idle;
            TransmitMessage = 0;
            AESKeyIn = 0;
            AESenable = 0;
            AESreset = 1;
            ReceiverOn = 0;
            TransmitSend = 0;
            KeyImported = 0;
            IVImported = 0;
            CTR = 0;
      end
        case(currentState)
            S_idle: begin
                if (ContinuousEncrypt^KeyImport^IVImport) begin
                    if (ContinuousEncrypt) begin
                        currentState = S_ReceiverWait; 
                        ReceiverOn = 1;
                    end
                    if (KeyImport & !KeyImported) begin
                        currentState = S_ReceiverWait;
                        ReceiverOn = 1;
                    end
                    if (IVImport & !IVImported) begin
                        currentState = S_ReceiverWait;
                        ReceiverOn = 1;
                    end
                end
            end
            S_ReceiverWait: begin
                if (ReceiverFull) begin 
                    currentState = S_ReadReceiver;
                end
            end
            S_ReadReceiver: begin
                if (KeyImport) begin
                    AESKeyIn = ReceiverMessage;
                    ReceiverOn = 0;
                    KeyImported = 1;
                    currentState = S_idle;
                end else if (IVImport) begin
                    CTR = ReceiverMessage;
                    ReceiverOn = 0;
                    IVImported = 1;
                    currentState = S_idle;
                end else if (ContinuousEncrypt) begin
                    EncryptionInput = ReceiverMessage;
                    ReceiverOn = 0;
                    currentState = S_AESenable;
                end
            end
            S_AESenable: begin
                AESreset = 0;
                AESenable = 1;
                CTR = CTR + 1;
                currentState = S_AESwait;
            end
            S_AESwait: begin
                if (clkcounter >= 200) begin //Estimated time it takes to execute AES
                    currentState = S_ReadAES;
                    clkcounter = 0;
                end else begin
                    clkcounter = clkcounter + 1;
                end
            end
            S_ReadAES: begin
                EncryptionOutput = AEShold ^ EncryptionInput;
                TransmitMessage = EncryptionOutput;
                TransmitSend = 1;
                currentState = S_TransmitWait;
                AESreset = 1;
                AESenable = 0;
            end
            S_TransmitWait: begin
                if (clkcounter >= 1600100) begin //Estimated time it takes to send a UART message.
                    TransmitSend = 0;
                    if (TransmitDone) begin
                        currentState = S_idle;
                        clkcounter = 0;
                    end
                end else begin
                    clkcounter = clkcounter + 1;
                end
            end
        endcase
        
    end
    
endmodule
