`timescale 1ms / 1us
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:57:27 03/30/2016 
// Design Name: 
// Module Name:    fir_top 
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

module fir_top(clk, rest, address, out); //FIR?????????

input clk;
input rest;
input [8:0] address;
output [34:0]out;
wire [15:0] x1; //?????????rom????fir?????????


	input_rom rom2(.addra(address),.clka(clk),.douta(x1));   //??rom??
	fir fir2(.out(out),.x(x1),.clk(clk),.rest(rest)); //??fir?????

endmodule
