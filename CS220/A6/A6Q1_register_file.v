// Module for Register File
module register_file(clk, valid, read_addr_1, read_addr_2, write_addr, write_data, read_1, read_2);

input clk;										// Clock
input [2:0] valid;        						// Indicator for which read/write operation to perform
input [4:0] read_addr_1;						// 5 bit 1st source register address
input [4:0] read_addr_2;						// 5 bit 2nd source register address
input [4:0] write_addr;							// 5 bit destination register address
input [15:0] write_data;						// 16 bit data to write in a register
output reg [15:0] read_1;						// 16 bit data read from the 1st register
output reg [15:0] read_2;						// 16 bit data read from the 2nd register

reg [15:0] REGISTER[0:31]; 						//32 16-bit register file
reg read_cycles_counter;						//Register to simulate read delay independent of clock
reg write_cycles_counter;						//Register to simulate write delay independent of clock

initial											// Initialisation of register file
	begin				
		read_cycles_counter = 2'b0;
		write_cycles_counter = 2'b0;
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
			if (read_cycles_counter == 1'b1) 						// complete by 2 clock cycles -- give read output
				begin
					read_1 <=  REGISTER[read_addr_1];
					read_2 <=  REGISTER[read_addr_2];
					read_cycles_counter <= 1'b0;
				end
			if (write_cycles_counter == 1'b1)						// complete by 2 clock cycles -- give read output
				begin
					REGISTER[write_addr] <=  write_data;
					write_cycles_counter <= 1'b0;
				end
			if ( valid[0] || valid[1])								// If any read valid bit is active, set read_cycles bit
				begin
					read_cycles_counter <= 1'b1;
				end
			if (valid[2])											// If write valid bit is active, set write_cycles bit
				begin
					write_cycles_counter <= 1'b1;
				end
		end

endmodule