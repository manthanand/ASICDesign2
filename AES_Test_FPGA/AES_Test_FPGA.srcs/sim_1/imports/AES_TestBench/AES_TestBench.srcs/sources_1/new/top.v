`timescale 1ns/1ps
`include "AES_Testbenchsp.v"

module top (
    input   clk,reset1,start1, 
    output   Krdy1, Drdy1,RSTn1, EN1,SU1, SI1,SE1,SO
     );


//logic enable2=0;
//logic enable21=0;

reg  enable2=0;
reg enable21=0;

always@(posedge clk ) 
begin
    if(reset1==0)
     begin
      if(start1==0)
      begin
        enable2<=1'b0;
        enable21<=1'b0; 
      end 
      else  if(start1==1)
        begin
        enable2<=1'b1;
        enable21<=1'b1;  
        end 
     end 
     else if(reset1==1)
        enable2<=1'b0;
        enable21<=1'b0; 

end

AES_Testbenchsp AES_Testbenchsp1( 
    .clk(clk), 
    .enable211(enable2), 
    .Krdy1(Krdy1), 
    .Drdy1(Drdy1),
    .RSTn1(RSTn1),
    .EN1(EN1),
    .SU1(SU1), 
    .SI1(SI1), 
    .SE1(SE1),
    .SO(SO)	 );





endmodule


