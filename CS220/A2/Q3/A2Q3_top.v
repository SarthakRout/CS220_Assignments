// Top Module for Blink

module top_module();
	
	reg clk;
	wire out;
	M toggle(clk, out);

	always @(out)
		begin
			$display("Time: %7d\tOutput: %b", $time,  out);
		end

	initial
		begin
			#3100000 $finish;
		end

	initial
		begin
			clk = 1;
			repeat(620000)
				begin
					#5 clk = !clk;
				end
		end

endmodule