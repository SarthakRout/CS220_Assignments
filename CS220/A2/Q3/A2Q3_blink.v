// Module M

module M(clk, out);
	
	input clk;
	output wire out;
	reg [20:0] counter;
	reg value;

	assign out = value;

	always @(posedge clk)
		begin
			if (counter == 20'd25000)
				begin
					counter <= 1;
					value <= ~value;
				end
			else
				begin
					counter <= counter + 1;
				end
		end


	initial
		begin
			value = 0; counter = 0;
		end
endmodule