//Module BANK as DRAM Bank with Read feature/operation

module BANK(clk, input_valid, row_num, output_valid, out);
	
	input clk; 							// 1-bit clock input

	input input_valid;					// 1-bit flag for input validity

	input [3:0] row_num;				// 4-bit row number as address

	output reg [31:0] out;
	output reg output_valid;

	reg [1:0] counter;					// A counter register to keep track of number of cycles afte which to show output
	reg [3:0] open_row_num;				// Stores address of row which is opened.
	reg [31:0] bank [0:16]; 			// 16 32-bit registers in a bank

	initial
		begin							// Initialisation of DRAM bank
			bank[0] = 0;
			bank[1] = 1;
			bank[2] = 2;
			bank[3] = 3;
			bank[4] = 4;
			bank[5] = 5;
			bank[6] = 6;
			bank[7] = 7;
			bank[8] = 8;
			bank[9] = 9;
			bank[10] = 10;
			bank[11] = 11;
			bank[12] = 12;
			bank[13] = 13;
			bank[14] = 14;
			bank[15] = 15;	

			output_valid = 1'b0;
			out = 1'b0;					// 0 or x or z?
			counter = 2'bxx;
			open_row_num = 4'bxxxx;
		end

	always @(posedge clk)
		begin
			
			if (input_valid == 1)
			begin
				output_valid = 0;
				out <= bank[row_num];
				open_row_num <= row_num;
				if (open_row_num === 4'bxxxx)
				begin
					counter <= 2'd1;
					output_valid <= 0;
				end
				else if (row_num == open_row_num)
				begin
					counter <= 2'd0;
					output_valid <= 1;
				end
				else
				begin
					counter <= 2'd2;
					output_valid <= 0;
				end
			end

			if (counter == 2'd1)
			begin
				counter <= 2'd0;
				output_valid <= 1;
			end
			else if (counter == 2'd2) 
			begin
				counter <= 2'd1; 
			end
			
		end
	

endmodule
