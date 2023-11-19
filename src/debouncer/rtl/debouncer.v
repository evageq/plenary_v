module debouncer (
    input clk,
    input clock_enable,
    input in_signal,

    output out_signal,          // stay high till signal unpressed
    output out_signal_enable    // stays high once, indicates signal pressed at the moment
);

localparam UPPER_BOUND = 512;
localparam SIZE = $clog2(UPPER_BOUND);

wire rst, tmp;

wire synch;
synchronizer synchronizer_i(
    .d(in_signal), 
    .clk(clk),
    .out(synch)
);

reg out_signal_reg        = 0;
reg out_signal_enable_reg = 0;


wire [SIZE-1:0] streak;

counter #(.UPPER_BOUND(UPPER_BOUND)) 
counter_i(
    .clk(clk), 
    .reset(rst), 
    .en(1'b1),

    .cnt(streak)
);

assign out_signal_enable = out_signal_enable_reg;
assign out_signal = out_signal_reg;


assign tmp = (streak == UPPER_BOUND-1) && clock_enable;
assign rst = synch ~^ out_signal_reg;


always @(posedge clk) begin
    out_signal_enable_reg <= tmp & synch;
    if (tmp)
        out_signal_reg <= synch;
    else
        out_signal_reg <= out_signal_reg;
end
endmodule   
