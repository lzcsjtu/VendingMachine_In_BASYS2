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
    input [4:0]SW,
    input clk,
    output [3:0] AN,
    output [6:0] a_to_g,
    output point);

wire clk_50hz;
wire clk_1000hz;
wire wu_jiao;
wire yi_yuan;
wire coin_out;
wire coca_cola;
wire oolong;
wire redtea;
wire inquire_coca_cola;
wire inquire_oolong;
wire inquire_redtea;
wire fill_up;

signal_decoder s_d(.SW(SW),
				   .BTN(BTN),
				   .coin_out(coin_out),
				   .clk(clk),

				   .wu_jiao(wu_jiao),
				   .yi_yuan(yi_yuan),
				   .coca_cola(coca_cola),
				   .oolong(oolong),
				   .redtea(redtea),
				   .inquire_coca_cola(inquire_coca_cola),
				   .inquire_oolong(inquire_oolong),
				   .inquire_redtea(inquire_redtea),
				   .fill_up(fill_up));

clk_div c_d(.clk(clk),
			.coin_out(coin_out),
			.clk_50hz(clk_50hz),
			.clk_1000hz(clk_1000hz));

control cl(.clk(clk),
		   .clk_50hz(clk_50hz),
		   .clk_1000hz(clk_1000hz),
		   .coin_out(coin_out),
		   .fill_up(fill_up),
		   .wu_jiao(wu_jiao),
		   .yi_yuan(yi_yuan),
		   .coca_cola(coca_cola),
		   .oolong(oolong),
		   .redtea(redtea),
		   .inquire_coca_cola(inquire_coca_cola),
		   .inquire_oolong(inquire_oolong),
		   .inquire_redtea(inquire_redtea),
		   .AN(AN),
		   .a_to_g(a_to_g),
		   .point(point));


endmodule
