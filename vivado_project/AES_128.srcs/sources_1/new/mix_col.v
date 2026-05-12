module mix_col ( input [127:0] state_in, output [127:0] state_out );
 wire [7:0] s [15:0]; wire [7:0] o [15:0]; 
 genvar i; 
 // Split input into bytes generate '
 generate
 for (i = 0; i < 16; i = i + 1) begin : split
     assign s[i] = state_in[127-8*i -: 8];
    end
 endgenerate 
 
 // GF(2^8) multiply by 2 
 function [7:0] xtime; input [7:0] x;
  begin xtime = (x << 1) ^ (8'h1B & {8{x[7]}}); //1B as per GF 
  end endfunction
 // === MixColumns (column-wise) === 
 // Column 0 (s0, s1, s2, s3) 
 assign o[0] = xtime(s[0]) ^ (xtime(s[1]) ^ s[1]) ^ s[2] ^ s[3];
 assign o[1] = s[0] ^ xtime(s[1]) ^ (xtime(s[2]) ^ s[2]) ^ s[3];
 assign o[2] = s[0] ^ s[1] ^ xtime(s[2]) ^ (xtime(s[3]) ^ s[3]);
 assign o[3] = (xtime(s[0]) ^ s[0]) ^ s[1] ^ s[2] ^ xtime(s[3]); 
 // Column 1 (s4, s5, s6, s7)
 assign o[4] = xtime(s[4]) ^ (xtime(s[5]) ^ s[5]) ^ s[6] ^ s[7]; 
 assign o[5] = s[4] ^ xtime(s[5]) ^ (xtime(s[6]) ^ s[6]) ^ s[7];
 assign o[6] = s[4] ^ s[5] ^ xtime(s[6]) ^ (xtime(s[7]) ^ s[7]);
 assign o[7] = (xtime(s[4]) ^ s[4]) ^ s[5] ^ s[6] ^ xtime(s[7]); 
 // Column 2 (s8, s9, s10, s11)
 assign o[8] = xtime(s[8]) ^ (xtime(s[9]) ^ s[9]) ^ s[10] ^ s[11];
 assign o[9] = s[8] ^ xtime(s[9]) ^ (xtime(s[10]) ^ s[10]) ^ s[11];
 assign o[10] = s[8] ^ s[9] ^ xtime(s[10]) ^ (xtime(s[11]) ^ s[11]);
 assign o[11] = (xtime(s[8]) ^ s[8]) ^ s[9] ^ s[10] ^ xtime(s[11]); 
 // Column 3 (s12, s13, s14, s15) 
 assign o[12] = xtime(s[12]) ^ (xtime(s[13]) ^ s[13]) ^ s[14] ^ s[15]; 
 assign o[13] = s[12] ^ xtime(s[13]) ^ (xtime(s[14]) ^ s[14]) ^ s[15];
 assign o[14] = s[12] ^ s[13] ^ xtime(s[14]) ^ (xtime(s[15]) ^ s[15]);
 assign o[15] = (xtime(s[12]) ^ s[12]) ^ s[13] ^ s[14] ^ xtime(s[15]); 
 // Combine output
  generate for (i = 0; i < 16; i = i + 1) begin :
     combine assign state_out[127-8*i -: 8] = o[i]; 
     end 
  endgenerate
endmodule
 