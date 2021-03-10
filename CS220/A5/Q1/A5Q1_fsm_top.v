// Top Module for FSM Top

module top_module();

	reg clk;
	reg [1:0] inp;
	wire [3:0] out;

	FSM fsm(clk, inp, out);

	initial
		begin
			 #150 $finish;
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

	always @(posedge clk or out)
		begin
			$display("Time: %3d Input: %b Output: %b = %4d", $time, inp, out, out);
		end

	initial
		begin
			#8
			inp = 2'b00;

			#10
			inp = 2'b01;

			#10
			inp = 2'b11;

			#10
			inp = 2'b10;
 
			#10
			inp = 2'b00;

			#10
			inp = 2'b11;

			#10
			inp = 2'b00;

			#10
			inp = 2'b01;

			#10
			inp = 2'b10;

			#10
			inp = 2'b11;

			#10
			inp = 2'b00;

			#10
			inp = 2'b10;

			#10
			inp = 2'b00;

			#10
			inp = 2'b10;

			#10
			inp = 2'b00;
		end

endmodule