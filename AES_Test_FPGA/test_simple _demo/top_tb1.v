`timescale 1ns/1ps
`include "top1.v"

module top_tb1();        
    //logic               enable;
    reg reset1;
    reg start1;
    reg input2;
    wire KRDY;
    wire Drdy;
    wire RSTN;
    wire EN;
    wire SU;
    wire SI;
    wire SE;
    wire SO;
    wire led1;
    wire led2;
    wire BSY;
    
    
    localparam clk_period = 2; 
    reg CLK = 0; 
    always#(clk_period/2) CLK = ~CLK;

       top1 top1(
      .CLK(CLK),.reset1(reset1),.start1(start1), .input2(input2),
      .Krdy1(KRDY),.Drdy1(Drdy),.RSTn1(RSTN),.EN1(EN),.SU1(SU),.SI1(SI),.SE1(SE),.SO(SO),
      .led1(led1),.led2(led2),.SCLK(SCLK),.BSY(BSY)
     );

    initial begin 

        //$dumpfile("top_tb.vcd");
        //$dumpvars(0,top_tb);

        start1 <= 0;
        reset1 <= 0;
        input2<= 0;
        #(clk_period*100);
 
        reset1 <= 0;
        start1 <= 1;
        input2<= 1;

        #(clk_period*2500);
        reset1 <= 1;
        start1 <= 0;
        input2<= 1;

        #(clk_period*10000);
        reset1 <= 1;
        start1 <= 0;
        input2<= 0;

        
    //$display("Test complete");
    
    end

endmodule










