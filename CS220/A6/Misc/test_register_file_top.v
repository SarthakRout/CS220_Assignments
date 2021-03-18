//Test module for register file top

module top();
	
	reg clk;
	reg [2:0] valid;        					// Indicator for which read/write operation to perform
	reg [4:0] read_addr_1;
	reg [4:0] read_addr_2;
	reg [4:0] write_addr;
	reg [15:0] write_data;
	wire [15:0] read_1;
	wire [15:0] read_2;
	register_file R(clk, valid, read_addr_1, read_addr_2, write_addr, write_data, read_1, read_2);

	always @(posedge clk) 					// Trying to show output each time it is returned from the bank
		begin
			$display("Top Module: Output: Time: %3d, Valid: %b, Read_Address: %b, Read_Output: %b", $time, valid, read_addr_1, read_1);
		end

	initial
		begin
			#50 $finish;
		end

	initial 
		begin
			clk = 1;								// Implementing clock with time period 10 units and 50% duty cycle for 30 cycles.
			repeat(10)  
			begin
				#5 clk = ~clk;
			end
		end

	initial
		begin
			valid = 3'b000;
			#8
			valid = 3'b001;
			read_addr_1 = 5'b00100;
			#4
			valid = 3'b000;

		end

endmodule;