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

`define MYKEY1  128'h000102030405060708090a0b0c0d0e0f
`define MYIN1   128'hB9D1C48E348FE771FA464A77A178FB07
`define MYOUT1  128'h95F8847369A8573D76AF987AB30A5DE2

`define MYKEY2  128'h0
`define MYIN2   128'h0
`define MYOUT2  128'h66e94bd4ef8a2c3b884cfa59ca342b2e

/*
Din
Expected: 10111001110100011100010010001110001101001000111111100111011100011111101001000110010010100111011110100001011110001111101100000111
Actual:   00000000101011110000010111000111001010000100000001100111011110111001010000000110100010001111000000011100100010000000110010010111

Kin
Expected: 00000000000000010000001000000011000001000000010100000110000001110000100000001001000010100000101100001100000011010000111000001111
Actual:   11100101100000011000101010010010001001001000100000011100000001110010010011110010000000110001011110000001110000010001001000100110
*/

module AES_Testbenchsp(
    input clk, runtest, BSY, SO, rst, //TESTBENCH INPUT PORTS
    input [9:0] DIVIDER, //Clock divider for testbench
    output reg Krdy, Drdy, RSTn, EN, SU, SE, SI, testpassed, rdy, done, //TESTBENCH REG PORTS
    output CLK, SCLK//TESTBENCH WIRE PORTS
    );

    reg testpassed = 1'b0;
    reg rdy = 1'b1;
    reg done = 1'b0;
    assign SCLK = CLK;

    wire [127:0] Din = `MYIN1;
    wire [127:0] Kin = `MYKEY1;
    wire [7:0] VRStage_SC = 8'b0;
    wire [127:0] Dout;
    wire [263:0] SCAN_IN_REG;
    reg [131:0] SCAN_OUT_REG;
    assign SCAN_IN_REG[263] = VRStage_SC[7];
    assign SCAN_IN_REG[262] = VRStage_SC[5];
    assign SCAN_IN_REG[261] = Din[84];
    assign SCAN_IN_REG[260] = Kin[84];
    assign SCAN_IN_REG[259] = Din[83];
    assign SCAN_IN_REG[258] = Kin[80];
    assign SCAN_IN_REG[257] = Kin[85];
    assign SCAN_IN_REG[256] = Din[80];
    assign SCAN_IN_REG[255] = Din[115];
    assign SCAN_IN_REG[254] = Din[117];
    assign SCAN_IN_REG[253] = Kin[112];
    assign SCAN_IN_REG[252] = Din[113];
    assign SCAN_IN_REG[251] = Kin[30];
    assign SCAN_IN_REG[250] = Din[30];
    assign SCAN_IN_REG[249] = Kin[118];
    assign SCAN_IN_REG[248] = Din[59];
    assign SCAN_IN_REG[247] = Din[86];
    assign SCAN_IN_REG[246] = Kin[114];
    assign SCAN_IN_REG[245] = Kin[62];
    assign SCAN_IN_REG[244] = Kin[57];
    assign SCAN_IN_REG[243] = Din[57];
    assign SCAN_IN_REG[242] = Kin[24];
    assign SCAN_IN_REG[241] = Din[27];
    assign SCAN_IN_REG[240] = Din[31];
    assign SCAN_IN_REG[239] = Din[62];
    assign SCAN_IN_REG[238] = Din[60];
    assign SCAN_IN_REG[237] = Kin[63];
    assign SCAN_IN_REG[236] = Din[63];
    assign SCAN_IN_REG[235] = Din[114];
    assign SCAN_IN_REG[234] = Kin[86];
    assign SCAN_IN_REG[233] = Kin[58];
    assign SCAN_IN_REG[232] = Kin[56];
    assign SCAN_IN_REG[231] = Din[61];
    assign SCAN_IN_REG[230] = Kin[113];
    assign SCAN_IN_REG[229] = Kin[59];
    assign SCAN_IN_REG[228] = Din[118];
    assign SCAN_IN_REG[227] = Kin[93];
    assign SCAN_IN_REG[226] = Din[81];
    assign SCAN_IN_REG[225] = Kin[88];
    assign SCAN_IN_REG[224] = Kin[60];
    assign SCAN_IN_REG[223] = Kin[29];
    assign SCAN_IN_REG[222] = Din[28];
    assign SCAN_IN_REG[221] = Din[97];
    assign SCAN_IN_REG[220] = Kin[28];
    assign SCAN_IN_REG[219] = Kin[101];
    assign SCAN_IN_REG[218] = Din[25];
    assign SCAN_IN_REG[217] = Din[96];
    assign SCAN_IN_REG[216] = Kin[27];
    assign SCAN_IN_REG[215] = Din[100];
    assign SCAN_IN_REG[214] = Din[46];
    assign SCAN_IN_REG[213] = Kin[46];
    assign SCAN_IN_REG[212] = Din[24];
    assign SCAN_IN_REG[211] = Din[102];
    assign SCAN_IN_REG[210] = Din[45];
    assign SCAN_IN_REG[209] = Kin[41];
    assign SCAN_IN_REG[208] = Kin[11];
    assign SCAN_IN_REG[207] = Din[8];
    assign SCAN_IN_REG[206] = Kin[10];
    assign SCAN_IN_REG[205] = Kin[13];
    assign SCAN_IN_REG[204] = Din[9];
    assign SCAN_IN_REG[203] = Kin[8];
    assign SCAN_IN_REG[202] = Din[41];
    assign SCAN_IN_REG[201] = Kin[14];
    assign SCAN_IN_REG[200] = Din[101];
    assign SCAN_IN_REG[199] = Kin[100];
    assign SCAN_IN_REG[198] = Din[42];
    assign SCAN_IN_REG[197] = Din[99];
    assign SCAN_IN_REG[196] = Kin[99];
    assign SCAN_IN_REG[195] = Din[10];
    assign SCAN_IN_REG[194] = Din[0];
    assign SCAN_IN_REG[193] = Kin[15];
    assign SCAN_IN_REG[192] = Kin[42];
    assign SCAN_IN_REG[191] = Din[13];
    assign SCAN_IN_REG[190] = Kin[12];
    assign SCAN_IN_REG[189] = Kin[44];
    assign SCAN_IN_REG[188] = Kin[43];
    assign SCAN_IN_REG[187] = Kin[40];
    assign SCAN_IN_REG[186] = Din[11];
    assign SCAN_IN_REG[185] = Din[5];
    assign SCAN_IN_REG[184] = Kin[67];
    assign SCAN_IN_REG[183] = Kin[66];
    assign SCAN_IN_REG[182] = Din[37];
    assign SCAN_IN_REG[181] = Din[32];
    assign SCAN_IN_REG[180] = Kin[68];
    assign SCAN_IN_REG[179] = Kin[32];
    assign SCAN_IN_REG[178] = Kin[71];
    assign SCAN_IN_REG[177] = Din[67];
    assign SCAN_IN_REG[176] = Kin[64];
    assign SCAN_IN_REG[175] = Kin[65];
    assign SCAN_IN_REG[174] = Kin[70];
    assign SCAN_IN_REG[173] = Kin[0];
    assign SCAN_IN_REG[172] = Kin[37];
    assign SCAN_IN_REG[171] = Kin[2];
    assign SCAN_IN_REG[170] = Kin[33];
    assign SCAN_IN_REG[169] = Kin[39];
    assign SCAN_IN_REG[168] = Kin[5];
    assign SCAN_IN_REG[167] = Din[39];
    assign SCAN_IN_REG[166] = Kin[38];
    assign SCAN_IN_REG[165] = Din[38];
    assign SCAN_IN_REG[164] = Din[35];
    assign SCAN_IN_REG[163] = Kin[35];
    assign SCAN_IN_REG[162] = Kin[34];
    assign SCAN_IN_REG[161] = Din[34];
    assign SCAN_IN_REG[160] = Kin[36];
    assign SCAN_IN_REG[159] = Din[33];
    assign SCAN_IN_REG[158] = Din[36];
    assign SCAN_IN_REG[157] = Kin[4];
    assign SCAN_IN_REG[156] = Din[7];
    assign SCAN_IN_REG[155] = Kin[7];
    assign SCAN_IN_REG[154] = Din[3];
    assign SCAN_IN_REG[153] = Kin[3];
    assign SCAN_IN_REG[152] = Din[2];
    assign SCAN_IN_REG[151] = Kin[6];
    assign SCAN_IN_REG[150] = Kin[1];
    assign SCAN_IN_REG[149] = Din[76];
    assign SCAN_IN_REG[148] = Kin[79];
    assign SCAN_IN_REG[147] = Din[79];
    assign SCAN_IN_REG[146] = Kin[78];
    assign SCAN_IN_REG[145] = Kin[110];
    assign SCAN_IN_REG[144] = Kin[106];
    assign SCAN_IN_REG[143] = Din[78];
    assign SCAN_IN_REG[142] = Kin[111];
    assign SCAN_IN_REG[141] = Kin[76];
    assign SCAN_IN_REG[140] = Din[106];
    assign SCAN_IN_REG[139] = Kin[73];
    assign SCAN_IN_REG[138] = Din[6];
    assign SCAN_IN_REG[137] = Din[111];
    assign SCAN_IN_REG[136] = Kin[108];
    assign SCAN_IN_REG[135] = Din[4];
    assign SCAN_IN_REG[134] = Din[1];
    assign SCAN_IN_REG[133] = Din[73];
    assign SCAN_IN_REG[132] = Din[75];
    assign SCAN_IN_REG[131] = Kin[72];
    assign SCAN_IN_REG[130] = Din[74];
    assign SCAN_IN_REG[129] = Kin[74];
    assign SCAN_IN_REG[128] = Din[110];
    assign SCAN_IN_REG[127] = Kin[104];
    assign SCAN_IN_REG[126] = Din[104];
    assign SCAN_IN_REG[125] = Din[105];
    assign SCAN_IN_REG[124] = Kin[75];
    assign SCAN_IN_REG[123] = Din[77];
    assign SCAN_IN_REG[122] = Din[12];
    assign SCAN_IN_REG[121] = Din[15];
    assign SCAN_IN_REG[120] = Din[72];
    assign SCAN_IN_REG[119] = Kin[109];
    assign SCAN_IN_REG[118] = Din[109];
    assign SCAN_IN_REG[117] = Din[107];
    assign SCAN_IN_REG[116] = Kin[107];
    assign SCAN_IN_REG[115] = Din[44];
    assign SCAN_IN_REG[114] = Din[108];
    assign SCAN_IN_REG[113] = Kin[105];
    assign SCAN_IN_REG[112] = Kin[77];
    assign SCAN_IN_REG[111] = Din[43];
    assign SCAN_IN_REG[110] = Din[47];
    assign SCAN_IN_REG[109] = Din[40];
    assign SCAN_IN_REG[108] = Kin[47];
    assign SCAN_IN_REG[107] = Din[14];
    assign SCAN_IN_REG[106] = Kin[45];
    assign SCAN_IN_REG[105] = Kin[9];
    assign SCAN_IN_REG[104] = Din[26];
    assign SCAN_IN_REG[103] = Kin[26];
    assign SCAN_IN_REG[102] = Kin[31];
    assign SCAN_IN_REG[101] = Din[29];
    assign SCAN_IN_REG[100] = Kin[119];
    assign SCAN_IN_REG[99] = Kin[25];
    assign SCAN_IN_REG[98] = Din[119];
    assign SCAN_IN_REG[97] = Kin[117];
    assign SCAN_IN_REG[96] = Din[82];
    assign SCAN_IN_REG[95] = Kin[82];
    assign SCAN_IN_REG[94] = Kin[102];
    assign SCAN_IN_REG[93] = Din[103];
    assign SCAN_IN_REG[92] = Din[70];
    assign SCAN_IN_REG[91] = Din[71];
    assign SCAN_IN_REG[90] = Din[65];
    assign SCAN_IN_REG[89] = Din[66];
    assign SCAN_IN_REG[88] = Din[68];
    assign SCAN_IN_REG[87] = Din[64];
    assign SCAN_IN_REG[86] = Kin[96];
    assign SCAN_IN_REG[85] = Kin[98];
    assign SCAN_IN_REG[84] = Din[98];
    assign SCAN_IN_REG[83] = Kin[69];
    assign SCAN_IN_REG[82] = Kin[103];
    assign SCAN_IN_REG[81] = Din[69];
    assign SCAN_IN_REG[80] = Kin[97];
    assign SCAN_IN_REG[79] = Kin[115];
    assign SCAN_IN_REG[78] = Kin[116];
    assign SCAN_IN_REG[77] = Din[112];
    assign SCAN_IN_REG[76] = Din[116];
    assign SCAN_IN_REG[75] = Kin[87];
    assign SCAN_IN_REG[74] = Din[85];
    assign SCAN_IN_REG[73] = Din[87];
    assign SCAN_IN_REG[72] = Kin[53];
    assign SCAN_IN_REG[71] = Din[53];
    assign SCAN_IN_REG[70] = VRStage_SC[0];
    assign SCAN_IN_REG[69] = Din[49];
    assign SCAN_IN_REG[68] = Kin[19];
    assign SCAN_IN_REG[67] = Din[51];
    assign SCAN_IN_REG[66] = Kin[23];
    assign SCAN_IN_REG[65] = Kin[20];
    assign SCAN_IN_REG[64] = Kin[51];
    assign SCAN_IN_REG[63] = Din[52];
    assign SCAN_IN_REG[62] = VRStage_SC[6];
    assign SCAN_IN_REG[61] = VRStage_SC[4];
    assign SCAN_IN_REG[60] = Din[16];
    assign SCAN_IN_REG[59] = VRStage_SC[3];
    assign SCAN_IN_REG[58] = Kin[50];
    assign SCAN_IN_REG[57] = VRStage_SC[2];
    assign SCAN_IN_REG[56] = VRStage_SC[1];
    assign SCAN_IN_REG[55] = Kin[83];
    assign SCAN_IN_REG[54] = Din[50];
    assign SCAN_IN_REG[53] = Din[55];
    assign SCAN_IN_REG[52] = Kin[48];
    assign SCAN_IN_REG[51] = Kin[55];
    assign SCAN_IN_REG[50] = Din[48];
    assign SCAN_IN_REG[49] = Kin[52];
    assign SCAN_IN_REG[48] = Din[18];
    assign SCAN_IN_REG[47] = Din[23];
    assign SCAN_IN_REG[46] = Din[20];
    assign SCAN_IN_REG[45] = Din[122];
    assign SCAN_IN_REG[44] = Din[94];
    assign SCAN_IN_REG[43] = Din[121];
    assign SCAN_IN_REG[42] = Din[19];
    assign SCAN_IN_REG[41] = Din[22];
    assign SCAN_IN_REG[40] = Din[126];
    assign SCAN_IN_REG[39] = Din[89];
    assign SCAN_IN_REG[38] = Kin[92];
    assign SCAN_IN_REG[37] = Kin[54];
    assign SCAN_IN_REG[36] = Din[125];
    assign SCAN_IN_REG[35] = Kin[122];
    assign SCAN_IN_REG[34] = Kin[120];
    assign SCAN_IN_REG[33] = Kin[95];
    assign SCAN_IN_REG[32] = Din[91];
    assign SCAN_IN_REG[31] = Kin[94];
    assign SCAN_IN_REG[30] = Din[120];
    assign SCAN_IN_REG[29] = Din[95];
    assign SCAN_IN_REG[28] = Din[90];
    assign SCAN_IN_REG[27] = Kin[90];
    assign SCAN_IN_REG[26] = Din[88];
    assign SCAN_IN_REG[25] = Din[93];
    assign SCAN_IN_REG[24] = Kin[61];
    assign SCAN_IN_REG[23] = Din[58];
    assign SCAN_IN_REG[22] = Din[54];
    assign SCAN_IN_REG[21] = Din[21];
    assign SCAN_IN_REG[20] = Kin[125];
    assign SCAN_IN_REG[19] = Kin[91];
    assign SCAN_IN_REG[18] = Kin[89];
    assign SCAN_IN_REG[17] = Kin[123];
    assign SCAN_IN_REG[16] = Din[92];
    assign SCAN_IN_REG[15] = Kin[49];
    assign SCAN_IN_REG[14] = Kin[81];
    assign SCAN_IN_REG[13] = Din[56];
    assign SCAN_IN_REG[12] = Kin[21];
    assign SCAN_IN_REG[11] = Kin[18];
    assign SCAN_IN_REG[10] = Kin[16];
    assign SCAN_IN_REG[9] = Din[127];
    assign SCAN_IN_REG[8] = Din[123];
    assign SCAN_IN_REG[7] = Kin[127];
    assign SCAN_IN_REG[6] = Kin[121];
    assign SCAN_IN_REG[5] = Kin[126];
    assign SCAN_IN_REG[4] = Kin[22];
    assign SCAN_IN_REG[3] = Din[17];
    assign SCAN_IN_REG[2] = Kin[17];
    assign SCAN_IN_REG[1] = Kin[124];
    assign SCAN_IN_REG[0] = Din[124];

    assign Dout[19] = SCAN_OUT_REG[127];
    assign Dout[20] = SCAN_OUT_REG[126];
    assign Dout[49] = SCAN_OUT_REG[125];
    assign Dout[23] = SCAN_OUT_REG[124];
    assign Dout[22] = SCAN_OUT_REG[123];
    assign Dout[17] = SCAN_OUT_REG[122];
    assign Dout[18] = SCAN_OUT_REG[121];
    assign Dout[127] = SCAN_OUT_REG[120];
    assign Dout[52] = SCAN_OUT_REG[119];
    assign Dout[54] = SCAN_OUT_REG[118];
    assign Dout[95] = SCAN_OUT_REG[117];
    assign Dout[55] = SCAN_OUT_REG[116];
    assign Dout[58] = SCAN_OUT_REG[115];
    assign Dout[89] = SCAN_OUT_REG[114];
    assign Dout[83] = SCAN_OUT_REG[113];
    assign Dout[85] = SCAN_OUT_REG[112];
    assign Dout[88] = SCAN_OUT_REG[111];
    assign Dout[94] = SCAN_OUT_REG[110];
    assign Dout[125] = SCAN_OUT_REG[109];
    assign Dout[120] = SCAN_OUT_REG[108];
    assign Dout[53] = SCAN_OUT_REG[107];
    assign Dout[124] = SCAN_OUT_REG[106];
    assign Dout[126] = SCAN_OUT_REG[105];
    assign Dout[121] = SCAN_OUT_REG[104];
    assign Dout[50] = SCAN_OUT_REG[103];
    assign Dout[51] = SCAN_OUT_REG[102];
    assign Dout[123] = SCAN_OUT_REG[101];
    assign Dout[122] = SCAN_OUT_REG[100];
    assign Dout[16] = SCAN_OUT_REG[99];
    assign Dout[21] = SCAN_OUT_REG[98];
    assign Dout[86] = SCAN_OUT_REG[97];
    assign Dout[57] = SCAN_OUT_REG[96];
    assign Dout[87] = SCAN_OUT_REG[95];
    assign Dout[84] = SCAN_OUT_REG[94];
    assign Dout[59] = SCAN_OUT_REG[93];
    assign Dout[90] = SCAN_OUT_REG[92];
    assign Dout[93] = SCAN_OUT_REG[91];
    assign Dout[119] = SCAN_OUT_REG[90];
    assign Dout[118] = SCAN_OUT_REG[89];
    assign Dout[24] = SCAN_OUT_REG[88];
    assign Dout[28] = SCAN_OUT_REG[87];
    assign Dout[26] = SCAN_OUT_REG[86];
    assign Dout[113] = SCAN_OUT_REG[85];
    assign Dout[116] = SCAN_OUT_REG[84];
    assign Dout[27] = SCAN_OUT_REG[83];
    assign Dout[117] = SCAN_OUT_REG[82];
    assign Dout[112] = SCAN_OUT_REG[81];
    assign Dout[61] = SCAN_OUT_REG[80];
    assign Dout[81] = SCAN_OUT_REG[79];
    assign Dout[115] = SCAN_OUT_REG[78];
    assign Dout[82] = SCAN_OUT_REG[77];
    assign Dout[60] = SCAN_OUT_REG[76];
    assign Dout[48] = SCAN_OUT_REG[75];
    assign Dout[92] = SCAN_OUT_REG[74];
    assign Dout[91] = SCAN_OUT_REG[73];
    assign Dout[56] = SCAN_OUT_REG[72];
    assign Dout[80] = SCAN_OUT_REG[71];
    assign Dout[62] = SCAN_OUT_REG[70];
    assign Dout[63] = SCAN_OUT_REG[69];
    assign Dout[29] = SCAN_OUT_REG[68];
    assign Dout[114] = SCAN_OUT_REG[67];
    assign Dout[31] = SCAN_OUT_REG[66];
    assign Dout[30] = SCAN_OUT_REG[65];
    assign Dout[25] = SCAN_OUT_REG[64];
    assign Dout[103] = SCAN_OUT_REG[63];
    assign Dout[102] = SCAN_OUT_REG[62];
    assign Dout[96] = SCAN_OUT_REG[61];
    assign Dout[71] = SCAN_OUT_REG[60];
    assign Dout[101] = SCAN_OUT_REG[59];
    assign Dout[99] = SCAN_OUT_REG[58];
    assign Dout[64] = SCAN_OUT_REG[57];
    assign Dout[65] = SCAN_OUT_REG[56];
    assign Dout[68] = SCAN_OUT_REG[55];
    assign Dout[42] = SCAN_OUT_REG[54];
    assign Dout[104] = SCAN_OUT_REG[53];
    assign Dout[5] = SCAN_OUT_REG[52];
    assign Dout[37] = SCAN_OUT_REG[51];
    assign Dout[108] = SCAN_OUT_REG[50];
    assign Dout[109] = SCAN_OUT_REG[49];
    assign Dout[111] = SCAN_OUT_REG[48];
    assign Dout[32] = SCAN_OUT_REG[47];
    assign Dout[110] = SCAN_OUT_REG[46];
    assign Dout[75] = SCAN_OUT_REG[45];
    assign Dout[4] = SCAN_OUT_REG[44];
    assign Dout[78] = SCAN_OUT_REG[43];
    assign Dout[6] = SCAN_OUT_REG[42];
    assign Dout[79] = SCAN_OUT_REG[41];
    assign Dout[1] = SCAN_OUT_REG[40];
    assign Dout[38] = SCAN_OUT_REG[39];
    assign Dout[35] = SCAN_OUT_REG[38];
    assign Dout[33] = SCAN_OUT_REG[37];
    assign Dout[72] = SCAN_OUT_REG[36];
    assign Dout[7] = SCAN_OUT_REG[35];
    assign Dout[2] = SCAN_OUT_REG[34];
    assign Dout[74] = SCAN_OUT_REG[33];
    assign Dout[36] = SCAN_OUT_REG[32];
    assign Dout[76] = SCAN_OUT_REG[31];
    assign Dout[39] = SCAN_OUT_REG[30];
    assign Dout[73] = SCAN_OUT_REG[29];
    assign Dout[34] = SCAN_OUT_REG[28];
    assign Dout[3] = SCAN_OUT_REG[27];
    assign Dout[107] = SCAN_OUT_REG[26];
    assign Dout[77] = SCAN_OUT_REG[25];
    assign Dout[106] = SCAN_OUT_REG[24];
    assign Dout[105] = SCAN_OUT_REG[23];
    assign Dout[66] = SCAN_OUT_REG[22];
    assign Dout[45] = SCAN_OUT_REG[21];
    assign Dout[43] = SCAN_OUT_REG[20];
    assign Dout[67] = SCAN_OUT_REG[19];
    assign Dout[40] = SCAN_OUT_REG[18];
    assign Dout[12] = SCAN_OUT_REG[17];
    assign Dout[8] = SCAN_OUT_REG[16];
    assign Dout[41] = SCAN_OUT_REG[15];
    assign Dout[46] = SCAN_OUT_REG[14];
    assign Dout[9] = SCAN_OUT_REG[13];
    assign Dout[11] = SCAN_OUT_REG[12];
    assign Dout[44] = SCAN_OUT_REG[11];
    assign Dout[10] = SCAN_OUT_REG[10];
    assign Dout[15] = SCAN_OUT_REG[9];
    assign Dout[13] = SCAN_OUT_REG[8];
    assign Dout[14] = SCAN_OUT_REG[7];
    assign Dout[47] = SCAN_OUT_REG[6];
    assign Dout[70] = SCAN_OUT_REG[5];
    assign Dout[69] = SCAN_OUT_REG[4];
    assign Dout[98] = SCAN_OUT_REG[3];
    assign Dout[100] = SCAN_OUT_REG[2];
    assign Dout[97] = SCAN_OUT_REG[1];
    assign Dout[0] = SCAN_OUT_REG[0];

    reg [11:0] clk_450_cntr = 1'b0;
    reg [11:0] clk_100_cntr = 1'b0;
    wire clk_450;
    reg clk_90, clk_75, clk_56_25;
    reg clk_50 = 1'b0;
    reg clk_33 = 1'b0;
    reg clk_25 = 1'b0;
    reg clk_20 = 1'b0;
    reg clk_10 = 1'b0;
    reg clk_5 = 1'b0;

    clk_wiz_0 instance_name (
        .clk_450(clk_450),     // output clk_450
        .reset(rst), // input reset
        .locked(),       // output locked
        .clk_in1(clk)      // input clk_in1
    );

    always @(posedge clk_450) begin
        if (clk_450_cntr == 59) clk_450_cntr <= 0;
        else clk_450_cntr <= clk_450_cntr + 1'b1;

        if (clk_450_cntr % 4 == 0) clk_90 <= ~clk_90;
        if (clk_450_cntr % 5 == 0) clk_75 <= ~clk_75;
        if (clk_450_cntr % 6 == 0) clk_56_25 <= ~clk_56_25;
    end

    always @(posedge clk) begin
        if (clk_100_cntr == 683) clk_100_cntr <= 0;
        else clk_100_cntr <= clk_100_cntr + 1'b1;

        if (clk_100_cntr % 1 == 0) clk_50 <= ~clk_50;
        if (clk_100_cntr % 2 == 0) clk_33 <= ~clk_33;
        if (clk_100_cntr % 3 == 0) clk_25 <= ~clk_25;
        if (clk_100_cntr % 4 == 0) clk_20 <= ~clk_20;
        if (clk_100_cntr % 9 == 0) clk_10 <= ~clk_10;
        if (clk_100_cntr % 19 == 0) clk_5 <= ~clk_5;
    end

    assign CLK = DIVIDER[0] ? clk_90 : 
               DIVIDER[1] ? clk_75 :
               DIVIDER[2] ? clk_56_25 :
//                DIVIDER[3] ? clk_60 : 
                DIVIDER[4] ? clk_50 :
                DIVIDER[5] ? clk_33 :
                DIVIDER[6] ? clk_25 :
                DIVIDER[7] ? clk_20 :
                DIVIDER[8] ? clk_10 :
                DIVIDER[9] ? clk_5 : clk;

    reg [1:0] csbutton = 0;
    reg [31:0] cntr = 32'd10;
    reg [31:0] timer = 32'd10;
    reg [31:0] i = 32'b0;
    reg [4:0] ns = 5'b0;

    // timer1
    always @(posedge CLK or posedge rst) begin
        if (rst) begin
            csbutton <= 0;
            timer <= 0;
        end
        else begin
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
    end

    // 1 initialization
    always@(posedge CLK or posedge rst) begin
        if (rst) begin
            testpassed <= 0;
            rdy <= 1;
            done <= 0;
            cntr <= 10;
            ns <= 0;
            i <= 0;
            SU <= 1'b0;
            SI <= 1'b0;
            SE <= 1'b0;
            Krdy <= 1'b0;
            Drdy <= 1'b0;
            RSTn <= 1'b0;
            EN <= 1'b0;
            RSTn <= 1'b0;
        end
        else if (timer == cntr) begin
            if (ns == 0) begin
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
                    SCAN_OUT_REG[i] = SO;  //making this level sensitive instead of edge sensitive to account for delays
                    i <= i + 32'b1;
                    cntr <= cntr + 1;
                end
            end

            else if (ns == 9) begin
            	SE <= 1'b0;
                if (Dout[127:0] == `MYOUT1) begin
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