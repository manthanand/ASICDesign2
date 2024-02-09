`timescale 1ns/1ps
`include "top.v"

module top_tb();        
    //logic               enable;
    logic reset1;
    logic start1;
    wire Krdy1;
    wire Drdy1;
    wire RSTn1;
    wire EN1;
    wire SU1;
    wire SI1;
    wire SE1;
    wire SO;
    
    localparam clk_period = 2; logic clk = 0; initial forever #(clk_period/2) clk = ~clk;

top top1(
      .clk(clk),.reset1(reset1),.start1(start1), 
      .Krdy1(Krdy1),.Drdy1(Drdy1),.RSTn1(RSTn1),.EN1(EN1),.SU1(SU1),.SI1(SI1),.SE1(SE1),.SO(SO)
     );

    initial begin 

        $dumpfile("top_tb.vcd");
        $dumpvars(0,top_tb);

        start1 = 0;
        reset1 = 0;
        #(clk_period*100);
 
        reset1 = 0;
        start1 = 1;

        #(clk_period*25000);
        reset1 = 1;
        start1 = 0;

        #(clk_period*100000);
        reset1 = 1;
        start1 = 0;
        
    $display("Test complete");
    
    end

endmodule










