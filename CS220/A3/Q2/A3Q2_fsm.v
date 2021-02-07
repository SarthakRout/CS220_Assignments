// module for FSM.

module FSM(inp, out, clk);
    // inp recieves input.
    // clk represents tha clock.
    input inp, clk;

    // out stores the required output.
    output reg out;

    // init=1 when FSM just started and init=0 afterwards.
    // seq stores the sequence.
    // counter stores clock cycle.
    reg init, seq, counter;

    // initialise the registers.
    initial begin
        init = 1;
        seq = 0;
        counter = 0;
        out = 1;
    end

    always @(posedge clk) begin
        if (counter == 0) begin // gives input 2 clock cycle time.
            seq <= inp;
            if (init == 0) begin
                out <= out & (inp ^ seq);
            end
            else begin
                init <= 0;
            end
            counter <= 1;
        end
        else begin
            counter <= 0;
        end
    end
endmodule