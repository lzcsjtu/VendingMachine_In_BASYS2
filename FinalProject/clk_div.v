`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:24:47 04/09/2018 
// Design Name: 
// Module Name:    clk_div 
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
module clk_div(
   input clk,
   input coin_out,
   output reg clk_50hz,
   output reg clk_1000hz);

reg [31:0] clk_50_cnt;
reg [14:0] clk_1000_cnt;

always@(posedge clk or posedge coin_out) begin
	if(coin_out)
		clk_50_cnt <= 0;
	else if(clk_50_cnt == 32'd3999999)
		clk_50_cnt <= 0;
	else
		clk_50_cnt <= clk_50_cnt + 1; 
end

always@(posedge clk or posedge coin_out) begin
	if(coin_out)
		clk_50hz <= 1'b0;
	else if(clk_50_cnt == 32'd3999999)
		clk_50hz <= ~clk_50hz;
	else
		clk_50hz <= clk_50hz;
end
	
always@(posedge clk or posedge coin_out) begin
	if(coin_out)
		clk_1000_cnt <= 0;
	else if(clk_1000_cnt == 15'd24999)
		clk_1000_cnt <= 0;
	else
		clk_1000_cnt <= clk_1000_cnt + 1;
end

always@(posedge clk or posedge coin_out) begin
	if(coin_out)
		clk_1000hz <= 1'b0;
	else if(clk_1000_cnt == 15'd24999)
		clk_1000hz <= ~clk_1000hz;
	else
		clk_1000hz <= clk_1000hz;
end
endmodule
