
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

module AES_Testbenchsp(
	input clk, enable211,
	output Krdy1, Drdy1,RSTn1,EN1,SU1, SI1, SE1,SO
	 );

reg	[264:0] SCAN_IN_REG;
reg [131:0] SCAN_OUT_REG;
reg  Krdy;         // Key input ready
reg  Drdy;         // Data input ready
reg  RSTn;         // Reset (Low active)
reg  EN;           // AES circuit enable
reg  scan_clk;
reg  SU, SI, SE;


logic [31:0]   timer =0;  
logic [1:0]   timer1 =0;  
logic [1:0]   clk1 =0;  
logic [8:0]   i=0;


// timer1 
always@(posedge clk ) 
begin
if(0)
          timer <=32'd0;
else if(timer >=32'd199_999_999)
          timer <=32'd0;
else if (enable211==1)
            timer <= timer +1'b1;
	else 
	timer <=32'd0;


end
// timer2
always@(posedge clk ) 
begin
if(0)
        timer1 <=2'd0;
else if(timer1 >=2'd3)
          timer1 <=2'd0;
else
        timer1 <= timer1 +1'b1;
end

// 1 initialization 记得等下还有其他的时候记得补一下 
always@(posedge clk ) 
begin 

if (timer==10)
begin
    SCAN_IN_REG <= {8'b0, `MYIN1, `MYKEY};
	SU <= 1'b0;
    SI <= 1'b0;
	SE <= 1'b1;
    Krdy <= 1'b0;
    Drdy <= 1'b0;
    RSTn <= 1'b0;
    EN <= 1'b0;
	RSTn <= 0;


else if (timer==30)

    //SI <= 0;
	SU <= 1'b0;
	SE <= 1'b1;
    Krdy <= 1'b0;
    Drdy <= 1'b0;
    EN <= 1'b0;
	RSTn <= 1'b1;
else  
 
if (timer==1070)

	SU <= 1'b1;
	SE <= 1'b0;
    Krdy <= 1'b0;
    Drdy <= 1'b0;
    EN <= 1'b0;
	RSTn <= 1'b1;
else  
 
if (timer==1072)
    SU <= 1'b0;
	SE <= 1'b0;
    Krdy <= 1'b0;
    Drdy <= 1'b0;
    EN <= 1'b0;
	RSTn <= 1'b1;
else  
 
if (timer==1074)
    SU <= 1'b0;
	SE <= 1'b0;
    Krdy <= 1'b1;
    Drdy <= 1'b0;
    EN <= 1'b1;
	RSTn <= 1'b1;
else 

if (timer==1076)
    SU <= 1'b0;
	SE <= 1'b0;
    Krdy <= 1'b0;
    Drdy <= 1'b1;
    EN <= 1'b1;
	RSTn <= 1'b1;
else 

if (timer==1078)
    SU <= 1'b0;
	SE <= 1'b0;
    Krdy <= 1'b0;
    Drdy <= 1'b0;
    EN <= 1'b1;
	RSTn <= 1'b1;

else 

if (timer==1080)

    SU <= 0;
	SE <= 1;
    Krdy <= 1'b0;
	EN <= 1'b1;
    Drdy <= 1'b0;


else 
    SCAN_IN_REG <= {8'b0, `MYIN1, `MYKEY};
	SU <= SU;
    SI <= SI;
	SE <= SE;
    Krdy <= Krdy;
    Drdy <= Drdy;
    RSTn <= RSTn;
    EN <= EN;
	RSTn <= RSTn;
 end 
end

always@(posedge clk ) 
begin 
if (timer1==1)
    begin 	  
	    if(i==272)
		begin
	      i<=0;
		end 
		else 
	  SI <= SCAN_IN_REG[i];  
      i<=i+1'b1; 
	end

end



assign Krdy1=Krdy;
assign Drdy1=Drdy;
assign RSTn1=RSTn;
assign EN1=EN;
assign SU1=SU;
assign SI1=SI;
assign SE1=SE;


endmodule