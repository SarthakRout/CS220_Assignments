// Module M as blinker

module M(clk, out);
	
	input clk; 							//1-bit clock input
	output wire out;					//1-bit output
	reg [20:0] counter;					//21-bit register counting clock posedge independent of time period
	reg value;							//1-bit register storing current value of blinker

	assign out = value;

	always @(posedge clk)
		begin
			if (counter == 20'd25000)
				begin
					counter <= 1; 		//Reseting counter to 1
					value <= ~value;	//Toggling the register value
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