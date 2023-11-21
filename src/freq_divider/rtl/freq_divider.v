module freq_divider #
(
    parameter DIV=2,
    parameter SIZE=$clog2(DIV)
)
(
    input clk,
    input rst,

    output reg divided_clk
);

wire [SIZE-1:0] cnt;

initial begin
    divided_clk <= 0;
end

always@(posedge clk) begin
    divided_clk <= (cnt < DIV / 2) ? 1'b1 : 1'b0;
end

counter #(.UPPER_BOUND(DIV))
counter_i(
    .clk(clk),
    .reset(rst),
    .en(1'b1),

    .cnt(cnt)
);

endmodule

