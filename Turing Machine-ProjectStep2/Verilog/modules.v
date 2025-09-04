// 1.a Code 4-bit binary logic functions: And, Nand, Or, Nor, Xor, Xnor, Not.

module multibit_AND
  #(parameter WIDTH = 4) (
    input [WIDTH-1 : 0] a,	input [WIDTH-1 : 0] b,
    output [WIDTH-1 : 0] out);
  assign out = a & b;
endmodule

module multibit_NAND
  #(parameter WIDTH = 4) (
    input [WIDTH-1 : 0] a,	input [WIDTH-1 : 0] b,
    output [WIDTH-1 : 0] out);
  assign out = ~(a & b);
endmodule

module multibit_OR
  #(parameter WIDTH = 4) (
    input [WIDTH-1 : 0] a,	input [WIDTH-1 : 0] b,
    output [WIDTH-1 : 0] out);
  assign out = a | b;
endmodule

module multibit_NOR
  #(parameter WIDTH = 4) (
    input [WIDTH-1 : 0] a,	input [WIDTH-1 : 0] b,
    output [WIDTH-1 : 0] out);
  assign out = ~(a | b);
endmodule

module multibit_XOR
  #(parameter WIDTH = 4) (
    input [WIDTH-1 : 0] a,	input [WIDTH-1 : 0] b,
    output [WIDTH-1 : 0] out);
  assign out = a ^ b;
endmodule

module multibit_XNOR
  #(parameter WIDTH = 4) (
    input [WIDTH-1 : 0] a,	input [WIDTH-1 : 0] b,
    output [WIDTH-1 : 0] out);
  assign out = a ~^ b;
endmodule

module multibit_NOT
  #(parameter WIDTH = 4) (
    input [WIDTH-1 : 0] a,
    output [WIDTH-1 : 0] out);
  assign out = ~a;
endmodule


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
//------------------------------Module Divider------------------------------
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

//------------------------------Module Divider------------------------------

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

//------------------------------Module Divider------------------------------

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

//------------------------------Module Divider------------------------------

module multiShift
  #(parameter WIDTH = 4) (
    input [WIDTH-1 : 0] in,
    input [WIDTH-1 : 0] control,
    output reg [WIDTH-1 : 0] outSubject,
    output reg [WIDTH-1 : 0] outOverflow );
  
  reg [(2*WIDTH)-1 : 0] ans;
  
  wire dir  = control[WIDTH-1];	// 1 <-- left ; right --> 0
  wire fill = control[0];
  wire [WIDTH-1 - 2 : 0] amt = control[WIDTH-1 - 1 : 1];
  
  integer i;
  
  always @(*) begin
    $display("in = %b, control = %b, dir = %b, fill = %b, amt = %b", in, control, dir, fill, amt);
    if (dir) begin
      ans = in << amt;
      $display("ans shifted = %b", ans);
      if(amt>0) begin
        for (i = 0; i < amt; i = i+1) begin
          ans[i] = fill;
        end
      end
      $display("ans filled  = %b", ans);
      outSubject  = ans[WIDTH-1 : 0];
      outOverflow = ans[(2*WIDTH)-1 : WIDTH];
    end
    else begin
      ans = in << WIDTH;
      $display("ans before  = %b", ans);
      ans = ans >> amt;
      $display("ans shifted = %b", ans);
      if(amt>0) begin
        for(i = 0; i < amt; i = i+1) begin
          ans[(2*WIDTH-1) - i] = fill;
        end
      end
      $display("ans filled  = %b", ans);
      outSubject  = ans[(2*WIDTH)-1 : WIDTH];
      outOverflow = ans[WIDTH-1 : 0];
    end
    
  end
  
  
endmodule