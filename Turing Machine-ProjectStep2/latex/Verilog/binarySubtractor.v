
module binarySubtractor
  #(parameter WIDTH = 4) (
    input [WIDTH-1 : 0] a,
    input [WIDTH-1 : 0] b,
    input carryin,
    output [WIDTH-1 : 0] out,
    output carryout );
  
  reg [WIDTH : 0] ans;
  
  always @(*) begin
    
    ans = {1'b1,a};
    ans = ans - b - carryin;
    
    
  end
  
  assign carryout = ~ans[WIDTH];
  assign out = ans[WIDTH-1 : 0];
  
endmodule
