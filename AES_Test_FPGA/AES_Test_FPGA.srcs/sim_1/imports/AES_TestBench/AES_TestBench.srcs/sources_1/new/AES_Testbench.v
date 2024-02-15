`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/22/2024 08:32:50 AM
// Design Name: 
// Module Name: AES_Testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module AES_Testbench;

reg runtest = 0;
reg clk = 0;
wire testpassed;
wire Krdy;
wire Drdy;
wire RSTn;
wire EN;
wire SU;
wire SI;
wire SE;
wire SO;
wire SCLK;
wire CLK;

AES_Testbenchsp test1(.clk(clk), .runtest(runtest), .Krdy(Krdy), .Drdy(Drdy), .RSTn(RSTn), .EN(EN), .SU(SU), .SI(SI), .SE(SE), .SO(SO), .SCLK(SCLK), .CLK(CLK), .testpassed(testpassed));

integer i;

initial begin
	#20
	runtest = 1;
	#20;
	runtest = 0;
	#200000
	$finish;
end

always #5  clk = ~clk;

endmodule
