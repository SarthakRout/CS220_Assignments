// Module for decoder 

module decoder3to8(dec_in, dec_out);
	
	input [2:0] dec_in;				// 3-bit input bus for decoder
	output [7:0] dec_out;			// 8-bit input bus for decoder
	wire [7:0] dec_out;

	assign dec_out[0] = (~dec_in[2]) & (~dec_in[1]) & (~dec_in[0]); 	// 0 = 000
	assign dec_out[1] = (~dec_in[2] & (~dec_in[1]) & dec_in[0] ); 		// 1 = 001
	assign dec_out[2] = (~dec_in[2]) & dec_in[1] & (~dec_in[0]) ;		// 2 = 010
	assign dec_out[3] = (~dec_in[2]) & dec_in[1] &  dec_in[0]; 			// 3 = 011
	assign dec_out[4] = dec_in[2] & (~dec_in[1]) & (~dec_in[0]) ;		// 4 = 100
	assign dec_out[5] = dec_in[2] & (~dec_in[1]) & dec_in[0] ;			// 5 = 101
	assign dec_out[6] = dec_in[2] & dec_in[1] & (~dec_in[0]);			// 6 = 110
	assign dec_out[7] = dec_in[2] & dec_in[1] & dec_in[0];				// 7 = 111

	
endmodule
