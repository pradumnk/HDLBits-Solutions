module top_module(
    input clk,
    input areset,    // Freshly brainwashed Lemmings walk left.
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging ); 
    
    parameter left=0, right=1, left_aah=2, right_aah=3, down_left=4, down_right=5;
    reg [2:0] ps, ns;
    
    always @(*)
        begin
            case(ps)
                left : begin
                    if(ground)
                        ns = dig?down_left:(bump_left?right:left);
                    else
                        ns = left_aah;
                end
                right : begin
                    if(ground)
                        ns = dig?down_right:(bump_right?left:right);
                    else
                        ns = right_aah;
                end
                left_aah : begin
                    if(ground)
                        ns = left;
                    else
                        ns = left_aah;
                end
                right_aah : begin
                    if(ground)
                        ns = right;
                    else
                        ns = right_aah;
                end
                down_left : begin
                    if(ground)
                        ns = down_left;
                    else
                        ns = left_aah;
                end
                down_right : begin
                    if(ground)
                        ns = down_right;
                    else
                        ns = right_aah;
                end
            endcase
        end
    
    always @(posedge clk, posedge areset)
        begin
            if(areset)
                ps <= left;
            else
                ps <= ns;
        end
    
    assign walk_left = ps==left;
    assign walk_right = ps==right;
    assign aaah = (ps==left_aah)|(ps==right_aah);
    assign digging = (ps==down_left)|(ps==down_right);
    

endmodule
