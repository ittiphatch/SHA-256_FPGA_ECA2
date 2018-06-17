`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:12:08 02/06/2018 
// Design Name: 
// Module Name:    sha256_core 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module sha256_core(
        a_i, b_i, c_i, d_i, e_i, f_i, g_i, h_i,
		  a_o, b_o, c_o, d_o, e_o, f_o, g_o, h_o,
		   w, k
    );
	 
	 input  [31:0] a_i, b_i, c_i, d_i, e_i, f_i, g_i, h_i;
	 output [31:0] a_o, b_o, c_o, d_o, e_o, f_o, g_o, h_o;
	 input  [31:0]	w;
	 input  [31:0] k;

//----------------------------------------------------------------------------------
wire [31:0] se6 =  {e_i[5:0],e_i[31:6]};
wire [31:0] se11 = {e_i[10:0],e_i[31:11]};
wire [31:0] se25 = {e_i[24:0],e_i[31:25]};
wire [31:0] sa2 = {a_i[1:0],a_i[31:2]};
wire [31:0] sa13 = {a_i[12:0],a_i[31:13]};
wire [31:0] sa22 = {a_i[21:0],a_i[31:22]};
wire [31:0] sigma1_e = se6 ^ se11 ^ se25;
wire [31:0] sigma0_a = sa2^sa13^sa22;
wire [31:0] maj = (a_i & b_i)^( a_i & c_i)^(b_i & c_i);
wire [31:0] ch  = (e_i & f_i)^(~e_i & g_i);
wire [31:0] T1  = h_i + sigma1_e + ch + k + w;
wire [31:0] T2  = sigma0_a + maj;

assign a_o = T1+T2;
assign b_o = a_i;
assign c_o = b_i;
assign d_o = c_i;
assign e_o = d_i+T1;
assign f_o = e_i;
assign g_o = f_i;
assign h_o = g_i;

//git Upload 6-17-2018

endmodule
