module top_module(
    input clk,
    input in,
    input areset,
    output out); //
    
    reg [1:0] A=0, B=1, C=2, D=3;
    reg [1:0] ps, ns;

    // State transition logic
    always @(*)
        begin
            case(ps)
                A : ns = (in)?B:A;
                B : ns = (in)?B:C;
                C : ns = (in)?D:A;
                D : ns = (in)?B:C;
            endcase
        end

    // State flip-flops with asynchronous reset
    always @(posedge clk, posedge areset)
        begin
            if (areset)
                ps <= A;
            else
                ps <= ns;
        end

    // Output logic
    assign out = (ps==D);

endmodule
