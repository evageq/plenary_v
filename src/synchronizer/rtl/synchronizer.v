module synchronizer(
    input clk,
    input d, 

    output out
);
    
reg a, b;

initial begin
    a = 0;
    b = 0;
end

always@ (posedge clk) begin
    a <= d;
    b <= a;
end

assign out = b;

endmodule
