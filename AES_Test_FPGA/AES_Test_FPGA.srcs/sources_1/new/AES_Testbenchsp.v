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

`define MYKEY   128'h000102030405060708090a0b0c0d0e0f
`define MYIN1   128'hB9D1C48E348FE771FA464A77A178FB07
`define MYOUT1  128'h95F8847369A8573D76AF987AB30A5DE2
`define MYIN2   128'hDCFEAD50D1D9FD08B386EFB08B142F74
`define MYOUT2  128'h85E5F163C857B0AC1162E07DD3432B66

module AES_Testbenchsp(
	input clk, runtest, BSY, SO,
	output Krdy, Drdy, RSTn, EN, SU, SE, SI, SCLK, CLK, testpassed
);
    reg	[264:0] SCAN_IN_REG;
    reg [131:0] SCAN_OUT_REG;
    reg Krdy; // Key input ready
    reg Drdy; // Data input ready
    reg RSTn; // Reset (Low active)
    reg EN;   // AES circuit enable
    reg SU, SI, SE;
    reg SCLK;
    wire CLKOUT;
    assign CLK = clk;
    assign SCLK = clk;

    reg [31:0] cntr =   32'b10;
    reg [31:0] timer =  32'b0;
    reg [1:0] timer1 =  1'b0;
    reg [1:0] clk1 =    1'b0;
    reg [8:0] i =       9'b0;
    reg testpassed =    1'b0;
    reg testrunning =   1'b0;

    //Intantiate AES Core within FPGA so if wires dont work, we can validate internally
    AES_Core AES1(.SI(SI), .SE(SE), .SU(SU), .SCLK(SCLK), .RSTN(RSTn), .EN(EN), .KRDY(Krdy), .DRDY(Drdy), .CLK(CLK),.SO(SO), .BSY(BSY), .CLKOUT(CLKOUT));

    // timer1 
    always@(posedge clk or runtest) begin
        if (timer >= 32'd199_999_999) timer <= 32'd0; //timer is set to 0 when reaches 200ms
        else if (testrunning) timer <= timer + 1'b1; //if test is started, incrememnt timer
        else if (runtest == 1) testrunning = 1'b1; //if test hasnt started, start test
    	else timer <= 32'd0; //otherwise timer is set to 0
    end

    // 1 initialization
    always@(posedge clk) begin 
        if (timer == cntr) begin
            SCAN_IN_REG <= {8'b0, `MYIN1, `MYKEY};
        	SU <= 1'b0;
            SI <= 1'b0;
        	SE <= 1'b1;
            Krdy <= 1'b0;
            Drdy <= 1'b0;
            RSTn <= 1'b0;
            EN <= 1'b0;
        	RSTn <= 0;
            cntr <= cntr + 20;
        end

        else if (timer == cntr) begin
            //SI <= 0;
        	// SU <= 1'b0;
        	// SE <= 1'b1;
            // Krdy <= 1'b0;
            // Drdy <= 1'b0;
            // EN <= 1'b0;
        	RSTn <= 1'b1;
            cntr <= cntr + (264 * 4);
        end

        else if (timer == cntr) begin
        	SU <= 1'b1;
        	SE <= 1'b0;
            // Krdy <= 1'b0;
            // Drdy <= 1'b0;
            // EN <= 1'b0;
        	// RSTn <= 1'b1;
            cntr <= cntr + 2;
        end

        else if (timer == cntr) begin
            SU <= 1'b0;
        	// SE <= 1'b0;
            // Krdy <= 1'b0;
            // Drdy <= 1'b0;
            // EN <= 1'b0;
        	// RSTn <= 1'b1;
            cntr <= cntr + 2;
        end

        else if (timer == cntr) begin
            // SU <= 1'b0;
        	// SE <= 1'b0;
            Krdy <= 1'b1;
            // Drdy <= 1'b0;
            EN <= 1'b1;
        	// RSTn <= 1'b1;
            cntr <= cntr + 2;
        end

        else if (timer == cntr) begin
            // SU <= 1'b0;
        	// SE <= 1'b0;
            Krdy <= 1'b0;
            Drdy <= 1'b1;
            // EN <= 1'b1;
        	// RSTn <= 1'b1;
            cntr <= cntr + 2;
        end

        else if (timer == cntr) begin
            // SU <= 1'b0;
        	// SE <= 1'b0;
            // Krdy <= 1'b0;
            Drdy <= 1'b0;
            // EN <= 1'b1;
        	// RSTn <= 1'b1;
            cntr <= cntr + 2;
        end

        else if (timer == cntr) begin
            while(BSY); //wait for AES to finish
            // SU <= 1'b0;
        	SE <= 1'b1;
            // Krdy <= 1'b0;
        	// EN <= 1'b1;
            // Drdy <= 1'b0;
            cntr <= cntr + (132 * 4);
        end

        else if (timer == cntr) begin
            // SU <= 1'b0;
        	SE <= 1'b0;
            // Krdy <= 1'b0;
        	// EN <= 1'b1;
            // Drdy <= 1'b0;
            if (SCAN_OUT_REG == `MYOUT1) begin
                testpassed <= 1'b1;
            end
            else testpassed <= 1'b0;
            timer <= 32'd0; //reset timer to run test again
        end

        else begin
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

    always@(posedge clk ) begin 
        if (timer1 == 1) begin 	  
        	if(i == 272) i <= 1'b0;
        	else SI <= SCAN_IN_REG[i];  
            i <= i + 1'b1; 
        end
    end

endmodule