`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:28:59 04/09/2018 
// Design Name: 
// Module Name:    binbcd14 
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
module binbcd14(
    input wire[13:0]bin,
    output reg[15:0]bcd);

reg [29:0] z;

integer i;

always@(*) begin

	for(i = 0; i <= 29; i = i+1) begin
		z[i] = 0;
	end

	z[13:0] = bin;
	repeat(14) begin
		if(z[17:14]>4)
			z[17:14] = z[17:14] + 3;
		if(z[21:18]>4)
			z[21:18] = z[21:18] + 3;
		if(z[25:22]>4)
			z[25:22] = z[25:22] + 3;
		if(z[29:26]>4)
			z[29:26] = z[29:26] + 3;

		z[29:1] = z[28:0];
	end
	bcd = z[29:14];
end
endmodule
