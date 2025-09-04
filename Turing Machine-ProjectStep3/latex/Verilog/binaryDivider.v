module binaryDivider
  #(parameter WIDTH = 4) (
    input [WIDTH-1 : 0] a,
    input [WIDTH-1 : 0] b,
    output reg [WIDTH-1 : 0] ans,
    output reg [WIDTH-1 : 0] rem );
  
  always @(*) begin
    
    ans = a / b;
    rem = a % b;
    
  end
  
endmodule
