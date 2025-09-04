module binaryAdder
  #(parameter WIDTH = 4) (
    input [WIDTH-1 : 0] a,
    input [WIDTH-1 : 0] b,
    input carryin,
    output [WIDTH-1 : 0] out,
    output carryout );
  
  reg [WIDTH : 0] ans;
  
  always @(*) begin
    
    ans = a + b + carryin;
    
  end
  
  assign out = ans[WIDTH-1 : 0];
  assign carryout = ans[WIDTH];
  
endmodule
