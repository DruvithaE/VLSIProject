`include "addsub.v"
`include "andg.v"
`include "comp.v"
`include "fulladder.v"


module mux(Y, S0, S1, a, b, enable);
    input S0, S1,enable;
    input [3:0] a, b;
    output reg [4:0] Y;
    wire [4:0] y1,y2,y3;
    addsub x(S0,a,b,y1);
    comp c(y2,a,b);
    andg cf(y3,a,b);
    always @* begin
        if (!S1 && enable) begin
            Y = y1;
        end
        else if (!S0 && S1 && enable) begin
            Y = y2;
        end
        else if (S0 && S1 && enable) begin
            Y = y3;
        end
        else begin
            Y = 5'b00000;
        end
    end
endmodule
