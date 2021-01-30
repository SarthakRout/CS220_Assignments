module priority_encoder8to3_top;
    reg [7:0] inp;
    wire [2:0] out;

    priority_encoder8to3 ENCODER (inp, out);

    always @(inp or out) begin
        $display("time = %d, %b = %d", $time, inp, out);
    end

    initial begin
        #10
        $finish;
    end

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
    end
endmodule