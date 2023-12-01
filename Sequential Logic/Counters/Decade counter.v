module top_module (
    input clk,
    input reset,        // Synchronous active-high reset
    output [3:0] q);
    
    always @(posedge clk)
        q <= reset || (q==4'd9) ? 0 : q+4'd1 ;

endmodule
