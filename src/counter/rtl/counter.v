module counter #(
    parameter STEP        = 1,
    parameter UPPER_BOUND = 65536,
    parameter SIZE        = $clog2(UPPER_BOUND)
)
(
    input clk,
    input reset,
    input en,

    output reg [SIZE:0] cnt
);

initial begin
    cnt <= {SIZE+1{1'b0}};
end

always @(posedge clk) begin
    if (reset)
        cnt <= {SIZE+1{1'b0}};
    else if (en) 
        cnt <= (cnt + STEP) % UPPER_BOUND;
end

endmodule
