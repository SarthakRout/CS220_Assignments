// top module for processor

module processor_top;

    reg clk;
    reg [2:0] instr;
    reg [4:0] reg1, reg2, reg3;
    reg [15:0] const;
    wire done;
    reg [3:0] ip;

    processor p(clk, instr, reg1, reg2, reg3, const, done);

    initial begin
        ip = 0;
        instr = 0;
        reg1 = 0;
        reg2 = 0;
        reg3 = 0;
        const = 0;
        if(ip == 10) begin
            #30 $finish;
        end
    end

    initial begin
        forever begin
            clk = 0;
            #5 clk = 1;
            #5 clk = 0;
        end
    end

    always @(posedge clk) begin
        if(done == 1'b1) begin
            if(ip == 0) begin
                instr <= 3'b000;
                reg1 <= 0;
                reg2 <= 0;
                reg3 <= 1;
                const <= 17;
            end
            if(ip == 1) begin
                instr <= 3'b011;
                reg1 <= 1;
                reg2 <= 0;
                reg3 <= 2;
                const <= -9;
            end
            if(ip == 2) begin
                instr <= 3'b100;
                reg1 <= 1;
                reg2 <= 2;
                reg3 <= 3;
                const <= 65;
            end
            if(ip == 3) begin
                instr <= 3'b010;
                reg1 <= 2;
                reg2 <= 3;
                reg3 <= 0;
                const <= 0;
            end
            if(ip == 4) begin
                instr <= 3'b111;
                reg1 <= 3;
                reg2 <= 0;
                reg3 <= 5;
                const <= 3;
            end
            if(ip == 5) begin
                instr <= 3'b101;
                reg1 <= 1;
                reg2 <= 2;
                reg3 <= 4;
                const <= 0;
            end
            if(ip == 6) begin
                instr <= 3'b111;
                reg1 <= 4;
                reg2 <= 0;
                reg3 <= 4;
                const <= 9;
            end
            if(ip == 7) begin
                instr <= 3'b110;
                reg1 <= 5;
                reg2 <= 4;
                reg3 <= 6;
                const <= 0;
            end
            if(ip == 8) begin
                instr <= 3'b001;
                reg1 <= 6;
                reg2 <= 0;
                reg3 <= 0;
                const <= 0;
            end
            if(ip == 9) begin
                $finish;
            end

            ip <= ip+1;
        end
    end

endmodule