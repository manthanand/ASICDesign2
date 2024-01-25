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

`define MYKEY 128'h000102030405060708090a0b0c0d0e0f
`define MYIN1 128'hB9D1C48E348FE771FA464A77A178FB07
`define MYOUT1 128'h95F8847369A8573D76AF987AB30A5DE2

`define MYIN2 128'hDCFEAD50D1D9FD08B386EFB08B142F74
`define MYOUT2 128'h85E5F163C857B0AC1162E07DD3432B66

module AES_Testbench;

reg	[264:0] SCAN_IN_REG;
reg [131:0] SCAN_OUT_REG;
reg  Krdy;         // Key input ready
reg  Drdy;         // Data input ready
reg  RSTn;         // Reset (Low active)
reg  EN;           // AES circuit enable
reg  CLK;          // System clock
wire  BSY;          // Busy signal
wire CLKOUT;
reg  scan_clk;
reg SU, SI, SE;
wire SO;

AES_Core AES_Core(.SI(SI), .SE(SE), .SU(SU), .SCLK(scan_clk), .SO(SO), .RSTN(RSTn), .EN(EN), .BSY(BSY), .KRDY(Krdy), .DRDY(Drdy), .CLK(CLK), .CLKOUT(CLKOUT));

integer i;

initial begin
	$dumpfile ("example1_scanin.vpd");
	$dumpvars(0,AES_Testbench);
end

initial begin
	CLK = 0;
	scan_clk = 0;
	SU = 0;
	SCAN_IN_REG = {8'b0, `MYIN1, `MYKEY};
	SI = 0;
	SE = 1;
	Krdy = 1'b0;
	Drdy = 1'b0;
	RSTn = 1'b0;
	EN = 1'b0;
	#20
	RSTn = 1;
end

initial begin
 	for (i=0; i<264; i=i+1) begin
 	  	@(posedge scan_clk) begin
 	  	  	SI <= SCAN_IN_REG[i];
 	  	end
 	end
	#10
  	@(posedge scan_clk)
  		SU <= 1;
  	 	SE <= 0;
	#10
  	@(posedge scan_clk)
  	 	SU <= 0;
  	#10
	@(posedge CLK);
	#2.5
	Krdy = 1;
	// Drdy = 1;
	EN = 1;

	@(posedge CLK);
	#2.5
	Krdy = 0;
	#0.5
	Drdy = 1;
	@(posedge CLK);
	#2.5
	//#1
	Drdy = 0;
	//	@(posedge CLK);
	//	#2.5
	# 200
	// while(BSY);

	@(posedge CLK);
	SE = 1;
	//start shifting
 
 	for (i=0; i<132; i=i+1) begin
 	  	@(posedge scan_clk) begin
 	  	  	SCAN_OUT_REG[i] <= SO;
 	  	end
 	end

end

initial begin
 	#20000
 	$finish;
end

always #5  CLK = ~CLK;
always #20 scan_clk = ~scan_clk;

endmodule

