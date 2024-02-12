`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/26/2023 09:57:39 PM
// Design Name: 
// Module Name: compressor
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


module compr(
input [8:0] inpp0,
input [10:0] inpp1,
input [9:0] inl0,
input [11:0] inl1,
output [9:0] out0,
output [13:0] out1);

wire net_0_0;
wire [1:0] net_0_1;
wire [2:0] net_0_2;
wire [3:0] net_0_3;
wire [3:0] net_0_4;
wire [3:0] net_0_5;
wire [3:0] net_0_6;
wire [3:0] net_0_7;
wire [3:0] net_0_8;
wire [3:0] net_0_9;
wire [3:0] net_0_10;
wire [2:0] net_0_11;
wire net_0_12;

wire net_1_0;
wire net_1_1;
wire [1:0] net_1_2;
wire [2:0] net_1_3;
wire [2:0] net_1_4;
wire [2:0] net_1_5;
wire [2:0] net_1_6;
wire [2:0] net_1_7;
wire [2:0] net_1_8;
wire [2:0] net_1_9;
wire [2:0] net_1_10;
wire [1:0] net_1_11;
wire [1:0] net_1_12;

assign net_0_0 = inl1[0];
assign net_0_1 = {inl0[0],inl1[1]};
assign net_0_2 = {inl0[1],inl1[2],         inpp1[0]};
assign net_0_3 = {inl0[2],inl1[3],inpp0[0],inpp1[1]};
assign net_0_4 = {inl0[3],inl1[4],inpp0[1],inpp1[2]};
assign net_0_5 = {inl0[4],inl1[5],inpp0[2],inpp1[3]};
assign net_0_6 = {inl0[5],inl1[6],inpp0[3],inpp1[4]};
assign net_0_7 = {inl0[6],inl1[7],inpp0[4],inpp1[5]};
assign net_0_8 = {inl0[7],inl1[8],inpp0[5],inpp1[6]};
assign net_0_9 = {inl0[8],inl1[9],inpp0[6],inpp1[7]};
assign net_0_10 ={inl0[9],inl1[10],inpp0[7],inpp1[8]};
assign net_0_11 = {       inl1[11],inpp0[8],inpp1[9]};
assign net_0_12 = {inpp1[10]};

assign net_1_3[2] = net_0_3[3];
assign net_1_4[2] = net_0_4[3];
assign net_1_5[2] = net_0_5[3];
assign net_1_6[2] = net_0_6[3];
assign net_1_7[2] = net_0_7[3];
assign net_1_8[2] = net_0_8[3];
assign net_1_9[2] = net_0_9[3];
assign net_1_10[2] = net_0_10[3];
assign net_1_12[1] = net_0_12;


ha ha1(net_0_1[0],net_0_1[1],net_1_1,net_1_2[0]);
fa fa1(net_0_2[0],net_0_2[1],net_0_2[2],net_1_2[1],net_1_3[0]);
fa fa2(net_0_3[0],net_0_3[1],net_0_3[2],net_1_3[1],net_1_4[0]);
fa fa3(net_0_4[0],net_0_4[1],net_0_4[2],net_1_4[1],net_1_5[0]);
fa fa4(net_0_5[0],net_0_5[1],net_0_5[2],net_1_5[1],net_1_6[0]);
fa fa5(net_0_6[0],net_0_6[1],net_0_6[2],net_1_6[1],net_1_7[0]);
fa fa6(net_0_7[0],net_0_7[1],net_0_7[2],net_1_7[1],net_1_8[0]);
fa fa7(net_0_8[0],net_0_8[1],net_0_8[2],net_1_8[1],net_1_9[0]);
fa fa8(net_0_9[0],net_0_9[1],net_0_9[2],net_1_9[1],net_1_10[0]);
fa fa9(net_0_10[0],net_0_10[1],net_0_10[2],net_1_10[1],net_1_11[0]);
fa fa10(net_0_11[0],net_0_11[1],net_0_11[2],net_1_11[1],net_1_12[0]);

ha ha2(net_1_2[0],net_1_2[1],out1[2],out0[0]);
fa fa11(net_1_3[0],net_1_3[1],net_1_3[2],out1[3],out0[1]);
fa fa12(net_1_4[0],net_1_4[1],net_1_4[2],out1[4],out0[2]);
fa fa13(net_1_5[0],net_1_5[1],net_1_5[2],out1[5],out0[3]);
fa fa14(net_1_6[0],net_1_6[1],net_1_6[2],out1[6],out0[4]);
fa fa15(net_1_7[0],net_1_7[1],net_1_7[2],out1[7],out0[5]);
fa fa16(net_1_8[0],net_1_8[1],net_1_8[2],out1[8],out0[6]);
fa fa17(net_1_9[0],net_1_9[1],net_1_9[2],out1[9],out0[7]);
fa fa18(net_1_10[0],net_1_10[1],net_1_10[2],out1[10],out0[8]);
ha ha3(net_1_11[0],net_1_11[1],out1[11],out0[9]);
ha ha4(net_1_12[0],net_1_12[1],out1[12],out1[13]);

assign out1[0] = inl1[0];
assign out1[1] = net_1_1;


endmodule
