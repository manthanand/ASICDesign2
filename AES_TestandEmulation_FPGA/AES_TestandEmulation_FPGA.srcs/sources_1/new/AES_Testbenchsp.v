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
`define DIVIDER 14

module AES_Testbenchsp(
    input clk, runtest, BSY, SO, //TESTBENCH INPUT PORTS
    output SI_AES, SE_AES, SU_AES, SCLK_AES, RSTN_AES, EN_AES, KRDY_AES, DRDY_AES, CLK_AES, //CLKOUT,//AES INPUT PORTS
    output reg Krdy, Drdy, RSTn, EN, SU, SE, SI, testpassed, rdy, done,//TESTBENCH REG PORTS
    output SCLK, CLK, dbg0, dbg1, dbg2, //TESTBENCH WIRE PORTS
    output SO_AES, BSY_AES //AES PORTS
    );
    
    reg testpassed = 1'b0;
    reg rdy = 1'b1;
    reg done = 1'b0;

    assign dbg0 = BSY;
    assign dbg1 = EN;
    assign dbg2 = RSTn;
    
    reg	[264:0] SCAN_IN_REG;
    reg [131:0] SCAN_OUT_REG;
    reg [`DIVIDER:0] divider = 0;
    assign CLK = divider[`DIVIDER];
    assign SCLK = divider[`DIVIDER];

    reg [31:0] cntr =   32'd10;
    reg [31:0] timer =  32'd10;
    reg [31:0] i =      32'b0;
    reg [4:0] ns = 5'b0;
    
    always @(posedge clk) divider <= divider + 1;

    //Intantiate AES Core within FPGA so if wires dont work, we can validate internally
//   AES_Core AES1(.SI(SI_AES), .SE(SE_AES), .SU(SU_AES), .SCLK(SCLK_AES), .RSTN(RSTN_AES), .EN(EN_AES), .KRDY(KRDY_AES), .DRDY(DRDY_AES), .CLK(CLK_AES),.SO(SO_AES), .BSY(BSY_AES), .CLKOUT(CLKOUT_AES));
    assign SI_AES = SI;
    assign SE_AES = SE;
    assign SU_AES = SU;
    assign SCLK_AES = SCLK;
    assign RSTN_AES = RSTn;
    assign EN_AES = EN;
    assign KRDY_AES = Krdy;
    assign DRDY_AES = Drdy;
    assign CLK_AES = CLK;
    assign SO_AES = SO;
    assign BSY_AES = BSY;
    // assign CLKOUT_AES = CLKOUT;
    
    reg [1:0] csbutton = 0;

    // timer1 
    always @(posedge CLK) begin
        case (csbutton)
            0: begin
                if (runtest == 1) begin
                    csbutton <= 1;
                end
                timer <= 0;
            end
            1: begin
                if (done == 1) begin
                    csbutton <= 2;
                    timer <= 0;
                end
                else begin
                    timer <= timer + 1;
                end
            end
            2: begin
                if (runtest && !done) begin
                    csbutton <= 1;
                end
                else if (runtest && done) begin
                    timer <= timer + 1;
                end
                else begin
                    csbutton <= 0;
                end
            end
        endcase
    end

    // 1 initialization
    always@(posedge CLK) begin 
        if (timer == cntr) begin
            if (ns == 0) begin
                SCAN_IN_REG <= {8'b0, `MYIN1, `MYKEY};
            	SU <= 1'b0;
                SI <= 1'b0;
            	SE <= 1'b1;
                Krdy <= 1'b0;
                Drdy <= 1'b0;
                RSTn <= 1'b0;
                EN <= 1'b0;
            	RSTn <= 1'b0;
                cntr <= cntr + 2;
                i <= 32'b0;
                ns <= 1;
                done <= 1'b0;
            end

            else if (ns == 1) begin
                rdy <= 1'b0;
                RSTn <= 1'b1;
                if(i == 263) begin
                    i <= 32'b0;
                    cntr <= cntr + 1;
                    ns <= 2;
                end
            	else begin
                    SI <= SCAN_IN_REG[i];  
                    i <= i + 32'b1; 
                    cntr <= cntr + 1;
                end
            end

            else if (ns == 2) begin
            	SU <= 1'b1;
            	SE <= 1'b0;
                cntr <= cntr + 2;
                ns <= 3;
            end

            else if (ns == 3) begin
                SU <= 1'b0;
                cntr <= cntr + 2;
                ns <= 4;
            end

            else if (ns == 4) begin
                Krdy <= 1'b1;
                EN <= 1'b1;
                cntr <= cntr + 1;
                ns <= 5;
            end

            else if (ns == 5) begin
                Krdy <= 1'b0;
                Drdy <= 1'b1;
                cntr <= cntr + 1;
                ns <= 6;
            end

            else if (ns == 6) begin
                Drdy <= 1'b0;
                cntr <= cntr + 2;
                ns <= 7;
            end

            else if (ns == 7) begin
                if (BSY) begin
                    cntr <= cntr + 1; //wait for AES to finish
                end
                else begin
                    SE <= 1'b1;
                    cntr <= cntr + 1;
                    ns <= 8;
                end
            end

            else if (ns == 8) begin
                if(i == 132) begin
                    i <= 32'b0;
                    ns <= 9;
                    cntr <= cntr + 3; ///changed here
                end
            	else begin
                    SCAN_OUT_REG[i] <= SO;  
                    i <= i + 32'b1; 
                    cntr <= cntr + 1;
                end
            end

            else if (ns == 9) begin
            	SE <= 1'b0;
                if (SCAN_OUT_REG[127:0] == `MYOUT1) begin
                    testpassed <= 1'b1;
                end
                else begin 
                    testpassed <= 1'b0;
                end
                ns <= 0;
                done <= 1;
                cntr <= 10;
                rdy <= 1'b1;
                EN <= 0;
            end
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

endmodule