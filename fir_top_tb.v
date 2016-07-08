`timescale 1ms / 1us

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:38:28 03/31/2016
// Design Name:   fir_top
// Module Name:   C:/Users/SUTD/codes/FIR_LP_Filter/fir_top_tb.v
// Project Name:  FIR_LP_Filter
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fir_top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fir_top_tb;

	// Inputs
	reg clk;
	reg rest;
	reg [8:0] address;

	// Outputs
	wire [34:0] out;
	reg signed [34:0] out1;  //signed decimal output 

	// Instantiate the Unit Under Test (UUT)
	fir_top uut (
		.clk(clk), 
		.rest(rest), 
		.address(address), 
		.out(out)
	);
	
//************Initial**************		
	initial 
	begin
		// Initialize Inputs
		clk = 1'b0;
		rest = 1'b0;
		address = 8'b0;

		// Wait 100 ns for global reset to finish
		#50 rest=1'b1;
      
		// Add stimulus here
	end
//***********************************


//**************clk******************
	always 
	#10 clk=~clk;		
//***********************************	


//************Address counter**************			
	always @ (negedge clk)
	begin 
		if (address != 9'd501)   // d means decimal
			address = address + 8'd1;
		else 
			address = 0'd0;
	end
//****************************************
	
//************record data*****************
	always @ (posedge clk)
	begin 
		out1=out;
		$display("%d",out1);
	end

//****************************************

	
endmodule

