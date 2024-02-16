`timescale 1ns/1ps
`include "top.v"

module top_tb();        
    //logic               enable;
    reg reset1;
    reg start1;
    wire KRDY;
    wire Drdy;
    wire RSTN;
    wire EN;
    wire SU;
    wire SI;
    wire SE;
    wire SO;
    wire Led1;
    
    localparam clk_period = 2; 
    reg CLK = 0; 
    always#(clk_period/2) CLK = ~CLK;

       top top1(
      .CLK(CLK),.reset1(reset1),.start1(start1), 
      .Krdy1(KRDY),.Drdy1(Drdy),.RSTn1(RSTN),.EN1(EN),.SU1(SU),.SI1(SI),.SE1(SE),.SO(SO),.led1(led1),.SCLK(SCLK),.BSY(BSY)
     );

    initial begin 

        //$dumpfile("top_tb.vcd");
        //$dumpvars(0,top_tb);

        start1 <= 0;
        reset1 <= 0;
        #(clk_period*100);
 
        reset1 <= 0;
        start1 <= 1;

        #(clk_period*2500);
        reset1 <= 1;
        start1 <= 0;

        #(clk_period*10000);
        reset1 <= 1;
        start1 <= 0;

        
    //$display("Test complete");
    
    end

endmodule










