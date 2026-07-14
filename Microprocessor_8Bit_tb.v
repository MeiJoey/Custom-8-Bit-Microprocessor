`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/08/2026 02:58:06 PM
// Design Name: 
// Module Name: Microprocessor_8Bit_tb
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


module Microprocessor_8Bit_tb;
reg clk;
reg rst;
reg en;
reg [3:0] opcode;
reg [7:0] sw;
reg [1:0] RegSelect;

wire [7:0] LED;
wire Cout;


Microprocessor_8Bit dut (
    .clk(clk),
    .rst(rst),
    .en(en),
    .opcode(opcode),
    .sw(sw),
    .Cout(Cout),
    .RegSelect(RegSelect),
    .LED(LED)
);

// Clock Generation
initial begin
    clk = 1'b0;
    forever #5 clk = ~clk;
end

// Execute Instructions
task exec_instruction;
    input [3:0] op;
    input [7:0] data;
    begin
        @(negedge clk);
        opcode = op;
        sw = data;
        en = 1'b1;

        @(posedge clk);
        en = 1'b0;

        @(posedge clk);
    end
endtask

 // Test sequence
initial begin
    
    rst = 1;
    en = 0;
    opcode = 0;
    sw = 0;
    RegSelect = 0;

    repeat(2) @(posedge clk);
    rst = 0;

    // ---------- LOAD A ----------
    RegSelect = 2'b01;
    exec_instruction(4'b0000, 8'b00111100);
    if (LED != 8'b00111100) $display("Error: LOAD A FAILED");
    else $display("PASS: LOAD A");

    // ---------- LOAD B ----------
    RegSelect = 2'b10;
    exec_instruction(4'b0001, 8'b11100011);
    if (LED != 8'b11100011) $display("Error: LOAD B FAILED");
    else $display("PASS: LOAD B");

    // ---------- CLR A ----------
    RegSelect = 2'b01;
    exec_instruction(4'b0010, 8'b00000000);
    if (LED != 8'b00000000) $display("Error: CLR A FAILED");
    else $display("PASS: CLR A");

    // ---------- CLR B ----------
    RegSelect = 2'b10;
    exec_instruction(4'b0011, 8'b00000000);
    if (LED != 8'b00000000) $display("Error: CLR B FAILED");
    else $display("PASS: CLR B");

    // ---------- LSL A ----------
    RegSelect = 2'b01;
    exec_instruction(4'b0000, 8'b00101100);
    exec_instruction(4'b0100, 8'b00000000);
    if (LED != 8'b01011000) $display("Error: LSL A FAILED");
    else $display("PASS: LSL A");

    // ---------- LSR A ----------
    RegSelect = 2'b01;
    exec_instruction(4'b0000, 8'b00101100);
    exec_instruction(4'b0101, 8'b00000000);
    if (LED != 8'b00010110) $display("Error: LSR A FAILED");
    else $display("PASS: LSR A");

    // ---------- MOV A->B ----------
    RegSelect = 2'b01;
    exec_instruction(4'b0000, 8'b11110000);
    RegSelect = 2'b10;
    exec_instruction(4'b0110, 8'b00000000);
    if (LED != 8'b11110000) $display("Error: MOV A->B FAILED");
    else $display("PASS: MOV A->B");

    // ---------- MOV B->A ----------
    RegSelect = 2'b10;
    exec_instruction(4'b0001, 8'b00001111);
    RegSelect = 2'b01;
    exec_instruction(4'b0111, 8'b00000000);
    if (LED != 8'b00001111) $display("Error: MOV B->A FAILED");
    else $display("PASS: MOV B->A");

    // ---------- Complement A ----------
    RegSelect = 2'b01;
    exec_instruction(4'b0000, 8'b10100101);
    exec_instruction(4'b1000, 8'b00000000);
    if (LED != 8'b01011010) $display("Error: Complement A FAILED");
    else $display("PASS: Complement A");

    // ---------- Complement B ----------
    RegSelect = 2'b10;
    exec_instruction(4'b0001, 8'b01011010);
    exec_instruction(4'b1001, 8'b00000000);
    if (LED != 8'b10100101) $display("Error: Complement B FAILED");
    else $display("PASS: Complement B");

    // ---------- ADD ----------
    RegSelect = 2'b01;
    exec_instruction(4'b0000, 8'b10100010);
    RegSelect = 2'b10;
    exec_instruction(4'b0001, 8'b11001100);
    exec_instruction(4'b1010, 8'b00000000);
    RegSelect = 2'b11;
    @(posedge clk);
    if (LED != 8'b01101110 || Cout != 1)
        $display("Error: ADD FAILED");
    else $display("PASS: ADD");

    // ---------- SUB ----------
    RegSelect = 2'b01;
    exec_instruction(4'b0000, 8'b10100010);
    RegSelect = 2'b10;
    exec_instruction(4'b0001, 8'b11001100);
    exec_instruction(4'b1011, 8'b00000000);
    RegSelect = 2'b11;
    @(posedge clk);
    if (LED != 8'b11010110 || Cout != 1)
        $display("Error: SUB FAILED");
    else $display("PASS: SUB");

    // ---------- Increment A ----------
    RegSelect = 2'b01;
    exec_instruction(4'b0000, 8'b01100110);
    exec_instruction(4'b1100, 8'b00000000);
    if (LED != 8'b01100111)
        $display("Error: Increment A FAILED");
    else $display("PASS: Increment A");

    // ---------- Decrement A ----------
    RegSelect = 2'b01;
    exec_instruction(4'b0000, 8'b10011001);
    exec_instruction(4'b1101, 8'b00000000);
    if (LED != 8'b10011000)
        $display("Error: Decrement A FAILED");
    else $display("PASS: Decrement A");

    // ---------- AND ----------
    RegSelect = 2'b01;
    exec_instruction(4'b0000, 8'b00100011);
    RegSelect = 2'b10;
    exec_instruction(4'b0001, 8'b01100010);
    exec_instruction(4'b1110, 8'b00000000);
    RegSelect = 2'b11;
    @(posedge clk);
    if (LED != 8'b00100010)
        $display("Error: AND FAILED");
    else $display("PASS: AND");

    // ---------- OR ----------
    RegSelect = 2'b01;
    exec_instruction(4'b0000, 8'b00100011);
    RegSelect = 2'b10;
    exec_instruction(4'b0001, 8'b01100010);
    exec_instruction(4'b1111, 8'b00000000);
    RegSelect = 2'b11;
    @(posedge clk);
    if (LED != 8'b01100011)
        $display("Error: OR FAILED");
    else $display("PASS: OR");
    
    $display("Test Completed");
    $stop;
end
    
endmodule
