// Top Module for FSM Top

module top_module();

	reg clk;
	reg [1:0] inp;
	wire [3:0] out;

	FSM fsm(clk, inp, out);

	initial
		begin
			 #150 $finish;							// Simulating for 15 clock cycles
		end

	initial 
		begin
			clk = 0;
			clk = 1;								// Implementing clock with time period 10 units and 50% duty cycle for 10 cycles.
			repeat(30)  
			begin
				#5 clk = ~clk;
			end
		end

	always @(posedge clk)
		begin
			$display("Time: %3d Input: %b Output: (Current State to be Changed) %b = %4d", $time, inp, out, out);
		end

	initial
		begin
			#8
			inp = 2'b00;

			//$display("\n");
			#10
			inp = 2'b01;

			//$display("\n");
			#10
			inp = 2'b11;

			//$display("\n");
			#10
			inp = 2'b10;
 
			//$display("\n");
			#10
			inp = 2'b00;

			//$display("\n");
			#10
			inp = 2'b11;

			//$display("\n");
			#10
			inp = 2'b00;

			//$display("\n");
			#10
			inp = 2'b01;

			//$display("\n");
			#10
			inp = 2'b10;

			//$display("\n");
			#10
			inp = 2'b11;

			//$display("\n");
			#10
			inp = 2'b00;

			//$display("\n");
			#10
			inp = 2'b10;

			//$display("\n");
			#10
			inp = 2'b00;

			//$display("\n");
			#10
			inp = 2'b11;

			//$display("\n");
			#10
			inp = 2'b01;
		end

endmodule