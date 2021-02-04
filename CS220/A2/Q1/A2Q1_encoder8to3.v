// Module for encoder 

module encoder8to3(enc_in, enc_out);
	
	input [7:0] enc_in;				// 8-bit input bus for encoder
	output [2:0] enc_out;			// 3-bit output bus for encoder
	wire [2:0] enc_out;

	assign enc_out[0] = enc_in[1] | enc_in[3] | enc_in[5] | enc_in[7]; 		// 1, 3, 5, 7 have 1st bit as 1
	assign enc_out[1] = enc_in[2] | enc_in[3] | enc_in[6] | enc_in[7];		// 2, 3, 6, 7 have 2nd bit as 1
	assign enc_out[2] = enc_in[4] | enc_in[5] | enc_in[6] | enc_in[7];		// 4, 5, 6, 7 have 3rd bit as 1
	
endmodule
