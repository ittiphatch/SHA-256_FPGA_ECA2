`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:37:24 02/13/2018 
// Design Name: 
// Module Name:    sha256_top 
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
  module sha256_top(
   clk,rst_n,sha_start,sha_done
	,rw0 ,rw1 ,rw2 ,rw3,rw4	,rw5 ,rw6	,rw7,rw8,rw9,rw10,rw11,rw12,rw13
	,size,hash_a,hash_b,hash_c,hash_d,hash_e, hash_f,hash_g,hash_h);

// -------------------------------------------------------------
                
    //wire [31:0] a_i = 32'h6a09e667;
	 //wire [31:0] b_i = 32'hbb67ae85;
	 //wire [31:0] c_i = 32'h3c6ef372;
	 //wire [31:0] d_i = 32'ha54ff53a;
	 //wire [31:0] e_i = 32'h510e527f;
	 //wire [31:0] f_i = 32'h9b05688c;
	 //wire [31:0] g_i = 32'h1f83d9ab;
	 //wire [31:0] h_i = 32'h5be0cd19;
	 //wire [31:0] k   = 32'h428a2f98;

input  clk;
input  rst_n;
input  sha_start;
input  [5:0] size;
input  [31:0] rw0,rw1,rw2,rw3,rw4,rw5,rw6,rw7,rw8,rw9,rw10,rw11,rw12,rw13;
output [31:0] hash_a,hash_b,hash_c,hash_d,hash_e,hash_f,hash_g,hash_h;
output sha_done;
wire [31:0] a_o;
wire [31:0] b_o; 
wire [31:0] c_o;
wire [31:0] d_o;
wire [31:0] e_o;
wire [31:0] f_o;
wire [31:0] g_o;
wire [31:0] h_o;
reg [31:0] a_i ;
reg [31:0] b_i ;
reg [31:0] c_i ;
reg [31:0] d_i ;
reg [31:0] e_i ;
reg [31:0] f_i ;
reg [31:0] g_i ;
reg [31:0] h_i ;
reg [31:0] k ;
reg [7:0] counter;
reg [4:0] countpad;
reg [31:0] w0;
reg [31:0] w1;
reg [31:0] w2;
reg [31:0] w3;
reg [31:0] w4;
reg [31:0] w5;
reg [31:0] w6;
reg [31:0] w7;
reg [31:0] w8;
reg [31:0] w9;
reg [31:0] w10;
reg [31:0] w11;
reg [31:0] w12;
reg [31:0] w13;
reg [31:0] w14;
reg [31:0] w15;
reg i = 0;
reg [4:0] s;
reg [1:0] sh;
reg  [31:0] hash_a;
reg  [31:0] hash_b;
reg  [31:0] hash_c;
reg  [31:0] hash_d;
reg  [31:0] hash_e;
reg  [31:0] hash_f;
reg  [31:0] hash_g;
reg  [31:0] hash_h;
reg sha_done;
	
	always@(posedge clk or negedge rst_n)
	begin 
		if(~rst_n)
			counter <= 0;
		else if (sha_done == 1)
		begin
			counter <= 0;
		end
		else if (counter < 63 && countpad == 15 )
			counter <= counter + 1;
	end
	always@(posedge clk or negedge rst_n)
	begin 
		if(~rst_n)
			countpad <= 0;
		else if (sha_done == 1)
		begin
			countpad <= 0;
		end
		else if (sha_start == 1)
			countpad <= countpad + 1;
		else if (countpad < 15 & countpad >= 1)
			countpad <= countpad + 1;
	end
	
always@(posedge clk or negedge rst_n)
	begin  
		if (~rst_n)
		begin
			 hash_a <= 32'h00000000;
			 hash_b <= 32'h00000000;
			 hash_c <= 32'h00000000;
			 hash_d <= 32'h00000000;
			 hash_e <= 32'h00000000;
			 hash_f <= 32'h00000000;
			 hash_g <= 32'h00000000;
			 hash_h <= 32'h00000000;
			 sha_done <= 0;
		end
		else if (counter == 63)
		begin
		    hash_a <= a_o + 32'h6a09e667;
			 hash_b <= b_o + 32'hbb67ae85;
			 hash_c <= c_o + 32'h3c6ef372;
			 hash_d <= d_o + 32'ha54ff53a;
			 hash_e <= e_o + 32'h510e527f;
			 hash_f <= f_o + 32'h9b05688c;
			 hash_g <= g_o + 32'h1f83d9ab;
			 hash_h <= h_o + 32'h5be0cd19;
			 sha_done <= 1;
		end
		else if (sha_done == 1)
			sha_done <= 0;

	end
	
	always@(counter) 
	begin
	case(counter)
		 0:k <= 32'h428a2f98;
		 1:k <= 32'h71374491;
		 2:k <= 32'hb5c0fbcf;
		 3:k <= 32'he9b5dba5;
		 4:k <= 32'h3956c25b;
		 5:k <= 32'h59f111f1;
		 6:k <= 32'h923f82a4;
		 7:k <= 32'hab1c5ed5;
		 8:k <= 32'hd807aa98;
		 9:k <= 32'h12835b01;
		10:k <= 32'h243185be;
		11:k <= 32'h550c7dc3;
		12:k <= 32'h72be5d74;
		13:k <= 32'h80deb1fe;
		14:k <= 32'h9bdc06a7;
		15:k <= 32'hc19bf174;
		16:k <= 32'he49b69c1;
		17:k <= 32'hefbe4786;
		18:k <= 32'h0fc19dc6;
		19:k <= 32'h240ca1cc;
		20:k <= 32'h2de92c6f;
		21:k <= 32'h4a7484aa;
		22:k <= 32'h5cb0a9dc;
		23:k <= 32'h76f988da;
		24:k <= 32'h983e5152;
		25:k <= 32'ha831c66d;
		26:k <= 32'hb00327c8;
		27:k <= 32'hbf597fc7;
		28:k <= 32'hc6e00bf3;
		29:k <= 32'hd5a79147;
		30:k <= 32'h06ca6351;
		31:k <= 32'h14292967;
		32:k <= 32'h27b70a85;
		33:k <= 32'h2e1b2138;
		34:k <= 32'h4d2c6dfc;
		35:k <= 32'h53380d13;
		36:k <= 32'h650a7354;
		37:k <= 32'h766a0abb;
		38:k <= 32'h81c2c92e;
		39:k <= 32'h92722c85;
		40:k <= 32'ha2bfe8a1;
		41:k <= 32'ha81a664b;
		42:k <= 32'hc24b8b70;
		43:k <= 32'hc76c51a3;
		44:k <= 32'hd192e819;
		45:k <= 32'hd6990624;
		46:k <= 32'hf40e3585;
		47:k <= 32'h106aa070;
		48:k <= 32'h19a4c116;
		49:k <= 32'h1e376c08;
		50:k <= 32'h2748774c;
		51:k <= 32'h34b0bcb5;
		52:k <= 32'h391c0cb3;
		53:k <= 32'h4ed8aa4a;
		54:k <= 32'h5b9cca4f;
		55:k <= 32'h682e6ff3;
		56:k <= 32'h748f82ee;
		57:k <= 32'h78a5636f;
		58:k <= 32'h84c87814;
		59:k <= 32'h8cc70208;
		60:k <= 32'h90befffa;
		61:k <= 32'ha4506ceb;
		62:k <= 32'hbef9a3f7;
		63:k <= 32'hc67178f2;
	endcase
	end
	
wire [31:0] s117 = {w14[16:0],w14[31:17]};
wire [31:0] s119 = {w14[18:0],w14[31:19]};
wire [31:0] r10  = {10'b0000000000,w14[31:10]};

wire [31:0] s007 = {w1[6:0],w1[31:7]};
wire [31:0] s018 = {w1[17:0],w1[31:18]};
wire [31:0] r3 = {3'b000,w1[31:3]};

wire [31:0] o0 = s007^s018^r3;
wire [31:0] o1 = s117^s119^r10;
wire [11:0] siebit  = 8*size;
wire [31:0] sizebit = {20'h00000,siebit};


	always@(posedge clk or negedge rst_n)
	begin
	   if  (~rst_n)
		begin
		     //w0 <= 32'h61626380;
			  w0 <= 32'h00000000;
			  w1 <= 32'h00000000;
			  w2 <= 32'h00000000;
			  w3 <= 32'h00000000;
			  w4 <= 32'h00000000;
			  w5 <= 32'h00000000;
			  w6 <= 32'h00000000;
			  w7 <= 32'h00000000;
			  w8 <= 32'h00000000;
			  w9 <= 32'h00000000;
			 w10 <= 32'h00000000;
			 w11 <= 32'h00000000;
			 w12 <= 32'h00000000;
			 w13 <= 32'h00000000;
			 w14 <= 32'h00000000;
			 w15 <= 32'h00000000;
			 s <= 0;
			 sh <= 0;

			 //w15 <= 32'h00000018;
		end
		else if  (sha_done == 1)
		begin
			  w0 <= 32'h00000000;
			  w1 <= 32'h00000000;
			  w2 <= 32'h00000000;
			  w3 <= 32'h00000000;
			  w4 <= 32'h00000000;
			  w5 <= 32'h00000000;
			  w6 <= 32'h00000000;
			  w7 <= 32'h00000000;
			  w8 <= 32'h00000000;
			  w9 <= 32'h00000000;
			 w10 <= 32'h00000000;
			 w11 <= 32'h00000000;
			 w12 <= 32'h00000000;
			 w13 <= 32'h00000000;
			 w14 <= 32'h00000000;
			 w15 <= 32'h00000000;
			 s <= 0;
			 sh <= 0;
			 i <=0;
			 hash_a <= 32'h00000000;
			 hash_b <= 32'h00000000;
			 hash_c <= 32'h00000000;
			 hash_d <= 32'h00000000;
			 hash_e <= 32'h00000000;
			 hash_f <= 32'h00000000;
			 hash_g <= 32'h00000000;
			 hash_h <= 32'h00000000;
		end
		else if (sha_start == 1)
			begin
			 w0  <= rw0;
			 w1  <= rw1;
			 w2  <= rw2;
			 w3  <= rw3;
			 w4  <= rw4;
			 w5  <= rw5;
			 w6  <= rw6;
			 w7  <= rw7;
			 w8  <= rw8;
			 w9  <= rw9;
			 w10 <= rw10;
			 w11 <= rw11;
			 w12 <= rw12;
			 w13 <= rw13;
			 w15 <= sizebit;
			 s  <= size[5:2];
			 sh <= size[1:0]; 
		end
		else if (countpad >= 1 && countpad<=13)
			begin
				if (s == 0 && i == 0)
				begin
					if  (sh == 0)
					   w13 <= 32'h80000000;
				   else if (sh == 1)
						w13 <= (w0 & 32'hFF000000)|32'h00800000;
					else if (sh == 2)
						w13 <= (w0 & 32'hFFFF0000)|32'h00008000;
					else if (sh == 3)
						w13 <= (w0 & 32'hFFFFFF00)|32'h00000080;
				   w0  <= w1;
					w1  <= w2;
					w2  <= w3;
					w3  <= w4;
					w4  <= w5;
					w5  <= w6;
					w6  <= w7;
					w7  <= w8;
					w8  <= w9;
					w9  <= w10;
					w10 <= w11;
					w11 <= w12;
					w12 <= w13;
					i <= 1;
										
				end
				else if (i==0 & s > 0 )
				begin
						w0  <= w1;
						w1  <= w2;
						w2  <= w3;
						w3  <= w4;
						w4  <= w5;
						w5  <= w6;
						w6  <= w7;
						w7  <= w8;
						w8  <= w9;
						w9  <= w10;
						w10 <= w11;
						w11 <= w12;
						w12 <= w13;
						w13 <= w0;
						s <= s-1;
				end
				else if (i==1)
				begin
						w0  <= 32'h00000000;
						w1  <= w2;
						w2  <= w3;
						w3  <= w4;
						w4  <= w5;
						w5  <= w6;
						w6  <= w7;
						w7  <= w8;
						w8  <= w9;
						w9  <= w10;
						w10 <= w11;
						w11 <= w12;
						w12 <= w13;
						w13 <= w0;
				end
			end
		else if (countpad == 14)
			begin
				if (i == 0)
				begin
					if  (sh == 0)
					   w13 <= 32'h80000000;
				   else if (sh == 1)
						w13 <= (w0 & 32'hFF000000)|32'h00800000;
					else if (sh == 2)
						w13 <= (w0 & 32'hFFFF0000)|32'h00008000;
					else if (sh == 3)
						w13 <= (w0 & 32'hFFFFFF00)|32'h00000080;
				   w0  <= w1;
					w1  <= w2;
					w2  <= w3;
					w3  <= w4;
					w4  <= w5;
					w5  <= w6;
					w6  <= w7;
					w7  <= w8;
					w8  <= w9;
					w9  <= w10;
					w10 <= w11;
					w11 <= w12;
					w12 <= w13;
					i <= 1;										
				end
				else if (i==1)
				begin
						w0  <= w1;
						w1  <= w2;
						w2  <= w3;
						w3  <= w4;
						w4  <= w5;
						w5  <= w6;
						w6  <= w7;
						w7  <= w8;
						w8  <= w9;
						w9  <= w10;
						w10 <= w11;
						w11 <= w12;
						w12 <= w13;
						w13 <= w0;
				end
			end
  		else if ((counter>=0) && (counter<63) && (countpad==15))
			begin
			 w0  <= w1;
			 w1  <= w2;
			 w2  <= w3;
			 w3  <= w4;
			 w4  <= w5;
			 w5  <= w6;
			 w6  <= w7;
			 w7  <= w8;
			 w8  <= w9;
			 w9  <= w10;
			 w10 <= w11;
			 w11 <= w12;
			 w12 <= w13;
			 w13 <= w14;
			 w14 <= w15;
			 w15 <= o0+w9+o1+w0;
		end
	end
	always@(posedge clk or negedge rst_n)
	begin  
		if (~rst_n)
		begin
			 a_i <= 32'h6a09e667;
			 b_i <= 32'hbb67ae85;
			 c_i <= 32'h3c6ef372;
			 d_i <= 32'ha54ff53a;
			 e_i <= 32'h510e527f;
			 f_i <= 32'h9b05688c;
			 g_i <= 32'h1f83d9ab;
			 h_i <= 32'h5be0cd19;
		end
		else if (countpad==15 && counter >=0 && counter <=63)
		begin
			 a_i <= a_o;
			 b_i <= b_o;
			 c_i <= c_o;
			 d_i <= d_o;
			 e_i <= e_o;
			 f_i <= f_o;
			 g_i <= g_o;
			 h_i <= h_o;
		end
		else if (sha_done ==1)
		begin
			a_i <= 32'h6a09e667;
			 b_i <= 32'hbb67ae85;
			 c_i <= 32'h3c6ef372;
			 d_i <= 32'ha54ff53a;
			 e_i <= 32'h510e527f;
			 f_i <= 32'h9b05688c;
			 g_i <= 32'h1f83d9ab;
			 h_i <= 32'h5be0cd19;
		end			
		else
		begin
			 a_i <= 32'h6a09e667;
			 b_i <= 32'hbb67ae85;
			 c_i <= 32'h3c6ef372;
			 d_i <= 32'ha54ff53a;
			 e_i <= 32'h510e527f;
			 f_i <= 32'h9b05688c;
			 g_i <= 32'h1f83d9ab;
			 h_i <= 32'h5be0cd19;
		end
	end
	

sha256_core sha256_core (
       .a_i (a_i), 	 
       .b_i (b_i), 
       .c_i (c_i), 
	    .d_i (d_i), 
		 .e_i (e_i), 
		 .f_i (f_i),
		 .g_i (g_i), 
		 .h_i (h_i),
       .a_o (a_o), 	 
       .b_o (b_o), 
       .c_o (c_o), 
	    .d_o (d_o),   
		 .e_o (e_o), 
		 .f_o (f_o),
		 .g_o (g_o), 
		 .h_o (h_o),
	    .w   (w0),
       .k   (k)		 
	);	 
     

endmodule
