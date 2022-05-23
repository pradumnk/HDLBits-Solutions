module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah ); 
    
    parameter LEFT = 0, RIGHT = 1, LEFT_aah = 2, RIGHT_aah = 3;
    reg [2:0] ps, ns;
    
    always @(*)
        begin
            case(ps)
                LEFT : begin
                    if(ground)
                        ns = (bump_left)?RIGHT:LEFT;
                    else
                        ns = LEFT_aah;
                end
                RIGHT : begin
                    if(ground)
                        ns = (bump_right)?LEFT:RIGHT;
                    else
                        ns = RIGHT_aah;
                end
                LEFT_aah : begin
                    if(ground)
                        ns = LEFT;
                    else
                        ns = LEFT_aah;
                end
                RIGHT_aah : begin
                    if(ground)
                        ns = RIGHT;
                    else
                        ns = RIGHT_aah;
                end
            endcase
        end
    
    always @(posedge clk, posedge areset)
        begin
            if(areset)
                ps <= LEFT;
            else
                ps <= ns;
        end
    
    assign walk_left = ps==LEFT;
    assign walk_right = ps==RIGHT;
    assign aaah = ps==LEFT_aah | ps==RIGHT_aah;

endmodule
