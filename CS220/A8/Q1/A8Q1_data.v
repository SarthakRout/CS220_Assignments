// Module for Storing Data

module data(data_index, data_out);

reg [7:0] data[0:10];

input [3:0] data_index;

output wire [7:0] data_out;

initial
	begin
		// To be initialised by the TA
		data[0] = 8'b10000000;
		data[1] = 8'b01111111;
		data[2] = 8'b10000000;
		data[3] = 8'b01111111;
		data[4] = 8'b00000001;
		data[5] = 8'b00000001;
		data[6] = 8'b00000001;
		data[7] = 8'b00000001;
		data[8] = 8'b00000001;
		data[9] = 8'b00000001;
		data[10] = 8'b00001100;
	end

	assign data_out = data[data_index];
	

endmodule