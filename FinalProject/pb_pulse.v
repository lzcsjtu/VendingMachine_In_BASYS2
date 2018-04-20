`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:58:34 04/10/2018 
// Design Name: 
// Module Name:    pb_pulse 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module pb_pulse(
    input btn,
    input clk,
    output pbPulse);

 reg [1:0] btnState;

 // If we see a edge now, but didnt 1 cycle ago, pulse
 assign pbPulse = btnState[0] & ~btnState[1];

 // Shift register storing the btn state now and 1 cycle ago
 always @(posedge clk) begin
    btnState <= {btnState[0], btn};
 end

endmodule
