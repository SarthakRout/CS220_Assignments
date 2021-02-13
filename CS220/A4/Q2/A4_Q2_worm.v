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
	wire [4:0] step_in;
	wire [4:0] out_x;
	wire [4:0] out_y;
	wire opcode;

	assign opcode = dirn[0];
	assign in_x = {opcode, x};
	assign in_y = {opcode, y};
	assign step_in = {3'b000, step};

	five_bit_add_sub X_OP(opcode, in_x, step_in, out_x);
	five_bit_add_sub Y_OP(opcode, in_y, step_in, out_y);

	initial
	begin
		x = 4'b0000;
		y = 4'b0000;
	end

	always @(posedge clk)
		begin
			if (dirn[1] == 1'b0)
			begin
				if(opcode == out_x[4])
				begin
					x <= out_x[3:0];
				end
				else if (opcode == 1'b0)
				begin
					x <= 4'b1111;
				end
				else
				begin
					x <= 4'b0000;
				end
			end
			else
			begin
				if(opcode == out_y[4])
				begin
					y <= out_y[3:0];
				end
				else if (opcode == 1'b0)
				begin
					y <= 4'b1111;
				end
				else
				begin
					y <= 4'b0000;
				end
			end
		end

endmodule