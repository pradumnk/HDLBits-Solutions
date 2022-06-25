module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output done); //
    
    parameter byte1 = 1, byte2=2, byte3=3, byte4=4;
    reg [2:0] ps, ns;
    // State transition logic (combinational)
    always @(*)
        begin
            case(ps)
                byte1 : ns = in[3]? byte2: byte1;
                byte2 : ns = byte3;
                byte3 : ns = byte4;
                byte4 : ns = in[3]? byte2: byte1;
                default : ns = byte1;
            endcase
        end

    // State flip-flops (sequential)
    always @(posedge clk)
        begin
            if(reset)
                ps <= byte1;
            else
                ps <= ns;
        end
 
    // Output logic
    assign done = ps==byte4;

endmodule
