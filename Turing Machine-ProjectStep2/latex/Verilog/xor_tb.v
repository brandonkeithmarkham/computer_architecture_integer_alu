module multibit_XOR
  #(parameter WIDTH = 4) (
    input [WIDTH-1 : 0] a,	input [WIDTH-1 : 0] b,
    output [WIDTH-1 : 0] out);
  assign out = a ^ b;
endmodule