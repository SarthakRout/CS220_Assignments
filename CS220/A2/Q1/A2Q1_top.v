// Top module for encoder and decoder

module top_module();
	
	reg [2:0] dec_in;
	wire [7:0] dec_out__enc_in;
	wire [2:0] enc_out;

	decoder3to8 dec(dec_in, dec_out__enc_in);

	encoder8to3 enc(dec_out__enc_in, enc_out);

	always @(dec_in or enc_out)
		begin
			$display("Decoder Input: %b\tIntermediate: %b\tEncoder Output: %b", dec_in, dec_out__enc_in, enc_out);
		end

	initial
		begin
			#10 $finish;
		end

	initial
		begin
			dec_in = 3'b000;
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