// Top Module for Blink

module top_module();
	
	reg clk; 							//1-bit register storing the value of clock
	wire out;							//1-bit wire for taking output of blinker
	M blinker(clk, out);

	always @(out)
		begin
			$display("Time: %7d\tOutput: %b", $time,  out);
		end

	initial
		begin
			#3100000 $finish; 			//3,10,000 clock cycles with each cycle of 10 time units.
		end

	initial
		begin
			clk = 1;
			repeat(620000)
				begin
					#5 clk = ~clk;		//Implementation of clock with 50% duty cycle and period of 10.
				end
		end

endmodule