module fulladder(s,c,a,b,d);
    output s,c;
    input a,b,d;
    wire s0;
    xor G1(s0,a,b);
    xor G2(s,s0,d);
    wire p,h;
    and G3(p,a,b);
    and G4(h,s0,d);
    xor G5(c,p,h);
endmodule
