`define OUTPUT_REG 4    // register containing final answer.
`define PROP_DELAY #2   // propositional delay
`define MAX_PC 11        // total number of instructions

// module for processor

module processor();

    reg clk;    // clock

    reg [2:0] state;            // stosum states of instruction execution
    reg [1:0] state_counter;    // counts cycles during a state
    reg signed [7:0] ip;               // instruction pointer
    wire [31:0] instruction;    // instruction recieved from module
    reg [31:0] instr;           // stosum current instruction
    reg instr_valid;            // stosum whether instruction is valid or not

    memory instructions(ip, instruction);   // module for instructions

    reg [1:0] instr_type; // 0 -> R, 1-> I, 2-> J    // stosum type of instruction

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

    // J-format instructions
    wire [7:0] jump;

    assign jump = instr[7:0];

    // variables for register file.
    reg [2:0] valid;
    reg [4:0] read_addr_1, read_addr_2, write_addr;
    reg [7:0] write_data;
    wire [7:0] read_1, read_2;

    // register file instantiation
    register_file rfile(clk, valid, read_addr_1, read_addr_2, write_addr, write_data, read_1, read_2);

    // variables for add/sub
    reg [7:0] op1,op2;
    reg add_sub_opcode;
    wire [7:0] sum;

    // instantiation of eight bit adder-subtracter
    eight_bit_add_sub add_sub(op1, op2, add_sub_opcode, sum);

    // variables for comp
    wire less, eq;

    // instantiation of eight bit comparator
    assign less = $signed(op1) < $signed(op2);
    assign eq = $signed(op1) == $signed(op2);

    // variables for data
    wire [1:0] data_index;
    wire [7:0] data_out;

    assign data_index = sum[1:0];
    
    // instantiation of data
    data arr(data_index, data_out);

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
            else if(opcode == 3) begin
                instr_type <= 2;
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
                    read_addr_2 <= `PROP_DELAY rt;
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
                    if((opcode == 6'b001001) || (opcode == 6'b100011)) begin
                        op2 <= `PROP_DELAY immediate[7:0];
                    end
                    else if((opcode == 6'b000100) || (opcode == 6'b000101)) begin
                        op2 <= `PROP_DELAY read_2;
                    end
                end
                state_counter <= `PROP_DELAY 0;
                state <= `PROP_DELAY state+1;
            end
        end
        if(state==3) begin
            // R
            if(instr_type == 0) begin
                // slt
                if(func == 6'b101010) begin
                    instr_valid <= `PROP_DELAY 1'b1;
                end
                // addu
                else if(func == 6'b100001) begin
                    add_sub_opcode <= `PROP_DELAY 1'b0;
                    instr_valid <= `PROP_DELAY 1'b1;
                end
                // jr
                else if(func == 6'b001000) begin
                    ip <= `PROP_DELAY op1;
                    instr_valid <= `PROP_DELAY 1'b0;
                end
            end
            // I
            else if(instr_type == 1) begin
                // addiu
                if(opcode == 6'b001001) begin
                    add_sub_opcode <= `PROP_DELAY 1'b0;
                    instr_valid <= `PROP_DELAY 1'b1;
                end
                // beq
                else if(opcode == 6'b000100) begin
                    if(eq == 1) begin
                        ip <= `PROP_DELAY ip-1 + $signed(immediate[7:0]);
                        instr_valid <= `PROP_DELAY 1'b0;
                    end
                end
                // lw
                else if(opcode == 6'b100011) begin
                    add_sub_opcode <= `PROP_DELAY 1'b0;
                    instr_valid <= `PROP_DELAY 1'b0;
                end
                // bne
                else if(opcode == 6'b000101) begin
                    if(eq == 0) begin
                        ip <= `PROP_DELAY ip-1 + $signed(immediate[7:0]);
                        instr_valid <= `PROP_DELAY 1'b0;
                    end
                end
            end
            // J
            else if(instr_type == 2) begin
                // jal
                if(opcode == 6'b000011) begin
                    ip <= `PROP_DELAY immediate[7:0];
                    write_data <= `PROP_DELAY ip;
                    instr_valid <= `PROP_DELAY 1'b1;
                end
            end
            state <= `PROP_DELAY state+1;
        end
        if(state==4) begin
            if(opcode == 6'b100011) begin
                if(state_counter == 0) begin
                    valid <= `PROP_DELAY 3'b100;
                    write_addr <= `PROP_DELAY rt;
                    write_data <= `PROP_DELAY data_out;
                    state_counter <= `PROP_DELAY state_counter+1;
                    // $display("data_out: %d\n", data_out);
                end
                else if(state_counter == 1) begin
                    valid <= `PROP_DELAY 3'b000;
                    state_counter <= `PROP_DELAY 0;
                    state <= `PROP_DELAY state+1;
                end
            end
            else begin
                state <= `PROP_DELAY state+1;
            end
        end
        if(state==5) begin
            if(state_counter == 0) begin
                if(instr_valid == 1) begin
                    if(instr_type == 0 && rd != 0) begin
                        valid <= `PROP_DELAY 3'b100;
                        write_addr <= `PROP_DELAY rd;
                        // slt
                        if(func == 6'b101010) begin
                            write_data <= `PROP_DELAY less;
                        end
                        //addu
                        else if(func == 6'b100001) begin
                            write_data <= `PROP_DELAY sum;
                        end
                    end
                    // addiu
                    if(opcode == 6'b001001 && rt != 0) begin
                        valid <= `PROP_DELAY 3'b100;
                        write_addr <= `PROP_DELAY rt;
                        write_data <= `PROP_DELAY sum;
                    end
                    // jal
                    else if(opcode == 6'b000011) begin
                        valid <= `PROP_DELAY 3'b100;
                        write_addr <= `PROP_DELAY 5'b11111;
                    end
                end
                state_counter <= `PROP_DELAY state_counter + 1;
            end
            if(state_counter == 1) begin
                // $display("time: %d, ip: %d, instr: %b, opcode: %d, op1: %d, op2: %d, sum: %d", $time, ip, instr, opcode, op1, op2, sum);
                valid <= 3'b000;
                state_counter <= `PROP_DELAY 0;
                if(ip == `MAX_PC) begin
                    state <= `PROP_DELAY state+1;
                end
                else begin
                    state <= `PROP_DELAY 0;
                end
            end
        end
        if(state==6) begin
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