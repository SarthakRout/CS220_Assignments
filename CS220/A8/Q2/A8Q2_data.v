// Module for Storing Data

module data(data_index, data);

reg [7:0] data[0:2];

input [1:0] data_index;

output wire [7:0] data_out;

intial
	begin
		// To be initialised by the TA
		data[0] = 8'b00000000;
		data[1] = 8'b00000000;
		data[2] = 8'b00000000;
	end

	assign data_out = data[data_index];
	

endmodule