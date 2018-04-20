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
    input mode,
    input clk,
    input clk_50hz,
    input clk_1000hz,
    input clr,
    input coin_out,
    input wu_jiao,
    input yi_yuan,
    input coca_cola,
    input oolong,
    input redtea,
    output reg[3:0] AN,
    output reg[2:0] display_mode,
    output [6:0] a_to_g,
    output reg point);

reg [3:0] xiaoshu;
reg [3:0] ge;
reg [3:0] shi;
reg [3:0] bai;

wire [13:0]money;
reg [1:0]dis_mode;


assign money = 14'd1000 * bai + 14'd100 * shi + 14'd10 * ge + 14'd1 * bai;

always@(posedge clk or posedge clr) begin
	if(clr)
		xiaoshu <= 4'd0;
	else if(wu_jiao && xiaoshu == 4'd5)
		xiaoshu <= 4'd0;
	else if(wu_jiao && xiaoshu == 4'd0)
		xiaoshu <= 4'd5;
	else if(redtea) begin
		if(money >= 14'd35) begin
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

always@(posedge clk or posedge clr) begin
	if(clr)
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
		if(money >= 14'd20) begin
			if(ge >= 4'd2)
				ge <= ge - 4'd2;
			else 
				ge <= ge + 4'd8;
		end
		else begin
			
		end
	end
	else if(oolong) begin
		if(money >= 14'd30) begin
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

always@(posedge clk or posedge clr) begin
	if(clr)
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
		if(money >= 14'd20) begin
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
		if(money >= 14'd30) begin
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
		if(money >= 14'd35) begin
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

always@(posedge clk or posedge clr) begin
	if(clr)
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
		if(money >= 14'd20) begin
			if(shi == 4'd0 && ge <= 4'd1)
				bai <= bai - 4'd1;
			else
				bai <= bai;
		end
		else begin
			
		end
	end
	else if(oolong) begin
		if(money >= 14'd30) begin
			if(shi == 4'd0 && ge <= 4'd2)
				bai <= bai - 4'd1;
			else
				bai <= bai; 
		end
		else begin
			
		end
	end
	else if(redtea) begin
		if(money >= 14'd35) begin
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

always @(*)begin
	dis_mode = 2'd0;
	if(coca_cola && money < 14'd20)
		dis_mode = 2'd1;
	else if(dis_mode == 2'd1 && money < 14'd20)
		dis_mode = 2'd1;
	else if(oolong && money < 14'd30)
		dis_mode = 2'd2;
	else if(dis_mode == 2'd2 && money < 14'd30)
		dis_mode = 2'd2;
	else if(redtea && money < 14'd35)
		dis_mode = 2'd3;
	else if(dis_mode == 2'd3 && money < 14'd35)
		dis_mode = 2'd3;
	else if(dis_mode == 2'd1 && money >= 14'd20)
		dis_mode = 2'd0;
	else if(dis_mode == 2'd2 && money >= 14'd30)
		dis_mode = 2'd0;
	else if(dis_mode == 2'd3 && money >= 14'd35)
		dis_mode = 2'd0;
	else
		dis_mode = 2'd0;
end

//Display part
reg [1:0]select0;
reg [3:0]NUM;
always @(posedge clk_1000hz)
begin
	if(clr)
		select0 <= 2'd0;
	else
		select0 <= select0 + 1;
end

reg [1:0]select1;
always @(posedge clk_50hz) begin
	if(clr)
		select1 <= 2'd0;
	else 
		select1 <= select1 + 1;
end


always @(*) begin
	if(dis_mode == 2'd0) begin
		case(select0)
		2'b00:AN = 4'b1110;
		2'b01:AN = 4'b1101;
		2'b10:AN = 4'b1011;
		2'b11:AN = 4'b0111;
		endcase
	end
	else begin
		case(select1)
		2'b00:AN = 4'b1110;
		2'b01:AN = 4'b1101;
		2'b10:AN = 4'b1011;
		2'b11:AN = 4'b0111;
		endcase
	end
end


always @(*)
case(select0)
2'b01:point = 1'b0;
default:point = 1'b1;
endcase

always @(*) begin
	if(dis_mode == 2'd0) begin
		case({dis_mode,select0})
		4'b0000:NUM = xiaoshu;
		4'b0001:NUM = ge;
		4'b0010:NUM = shi;
		4'b0011:NUM = bai;
		endcase
	end

	else begin
		case({dis_mode,select1})
		4'b0100:NUM = 4'd0;
		4'b0101:NUM = 4'd2;
		4'b0110:NUM = 4'd0;
		4'b0111:NUM = 4'd0;

		4'b1000:NUM = 4'd0;
		4'b1001:NUM = 4'd3;
		4'b1010:NUM = 4'd0;
		4'b1011:NUM = 4'd0;

		4'b1100:NUM = 4'd5;
		4'b1101:NUM = 4'd3;
		4'b1110:NUM = 4'd0;
		4'b1111:NUM = 4'd0;
		endcase
	end
end

seg7_display seg_d(.NUM(NUM),
			.a_to_g(a_to_g));

always@(*) begin
case (dis_mode)
2'b00:display_mode = 3'b111;
2'b01:display_mode = 3'b001;
2'b10:display_mode = 3'b010;
2'b11:display_mode = 3'b100;
endcase
end

endmodule
