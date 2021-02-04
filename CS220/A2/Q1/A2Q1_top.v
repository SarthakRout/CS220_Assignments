// Top module for encoder and decoder

module top_module();
	
	reg [2:0] dec_in;					// 3-bit bus input of decoder
	wire [7:0] dec_out__enc_in; 		// Common 8-bit bus connecting output of decoder to input of encoder
	wire [2:0] enc_out;					// 3-bit bus output of encoder

	decoder3to8 dec(dec_in, dec_out__enc_in);

	encoder8to3 enc(dec_out__enc_in, enc_out);

	always @(dec_in or enc_out)
		begin
			$display("Decoder Input: %b\tIntermediate: %b\tEncoder Output: %b", dec_in, dec_out__enc_in, enc_out);
		end

	initial
		begin
			#10 $finish; 				// Simulation running for 10 time units.
		end

	initial
		begin
			dec_in = 3'b000;			// 8 test cases
			$display("\n");
			#1
			dec_in = 3'b001;
			$display("\n");
			#1
			dec_in = 3'b010;
			$display("\n");
			#1
			dec_in = 3'b011;
			$display("\n");
			#1
			dec_in = 3'b100;
			$display("\n");
			#1
			dec_in = 3'b101;
			$display("\n");
			#1
			dec_in = 3'b110;
			$display("\n");
			#1
			dec_in = 3'b111;
			$display("\n");
		end
endmodule