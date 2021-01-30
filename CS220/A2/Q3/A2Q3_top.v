// Top Module for Blink

module top_module();
	
	reg clk;
	wire out;
	integer cycle;
	M toggle(clk, out);

	always @(out)
		begin
			$display("Time: %7d\tCycles: %6d\tOutput: %b", $time, (cycle>>1), out);
		end

	initial
		begin
			#3100000 $finish;
		end

	initial
		begin
			clk = 1;
			cycle = 0;
			repeat(620000)
				begin
					#5 clk = !clk; cycle = cycle + 1;
				end
		end

endmodule