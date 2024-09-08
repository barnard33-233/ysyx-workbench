module example(
    input a,
    input b,
    output f
);
  initial begin $display("Hello!");$finish; end
  assign f = a^b;
endmodule
