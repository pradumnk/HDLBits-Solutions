// Note the Verilog-1995 module declaration syntax here:
module top_module(clk, reset, in, out);
    input clk;
    input reset;    // Synchronous reset to state B
    input in;
    output out;//  
    reg out;

    // Fill in state name declarations

    reg present_state, next_state;
    reg B=0, A=1;

    always @(posedge clk) 
        begin
        if (reset) 
            begin  
            // Fill in reset logic
                present_state <= B;
            end
        else 
            begin
            present_state <= next_state;
            end
        end
    always @(*)
        begin
            case (present_state)
                B : next_state = (in)?B:A;
                A : next_state = (in)?A:B;
            endcase
    	end
    assign out = present_state==B;

endmodule
