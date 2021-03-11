// Module FSM for the Finite State Machine

module FSM(clk, inp, out);
	
	input clk;
	
	input [1:0] inp;

	output wire [3:0] out;

	reg [3:0] current_state;				//Micro Program Counter
	wire [3:0] incremented_state;
	wire [2:0] micro_instruction;

	four_bit_incrementer state_incrementer(current_state, incremented_state);
	microcode ROM(current_state, micro_instruction);
	reg [3:0] dispatch_rom_1[0:3];
	reg [3:0] dispatch_rom_2[0:3];

	assign out = current_state;
	initial
		begin
			current_state = 4'b0000;

			dispatch_rom_1[0] = 4'b0100;
			dispatch_rom_1[1] = 4'b0101;
			dispatch_rom_1[2] = 4'b0110;
			dispatch_rom_1[3] = 4'b0110; 

			dispatch_rom_2[0] = 4'b1011;
			dispatch_rom_2[1] = 4'b1100;
			dispatch_rom_2[2] = 4'b1100;
			dispatch_rom_2[3] = 4'b1100; 
		end

	always @(posedge clk)
		begin
			// State Selection Multiplexer
			case(micro_instruction)
			3'b000:
				current_state <= #2 incremented_state;
			3'b001:
				current_state <= #2 dispatch_rom_1[inp];
			3'b010:
				current_state <= #2 4'b0111;
			3'b011:
				current_state <= #2 dispatch_rom_2[inp];
			3'b100:
				current_state <= #2 4'b0000;
			default:
				current_state <= #2 4'b0000; // Assigned randomly
			endcase
		end
endmodule