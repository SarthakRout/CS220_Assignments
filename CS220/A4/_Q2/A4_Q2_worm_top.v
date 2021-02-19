// Top Module for Worm Game

module top_module();
	
	reg clk;
	reg [1:0] dir_in;
	reg [1:0] step_in;
	wire [3:0] x;
	wire [3:0] y;

	worm WORM_GAME(clk, dir_in, step_in, x, y);


	always @(posedge clk)
		begin
			$display("Time: %3d, Input: Direction: %d Steps: %d, Output: x: %d, y : %d, ", $time, dir_in, step_in, x, y);
		end

	initial
		begin
			#150 $finish;
		end

	initial 
		begin
			clk = 0;								// Implementing clock with time period 10 units and 50% duty cycle for 10 cycles.
			repeat(30)  
			begin
				#5 clk = ~clk;
			end
		end

	initial
		begin
			$display("Direction: 0: EAST, 1: WEST, 2: NORTH, 3: SOUTH");
			#3
			dir_in = 2'b01;
			step_in = 2'b01;

			#10
			dir_in = 2'b10;
			step_in = 2'b11;

			#10
			dir_in = 2'b11;
			step_in = 2'b01;

			#10
			dir_in = 2'b11;
			step_in = 2'b01;

			#10
			dir_in = 2'b01;
			step_in = 2'b11;

			#10
			dir_in = 2'b10;
			step_in = 2'b10;

			#10
			dir_in = 2'b10;
			step_in = 2'b11;

			#10
			dir_in = 2'b10;
			step_in = 2'b11;

			#10
			dir_in = 2'b10;
			step_in = 2'b11;

			#10
			dir_in = 2'b10;
			step_in = 2'b11;

			#10
			dir_in = 2'b01;
			step_in = 2'b01;

			#10
			dir_in = 2'b00;
			step_in = 2'b10;

			#10
			dir_in = 2'b00;
			step_in = 2'b10;


			#10
			step_in = 2'b00;
		end

endmodule