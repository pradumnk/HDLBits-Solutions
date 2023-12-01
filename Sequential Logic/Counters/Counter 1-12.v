module top_module (
    input clk,
    input reset,
    input enable,
    output [3:0] Q,
    output c_enable,
    output c_load,
    output [3:0] c_d
); //
    assign c_enable = enable;
    always @(*)
        begin
            if(reset)
                c_load = 1;
            else if(Q==4'd12 & enable==1)
                c_load = 1;
            else
                c_load =0;
        end
    //assign c_load = (enable==1)? Q==4'd12 : 0 ;
    //assign c_load = reset==1;
    //assign c_load = Q==4'd12 | reset==1;
    assign c_d = 4'd1;
    
    count4 the_counter (clk, enable, c_load, c_d, Q);

endmodule
