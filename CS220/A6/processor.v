// Instruction processor module over register file.

module processor(clk, instr, reg1, reg2, reg3, const, done);
    input clk;                                              // clock
    input [2:0] instr;                                      // 3-bit instructions
    input [4:0] reg1, reg2, reg3;                           // 5-bit register numbers
    // reg1, reg2 store reading register addresses and reg3 stores writing register address.
    input [15:0] const;                                     // 16-bit constant

    output reg done;                                        // stores state of current instruction.

    reg [2:0] valid;                                        // enables read and write port of register file.
    wire signed [15:0] read1, read2;                        // stores the data read by read ports.
    reg [4:0] cycle_count;                                  // counts number of cycles since new instruction.
    reg signed [15:0] op1, op2;                             // operands for various operations.
    wire signed [15:0] sum_sub_ans, left_shift_ans;         // output of various operations.
    reg signed [15:0] write_data;                           // stores value to be written in register file.
    reg opcode;                                             // stores type of operation.

    register_file rfile(clk, valid, reg1, reg2, reg3, write_data, read1, read2);
    add_sub AS(op1,op2,opcode,sum_sub_ans);
    assign left_shift_ans = op1 << const;

    initial begin
        valid = 3'b000;
        done = 1'b1;
        cycle_count = 0;
        write_data = 0;
        op1 = 0;
        op2 = 0;
        opcode = 0;
    end

    always @(posedge clk) begin
        if(done == 1'b0) begin
            if(instr == 3'b000) begin
                if(cycle_count == 0) begin
                    valid <= 3'b100;
                    write_data <= const;
                end
                if (cycle_count == 1) begin
                    valid <= 3'b000;
                end
                if(cycle_count == 2) begin
                    done <= 1'b1;
                end
            end
            else if(instr == 3'b001) begin
                if (cycle_count == 0) begin
                    valid <= 3'b001;
                end
                if (cycle_count == 1) begin
                    valid <= 3'b000;
                end
                if (cycle_count == 2) begin
                    done <= 1'b1;
                end
            end
            else if(instr == 3'b010) begin
                if (cycle_count == 0) begin
                    valid <= 3'b011;
                end
                if (cycle_count == 1) begin
                    valid <= 3'b000;
                end
                if (cycle_count == 2) begin
                    done <= 1'b1;
                end
            end
            else if(instr == 3'b011) begin                
                if (cycle_count == 0) begin
                    valid <= 3'b101;
                    write_data <= const;
                end
                if (cycle_count == 1) begin
                    valid <= 3'b000;
                end
                if (cycle_count == 2) begin
                    done <= 1'b1;
                end
            end
            else if(instr == 3'b100) begin
                if (cycle_count == 0) begin
                    valid <= 3'b111;
                    write_data <= const;
                end
                if (cycle_count == 1) begin
                    valid <= 3'b000;
                end
                if (cycle_count == 2) begin
                    done <= 1'b1;
                end
            end
            else if(instr == 3'b101) begin
                if (cycle_count == 0) begin
                    valid <= 3'b011;
                end
                if (cycle_count == 1) begin
                    valid <= 3'b000;
                end
                if (cycle_count == 3) begin
                    op1 <= read1;
                    op2 <= read2;
                    opcode <= 1'b0;
                end
                if (cycle_count == 19) begin
                    write_data <= sum_sub_ans;
                    op1 <= 0;
                    op2 <= 0;
                    valid <= 3'b100;
                end
                if (cycle_count == 20) begin
                    valid <= 3'b000;
                end
                if(cycle_count == 21) begin
                    done <= 1'b1;
                end
            end
            else if(instr == 3'b110) begin
                if (cycle_count == 0) begin
                    valid <= 3'b011;
                end
                if (cycle_count == 1) begin
                    valid <= 3'b000;
                end
                if (cycle_count == 3) begin
                    op1 <= read1;
                    op2 <= read2;
                    opcode <= 1'b1;
                end
                if (cycle_count == 19) begin
                    write_data <= sum_sub_ans;
                    op1 <= 0;
                    op2 <= 0;
                    valid <= 3'b100;
                end
                if (cycle_count == 20) begin
                    valid <= 3'b000;
                end
                if(cycle_count == 21) begin
                    done <= 1'b1;
                end
            end
            else if(instr == 3'b111) begin
                if (cycle_count == 0) begin
                    valid <= 3'b001;
                end
                if (cycle_count == 1) begin
                    valid <= 3'b000;
                end
                if (cycle_count == 3) begin
                    op1 <= read1;
                end
                if (cycle_count == 19) begin
                    op1 <= 0;
                    write_data <= left_shift_ans;
                    valid <= 3'b100;
                end
                if (cycle_count == 20) begin
                    valid <= 3'b000;
                end
                if(cycle_count == 21) begin
                    done <= 1'b1;
                end
            end

            cycle_count <= cycle_count + 1;
        end
        else begin
            done <= 1'b0;
            cycle_count <= 0;
            write_data <= 0;

            if(instr == 3'b000) begin
                //$display("executed instruction 000");
            end
            else if(instr == 3'b001) begin
                $display("address: %d, value: %d", reg1, read1);
            end
            else if(instr == 3'b010) begin
                $display("address1: %d, value1: %d, address2: %d, value2: %d", reg1, read1, reg2, read2);
            end
            else if(instr == 3'b011) begin
                $display("address: %d, value: %d", reg1, read1);
            end
            else if(instr == 3'b100) begin
                $display("address1: %d, value1: %d, address2: %d, value2: %d", reg1, read1, reg2, read2);
            end
            else if(instr == 3'b101) begin
                $display("address: %d, value: %d", reg3, write_data);
            end
            else if(instr == 3'b110) begin
                $display("address: %d, value: %d", reg3, write_data);
            end
            else if(instr == 3'b111) begin
                $display("address: %d, value: %d", reg3, write_data);
            end
        end
    end

endmodule