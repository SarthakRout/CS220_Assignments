// Module for Microcode Rom

module microcode(input_address, output_data);
	
	input clk;
	input [3:0] input_address;
	output reg [2:0] output_data;

	reg [2:0] micro_code_rom[12:0];

	initial
		begin
			micro_code_rom[0] = 3'b000;
			micro_code_rom[1] = 3'b000;
			micro_code_rom[2] = 3'b000;
			micro_code_rom[3] = 3'b001;
			micro_code_rom[4] = 3'b010;
			micro_code_rom[5] = 3'b010;
			micro_code_rom[6] = 3'b000;
			micro_code_rom[7] = 3'b000;
			micro_code_rom[8] = 3'b000;
			micro_code_rom[9] = 3'b000;
			micro_code_rom[10] = 3'b011;
			micro_code_rom[11] = 3'b100;
			micro_code_rom[12] = 3'b100;

			output_data = 3'b000;
		end

	always @(input_address)
		begin
			output_data <= micro_code_rom[input_address];
		end

endmodule