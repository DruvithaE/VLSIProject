
module comp(Y,A,B);
    input [3:0] A,B;
    output [4:0] Y;
    wire I0,I1,I2,I3;
    wire a0,a1,a2,a3;
    wire b0,b1,b2,b3;
    and G1(a0,A[0],B[0]);
    and G2(a1,A[1],B[1]);
    and G3(a2,A[2],B[2]);
    and G4(a3,A[3],B[3]);
    wire ab0,ab1,ab2,ab3;
    wire hl0,hl1,hl2,hl3;
    xor f(ab0,A[0],1);
    xor fg(ab1,A[1],1);
    xor fh(ab2,A[2],1);
    xor fj(ab3,A[3],1);
    xor bd(hl1,B[1],1);
    xor cv(hl0,B[0],1);
    xor cd(hl2,B[2],1);
    xor h(hl3,B[3],1);
    and df(b0,hl0,ab0);
    and dfd(b1,hl1,ab1);
    and ffg(b2,hl2,ab2);
    and hgf(b3,hl3,ab3);
    or dfg(I0,a0,b0);
    or dfgf(I1,a1,b1);
    or dgfg(I2,a2,b2);
    or jfhg(I3,a3,b3);
    assign Y[4]=1'b0;
    assign Y[3] = 1'b0;
    wire p31,p32,p33,p34;
    and hn(p31,A[3],hl3);
    and hf(p32,A[2],hl2,I3);
    and vbb(p33,A[1],hl1,I3,I2);
    and cfd(p34,A[0],hl0,I3,I2,I1);
    or dfcv(Y[2],p31,p32,p33,p34);
    and FGB(Y[1],I0,I1,I2,I3);
    wire y1l,y2l;
    xor hufh(y1l,Y[1],1);
    xor fvb(y2l,Y[2],1);
    and SDF(Y[0],y1l,y2l);



endmodule