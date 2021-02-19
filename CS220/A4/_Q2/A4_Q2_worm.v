// Module for Worm Game

module worm(clk, dirn, step, x, y);
	
	input clk;
	input [1:0] dirn;
	input [1:0] step;

	output reg[3:0] x;
	output reg[3:0] y;

	// Variables for ADD SUB Combinational Logic
	wire [4:0] in_x;
	wire [4:0] in_y;
	wire [4:0] out_x;
	wire [4:0] out_y;
	wire [4:0] in_step;
	wire over_x, over_y, carry_x, carry_y, op;
	
	assign in_x = {1'b0, x};
	assign in_y = {1'b0, y};
	assign in_step = {3'b000, step};
	assign op = dirn[0];

	five_bit_adder_subtracter X_OP(in_x, in_step, op, out_x, carry_x, over_x);
	five_bit_adder_subtracter Y_OP(in_y, in_step, op, out_y, carry_y, over_y);

	initial
	begin
		x = 4'b0000;
		y = 4'b0000;
	end

	always @(posedge clk) begin
		if (dirn[1] == 1'b0) begin
			if (over_x == 1'b1)
				x <= 4'b1111;
			else begin
				if (out_x[4] == 1'b1)
					x <= 4'b0000;
				else
					x <= out_x[3:0];
			end
		end
		else begin
			if (over_y == 1'b1)
				y <= 4'b1111;
			else begin
				if (out_y[4] == 1'b1)
					y <= 4'b0000;
				else
					y <= out_y[3:0];
			end
		end
	end

endmodule