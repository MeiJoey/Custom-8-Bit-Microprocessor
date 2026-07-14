`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2026 08:22:51 PM
// Design Name: 
// Module Name: Decoder_4x16
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


module Decoder_4x16(
    input en,
    input [3:0] a,
    output reg [15:0] y
    );
    
    always @(*) begin
    y = 16'b0000000000000000;
    if (en) begin
        case(a)
        4'b0000: y = 16'b0000000000000001; // Load A
        4'b0001: y = 16'b0000000000000010; // Load B
        4'b0010: y = 16'b0000000000000100; // CLR A
        4'b0011: y = 16'b0000000000001000; // CLR B
        4'b0100: y = 16'b0000000000010000; // Logic Shift Left
        4'b0101: y = 16'b0000000000100000; // Logic Shift Right
        4'b0110: y = 16'b0000000001000000; // MOV A -> B
        4'b0111: y = 16'b0000000010000000; // MOV B -> A
        4'b1000: y = 16'b0000000100000000; // Complement A
        4'b1001: y = 16'b0000001000000000; // Complement B
        4'b1010: y = 16'b0000010000000000; // ADD
        4'b1011: y = 16'b0000100000000000; // SUB
        4'b1100: y = 16'b0001000000000000; // Increment A
        4'b1101: y = 16'b0010000000000000; // Decrement A
        4'b1110: y = 16'b0100000000000000; // AND
        4'b1111: y = 16'b1000000000000000; // OR
        default: y = 16'b0000000000000000;
        endcase
    end
end
endmodule
