// Module for Register File

module register_file(clk, valid, read_addr_1, read_addr_2, write_addr, write_data, read_1, read_2);

input clk;									// Clock
input [2:0] valid;        					// Indicator for which read/write operation to perform
input [4:0] read_addr_1;
input [4:0] read_addr_2;
input [4:0] write_addr;
input [15:0] write_data;
output reg [15:0] read_1;
output reg [15:0] read_2;

reg [15:0] REGISTER[0:31]; 					//32 16-bit register file
reg [1:0] read_cycles;						//Register to simulate read delay independent of clock
reg [1:0] write_cycles;						//Register to simulate write delay independent of clock

initial
	begin
		read_cycles = 2'b0;
		write_cycles = 2'b0;
		REGISTER[0] = 16'b0; 
		REGISTER[1] = 16'b0; 
		REGISTER[2] = 16'b0; 
		REGISTER[3] = 16'b0; 
		REGISTER[4] = 16'b0; 
		REGISTER[5] = 16'b0; 
		REGISTER[6] = 16'b0; 
		REGISTER[7] = 16'b0; 
		REGISTER[8] = 16'b0; 
		REGISTER[9] = 16'b0; 
		REGISTER[10] = 16'b0; 
		REGISTER[11] = 16'b0; 
		REGISTER[12] = 16'b0; 
		REGISTER[13] = 16'b0; 
		REGISTER[14] = 16'b0; 
		REGISTER[15] = 16'b0; 
		REGISTER[16] = 16'b0; 
		REGISTER[17] = 16'b0; 
		REGISTER[18] = 16'b0; 
		REGISTER[19] = 16'b0; 
		REGISTER[20] = 16'b0; 
		REGISTER[21] = 16'b0; 
		REGISTER[22] = 16'b0; 
		REGISTER[23] = 16'b0; 
		REGISTER[24] = 16'b0; 
		REGISTER[25] = 16'b0; 
		REGISTER[26] = 16'b0; 
		REGISTER[27] = 16'b0; 
		REGISTER[28] = 16'b0; 
		REGISTER[29] = 16'b0; 
		REGISTER[30] = 16'b0; 
		REGISTER[31] = 16'b0; 
	end

	always @(posedge clk)
		begin
			if (read_cycles == 2'b10) 						// 2 clock cycles -- give read output
				begin
					read_1 <= REGISTER[read_addr_1];
					read_2 <= REGISTER[read_addr_2];
					read_cycles <= 2'b00;
				end
			else if (read_cycles == 2'b01)					// 1 clock cycle -- update
				begin
					read_cycles <= 2'b10;
				end
			if (write_cycles == 2'b10)						// 2 clock cycles -- give read output
				begin
					REGISTER[write_addr] <= write_data;
					write_cycles <= 2'b00;
				end
			else if (write_cycles == 2'b01) 				// 1 clock cycle -- update
				begin
					write_cycles <= 2'b10
				end
			if ( valid[0] || valid[1])						// If any read valid bit is active, set read_cycles bit
				begin
					read_cycles <= 2'b01;
				end
			if (valid[2])									// If write valid bit is active, set write_cycles bit
				begin
					write_cycles <= 2'b01;
				end
		end

endmodule