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
reg clk100 = 0;
reg clk450 = 0;
reg rst = 0;
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
wire BSY;

AES_Core AES1(.SI(SI), .SE(SE), .SU(SU), .SCLK(SCLK), .RSTN(RSTn), .EN(EN), .KRDY(Krdy), .DRDY(Drdy), .CLK(CLK), .SO(SO), .BSY(BSY), .CLKOUT());
AES_Testbenchsp test1(
    .clk450(clk450),
	.clk100(clk100), 
	.runtest(runtest), 
	.Krdy(Krdy), 
	.Drdy(Drdy), 
	.RSTn(RSTn), 
	.EN(EN), 
	.SU(SU), 
	.SI(SI), 
	.SE(SE), 
	.SO(SO), 
	.BSY(BSY), 
	.SCLK(SCLK), 
	.CLK(CLK), 
	.testpassed(testpassed), 
	.DIVIDER(0),
	.rst(rst));

initial begin
	#10
	runtest = 1;
	#100
	runtest = 0;
	#100000
	runtest = 1;
	#100000
	runtest = 0;
	#1000
	rst = 1;
	#1000
	$finish;
end

always #2 clk450 = ~clk450;
always #9 clk100 = ~clk100;

endmodule
