module top_module (input x, input y, output z);

    wire w1,w2,w3,w4,w5,w6;
    
    SimpleCircuitA A1 (x, y, w1);
    SimpleCircuitA A2 (x, y, w2);
    
    SimpleCircuitB B1 (x, y, w3);
    SimpleCircuitB B2 (x, y, w4);
    
    assign w5 = w1 || w3;
    assign w6 = w2 && w4;
    assign z = w5 ^ w6;
    
endmodule


module SimpleCircuitA (input x, input y, output z);

    assign z = (x ^ y) && x;
endmodule

module SimpleCircuitB ( input x, input y, output z );

    assign z = x ~^ y;
endmodule
