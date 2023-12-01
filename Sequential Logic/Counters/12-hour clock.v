module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    
    always @(posedge clk)
        begin
            if(reset) 
                begin
                    hh <= {4'd1, 4'd2};
                    mm <= '0;
                    ss <= '0;
                    pm <= 0;
                end
            else if(ena)
                begin
                    if(ss=={4'd5,4'd9})
                        begin
                            ss<='0;
                            if(mm=={4'd5,4'd9})
                                begin
                                    mm <= '0;
                                    if(hh=={{4'd1,4'd2}})
                                        begin
                                            hh <= {4'd0,4'd1};
                                        end
                                    else
                                        hh <= bcd_increment(hh);
                                end
                            else
                                mm <= bcd_increment(mm);
                        end
                    else
                        ss <= bcd_increment(ss);
                    if({hh,mm,ss}=={{4'd1,4'd1},{4'd5,4'd9},{4'd5,4'd9}})
                        pm <= ~pm;
                end
        end

endmodule

function [7:0] bcd_increment (input [7:0]ip);
    begin
        if(ip[3:0]==4'd9)
            begin
                bcd_increment[3:0] = '0;
                if(ip[7:4]==4'd9)
                    bcd_increment[7:4]='0;
                else
                    bcd_increment[7:4] = ip[7:4] + 1; 
            end
        else
            begin
                bcd_increment[3:0] = ip[3:0] + 1;
                bcd_increment[7:4] = ip[7:4];
            end
    end
endfunction
