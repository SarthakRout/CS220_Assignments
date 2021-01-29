module priority_encoder8to3 (inp, out);
    input [7:0] inp;
    output wire [2:0] out;

    assign out[0] = (~inp[0]) & (inp[1] | (~inp[1] & ~inp[2] & (inp[3] | (~inp[3] & ~inp[4] & (inp[5] | (~inp[5] & ~inp[6] & inp[7]))))));
    assign out[1] = ~inp[0] & ~inp[1] & (inp[2] | inp[3] | (~inp[2] & ~inp[3] & ~inp[4] & ~inp[5] & (inp[6] | inp[7])));
    assign out[2] = ~inp[0] & ~inp[1] & ~inp[2] & ~inp[3] & (inp[4] | inp[5] | inp[6] | inp[7]);
endmodule