// Module for encoder

module encoder8to3(enc_in, enc_out);
	
	input [7:0] enc_in;
	output [2:0] enc_out;
	wire [2:0] enc_out;

	assign enc_out[0] = enc_in[0] | enc_in[2] | enc_in[4] | enc_in[6]; 
	assign enc_out[1] = enc_in[0] | enc_in[1] | enc_in[4] | enc_in[5];
	assign enc_out[2] = enc_in[0] | enc_in[1] | enc_in[2] | enc_in[3];
	
endmodule
