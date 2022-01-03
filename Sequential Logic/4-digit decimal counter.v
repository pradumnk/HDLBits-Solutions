module top_module (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q);
    
    genvar i;
    bcd_counter first (clk, reset, 1, q[3 : 0]);
    generate
        for(i=1;i<4;i=i+1) begin : abc
            bcd_counter inst (clk, reset, ena[i], q[4*i+3 -: 4]);
        end
    endgenerate
    
    assign ena = {(q[11:8]==4'd9 && q[7:4]==4'd9 && q[3:0]==4'd9), (q[7:4]==4'd9 && q[3:0]==4'd9), (q[3:0]==4'd9)};

endmodule

module bcd_counter(input clk, reset, ena, output [3:0] q);
    always @(posedge clk)
        begin
            if(reset)
                q <= '0;
            else if(ena)
                begin
                    q <= (q==4'd9)?'0:q+1; 
                end
        end
endmodule
