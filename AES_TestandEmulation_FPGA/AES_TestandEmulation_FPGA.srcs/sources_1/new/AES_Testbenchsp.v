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
`define DIVIDER 14

module AES_Testbenchsp(
    input clk, runtest, BSY, SO, //TESTBENCH INPUT PORTS
    output reg Krdy, Drdy, RSTn, EN, SU, SE, SI, testpassed, rdy, done,//TESTBENCH REG PORTS
    output SCLK, CLK, dbg0, dbg1, dbg2 //TESTBENCH WIRE PORTS
    );
    
    reg testpassed = 1'b0;
    reg rdy = 1'b1;
    reg done = 1'b0;

    assign dbg0 = BSY;
    assign dbg1 = EN;
    assign dbg2 = RSTn;


    wire [127:0] Din = `MYIN1;
    wire [127:0] Kin = `MYKEY1;
    wire [7:0] VRStage_SC = 8'b0;
    wire [127:0] Dout;
    wire [263:0] SCAN_IN_REG;
    reg [131:0] SCAN_OUT_REG;
    assign SCAN_IN_REG[0] = VRStage_SC[7];
    assign SCAN_IN_REG[1] = VRStage_SC[5];
    assign SCAN_IN_REG[2] = Din[84];
    assign SCAN_IN_REG[3] = Kin[84];
    assign SCAN_IN_REG[4] = Din[83];
    assign SCAN_IN_REG[5] = Kin[80];
    assign SCAN_IN_REG[6] = Kin[85];
    assign SCAN_IN_REG[7] = Din[80];
    assign SCAN_IN_REG[8] = Din[115];
    assign SCAN_IN_REG[9] = Din[117];
    assign SCAN_IN_REG[10] = Kin[112];
    assign SCAN_IN_REG[11] = Din[113];
    assign SCAN_IN_REG[12] = Kin[30];
    assign SCAN_IN_REG[13] = Din[30];
    assign SCAN_IN_REG[14] = Kin[118];
    assign SCAN_IN_REG[15] = Din[59];
    assign SCAN_IN_REG[16] = Din[86];
    assign SCAN_IN_REG[17] = Kin[114];
    assign SCAN_IN_REG[18] = Kin[62];
    assign SCAN_IN_REG[19] = Kin[57];
    assign SCAN_IN_REG[20] = Din[57];
    assign SCAN_IN_REG[21] = Kin[24];
    assign SCAN_IN_REG[22] = Din[27];
    assign SCAN_IN_REG[23] = Din[31];
    assign SCAN_IN_REG[24] = Din[62];
    assign SCAN_IN_REG[25] = Din[60];
    assign SCAN_IN_REG[26] = Kin[63];
    assign SCAN_IN_REG[27] = Din[63];
    assign SCAN_IN_REG[28] = Din[114];
    assign SCAN_IN_REG[29] = Kin[86];
    assign SCAN_IN_REG[30] = Kin[58];
    assign SCAN_IN_REG[31] = Kin[56];
    assign SCAN_IN_REG[32] = Din[61];
    assign SCAN_IN_REG[33] = Kin[113];
    assign SCAN_IN_REG[34] = Kin[59];
    assign SCAN_IN_REG[35] = Din[118];
    assign SCAN_IN_REG[36] = Kin[93];
    assign SCAN_IN_REG[37] = Din[81];
    assign SCAN_IN_REG[38] = Kin[88];
    assign SCAN_IN_REG[39] = Kin[60];
    assign SCAN_IN_REG[40] = Kin[29];
    assign SCAN_IN_REG[41] = Din[28];
    assign SCAN_IN_REG[42] = Din[97];
    assign SCAN_IN_REG[43] = Kin[28];
    assign SCAN_IN_REG[44] = Kin[101];
    assign SCAN_IN_REG[45] = Din[25];
    assign SCAN_IN_REG[46] = Din[96];
    assign SCAN_IN_REG[47] = Kin[27];
    assign SCAN_IN_REG[48] = Din[100];
    assign SCAN_IN_REG[49] = Din[46];
    assign SCAN_IN_REG[50] = Kin[46];
    assign SCAN_IN_REG[51] = Din[24];
    assign SCAN_IN_REG[52] = Din[102];
    assign SCAN_IN_REG[53] = Din[45];
    assign SCAN_IN_REG[54] = Kin[41];
    assign SCAN_IN_REG[55] = Kin[11];
    assign SCAN_IN_REG[56] = Din[8];
    assign SCAN_IN_REG[57] = Kin[10];
    assign SCAN_IN_REG[58] = Kin[13];
    assign SCAN_IN_REG[59] = Din[9];
    assign SCAN_IN_REG[60] = Kin[8];
    assign SCAN_IN_REG[61] = Din[41];
    assign SCAN_IN_REG[62] = Kin[14];
    assign SCAN_IN_REG[63] = Din[101];
    assign SCAN_IN_REG[64] = Kin[100];
    assign SCAN_IN_REG[65] = Din[42];
    assign SCAN_IN_REG[66] = Din[99];
    assign SCAN_IN_REG[67] = Kin[99];
    assign SCAN_IN_REG[68] = Din[10];
    assign SCAN_IN_REG[69] = Din[0];
    assign SCAN_IN_REG[70] = Kin[15];
    assign SCAN_IN_REG[71] = Kin[42];
    assign SCAN_IN_REG[72] = Din[13];
    assign SCAN_IN_REG[73] = Kin[12];
    assign SCAN_IN_REG[74] = Kin[44];
    assign SCAN_IN_REG[75] = Kin[43];
    assign SCAN_IN_REG[76] = Kin[40];
    assign SCAN_IN_REG[77] = Din[11];
    assign SCAN_IN_REG[78] = Din[5];
    assign SCAN_IN_REG[79] = Kin[67];
    assign SCAN_IN_REG[80] = Kin[66];
    assign SCAN_IN_REG[81] = Din[37];
    assign SCAN_IN_REG[82] = Din[32];
    assign SCAN_IN_REG[83] = Kin[68];
    assign SCAN_IN_REG[84] = Kin[32];
    assign SCAN_IN_REG[85] = Kin[71];
    assign SCAN_IN_REG[86] = Din[67];
    assign SCAN_IN_REG[87] = Kin[64];
    assign SCAN_IN_REG[88] = Kin[65];
    assign SCAN_IN_REG[89] = Kin[70];
    assign SCAN_IN_REG[90] = Kin[0];
    assign SCAN_IN_REG[91] = Kin[37];
    assign SCAN_IN_REG[92] = Kin[2];
    assign SCAN_IN_REG[93] = Kin[33];
    assign SCAN_IN_REG[94] = Kin[39];
    assign SCAN_IN_REG[95] = Kin[5];
    assign SCAN_IN_REG[96] = Din[39];
    assign SCAN_IN_REG[97] = Kin[38];
    assign SCAN_IN_REG[98] = Din[38];
    assign SCAN_IN_REG[99] = Din[35];
    assign SCAN_IN_REG[100] = Kin[35];
    assign SCAN_IN_REG[101] = Kin[34];
    assign SCAN_IN_REG[102] = Din[34];
    assign SCAN_IN_REG[103] = Kin[36];
    assign SCAN_IN_REG[104] = Din[33];
    assign SCAN_IN_REG[105] = Din[36];
    assign SCAN_IN_REG[106] = Kin[4];
    assign SCAN_IN_REG[107] = Din[7];
    assign SCAN_IN_REG[108] = Kin[7];
    assign SCAN_IN_REG[109] = Din[3];
    assign SCAN_IN_REG[110] = Kin[3];
    assign SCAN_IN_REG[111] = Din[2];
    assign SCAN_IN_REG[112] = Kin[6];
    assign SCAN_IN_REG[113] = Kin[1];
    assign SCAN_IN_REG[114] = Din[76];
    assign SCAN_IN_REG[115] = Kin[79];
    assign SCAN_IN_REG[116] = Din[79];
    assign SCAN_IN_REG[117] = Kin[78];
    assign SCAN_IN_REG[118] = Kin[110];
    assign SCAN_IN_REG[119] = Kin[106];
    assign SCAN_IN_REG[120] = Din[78];
    assign SCAN_IN_REG[121] = Kin[111];
    assign SCAN_IN_REG[122] = Kin[76];
    assign SCAN_IN_REG[123] = Din[106];
    assign SCAN_IN_REG[124] = Kin[73];
    assign SCAN_IN_REG[125] = Din[6];
    assign SCAN_IN_REG[126] = Din[111];
    assign SCAN_IN_REG[127] = Kin[108];
    assign SCAN_IN_REG[128] = Din[4];
    assign SCAN_IN_REG[129] = Din[1];
    assign SCAN_IN_REG[130] = Din[73];
    assign SCAN_IN_REG[131] = Din[75];
    assign SCAN_IN_REG[132] = Kin[72];
    assign SCAN_IN_REG[133] = Din[74];
    assign SCAN_IN_REG[134] = Kin[74];
    assign SCAN_IN_REG[135] = Din[110];
    assign SCAN_IN_REG[136] = Kin[104];
    assign SCAN_IN_REG[137] = Din[104];
    assign SCAN_IN_REG[138] = Din[105];
    assign SCAN_IN_REG[139] = Kin[75];
    assign SCAN_IN_REG[140] = Din[77];
    assign SCAN_IN_REG[141] = Din[12];
    assign SCAN_IN_REG[142] = Din[15];
    assign SCAN_IN_REG[143] = Din[72];
    assign SCAN_IN_REG[144] = Kin[109];
    assign SCAN_IN_REG[145] = Din[109];
    assign SCAN_IN_REG[146] = Din[107];
    assign SCAN_IN_REG[147] = Kin[107];
    assign SCAN_IN_REG[148] = Din[44];
    assign SCAN_IN_REG[149] = Din[108];
    assign SCAN_IN_REG[150] = Kin[105];
    assign SCAN_IN_REG[151] = Kin[77];
    assign SCAN_IN_REG[152] = Din[43];
    assign SCAN_IN_REG[153] = Din[47];
    assign SCAN_IN_REG[154] = Din[40];
    assign SCAN_IN_REG[155] = Kin[47];
    assign SCAN_IN_REG[156] = Din[14];
    assign SCAN_IN_REG[157] = Kin[45];
    assign SCAN_IN_REG[158] = Kin[9];
    assign SCAN_IN_REG[159] = Din[26];
    assign SCAN_IN_REG[160] = Kin[26];
    assign SCAN_IN_REG[161] = Kin[31];
    assign SCAN_IN_REG[162] = Din[29];
    assign SCAN_IN_REG[163] = Kin[119];
    assign SCAN_IN_REG[164] = Kin[25];
    assign SCAN_IN_REG[165] = Din[119];
    assign SCAN_IN_REG[166] = Kin[117];
    assign SCAN_IN_REG[167] = Din[82];
    assign SCAN_IN_REG[168] = Kin[82];
    assign SCAN_IN_REG[169] = Kin[102];
    assign SCAN_IN_REG[170] = Din[103];
    assign SCAN_IN_REG[171] = Din[70];
    assign SCAN_IN_REG[172] = Din[71];
    assign SCAN_IN_REG[173] = Din[65];
    assign SCAN_IN_REG[174] = Din[66];
    assign SCAN_IN_REG[175] = Din[68];
    assign SCAN_IN_REG[176] = Din[64];
    assign SCAN_IN_REG[177] = Kin[96];
    assign SCAN_IN_REG[178] = Kin[98];
    assign SCAN_IN_REG[179] = Din[98];
    assign SCAN_IN_REG[180] = Kin[69];
    assign SCAN_IN_REG[181] = Kin[103];
    assign SCAN_IN_REG[182] = Din[69];
    assign SCAN_IN_REG[183] = Kin[97];
    assign SCAN_IN_REG[184] = Kin[115];
    assign SCAN_IN_REG[185] = Kin[116];
    assign SCAN_IN_REG[186] = Din[112];
    assign SCAN_IN_REG[187] = Din[116];
    assign SCAN_IN_REG[188] = Kin[87];
    assign SCAN_IN_REG[189] = Din[85];
    assign SCAN_IN_REG[190] = Din[87];
    assign SCAN_IN_REG[191] = Kin[53];
    assign SCAN_IN_REG[192] = Din[53];
    assign SCAN_IN_REG[193] = VRStage_SC[0];
    assign SCAN_IN_REG[194] = Din[49];
    assign SCAN_IN_REG[195] = Kin[19];
    assign SCAN_IN_REG[196] = Din[51];
    assign SCAN_IN_REG[197] = Kin[23];
    assign SCAN_IN_REG[198] = Kin[20];
    assign SCAN_IN_REG[199] = Kin[51];
    assign SCAN_IN_REG[200] = Din[52];
    assign SCAN_IN_REG[201] = VRStage_SC[6];
    assign SCAN_IN_REG[202] = VRStage_SC[4];
    assign SCAN_IN_REG[203] = Din[16];
    assign SCAN_IN_REG[204] = VRStage_SC[3];
    assign SCAN_IN_REG[205] = Kin[50];
    assign SCAN_IN_REG[206] = VRStage_SC[2];
    assign SCAN_IN_REG[207] = VRStage_SC[1];
    assign SCAN_IN_REG[208] = Kin[83];
    assign SCAN_IN_REG[209] = Din[50];
    assign SCAN_IN_REG[210] = Din[55];
    assign SCAN_IN_REG[211] = Kin[48];
    assign SCAN_IN_REG[212] = Kin[55];
    assign SCAN_IN_REG[213] = Din[48];
    assign SCAN_IN_REG[214] = Kin[52];
    assign SCAN_IN_REG[215] = Din[18];
    assign SCAN_IN_REG[216] = Din[23];
    assign SCAN_IN_REG[217] = Din[20];
    assign SCAN_IN_REG[218] = Din[122];
    assign SCAN_IN_REG[219] = Din[94];
    assign SCAN_IN_REG[220] = Din[121];
    assign SCAN_IN_REG[221] = Din[19];
    assign SCAN_IN_REG[222] = Din[22];
    assign SCAN_IN_REG[223] = Din[126];
    assign SCAN_IN_REG[224] = Din[89];
    assign SCAN_IN_REG[225] = Kin[92];
    assign SCAN_IN_REG[226] = Kin[54];
    assign SCAN_IN_REG[227] = Din[125];
    assign SCAN_IN_REG[228] = Kin[122];
    assign SCAN_IN_REG[229] = Kin[120];
    assign SCAN_IN_REG[230] = Kin[95];
    assign SCAN_IN_REG[231] = Din[91];
    assign SCAN_IN_REG[232] = Kin[94];
    assign SCAN_IN_REG[233] = Din[120];
    assign SCAN_IN_REG[234] = Din[95];
    assign SCAN_IN_REG[235] = Din[90];
    assign SCAN_IN_REG[236] = Kin[90];
    assign SCAN_IN_REG[237] = Din[88];
    assign SCAN_IN_REG[238] = Din[93];
    assign SCAN_IN_REG[239] = Kin[61];
    assign SCAN_IN_REG[240] = Din[58];
    assign SCAN_IN_REG[241] = Din[54];
    assign SCAN_IN_REG[242] = Din[21];
    assign SCAN_IN_REG[243] = Kin[125];
    assign SCAN_IN_REG[244] = Kin[91];
    assign SCAN_IN_REG[245] = Kin[89];
    assign SCAN_IN_REG[246] = Kin[123];
    assign SCAN_IN_REG[247] = Din[92];
    assign SCAN_IN_REG[248] = Kin[49];
    assign SCAN_IN_REG[249] = Kin[81];
    assign SCAN_IN_REG[250] = Din[56];
    assign SCAN_IN_REG[251] = Kin[21];
    assign SCAN_IN_REG[252] = Kin[18];
    assign SCAN_IN_REG[253] = Kin[16];
    assign SCAN_IN_REG[254] = Din[127];
    assign SCAN_IN_REG[255] = Din[123];
    assign SCAN_IN_REG[256] = Kin[127];
    assign SCAN_IN_REG[257] = Kin[121];
    assign SCAN_IN_REG[258] = Kin[126];
    assign SCAN_IN_REG[259] = Kin[22];
    assign SCAN_IN_REG[260] = Din[17];
    assign SCAN_IN_REG[261] = Kin[17];
    assign SCAN_IN_REG[262] = Kin[124];
    assign SCAN_IN_REG[263] = Din[124];
    assign Dout[19] = SCAN_OUT_REG[0];
    assign Dout[20] = SCAN_OUT_REG[1];
    assign Dout[49] = SCAN_OUT_REG[2];
    assign Dout[23] = SCAN_OUT_REG[3];
    assign Dout[22] = SCAN_OUT_REG[4];
    assign Dout[17] = SCAN_OUT_REG[5];
    assign Dout[18] = SCAN_OUT_REG[6];
    assign Dout[127] = SCAN_OUT_REG[7];
    assign Dout[52] = SCAN_OUT_REG[8];
    assign Dout[54] = SCAN_OUT_REG[9];
    assign Dout[95] = SCAN_OUT_REG[10];
    assign Dout[55] = SCAN_OUT_REG[11];
    assign Dout[58] = SCAN_OUT_REG[12];
    assign Dout[89] = SCAN_OUT_REG[13];
    assign Dout[83] = SCAN_OUT_REG[14];
    assign Dout[85] = SCAN_OUT_REG[15];
    assign Dout[88] = SCAN_OUT_REG[16];
    assign Dout[94] = SCAN_OUT_REG[17];
    assign Dout[125] = SCAN_OUT_REG[18];
    assign Dout[120] = SCAN_OUT_REG[19];
    assign Dout[53] = SCAN_OUT_REG[20];
    assign Dout[124] = SCAN_OUT_REG[21];
    assign Dout[126] = SCAN_OUT_REG[22];
    assign Dout[121] = SCAN_OUT_REG[23];
    assign Dout[50] = SCAN_OUT_REG[24];
    assign Dout[51] = SCAN_OUT_REG[25];
    assign Dout[123] = SCAN_OUT_REG[26];
    assign Dout[122] = SCAN_OUT_REG[27];
    assign Dout[16] = SCAN_OUT_REG[28];
    assign Dout[21] = SCAN_OUT_REG[29];
    assign Dout[86] = SCAN_OUT_REG[30];
    assign Dout[57] = SCAN_OUT_REG[31];
    assign Dout[87] = SCAN_OUT_REG[32];
    assign Dout[84] = SCAN_OUT_REG[33];
    assign Dout[59] = SCAN_OUT_REG[34];
    assign Dout[90] = SCAN_OUT_REG[35];
    assign Dout[93] = SCAN_OUT_REG[36];
    assign Dout[119] = SCAN_OUT_REG[37];
    assign Dout[118] = SCAN_OUT_REG[38];
    assign Dout[24] = SCAN_OUT_REG[39];
    assign Dout[28] = SCAN_OUT_REG[40];
    assign Dout[26] = SCAN_OUT_REG[41];
    assign Dout[113] = SCAN_OUT_REG[42];
    assign Dout[116] = SCAN_OUT_REG[43];
    assign Dout[27] = SCAN_OUT_REG[44];
    assign Dout[117] = SCAN_OUT_REG[45];
    assign Dout[112] = SCAN_OUT_REG[46];
    assign Dout[61] = SCAN_OUT_REG[47];
    assign Dout[81] = SCAN_OUT_REG[48];
    assign Dout[115] = SCAN_OUT_REG[49];
    assign Dout[82] = SCAN_OUT_REG[50];
    assign Dout[60] = SCAN_OUT_REG[51];
    assign Dout[48] = SCAN_OUT_REG[52];
    assign Dout[92] = SCAN_OUT_REG[53];
    assign Dout[91] = SCAN_OUT_REG[54];
    assign Dout[56] = SCAN_OUT_REG[55];
    assign Dout[80] = SCAN_OUT_REG[56];
    assign Dout[62] = SCAN_OUT_REG[57];
    assign Dout[63] = SCAN_OUT_REG[58];
    assign Dout[29] = SCAN_OUT_REG[59];
    assign Dout[114] = SCAN_OUT_REG[60];
    assign Dout[31] = SCAN_OUT_REG[61];
    assign Dout[30] = SCAN_OUT_REG[62];
    assign Dout[25] = SCAN_OUT_REG[63];
    assign Dout[103] = SCAN_OUT_REG[64];
    assign Dout[102] = SCAN_OUT_REG[65];
    assign Dout[96] = SCAN_OUT_REG[66];
    assign Dout[71] = SCAN_OUT_REG[67];
    assign Dout[101] = SCAN_OUT_REG[68];
    assign Dout[99] = SCAN_OUT_REG[69];
    assign Dout[64] = SCAN_OUT_REG[70];
    assign Dout[65] = SCAN_OUT_REG[71];
    assign Dout[68] = SCAN_OUT_REG[72];
    assign Dout[42] = SCAN_OUT_REG[73];
    assign Dout[104] = SCAN_OUT_REG[74];
    assign Dout[5] = SCAN_OUT_REG[75];
    assign Dout[37] = SCAN_OUT_REG[76];
    assign Dout[108] = SCAN_OUT_REG[77];
    assign Dout[109] = SCAN_OUT_REG[78];
    assign Dout[111] = SCAN_OUT_REG[79];
    assign Dout[32] = SCAN_OUT_REG[80];
    assign Dout[110] = SCAN_OUT_REG[81];
    assign Dout[75] = SCAN_OUT_REG[82];
    assign Dout[4] = SCAN_OUT_REG[83];
    assign Dout[78] = SCAN_OUT_REG[84];
    assign Dout[6] = SCAN_OUT_REG[85];
    assign Dout[79] = SCAN_OUT_REG[86];
    assign Dout[1] = SCAN_OUT_REG[87];
    assign Dout[38] = SCAN_OUT_REG[88];
    assign Dout[35] = SCAN_OUT_REG[89];
    assign Dout[33] = SCAN_OUT_REG[90];
    assign Dout[72] = SCAN_OUT_REG[91];
    assign Dout[7] = SCAN_OUT_REG[92];
    assign Dout[2] = SCAN_OUT_REG[93];
    assign Dout[74] = SCAN_OUT_REG[94];
    assign Dout[36] = SCAN_OUT_REG[95];
    assign Dout[76] = SCAN_OUT_REG[96];
    assign Dout[39] = SCAN_OUT_REG[97];
    assign Dout[73] = SCAN_OUT_REG[98];
    assign Dout[34] = SCAN_OUT_REG[99];
    assign Dout[3] = SCAN_OUT_REG[100];
    assign Dout[107] = SCAN_OUT_REG[101];
    assign Dout[77] = SCAN_OUT_REG[102];
    assign Dout[106] = SCAN_OUT_REG[103];
    assign Dout[105] = SCAN_OUT_REG[104];
    assign Dout[66] = SCAN_OUT_REG[105];
    assign Dout[45] = SCAN_OUT_REG[106];
    assign Dout[43] = SCAN_OUT_REG[107];
    assign Dout[67] = SCAN_OUT_REG[108];
    assign Dout[40] = SCAN_OUT_REG[109];
    assign Dout[12] = SCAN_OUT_REG[110];
    assign Dout[8] = SCAN_OUT_REG[111];
    assign Dout[41] = SCAN_OUT_REG[112];
    assign Dout[46] = SCAN_OUT_REG[113];
    assign Dout[9] = SCAN_OUT_REG[114];
    assign Dout[11] = SCAN_OUT_REG[115];
    assign Dout[44] = SCAN_OUT_REG[116];
    assign Dout[10] = SCAN_OUT_REG[117];
    assign Dout[15] = SCAN_OUT_REG[118];
    assign Dout[13] = SCAN_OUT_REG[119];
    assign Dout[14] = SCAN_OUT_REG[120];
    assign Dout[47] = SCAN_OUT_REG[121];
    assign Dout[70] = SCAN_OUT_REG[122];
    assign Dout[69] = SCAN_OUT_REG[123];
    assign Dout[98] = SCAN_OUT_REG[124];
    assign Dout[100] = SCAN_OUT_REG[125];
    assign Dout[97] = SCAN_OUT_REG[126];
    assign Dout[0] = SCAN_OUT_REG[127];

    reg [`DIVIDER:0] divider = 0;
    assign CLK = divider[`DIVIDER];
    assign SCLK = divider[`DIVIDER];

    reg [31:0] cntr =   32'd10;
    reg [31:0] timer =  32'd10;
    reg [31:0] i =      32'b0;
    reg [4:0] ns = 5'b0;
    
    always @(posedge clk) divider <= divider + 1;
    
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