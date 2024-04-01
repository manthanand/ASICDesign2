`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/22/2024 10:37:54 AM
// Design Name: 
// Module Name: AES_Core
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

//`define mykey 128'h80000000000000000000000000000000
//`define myin 128'h50a5ffe6ada8470916bfb9512e95c6ff
//`define myout 128'h8997889b513ff24958e2bd3964984a3a



module AES_Core(
    input SI, SE, SU, SCLK, RSTN, EN, KRDY, DRDY, CLK, clk,
    output SO, BSY, dbg0, dbg1, dbg2//, CLKOUT
    );

//    assign CLKOUT = CLK;
  
    wire  [127:0] Kin;  // Key input
    wire  [127:0] Din;  // Data input
    wire [127:0] Dout; // Data output
    wire [7:0] VRStage_SC;
    reg CLKAES = 0, SCLKAES = 0;
    reg dbg0 = 0, dbg1 = 0, dbg2 = 0;
    
    always @(posedge clk) begin
    if (CLK) CLKAES <= 1;
    else CLKAES <= 0;
    
    if (SCLK) SCLKAES <= 1;
    else SCLKAES <= 0;
    
    dbg0 <= BSY;
    dbg1 <= KRDY;
    dbg2 <= DRDY;
    end
    
    AES_Comp AES_Comp(.Kin(Kin), .Din(Din), .Dout(Dout), .Krdy(KRDY), .Drdy(DRDY), .RSTn(RSTN), .EN(EN), .CLK(CLKAES), .BSY(BSY));
    scan scan(.scan_in(SI), .scan_out(SO), .scan_clk(SCLKAES), .update_clk(SU), .se(SE), .VRStage_SC(VRStage_SC), .Din(Din), .Kin(Kin), .Dout(Dout));


endmodule
