`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2026 04:07:38 PM
// Design Name: 
// Module Name: Enable_Debounce_PushButton
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
// Enable_Debounce_PushButton
//////////////////////////////////////////////////////////////////////////////////


module Enable_Debounce_PushButton(
    input clk,
    input button,
    output reg pulse
);

    // Synchronizer
    reg [1:0] sync;
    always @(posedge clk) begin
        sync <= {sync[1:0], button};
    end

    // Debounce counter (~10ms for 100MHz clock)
    reg [19:0] counter = 0;
    reg stable = 0;

    always @(posedge clk) begin
        if (sync[1] == stable)
            counter <= 0;
        else begin
            counter <= counter + 1;
            if (counter == 1_000_000) begin
                stable <= sync[1];
                counter <= 0;
            end
        end
    end

    // Edge detect
    reg stable_d = 0;
    always @(posedge clk) begin
        stable_d <= stable;
        pulse <= stable & ~stable_d;
    end
endmodule
