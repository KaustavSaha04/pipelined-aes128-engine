module sub_bytes (input [127:0] state_in, output [127:0] state_out ); 
    genvar i; 
    generate for (i = 0; i < 16; i = i + 1) begin :
        sbox_loop sbox s_inst ( .in (state_in[127-8*i -: 8]),
                                .out (state_out[127-8*i -: 8])); 
      end 
    endgenerate 
endmodule
