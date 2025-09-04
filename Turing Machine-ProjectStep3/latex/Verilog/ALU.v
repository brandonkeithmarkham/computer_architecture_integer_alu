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
    