module andg(Y,A,B);
    input [3:0] A,B;
    output [4:0] Y;
    and Gp1(Y[0],A[0],B[0]);
    and Gp2(Y[1],A[1],B[1]);
    and Gp3(Y[2],A[2],B[2]);
    and Gp4(Y[3],A[3],B[3]);
    assign Y[4]=1'b0;
endmodule