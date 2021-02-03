module rotate_top;
    wire [3:0] out;
    reg clk;

    M rotate(out, clk);
    always @(out) begin
        $display("time = %d, %b", $time, out);
    end

    initial begin
        #310000 $finish;
    end

    initial begin
        forever begin
            clk = 0;
            #5
            clk = 1;
            #5
            clk = 0;
        end
    end
endmodule