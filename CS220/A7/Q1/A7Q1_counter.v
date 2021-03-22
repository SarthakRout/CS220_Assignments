// Program Counter

module hardware(clk, terminate);
	
	memory MEMORY(prog_counter, instruction);						// Module instantiation for Instruction Memory

	wire [31:0] instruction;										// 32 bit instruction from the MEMORY
	reg [2:0] prog_counter;											// 3 bit program counter
	reg [2:0] r_counter;											// 3 bit R-Format Counter
	reg [2:0] i_counter;											// 3 bit I-Format Counter
	reg [2:0] j_counter;											// 3 bit J-Format Counter
	reg [2:0] reg_counter[0:3];										// 4 3-bit counter for $3, $4, $5, $6
	input clk;														// Clock input for the module
	output reg terminate;											// A terminate signal 
	 																//sent to the top processor to give $finish signal

	initial															// Initialising everything to zero
		begin
			prog_counter = 3'b000;
			r_counter = 3'b000;
			i_counter = 3'b000;
			j_counter = 3'b000;
			terminate = 1'b0;
			reg_counter[0] = 3'b000;
			reg_counter[1] = 3'b000;
			reg_counter[2] = 3'b000;
			reg_counter[3] = 3'b000;
		end

	always @(posedge clk)
		begin

		if(terminate == 1'b0)										// Only run when terminate condition is not set
			begin
				// R - Format (0 as opcode)
				if(instruction[31:26] == 6'b000000)
					begin
						r_counter <= r_counter + 1;
						case(instruction[15:11])
							3'b011:	reg_counter[0] <= reg_counter[0] + 1;
							3'b100: reg_counter[1] <= reg_counter[1] + 1;
							3'b101: reg_counter[2] <= reg_counter[2] + 1;
							3'b110: reg_counter[3] <= reg_counter[3] + 1;
						endcase
					end
				// J - Format (2, 3, 26(trap) as opcode)
				else if ((instruction[31:26] == 6'b000010) || (instruction[31:26] == 6'b000011) || (instruction[31:26] == 6'b011010))
					begin
						j_counter <= j_counter + 1;
					end
				// I - Format
				else
					begin
						i_counter <= i_counter + 1;
						case(instruction[20:16])
							3'b011:	reg_counter[0] <= reg_counter[0] + 1;
							3'b100: reg_counter[1] <= reg_counter[1] + 1;
							3'b101: reg_counter[2] <= reg_counter[2] + 1;
							3'b110: reg_counter[3] <= reg_counter[3] + 1;
						endcase
					end
				// To terminate the program an display output if the prog_count reaches the last count or increment value
				if (prog_counter == 3'b111)
					begin
						terminate <= 1'b1;
						$monitor("Format Counts::\t\t R: %d\t I:%d\t J: %d\t\nRegister Write Counts:: $3: %d\t$4: %d\t$5: %d\t$6: %d", r_counter, i_counter, j_counter, reg_counter[0],reg_counter[1],reg_counter[2], reg_counter[3]);
					end
				else
					begin
						prog_counter <= prog_counter + 1;
					end
			end

			
		end

endmodule