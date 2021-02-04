// Top module for testing priority encoder

module priority_encoder8to3_top;
    reg [7:0] inp;
    wire [2:0] out;

    priority_encoder8to3 ENCODER (inp, out);

    always @(inp or out) begin
        $display("time = %0d, Input: %b Output: %d = %b", $time, inp, out, out);
    end

    initial begin
        #10
        $finish;
    end

    // 10 test cases with gap of 1 cycle.
    initial begin
        inp = 8'b00100000;
        #1
        $display("\n");
        inp = 8'b00000000;
        #1
        $display("\n");
        inp = 8'b00010100;
        #1
        $display("\n");
        inp = 8'b11111111;
        #1
        $display("\n");
        inp = 8'b10000001;
        #1
        $display("\n");
        inp = 8'b00001010;
        #1
        $display("\n");
        inp = 8'b01001001;
        #1
        $display("\n");
        inp = 8'b10000000;
        #1
        $display("\n");
        inp = 8'b00001000;
        #1
        $display("\n");
        inp = 8'b10110010;
    end
endmodule