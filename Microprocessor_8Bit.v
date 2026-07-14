`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2026 08:23:24 PM
// Design Name: 
// Module Name: Microprocessor_8Bit
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


module Microprocessor_8Bit(
    input clk,
    input rst,
    input en,
    input [3:0] opcode,
    input [7:0] sw,
    input [1:0] RegSelect,
    output [7:0] LED,
    output [6:0] Segments,
    output [3:0] an,
    output reg Cout
    );
    
    // Registers to Display Data
    reg [7:0] DisplayReg;
    reg [1:0] digit_select = 0;
    reg [6:0] segment_reg;
    reg [3:0] an_reg;
    reg [15:0] refresh_counter = 0;
    
    // Registers to Store Data
    reg [7:0] RegA;
    reg [7:0] RegB;
    reg [7:0] RegC;
    
    // Wires for 7-Segment Display
    wire [3:0] lower = DisplayReg[3:0];
    wire [3:0] upper = DisplayReg[7:4];
    
    //Wire for Enable
    wire en_pulse;
    
    //Wire for DCD
    wire [15:0] dec_out;
    
    // Debounce Module
    Enable_Debounce_PushButton u_db (
        .clk(clk),
        .button(en),
        .pulse(en_pulse)
    );
    
    
    // 7-Segment Digit Select
    assign Segments = segment_reg;
    assign an = an_reg;
    always @(posedge clk) begin
        refresh_counter <= refresh_counter + 1;
        digit_select <= refresh_counter[15:14];
    end
    
    always @(*) begin
        case(digit_select)
            2'b00: begin
                an_reg = 4'b1110;
                segment_reg = hex_to_7segment(lower);
                end
            2'b01: begin
                an_reg = 4'b1101;
                segment_reg = hex_to_7segment(upper);
                end
            default: begin
                an_reg = 4'b1111;
                segment_reg = 7'b1111111;
                end
        endcase
    end
    
// Decoder    
    Decoder_4x16 u_dec(
        .en(en_pulse),
        .a(opcode),
        .y(dec_out)
    );
    
    
// Display Register Select
    always @(*) begin
        case(RegSelect)
            2'b01: DisplayReg = RegA;
            2'b10: DisplayReg = RegB;
            2'b11: DisplayReg = RegC;
            default: DisplayReg = 8'b00000000;
        endcase
    end
    assign LED[7:0] = DisplayReg;
    
    
// 7 Segment Display
function [6:0] hex_to_7segment;
    input [3:0] hex;
    case(hex)
        4'b0000: hex_to_7segment = 7'b1000000;
        4'b0001: hex_to_7segment = 7'b1111001;
        4'b0010: hex_to_7segment = 7'b0100100;
        4'b0011: hex_to_7segment = 7'b0110000;
        4'b0100: hex_to_7segment = 7'b0011001;
        4'b0101: hex_to_7segment = 7'b0010010;
        4'b0110: hex_to_7segment = 7'b0000010;
        4'b0111: hex_to_7segment = 7'b1111000;
        4'b1000: hex_to_7segment = 7'b0000000;
        4'b1001: hex_to_7segment = 7'b0010000;
        4'b1010: hex_to_7segment = 7'b0001000;
        4'b1011: hex_to_7segment = 7'b0000011;
        4'b1100: hex_to_7segment = 7'b1000110;
        4'b1101: hex_to_7segment = 7'b0100001;
        4'b1110: hex_to_7segment = 7'b0000110;
        4'b1111: hex_to_7segment = 7'b0001110;
     endcase
endfunction 

    
// Main Logic    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            RegA <= 8'b00000000;
            RegB <= 8'b00000000;
            RegC <= 8'b00000000;
            Cout <= 1'b0;
        end
        
        else begin
            if (dec_out[0]) begin
                RegA <= sw; // Load A
            end
            else if (dec_out[1]) begin
                RegB <= sw; // Load B
            end
            else if (dec_out[2]) begin
               RegA <= 8'b00000000; // CLR A
            end
            else if (dec_out[3]) begin
                RegB <= 8'b00000000; // CLR B
            end
            else if (dec_out[4]) begin
                RegA <= {RegA[6:0], 1'b0}; // LSL A
            end
            else if (dec_out[5]) begin
                RegA <= {1'b0, RegA[7:1]}; // LSR A
            end
            else if (dec_out[6]) begin
                RegB <= RegA; // MOV A -> B
            end
            else if (dec_out[7]) begin
                RegA <= RegB; // MOV B -> A
            end
            else if (dec_out[8]) begin
                RegA <= ~RegA; // Complement A
            end
            else if (dec_out[9]) begin
                RegB <= ~RegB; // Complement B
            end
            else if (dec_out[10]) begin
                {Cout, RegC} <= RegA + RegB; // ADD
            end
            else if (dec_out[11]) begin
                {Cout, RegC} <= RegA - RegB; // SUB
            end
            else if (dec_out[12]) begin
                RegA <= RegA + 1; // Increment A
            end
            else if (dec_out[13]) begin
                RegA <= RegA - 1; // Decrement A
            end
            else if (dec_out[14]) begin
                RegC <= RegA & RegB; // AND
            end
            else if (dec_out[15]) begin
                RegC <= RegA | RegB; // OR
            end
        end
    end

endmodule
