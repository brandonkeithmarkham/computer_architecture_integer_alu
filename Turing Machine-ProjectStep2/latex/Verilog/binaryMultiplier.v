module binaryMultiplier 
  #(parameter WIDTH = 4) (
    input [WIDTH-1 : 0] a,
    input [WIDTH-1 : 0] b,
    output [WIDTH-1 : 0] MSB,
    output [WIDTH-1 : 0] LSB );
  
  reg [(2*WIDTH)-1 : 0] ans;
  
  always @(*) begin
    
    ans = a * b;
    
  end
  
  assign LSB = ans[WIDTH-1 : 0];
  assign MSB = ans[(2*WIDTH)-1 : WIDTH];
  
endmodule