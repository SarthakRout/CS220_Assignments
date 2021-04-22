// Module for Non-Restoring Division Algorithm

module divide(clk, new_inp, dvdend, len_a, dvsor, len_b, quotient, remainder, count_add, count_sub, done);

	input clk;
	input new_inp;
	input [31:0] dvdend, dvsor;
	input [4:0] len_a, len_b;

	output reg [31:0] quotient, remainder;
	output reg done;
	output reg [4:0] count_add, count_sub;

	wire [4:0] shift;
	reg [1:0] state;
	reg [31:0] dvsor_;
	wire [5:0] iter_comp;
	reg [5:0] iter_count;
	wire [31:0] q_1, q_2;

	initial begin
		done <= 1;
		state <= 2'b00;
		quotient <= 0;
		remainder <= 0;
		count_add <= 0;
		count_sub <= 0;
		iter_count <= 0;
		dvsor_ <= 0;
	end

	assign shift = len_a - len_b; 
	assign iter_comp = shift + 1;
	assign q_1 = ((quotient ^ 1'b1) << 1 ) | 1;
	assign q_2 = (quotient << 1) | 1;

	always @(posedge clk)
	begin
		if (state == 2'b00)
		begin
			done <= 0;
			count_add <= 0;
			iter_count <= 0;
			count_sub <= 0;
			remainder <= dvdend;
			quotient <= 0;
			if (dvsor == 0)
			begin
				// -1 to show that the division was invalid
				quotient <= -1;
				remainder <= -1;
				state <= 2'b11;
			end
			else if (len_a < len_b)
			begin
				// Divident < Divisor (by bit length)
				state <= 2'b11;
			end
			else
			begin
				// Aligning Dividor with Dividend
				dvsor_ <= (dvsor << shift);
				state <= 2'b01;
			end
		end
		else if (state == 2'b01)
		begin
			if(iter_count != iter_comp)
			begin
				// One Iteration of Division

				if (remainder[31] == 1'b1) 				
				begin
					// Negative Remainder
					remainder <= remainder + dvsor_;
					quotient <=  q_1;
					count_add <= count_add + 1;
				end
				else
				begin
					// Positive Remainder
					remainder <= remainder - dvsor_;
					quotient <= q_2;
					count_sub <= count_sub + 1;
				end
				dvsor_ <= ( dvsor_ >> 1);
				iter_count <= iter_count + 1;
			end
			else
			begin
				state <= 2'b10;
			end
		end
		else if (state == 2'b10)
		begin
			if (remainder[31] == 1'b1)
			begin
				// Extra Correction Step
				remainder <= remainder + dvsor;
				quotient <= quotient ^ 1'b1;
				count_add <= count_add + 1;
			end
			state <= 2'b11;
			iter_count <= 0;
		end
		else if (state == 2'b11)
		begin
			// Last step to reset intermediate values and report other values
			state <= 2'b00; 
			done <= 1;
		end
	end

endmodule;