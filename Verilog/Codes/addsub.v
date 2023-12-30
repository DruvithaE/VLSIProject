module addsub(input M, input [3:0] A, input [3:0] B, output reg [4:0] Yp);
    wire [3:0] b;
    wire c0, c1, c2,c0p,cl1,c2l;
    wire[4:0] y;
    wire [4:0] k;
    wire [4:0] Yo;
    xor G0(b[0], B[0], M);
    xor G1(b[1], B[1], M);
    xor G2(b[2], B[2], M);
    xor G3(b[3], B[3], M);
    fulladder fa0 (.a(A[0]), .b(b[0]), .d(M), .s(y[0]), .c(c0));
    fulladder fa1 (.a(A[1]), .b(b[1]), .d(c0), .s(y[1]), .c(c1));
    fulladder fa2 (.a(A[2]), .b(b[2]), .d(c1), .s(y[2]), .c(c2));
    fulladder fa3 (.a(A[3]), .b(b[3]), .d(c2), .s(y[3]), .c(y[4]));

    not Gb0(k[0], y[0]);
    not Gb2(k[1], y[1]);
    not Gb3(k[2], y[2]);
    not Gb4(k[3], y[3]);
    not Gb5(k[4], y[4]);
    fulladder gh(.a(k[0]),.b(1'b0),.d(M),.s(Yo[0]),.c(c0p));
    fulladder gh2(.a(k[1]),.b(1'b0),.d(c0p),.s(Yo[1]),.c(cl1));
    fulladder gh1(.a(k[2]),.b(1'b0),.d(cl1),.s(Yo[2]),.c(c2l));
    fulladder gh1h(.a(k[3]),.b(1'b0),.d(c2l),.s(Yo[3]),.c(c3l));
    fulladder g81h(.a(k[4]),.b(1'b0),.d(c3l),.s(Yo[4]),.c(cf3l));
    
    always @ (*) begin
        if (M == 1'b1 && y[4] == 1'b1) begin
            Yp <= 1'b0;
            Yp[3:0] <= y[3:0];
        end
        else if (M == 1'b1 && y[4] == 1'b0) begin
            Yp <= Yo;
        end 
        else begin
            Yp <= y;
        end
    end
    
    
endmodule
