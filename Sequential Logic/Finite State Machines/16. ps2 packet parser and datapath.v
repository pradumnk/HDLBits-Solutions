module top_module(
    input clk,
    input [7:0] in,
    input reset,    // Synchronous reset
    output [23:0] out_bytes,
    output done); //
    
    parameter byte1 = 0, byte2=1, byte3=2, byte4=3;
    reg [1:0] ps, ns;
    reg [23:0] data;
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
    assign out_bytes = done? data: 24'd0; 
    
    always @(posedge clk)
        begin
            data[23:0] = {data[15:0], in};
        end

endmodule
