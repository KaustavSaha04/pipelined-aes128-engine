module shift_row ( input [127:0] state_in, output [127:0] state_out );
 // Extract bytes for readability 
 wire [7:0] s [15:0]; wire [7:0] o [15:0]; 
 genvar i; 
 // Split input into bytes
  generate for (i = 0; i < 16; i = i + 1) begin : 
    split assign s[i] = state_in[127-8*i -: 8]; 
    end 
  endgenerate
  // ShiftRows operation 
  // Row 0 (no shift)
   assign o[0] = s[0]; assign o[4] = s[4]; assign o[8] = s[8]; assign o[12] = s[12]; 
  // Row 1 (shift left by 1) 
  assign o[1] = s[5]; assign o[5] = s[9]; assign o[9] = s[13]; assign o[13] = s[1]; 
  // Row 2 (shift left by 2) 
  assign o[2] = s[10]; assign o[6] = s[14]; assign o[10] = s[2]; assign o[14] = s[6]; 
  // Row 3 (shift left by 3)
  assign o[3] = s[15]; assign o[7] = s[3]; assign o[11] = s[7]; assign o[15] = s[11]; 
  // Combine output bytes back into 128-bit 
  generate for (i = 0; i < 16; i = i + 1) begin : 
    combine assign state_out[127-8*i -: 8] = o[i];
    end 
  endgenerate endmodule