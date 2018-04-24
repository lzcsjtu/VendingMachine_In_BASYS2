`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:03:20 04/09/2018 
// Design Name: 
// Module Name:    siganl_decoder 
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
module signal_decoder(
    input [4:0]SW,
    input [3:0] BTN,
    input clk,
    
    output reg wu_jiao,
    output reg yi_yuan,
    output reg coin_out,
    output reg coca_cola,
    output reg oolong,
    output reg redtea,
    output reg inquire_coca_cola,
    output reg inquire_oolong,
    output reg inquire_redtea,
    output reg fill_up);

wire BTN0;
wire BTN1;
wire BTN2;
wire BTN3;
wire PBPULSE0;
wire PBPULSE1;
wire PBPULSE2;
wire PBPULSE3;

assign BTN0 = BTN[0];
assign BTN1 = BTN[1];
assign BTN2 = BTN[2];
assign BTN3 = BTN[3];

pb_pulse pp0(.btn(BTN0),
			 .clk(clk),
			 .pbPulse(PBPULSE0));
pb_pulse pp1(.btn(BTN1),
			 .clk(clk),
			 .pbPulse(PBPULSE1));
pb_pulse pp2(.btn(BTN2),
			 .clk(clk),
			 .pbPulse(PBPULSE2));
pb_pulse pp3(.btn(BTN3),
			 .clk(clk),
			 .pbPulse(PBPULSE3));

always@(*) begin	
	if(SW[0])
		wu_jiao = PBPULSE1;
	else
		wu_jiao = 1'b0;

end

always@(*) begin
	if(SW[0])
		yi_yuan = PBPULSE2;
	else
		yi_yuan = 1'b0;
end

always@(*) begin
	coin_out = PBPULSE3;
end


always@(*) begin
	if(SW[1])
		coca_cola = PBPULSE0;
	else
		coca_cola = 1'b0;
end

always@(*) begin
	if(SW[2])
		oolong = PBPULSE0;
	else
		oolong = 1'b0;
end

always@(*) begin
	if(SW[3])
		redtea = PBPULSE0;
	else
		redtea = 1'b0;
end

always@(*) begin
	if(SW[1])
		inquire_coca_cola = PBPULSE1;
	else
		inquire_coca_cola = 1'b0;
end

always@(*) begin
	if(SW[2])
		inquire_oolong = PBPULSE1;
	else
		inquire_oolong = 1'b0;
end

always@(*) begin
	if(SW[3])
		inquire_redtea = PBPULSE1;
	else
		inquire_redtea = 1'b0;
end

always@(*) begin
	if(SW[4])
		fill_up = PBPULSE0;
	else
		fill_up = 1'b0;
end

endmodule
