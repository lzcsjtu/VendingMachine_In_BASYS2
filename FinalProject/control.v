`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:46:59 04/09/2018 
// Design Name: 
// Module Name:    control 
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
module control(
    input clk,
    input clk_50hz,
    input clk_1000hz,
    input coin_out,
    input fill_up,
    input wu_jiao,
    input yi_yuan,
    input coca_cola,
    input oolong,
    input redtea,
    input inquire_coca_cola,
    input inquire_oolong,
    input inquire_redtea,
    output reg[3:0] AN,
    output [6:0] a_to_g,
    output reg point);

reg [3:0] xiaoshu;
reg [3:0] ge;
reg [3:0] shi;
reg [3:0] bai;

wire [13:0]money;
reg dis_mode;

assign money = 14'd1000 * bai + 14'd100 * shi + 14'd10 * ge + 14'd1 * bai;

////////////////////////////////////////////////////
reg [2:0]coca_cola_cnt;
reg [2:0]oolong_cnt;
reg [2:0]redtea_cnt;

initial begin
	coca_cola_cnt = 3'd5;
	oolong_cnt = 3'd5;
	redtea_cnt = 3'd5;
end

always@(posedge clk or posedge fill_up) begin
	if(fill_up)
		coca_cola_cnt <= 3'd5;
	else if(coca_cola && money >= 14'd20 && coca_cola_cnt > 3'd0)
		coca_cola_cnt <= coca_cola_cnt - 1;
	else
		coca_cola_cnt <= coca_cola_cnt;
end

always@(posedge clk or posedge fill_up) begin
	if(fill_up)
		oolong_cnt <= 3'd5;
	else if(oolong && money >= 14'd30 && oolong_cnt > 3'd0)
		oolong_cnt <= oolong_cnt - 1;
	else
		oolong_cnt <= oolong_cnt;
end

always@(posedge clk or posedge fill_up) begin
	if(fill_up)
		redtea_cnt <= 3'd5;
	else if(redtea && money >= 14'd35 && redtea_cnt > 3'd0)
		redtea_cnt <= redtea_cnt - 1;
	else
		redtea_cnt <= redtea_cnt;
end

///////////////////////////////////////////////////


always@(posedge clk or posedge coin_out) begin
	if(coin_out)
		xiaoshu <= 4'd0;
	else if(wu_jiao && xiaoshu == 4'd5)
		xiaoshu <= 4'd0;
	else if(wu_jiao && xiaoshu == 4'd0)
		xiaoshu <= 4'd5;
	else if(redtea) begin
		if(money >= 14'd35 && redtea_cnt > 3'd0) begin
			if(ge >= 4'd3 && xiaoshu == 4'd5)
				xiaoshu <= 4'd0;
			else if(xiaoshu != 4'd5)
				xiaoshu <= 4'd5;
		end
		else begin
			
		end
	end
	else
		xiaoshu <= xiaoshu;
end

always@(posedge clk or posedge coin_out) begin
	if(coin_out)
		ge <= 4'd0;
	else if(ge == 4'd9 && yi_yuan)
		ge <= 4'd0;
	else if(ge == 4'd9 && xiaoshu == 4'd5 && wu_jiao)
		ge <= 4'd0;
	else if(xiaoshu == 4'd5 && wu_jiao)
		ge <= ge + 4'd1;
	else if(yi_yuan)
		ge <= ge + 4'd1;
	else if(coca_cola) begin
		if(money >= 14'd20 && coca_cola_cnt > 3'd0) begin
			if(ge >= 4'd2)
				ge <= ge - 4'd2;
			else 
				ge <= ge + 4'd8;
		end
		else begin
			
		end
	end
	else if(oolong) begin
		if(money >= 14'd30 && oolong_cnt > 3'd0) begin
			if(ge >= 4'd3)
				ge <= ge - 4'd3;
			else
				ge <= ge + 4'd7; 
		end
		else begin
			
		end
	end
	else if(redtea) begin
		if(money >= 14'd35) begin
			if(ge >= 4'd3 && xiaoshu == 4'd5)
				ge <= ge - 4'd3;
			else if(ge >= 4'd4 && xiaoshu == 4'd0)
				ge <= ge - 4'd4;
			else
				ge <= ge + 4'd6;
		end
		else begin
			
		end
	end
	else
		ge <= ge; 	
end

always@(posedge clk or posedge coin_out) begin
	if(coin_out)
		shi <= 4'd0;
	else if(shi == 4'd9 && ge == 4'd9 && xiaoshu == 4'd5 && wu_jiao)
		shi <= 4'd0;
	else if(shi == 4'd9 && ge == 4'd9 && yi_yuan)
		shi <= 4'd0;
	else if(ge == 4'd9 && yi_yuan)
		shi <= shi + 4'd1;
	else if(ge == 4'd9 && xiaoshu == 4'd5 && wu_jiao)
		shi <= shi + 4'd1;
	else if(coca_cola) begin
		if(money >= 14'd20 && coca_cola_cnt > 3'd0) begin
			if(shi == 4'd0 && ge <= 4'd1)
				shi <= shi + 4'd9;
			else if(shi >= 4'd1 && ge <= 4'd1)
				shi <= shi - 4'd1;
			else
				shi <= shi;
		end
		else begin
			
		end
	end
	else if(oolong) begin
		if(money >= 14'd30 && oolong_cnt > 3'd0) begin
			if(shi == 4'd0 && ge <= 4'd2)
				shi <= shi + 4'd9;
			else if(shi >= 4'd1 && ge <= 4'd2)
				shi <= shi - 4'd1;
			else
				shi <= shi;
		end
		else begin
			
		end
	end
	else if(redtea)begin
		if(money >= 14'd35 && redtea_cnt > 3'd0) begin
			if(shi == 4'd0 && ge <= 4'd2)
				shi <= shi + 4'd9;
			else if(shi == 4'd0 && ge == 4'd3 && xiaoshu == 4'd0)
				shi <= shi + 4'd9;
			else if(shi >= 4'd1 && ge <= 4'd2)
				shi <= shi - 4'd1;
			else if(shi >= 4'd1 && ge == 4'd3 && xiaoshu == 4'd0)
				shi <= shi - 4'd1;
			else 
				shi <= shi;
		end
		else begin
			
		end
	end
	else
		shi <= shi;
end

always@(posedge clk or posedge coin_out) begin
	if(coin_out)
		bai <= 4'd0;
	else if(shi == 4'd9 && ge == 4'd9 && xiaoshu == 4'd5 && wu_jiao)
		bai <= bai + 4'd1;
	else if(shi == 4'd9 && ge == 4'd9 && yi_yuan)
		bai <= bai + 4'd1;
	else if(bai == 4'd9 && shi == 4'd9 && ge == 4'd9 && xiaoshu == 4'd5 && wu_jiao)
		bai <= 4'd0;
	else if(bai == 4'd9 && shi == 4'd9 && ge == 4'd9 && yi_yuan)
		bai <= 4'd0;
	else if(coca_cola) begin
		if(money >= 14'd20 && coca_cola_cnt > 3'd0) begin
			if(shi == 4'd0 && ge <= 4'd1)
				bai <= bai - 4'd1;
			else
				bai <= bai;
		end
		else begin
			
		end
	end
	else if(oolong) begin
		if(money >= 14'd30 && oolong_cnt > 3'd0) begin
			if(shi == 4'd0 && ge <= 4'd2)
				bai <= bai - 4'd1;
			else
				bai <= bai; 
		end
		else begin
			
		end
	end
	else if(redtea) begin
		if(money >= 14'd35 && redtea_cnt > 3'd0) begin
			if(shi == 4'd0 && ge <= 4'd2)
				bai <= bai - 4'd1;
			else if(shi == 4'd0 && ge == 4'd3 && xiaoshu == 4'd0)
				bai <= bai - 4'd1;
			else
				bai <= bai;
		end
	end
	else
		bai <= bai;
end

//----------------------------------------------------
reg [31:0]timer1;

always @(posedge clk)begin
	if(redtea && redtea_cnt == 3'd0)
		dis_mode <= 1'b1;
	else if(oolong && oolong_cnt == 3'd0)
		dis_mode <= 1'b1;
	else if(coca_cola && coca_cola_cnt == 3'd0)
		dis_mode <= 1'b1;
	else if(dis_mode == 1'b1 && timer1 > 9'd0)
		dis_mode <= 1'b1;
	else
		dis_mode <= 1'b0;
end


//----------------------------------------------------

always@(posedge clk) begin
	if(redtea && redtea_cnt == 3'd0)
		timer1 <= 32'd100000000;
	else if(oolong && oolong_cnt == 3'd0)
		timer1 <= 32'd100000000;
	else if(coca_cola && coca_cola_cnt == 3'd0)
		timer1 <= 32'd100000000;
	else if(timer1 == 0)
		timer1 <= timer1;
	else
		timer1 <= timer1 - 1;
end
//-----------------------------------------------------

//-----------------------------------------------------
reg [31:0] timer2;
always@(posedge clk)begin
	if(coca_cola && money < 14'd20)
		timer2 <= 32'd100000000;
	else if(oolong && money < 14'd30)
		timer2 <= 32'd100000000;
	else if(redtea && money < 14'd35)
		timer2 <= 32'd100000000;
	else if(timer2 == 0)
		timer2 <= timer2;
	else
		timer2 <= timer2 - 1;
end
//-----------------------------------------------------
reg [1:0] mode_flash;
always@(posedge clk)begin
	if(coca_cola && money <= 14'd20)
		mode_flash <= 2'd1;
	else if(timer2 > 0 && mode_flash == 2'd1)
		mode_flash <= 2'd1;
	else if(oolong && money <= 14'd30)
		mode_flash <= 2'd2;
	else if(timer2 > 0 && mode_flash == 2'd2)
		mode_flash <= 2'd2;
	else if(redtea && money <= 14'd35)
		mode_flash <= 2'd3;
	else if(timer2 > 0 && mode_flash == 2'd3)
		mode_flash <= 2'd3;
	else
		mode_flash <= 2'd0; 
end
//-----------------------------------------------------
reg [31:0] timer3;
reg [1:0] mode_inquire;

always@(posedge clk)begin
	if(inquire_coca_cola)
		timer3 <= 32'd100000000;
	else if(inquire_oolong)
		timer3 <= 32'd100000000;
	else if(inquire_redtea)
		timer3 <= 32'd100000000;
	else if(timer3 > 0)
		timer3 <= timer3 - 1;
	else
		timer3 <= 0;
end

always@(posedge clk)begin
	if(inquire_coca_cola)
		mode_inquire <= 2'd1;
	else if(timer3 > 0 && mode_inquire == 2'd1)
		mode_inquire <= 2'd1;
	else if(inquire_oolong)
		mode_inquire <= 2'd2;
	else if(timer3 > 0 && mode_inquire == 2'd2)
		mode_inquire <= 2'd2;
	else if(inquire_redtea)
		mode_inquire <= 2'd3;
	else if(timer3 >0 && mode_inquire == 2'd3)
		mode_inquire <= 2'd3;
	else
		mode_inquire <= 2'd0;
end

//-----------------------------------------------------
//Display part
reg [1:0]select;
reg [3:0]NUM;
always @(posedge clk_1000hz)
begin
	if(coin_out)
		select <= 2'd0;
	else
		select <= select + 1;
end


reg [1:0] select_flash;
always @(posedge clk_50hz)
begin
	if(coin_out)
		select_flash <= 2'd0;
	else
		select_flash <= select_flash + 1;
end

always @(*) begin
	if(timer2 > 0) begin
		case(select_flash)
		2'b00:AN = 4'b1110;
		2'b01:AN = 4'b1101;
		2'b10:AN = 4'b1111;
		2'b11:AN = 4'b1111;
		endcase
	end
	else begin
		case(select)
		2'b00:AN = 4'b1110;
		2'b01:AN = 4'b1101;
		2'b10:AN = 4'b1011;
		2'b11:AN = 4'b0111;
		endcase
	end
end

always @(*)
case(select)
2'b01:point = 1'b0;
default:point = 1'b1;
endcase

always @(*) begin
	if(timer1 > 9'd0) begin
		case(select)
		4'b00:NUM = 4'hf;
		4'b01:NUM = 4'hf;
		4'b10:NUM = 4'hf;
		4'b11:NUM = 4'hf;
		endcase	
	end
	else if(timer2 > 9'd0 && mode_flash == 2'd1) begin
			case(select_flash)
			4'b00:NUM = 4'd0;
			4'b01:NUM = 4'd2;
			4'b10:NUM = 4'd0;
			4'b11:NUM = 4'd0;
			endcase
	end
	else if(timer2 > 9'd0 && mode_flash == 2'd2) begin
		case(select_flash)
		4'b00:NUM = 4'd0;
		4'b01:NUM = 4'd3;
		4'b10:NUM = 4'd0;
		4'b11:NUM = 4'd0;
		endcase
	end
	else if(timer2 > 9'd0 && mode_flash == 2'd3) begin
		case(select_flash)
		4'b00:NUM = 4'd5;
		4'b01:NUM = 4'd3;
		4'b10:NUM = 4'd0;
		4'b11:NUM = 4'd0;
		endcase
	end
	else if(timer3 > 9'd0 && mode_inquire == 2'd1) begin
		case(select)
		4'b00:NUM = 4'd0;
		4'b01:NUM = coca_cola_cnt;
		4'b10:NUM = 4'd0;
		4'b11:NUM = 4'd0;
		endcase
	end
	else if(timer3 > 9'd0 && mode_inquire == 2'd2) begin
		case(select)
		4'b00:NUM = 4'd0;
		4'b01:NUM = oolong_cnt;
		4'b10:NUM = 4'd0;
		4'b11:NUM = 4'd0;
		endcase
	end
	else if(timer3 > 9'd0 && mode_inquire == 2'd3) begin
		case(select)
		4'b00:NUM = 4'd0;
		4'b01:NUM = redtea_cnt;
		4'b10:NUM = 4'd0;
		4'b11:NUM = 4'd0;
		endcase
	end
	else begin
		case(select)
		4'b00:NUM = xiaoshu;
		4'b01:NUM = ge;
		4'b10:NUM = shi;
		4'b11:NUM = bai;
		endcase
	end
end

seg7_display seg_d(.NUM(NUM),
			.a_to_g(a_to_g));


endmodule
