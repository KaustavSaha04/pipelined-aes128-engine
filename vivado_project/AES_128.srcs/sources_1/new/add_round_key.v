module add_round_key (
    input  [127:0] state_in,
    input  [127:0] round_key,
    output [127:0] state_out
);

wire [7:0] s [15:0];
wire [7:0] k [15:0];
wire [7:0] o [15:0];

genvar i;

generate
    for (i = 0; i < 16; i = i + 1) begin : split
        assign s[i] = state_in[127 - 8*i -: 8];
        assign k[i] = round_key[127 - 8*i -: 8];
        assign o[i] = s[i] ^ k[i];
        assign state_out[127 - 8*i -: 8] = o[i];
    end
endgenerate

endmodule