module top_module(
    input clk,
    input in,
    input reset,    // Synchronous reset
    output done
); 
    parameter IDLE=0, START=1, RECEIVE=2, WAIT=3, STOP=4;
    reg [3:0] ps, ns;
    integer i=0;
    
    always @(posedge clk)
        begin
            if(reset)
                ps <= IDLE;
            else
                ps <= ns;
        end
    
    always@(*)
        begin
            case(ps)
                IDLE : ns = in? IDLE: START;
                START : ns = RECEIVE;
                RECEIVE : begin if (i == 8) begin
                    if (in) ns = STOP;
					else ns = WAIT;
				end 
				else ns = RECEIVE; end
                WAIT : begin ns = (in) ? IDLE : WAIT; end
                STOP : begin ns = (in) ? IDLE : START; end
            endcase
        end
    
    always @(posedge clk)
        begin
            if(reset)
                begin
                    done <= 0;
                    i <= 0;
                end
            else
                begin
                    case(ns)
                        RECEIVE : begin done<=0; i<=i+1; end
                        STOP : begin done<=1; i<=0; end
                        default : begin done<=0; i<=0; end
                    endcase
                end
        end
    
endmodule
