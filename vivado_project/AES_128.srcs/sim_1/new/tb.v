`timescale 1ns / 1ps

module tb;

    reg clk;
    reg reset;
    reg [127:0] key;
    reg [127:0] state_in;
    wire [127:0] state_out;

    reg [127:0] plaintext_mem [0:15601];
    integer i, out_f;

    design_3_wrapper uut (
        .clk_0(clk),
        .reset_0(reset),
        .key_0(key),
        .state_in_0(state_in),
        .state_out_0(state_out)
    );

    always #1 clk = ~clk;

    initial begin
        clk = 0;
        out_f = $fopen("sim_results.txt", "w");
        
        $readmemh("plaintext.mem", plaintext_mem);
        key = 128'h546869734973413136427974654b6579;

        // Reset Sequence
        reset = 1;
        state_in = 0;
        repeat (5) @(posedge clk);
        reset = 0;
        @(posedge clk);

        $display("Starting Streaming Simulation...");

        // RUN FOR (TOTAL BLOCKS + LATENCY)
        // This loop handles feeding and recording simultaneously
        for (i = 0; i < 15602 + 13; i = i + 1) begin
            @(posedge clk);
            
            // FEED PHASE: Apply input for the first 15602 cycles
            if (i < 15602) begin
                state_in <= plaintext_mem[i];
            end else begin
                state_in <= 0; // Clear input after dataset is done
            end

            // RECORD PHASE: Start recording after the 11-cycle pipeline latency
            // This captures Output 0 at cycle 12, Output 1 at cycle 13, etc.
            if (i >=13) begin
                $fdisplay(out_f, "%h", state_out);
            end
        end

        $fclose(out_f);
        $display("Simulation Finished. Results saved to sim_results.txt");
        $finish;
    end
endmodule