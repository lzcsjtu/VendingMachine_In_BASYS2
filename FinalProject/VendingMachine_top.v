`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:33:38 04/09/2018 
// Design Name: 
// Module Name:    VendingMachine_top 
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
module VendingMachine_top(
    input [3:0] BTN,
    input insertcoinSW,
    input [2:0]drinkSW,
    input coin_outSW,
    input clk,
    output [3:0] AN,
    output [2:0] display_mode,
    output [6:0] a_to_g,
    output point);

wire clk_50hz;
wire clk_1000hz;
wire wu_jiao;
wire yi_yuan;
wire clr;
wire coca_cola;
wire oolong;
wire redtea;
wire coin_out;
wire mode;

assign mode = insertcoinSW;

signal_decoder s_d(.insertcoinSW(insertcoinSW),
				   .drinkSW(drinkSW),
				   .coin_outSW(coin_outSW),
				   .BTN(BTN),
				   .wu_jiao(wu_jiao),
				   .yi_yuan(yi_yuan),
				   .clr(clr),
				   .clk(clk),
				   .coca_cola(coca_cola),
				   .oolong(oolong),
				   .redtea(redtea),
				   .coin_out(coin_out));

clk_div c_d(.clk(clk),
			.clr(clr),
			.clk_50hz(clk_50hz),
			.clk_1000hz(clk_1000hz));

control cl(.mode(mode),
		   .clk(clk),
		   .clk_50hz(clk_50hz),
		   .clk_1000hz(clk_1000hz),
		   .clr(clr),
		   .coin_out(coin_out),
		   .wu_jiao(wu_jiao),
		   .yi_yuan(yi_yuan),
		   .coca_cola(coca_cola),
		   .oolong(oolong),
		   .redtea(redtea),
		   .AN(AN),
		   .display_mode(display_mode),
		   .a_to_g(a_to_g),
		   .point(point));


endmodule
