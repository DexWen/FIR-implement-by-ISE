`timescale 1ms / 1us
//////////////////////////////////////////////////////////////////////////////////
// Company:    
// Engineer:	Wen  Jiaying  (Study from Liu Haocheng)
// 
// Create Date:    15:36:54 03/30/2016 
// Design Name: 
// Module Name:    fir 
// Project Name: 
// Target Devices: Virtex-7 XC7VX485-2ffg1761c
// Tool versions: 
// Description: A simple FIR low-pass Filter 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module fir(
	out,
	x,
	clk,
	rest
	);                 //FIR  ???

output[31:0] out;
input rest;
input[15:0] x;                              // ??16?????,1???+15?????
input clk;
reg  signed [15:0] x1,x2,x3,x4,x5,x6,x7,x8; // ?????????
reg  signed [15:0] s1,s2,s3,s4;             // ????????
wire signed [31:0] y1,y2,y3,y4,y5,y6,y7,y8; // ?????????,1???+30???+???(??)
reg signed  [34:0] out;                     // ?????
reg signed  [33:0] out1,out2;               // ?????????

//8???FIR???????,??11?(?2^11)????

  parameter [15:0] coeff1 = 16'd5;          // ??h(1) ~ h(4) ? h(5) ~ h(8) ?????
  parameter [15:0] coeff2 = 16'd60; 
  parameter [15:0] coeff3 = 16'd257; 
  parameter [15:0] coeff4 = 16'd476; 
  parameter [15:0] coeff5 = 16'd476; 
  parameter [15:0] coeff6 = 16'd257; 
  parameter [15:0] coeff7 = 16'd60; 
  parameter [15:0] coeff8 = 16'd5; 
 
always@(negedge clk)
      if(!rest)                            //????
		begin
		    x1<=16'd0;
			  x2<=16'd0;
			  x3<=16'd0;
			  x4<=16'd0;
			  x5<=16'd0;
			  x6<=16'd0;
			  x7<=16'd0;
			  x8<=16'd0;
			  s1<=16'd0;
			  s2<=16'd0;
        s3<=16'd0;
        s4<=16'd0;
		end
		
		else
      begin                   
           x1  <=  x;                     //8??????,???? x(n),x(n-1),...,x(n-7)??
           x2  <=  x1;
           x3  <=  x2;
           x4  <=  x3;
           x5  <=  x4;
           x6  <=  x5;
           x7  <=  x6;
           x8  <=  x7;
           s1  <=x1+x8;                  //????,????????,??????
           s2  <=x2+x7;
           s3  <=x3+x6;
           s4  <=x4+x5;
			     out1   <=  y1+y2;
           out2   <=  y3+y4;
           out    <= out1+out2;
      end

		fix_mult mult1(.clk(clk),.rst_n(rest),.in_a(coeff1),.in_b(s1),.y_out(y1));  //???????????,???????????????32?????
		fix_mult mult2(.clk(clk),.rst_n(rest),.in_a(coeff2),.in_b(s2),.y_out(y2));
		fix_mult mult3(.clk(clk),.rst_n(rest),.in_a(coeff3),.in_b(s3),.y_out(y3));
		fix_mult mult4(.clk(clk),.rst_n(rest),.in_a(coeff4),.in_b(s4),.y_out(y4));  //????,??1???

endmodule
