// Top Module for DRAM Bank

module top_module();
	
	reg clk;
	reg input_valid;
	reg [3:0] row_num;
	wire output_valid;
	wire [31:0] out;

	BANK bank(clk, input_valid, row_num, output_valid, out);

	always @(posedge output_valid) 					// Trying to show output each time it is returned from the bank
		begin
			$display("Output: Time: %3d, Row Number: %b, Output: %b", $time, row_num, out);
		end

	initial
		begin
			#300 $finish;
		end

	initial 
		begin
			clk = 1;								// Implementing clock with time period 10 units and 50% duty cycle for 30 cycles.
			repeat(60)  
			begin
				#5 clk = ~clk;
			end
		end

	initial
		begin
			input_valid = 0;
			#8 
			row_num = 4'b1010;
			input_valid = 1;
			$display("\nInput:  Time: %3d, Row Number: %b", $time, row_num);
			#10 input_valid = 0;

			#20
			row_num = 4'b1011;
			input_valid = 1;
			$display("\nInput:  Time: %3d, Row Number: %b", $time, row_num);
			#10 input_valid = 0;

			#20
			row_num = 4'b1110;
			input_valid = 1;
			$display("\nInput:  Time: %3d, Row Number: %b", $time, row_num);
			#10 input_valid = 0;

			#20
			row_num = 4'b1110;
			input_valid = 1;
			$display("\nInput:  Time: %3d, Row Number: %b", $time, row_num);
			#10 input_valid = 0;

			#20
			row_num = 4'b0110;
			input_valid = 1;
			$display("\nInput:  Time: %3d, Row Number: %b", $time, row_num);
			#10 input_valid = 0;

			#20
			row_num = 4'b1110;
			input_valid = 1;
			$display("\nInput:  Time: %3d, Row Number: %b", $time, row_num);
			#10 input_valid = 0;

			#20
			row_num = 4'b0000;
			input_valid = 1;
			$display("\nInput:  Time: %3d, Row Number: %b", $time, row_num);
			#10 input_valid = 0;

			#20
			row_num = 4'b0010;
			input_valid = 1;
			$display("\nInput:  Time: %3d, Row Number: %b", $time, row_num);
			#10 input_valid = 0;

			#20
			row_num = 4'b1101;
			input_valid = 1;
			$display("\nInput:  Time: %3d, Row Number: %b", $time, row_num);
			#10 input_valid = 0;

			#20
			row_num = 4'b1101;
			input_valid = 1;
			$display("\nInput:  Time: %3d, Row Number: %b", $time, row_num);
			#10 input_valid = 0;

		end
endmodule;