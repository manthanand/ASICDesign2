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
`define DIVIDER 23

module transmitter(
    input clk, //UART input clock
    input reset, // reset signal
    input transmit, //btn signal to trigger the UART communication
    input [7:0] data, // data transmitted
    output reg TxD // Transmitter serial output. TxD will be held high during reset, or when no transmissions aretaking place. 
    );

    //internal variables
    reg [3:0] bitcounter = 0; //4 bits counter to count up to 10
    reg [13:0] counter = 0; //14 bits counter to count the baud rate, counter = clock / baud rate
    reg state = 0,nextstate; // initial & next state variable
    // 10 bits data needed to be shifted out during transmission.
    //The least significant bit is initialized with the binary value �0� (a start bit) A binary value �1� is introduced in the most significant bit 
    reg [9:0] rightshiftreg; 
    reg shift; //shift signal to start bit shifting in UART
    reg load; //load signal to start loading the data into rightshift register and add start and stop bit
    reg clear; //clear signal to start reset the bitcounter for UART transmission

    //UART transmission logic
    always @ (posedge clk) 
    begin 
        if (reset) 
    	   begin // reset is asserted (reset = 1)
            state <= 0; // state is idle (state = 0)
            counter <= 0; // counter for baud rate is reset to 0 
            bitcounter <= 0; //counter for bit transmission is reset to 0
           end
        else begin
             counter <= counter + 1; //counter for baud rate generator start counting 
                if (counter >= 10415) //if count to 10416 (from 0 to 10415)
                   begin 
                      state <= nextstate; //previous state change to next state
                      counter <=0; // reset couter to 0
                	  if (load) rightshiftreg <= {1'b1,data,1'b0}; //load the data if load is asserted
    		          if (clear) bitcounter <=0; // reset the bitcounter if clear is asserted
                      if (shift) 
                         begin // if shift is asserted
                            rightshiftreg <= rightshiftreg >> 1; //right shift the data as we transmit the data from lsb
                            bitcounter <= bitcounter + 1; //count the bitcounter
                         end
                   end
             end
    end 

    //state machine

    always @ (posedge clk) //trigger by positive edge of clock, 
    //always @ (state or bitcounter or transmit)
    begin
        load <= 0; // set load equal to 0 at the beginning
        shift <= 0; // set shift equal to 0 at the beginning
        clear <= 0; // set clear equal to 0 at the beginning
        TxD <= 1; // set TxD equals to during no transmission
        case (state)
            0: begin // idle state
                 if (transmit) begin // assert transmit input
                 nextstate <= 1; // Move to transmit state
                 load <=1; // set load to 1 to prepare to load the data
                 shift <=0; // set shift to 0 so no shift ready yet
                 clear <=0; // set clear to 0 to avoid clear any counter
                 end 
    		else begin // if transmit not asserted
                 nextstate <= 0; // next state is back to idle state
                 TxD <= 1; 
                 end
               end
            1: begin  // transmit state
                 if (bitcounter >=10) begin // check if transmission is complete or not. If complete
                 nextstate <= 0; // set nextstate back to 0 to idle state
                 clear <=1; // set clear to 1 to clear all counters
                 end 
    		else begin // if transmisssion is not complete 
                 nextstate <= 1; // set nextstate to 1 to stay in transmit state
                 TxD <= rightshiftreg[0]; // shift the bit to output TxD
                 shift <=1; // set shift to 1 to continue shifting the data
                 end
               end
             default: nextstate <= 0;                      
        endcase
    end

endmodule

module AES_Testbenchsp(clk, runtest, BSY, SO, Krdy, Drdy, RSTn, EN, SU, SE, SI, SCLK, CLK, /*TxD,*/ testpassed, rdy, done, dbg0, dbg1, dbg2);
    input clk; // Clock
    input runtest; // Start test
    input BSY; // AES Busy
    input SO; // Scan Chain Out
    output reg Krdy; // Key input ready
    output reg Drdy; // Data input ready
    output reg RSTn; // Reset (Low active)
    output reg EN; // AES circuit enable
    output reg SU; // Scan Chain Update
    output reg SI; // Scan Chain In
    output reg SE; // Scan Chain Enable
    output CLK, SCLK;
    //output TxD;
    output reg testpassed = 1'b0;
    output reg rdy = 1'b1;
    output reg done = 1'b0;
    output wire dbg0, dbg1, dbg2;

    // wire BSY, SO, SCLK, CLK;
    // reg Krdy, Drdy, RSTn, EN, SU, SI, SE;

    assign dbg0 = BSY;
    assign dbg1 = EN;
    assign dbg2 = RSTn;
    
    reg	[264:0] SCAN_IN_REG;
    reg [131:0] SCAN_OUT_REG = 132'b0;
    reg [`DIVIDER:0] divider = 0;
    assign CLK = divider[`DIVIDER];
    assign SCLK = divider[`DIVIDER];

    reg [31:0] cntr = 32'd10;
    reg [31:0] timer = 32'd10;
    reg [31:0] i = 32'b0;
    reg [4:0] ns = 5'b0;
    
    always @(posedge clk) divider <= divider + 1;
    /*
    wire3 char [8 * 40:0];
    // assign char[0:36] = "KEY: 000102030405060708090a0b0c0d0e0f";
    // assign char[37] = 8'h0A;
    // assign char[38] = 8'h0D;
    // assign char[39:70] = "IN: B9D1C48E348FE771FA464A77A178FB07";
    // assign char[71] = 8'h0A;
    // assign char[72] = 8'h0D;
    // assign char[73:77] = "OUT: ";
    // wire [7:0] char [39:0];
    //The following for loop will convert the binary 4 bit values in SCAN_OUT_REG to ASCII characters and store them in the char array
    //It iterates from 77 to 114 because the SCAN_OUT_REG is 132 bits long
    // for (int j = 0; j < 132; j = j + 4) begin
    //     char[78 + j] = (SCAN_OUT_REG[131-j:128-j] < 10) ? SCAN_OUT_REG[131-j:128-j] + 48 : SCAN_OUT_REG[131-j:128-j] + 55;
    // end

    for (integer j = 0; j < 132; j = j + 4) begin
        char[j/4] = (SCAN_OUT_REG[131-j:128-j] < 10) ? SCAN_OUT_REG[131-j:128-j] + 48 : SCAN_OUT_REG[131-j:128-j] + 55;
    end

    // assign char [115] = 0x0A;
    // assign char [116] = 0x0D;
    reg char[] = 8'h0A;
    reg [6:0] charindex = 0;
    reg transmit = 0;
    reg [16:0] cntr = 0;
    reg [1:0] csuart = 0;

    always @(posedge clk) begin
        // This block will print out the following message using the transmitter module:
        // Need to add Newline & Carriage Return character to every line
        // KEY: `keyvalue`        (32 + 5 characters + newline + carriage return = 39)
        // IN: `invvalue`         (32 + 4 characters + newline + carriage return = 38)
        // OUT: `SCAN_OUT_REG`    (33 + 5 characters + newline + carriage return = 40)
        case (csuart)
            0: begin //Reset transmitter
                cntr <= 0;
                transmit <= 0;
                csuart <= 1;
            end
            1: begin //This moves the transmitter into the transmit state without it transmitting the same character multiple times
                transmit <= 1;
                cntr <= cntr + 1;
                if (cntr > 3) csuart <= 2;
            end
            2: begin //wait for 8 bits to be transmitted
                transmit <= 0;
                cntr <= cntr + 1;
                if (cntr > 110000) csuart <= 3;
            end
            3: begin //Set new character to be transmitted
                charindex <= (charindex < 39) ? charindex + 1 : 0;
                csuart <= 0;
            end
        endcase

    end

    transmitter UART1(.clk(clk), .reset(0), .transmit(transmit), .data(char[charindex][7:0]), .TxD(TxD));
    */
    //Intantiate AES Core within FPGA so if wires dont work, we can validate internally
//    AES_Core AES1(.SI(SI), .SE(SE), .SU(SU), .SCLK(SCLK), .RSTN(RSTn), .EN(EN), .KRDY(Krdy), .DRDY(Drdy), .CLK(CLK),.SO(SO), .BSY(BSY), .CLKOUT(CLKOUT));

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
