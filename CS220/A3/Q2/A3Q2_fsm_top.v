module FSM_top;
    reg inp, clk;   // input and clock
    wire out;       // output

    FSM uut(inp, out, clk);

    always @(clk) begin
        $display("time = %d, input = %d, output = %d", $time, inp, out);
    end

    initial begin
        #100 $finish;
    end

    // clock with period 10 time units and 50% duty cycle.
    initial begin
        forever begin
            clk = 0;
            #5 clk = 1;
            #5 clk = 0;
        end
    end

    // simulating input stream for 10 clock cycles.
    initial begin
        #3 inp = 0;
        #10 inp = 1;
        #10 inp = 0;
        #10 inp = 1;
        #10 inp = 0;
        #10 inp = 0;
        #10 inp = 1;
        #10 inp = 0;
        #10 inp = 1;
        #10 inp = 0;
    end
endmodule