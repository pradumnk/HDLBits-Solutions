module top_module (
    input clk,
    input d,
    output q
);
  reg trig1, trig2;
assign q = trig1^trig2;

  always @(posedge clk) begin
    trig1 <= d^trig2;
  end

  always @(negedge clk) begin
  trig2 <= d^trig1;
  end
    
endmodule
