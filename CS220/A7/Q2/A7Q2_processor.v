`define OUTPUT_REG 5    // register containing final answer.
`define PROP_DELAY #2   // propositional delay
`define MAX_PC 7        // total number of instructions

// module for processor

module processor();

    reg clk;    // clock

    reg [2:0] state;            // stores states of instruction execution
    reg [1:0] state_counter;    // counts cycles during a state
    reg [2:0] ip;               // instruction pointer
    wire [31:0] instruction;    // instruction recieved from module
    reg [31:0] instr;           // stores current instruction
    reg instr_valid;            // stores whether instruction is valid or not

    memory instructions(ip, instruction);   // module for instructions

    reg instr_type; // 0 -> R, 1-> I    // stores type of instruction

    // R-format instructions
    wire [5:0] opcode;
    wire [4:0] rs,rt,rd,sh_amt;
    wire [5:0] func;

    assign opcode = instr[31:26];
    assign rs = instr[25:21];
    assign rt = instr[20:16];
    assign rd = instr[15:11];
    assign sh_amt = instr[10:6];
    assign func = instr[5:0];

    // I-format instructions
    wire [15:0] immediate;

    assign immediate = instr[15:0];

    // variables for register file.
    reg [2:0] valid;
    reg [4:0] read_addr_1, read_addr_2, write_addr;
    reg [7:0] write_data;
    wire [7:0] read_1, read_2;

    // register file instantiation
    register_file rfile(clk, valid, read_addr_1, read_addr_2, write_addr, write_data, read_1, read_2);

    // variables for operation
    reg [7:0] op1,op2;
    reg add_sub_opcode;
    wire [7:0] res;

    // instantiation of eight bit adder-subtracter
    eight_bit_add_sub add_sub(op1, op2, add_sub_opcode, res);

    // initialising variables
    initial begin
        state = 0;
        state_counter = 0;
        ip = 0;
        valid = 3'b000;
    end

    initial begin							// Implementing clock
        forever begin
            clk = 0;
            #5 clk = 1;
            #5 clk = 0;
        end
    end

    always @(posedge clk) begin
        if(state==0) begin
            instr <= `PROP_DELAY instruction;
            ip <= `PROP_DELAY ip+1;
            state <= `PROP_DELAY state + 1;
        end
        if(state==1) begin
            if(opcode == 0) begin
                instr_type <= 0;
            end
            else begin
                instr_type <= 1;
            end
            state <= `PROP_DELAY state+1;
        end
        if(state==2) begin
            if(state_counter == 0) begin
                if(instr_type == 0) begin
                    valid <= `PROP_DELAY 3'b011;
                    read_addr_1 <= `PROP_DELAY rs;
                    read_addr_2 <= `PROP_DELAY rt;
                end
                if(instr_type == 1) begin
                    valid <= `PROP_DELAY 3'b010;
                    read_addr_1 <= `PROP_DELAY rs;
                end
                state_counter <= `PROP_DELAY state_counter + 1;
            end
            if(state_counter == 1) begin
                valid <= `PROP_DELAY 3'b000;
                state_counter <= `PROP_DELAY state_counter + 1;
            end
            if(state_counter == 2) begin
                op1 <= `PROP_DELAY read_1;
                if(instr_type == 0) begin
                    op2 <= `PROP_DELAY read_2;
                end
                if(instr_type == 1) begin
                    op2 <= `PROP_DELAY immediate[7:0];
                end
                state_counter <= `PROP_DELAY 0;
                state <= `PROP_DELAY 3;
            end
        end
        if(state==3) begin
            if(instr_type == 0 && func == 6'b010101) begin
                add_sub_opcode <= `PROP_DELAY 1'b0;
                instr_valid <= `PROP_DELAY 1'b1;
            end
            else if(instr_type == 0 && func == 6'b010111) begin
                add_sub_opcode <= `PROP_DELAY 1'b1;
                instr_valid <= `PROP_DELAY 1'b1;
            end
            else if(instr_type == 1 && opcode == 6'b001001) begin
                add_sub_opcode <= `PROP_DELAY 1'b0;
                instr_valid <= `PROP_DELAY 1'b1;
            end
            else begin
                instr_valid <= `PROP_DELAY 1'b0;
            end
            state <= `PROP_DELAY state+1;
        end
        if(state==4) begin            
            if(state_counter == 0) begin
                if(instr_valid == 1 && instr_type == 0 && rd != 0) begin
                    valid <= `PROP_DELAY 3'b100;
                    write_addr <= `PROP_DELAY rd;
                    write_data <= `PROP_DELAY res;
                end
                else if(instr_valid == 1 && instr_type == 1 && rt != 0) begin
                    valid <= `PROP_DELAY 3'b100;
                    write_addr <= `PROP_DELAY rt;
                    write_data <= `PROP_DELAY res;
                end
                state_counter <= `PROP_DELAY state_counter + 1;
            end
            if(state_counter == 1) begin
                // $display("time: %d, instr: %b, opcode: %d, op1: %d, op2: %d, result: %d", $time, instr, opcode, op1, op2, res);
                valid <= 3'b000;
                state_counter <= `PROP_DELAY 0;
                if(ip == `MAX_PC) begin
                    state <= `PROP_DELAY state+1;
                end
                else begin
                    state <= 0;
                end
            end
        end
        if(state==5) begin
            if(state_counter == 0) begin
                valid <= `PROP_DELAY 3'b010;
                read_addr_1 <= `PROP_DELAY `OUTPUT_REG;
                state_counter <= `PROP_DELAY state_counter + 1;
            end
            if(state_counter == 1) begin
                valid <= 3'b000;
                state_counter <= `PROP_DELAY state_counter + 1;
            end
            if(state_counter == 2) begin
                $display("time: %d, answer: %d", $time, read_1);
                $finish;
            end
        end
    end

endmodule