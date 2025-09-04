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
//------------------------------Module Divider------------------------------
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
    //$display("in = %b, control = %b, dir = %b, fill = %b, amt = %b", in, control, dir, fill, amt);
    if (dir) begin
      ans = in << amt;
      //$display("ans shifted = %b", ans);
      if(amt>0) begin
        for (i = 0; (i < amt) && (i < WIDTH*2); i = i+1) begin
          ans[i] = fill;
        end
      end
      //$display("ans filled  = %b", ans);
      outSubject  = ans[WIDTH-1 : 0];
      outOverflow = ans[(2*WIDTH)-1 : WIDTH];
    end
    else begin
      ans = in << WIDTH;
      //$display("ans before  = %b", ans);
      ans = ans >> amt;
      //$display("ans shifted = %b", ans);
      if(amt>0) begin
        for(i = 0; (i < amt) && (i < WIDTH*2); i = i+1) begin
          ans[(2*WIDTH-1) - i] = fill;
        end
      end
      //$display("ans filled  = %b", ans);
      outSubject  = ans[(2*WIDTH)-1 : WIDTH];
      outOverflow = ans[WIDTH-1 : 0];
    end
    
  end
  
  
endmodule

module ALU
  #(parameter WIDTH = 4) (
    input [3:0] opcode,
    input [WIDTH-1 : 0] a,
    input [WIDTH-1 : 0] b,
    input carryin,
    output reg [WIDTH-1 : 0] out,
    output reg [WIDTH-1 : 0] extra );
  
  wire [WIDTH-1 : 0] and_out;
  wire [WIDTH-1 : 0] nand_out;
  wire [WIDTH-1 : 0] or_out;
  wire [WIDTH-1 : 0] nor_out;
  wire [WIDTH-1 : 0] xnor_out;
  wire [WIDTH-1 : 0] xor_out;
  wire [WIDTH-1 : 0] not_out;
  
  multibit_AND #(.WIDTH( WIDTH )) alu_AND (
    .a( a ),
    .b( b ),
    .out( and_out ));
  multibit_NAND #(.WIDTH( WIDTH )) alu_NAND (
    .a( a ),
    .b( b ),
    .out( nand_out ));
  multibit_OR #(.WIDTH( WIDTH )) alu_OR (
    .a( a ),
    .b( b ),
    .out( or_out ));
  multibit_NOR #(.WIDTH( WIDTH )) alu_NOR (
    .a( a ),
    .b( b ),
    .out( nor_out ));
  multibit_XOR #(.WIDTH( WIDTH )) alu_XOR (
    .a( a ),
    .b( b ),
    .out( xor_out ));
  multibit_XNOR #(.WIDTH( WIDTH )) alu_XNOR (
    .a( a ),
    .b( b ),
    .out( xnor_out ));
  multibit_NOT #(.WIDTH( WIDTH )) alu_NOT (
    .a( a ),
    .out( not_out ));
  
  
  wire [WIDTH-1 : 0] add_out;
  wire [WIDTH-1 : 0] add_carryout;
  wire [WIDTH-1 : 0] sub_out;
  wire [WIDTH-1 : 0] sub_carryout;
  wire [WIDTH-1 : 0] mul_msb;
  wire [WIDTH-1 : 0] mul_lsb;
  wire [WIDTH-1 : 0] div_ans;
  wire [WIDTH-1 : 0] div_rem;
  
  binaryAdder #(.WIDTH( WIDTH )) alu_add (
    .a( a ),
    .b( b ),
    .carryin( carryin ),
    .out( add_out ),
    .carryout( add_carryout ));
  binarySubtractor #(.WIDTH( WIDTH )) alu_sub (
    .a( a ),
    .b( b ),
    .carryin( carryin ),
    .out( sub_out ),
    .carryout( sub_carryout ));
  binaryMultiplier #(.WIDTH( WIDTH )) alu_mul (
    .a( a ),
    .b( b ),
    .MSB( mul_msb ),
    .LSB( mul_lsb ));
  binaryDivider #(.WIDTH( WIDTH )) alu_div (
    .a( a ),
    .b( b ),
    .ans( div_ans ),
    .rem( div_rem ));
  
  wire [WIDTH-1 : 0] shf_sub;
  wire [WIDTH-1 : 0] shf_ovr;
  multiShift #(.WIDTH( WIDTH )) alu_shf (
    .in( a ),
    .control( b ),
    .outSubject( shf_sub ),
    .outOverflow( shf_ovr ));
  
  
  always_comb begin
    
    case(opcode)
      4'b0000	:	out = and_out;
      4'b0001	:	out = or_out;
      4'b0010	:	out = nand_out;
      4'b0011	:	out = nor_out;
      4'b0100	:	out = xor_out;
      4'b0101	:	out = xnor_out;
      4'b0110	:	out = not_out;
      4'b0111	:	begin
        out = add_out;
        extra = add_carryout;
      end
      4'b1000	:	begin
        out = sub_out;
        extra = sub_carryout;
      end
      4'b1001	:	begin
        out = mul_msb;
        extra = mul_lsb;
      end
      4'b1010	:	begin
        out = div_ans;
        extra = div_rem;
      end
      4'b1011	:	begin
        out = shf_sub;
        extra = shf_ovr;
      end
    endcase
    
  end
      
  
  
  
endmodule
    