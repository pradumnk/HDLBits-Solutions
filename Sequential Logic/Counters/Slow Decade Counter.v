module top_module (
    input clk,
    input slowena,
    input reset,
    output [3:0] q);
    
    always @(posedge clk)
        begin
            q <= reset ? 0 : (~slowena)?q:(q==4'd9)?0:q+1;
        end

endmodule
