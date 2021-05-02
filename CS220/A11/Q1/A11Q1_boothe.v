module boothe_multiplier (clk, new_inp, m1, m2, prod, add_op, sub_op, done);

    // inputs
    input clk;
    input new_inp;
    input signed [31:0] m1, m2;

    // outputs
    output reg done;
    output reg signed [63:0] prod;
    output reg [4:0] add_op;
    output reg [4:0] sub_op;

    reg [5:0] counter;
    reg sub_counter;

    reg signed [63:0] a;
    reg signed [31:0] b;
    reg b_;
    wire signed [31:0] c;

    assign c = b+1;

    initial begin
        done <= 1;
        counter <= 0;
        b_ <= 0;
        a <= 0;
        prod <= 0;
        sub_counter <= 0;
        add_op <= 0;
        sub_op <= 0;
    end

    always @(posedge clk) begin
        if(new_inp == 1) begin
            a[31:0] <= m1;
            a[63:32] <= -m1[31];
            b <= m2;
            b_ <= 0;
            prod <= 0;
            done <= 0;
            add_op <= 0;
            sub_op <= 0;
        end
        
        if (done == 0) begin
            if(counter == 31) begin
                done <= 1;
                counter <= 0;
            end
            else begin
                if (sub_counter == 0) begin
                    if(b_ == 0 && b[0] == 1) begin
                        prod <= prod - a;
                        sub_op <= sub_op + 1;
                    end
                    else if(b_ == 1 && b[0] == 0) begin
                        prod <= prod + a;
                        add_op <= add_op + 1;
                    end
                    sub_counter <= 1;
                end
                else begin
                    // $display("time: %d, a: %d, b: %d, prod: %d", $time, a, b, prod);
                    a <= (a<<1);
                    b <= (b>>1)|(b[30]<<31);
                    b_ <= b[0];

                    if ((c==1)|(c==0)) begin
                        counter <= 31;
                    end
                    else begin
                        counter <= counter + 1;
                    end
                    sub_counter <= 0;
                end
            end
        end
    end

endmodule