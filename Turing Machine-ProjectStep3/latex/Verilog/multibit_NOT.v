module multibit_NOT
  #(parameter WIDTH = 4) (
    input [WIDTH-1 : 0] a,
    output [WIDTH-1 : 0] out);
  assign out = ~a;
endmodule