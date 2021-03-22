// Top Module for Instruction Memory Hardware
module top();
		
	reg clk;										// Register for Clock
	
	hardware HARDWARE(clk, terminate);				// Module Instantiation for HARDWARE

	always @(posedge clk)
		begin
			if(terminate == 1'b1)
				begin
					$display("Program Terminated at Time: %3d", $time);
					$finish;
				end
			
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

endmodule