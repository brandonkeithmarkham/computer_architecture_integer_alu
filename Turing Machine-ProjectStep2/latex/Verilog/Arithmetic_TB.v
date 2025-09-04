// Code your testbench here
// or browse Examples
//`timescale 1ns / 1ps

module testbench;

  // Parameters
  parameter BENCHWIDTH = 4 ;
  //*********************^ *****
//REGISTER SIZE PARAMETER!
//Scale to 4, 8, 16, 32 for extra credit criteria.
  
  // Inputs
  reg [BENCHWIDTH-1 : 0] a;
  reg [BENCHWIDTH-1 : 0] b;
  reg carryin;
  
  // Outputs
  wire [BENCHWIDTH-1 : 0] MSB_Product;
  wire  [BENCHWIDTH-1 : 0] LSB_Product;
  wire  [BENCHWIDTH-1 : 0] Quotient;
  wire  [BENCHWIDTH-1 : 0] Remainder;
  wire  [BENCHWIDTH-1 : 0] Difference;
  wire  CarryOut_Difference;
  wire  [BENCHWIDTH-1 : 0] Sum;
  wire  CarryOut_Sum;
  wire  [BENCHWIDTH-1 : 0] Shift_Subject;
  wire  [BENCHWIDTH-1 : 0] Shift_Overflow;
  
  wire	[BENCHWIDTH-1 : 0]	AND_out;
  wire	[BENCHWIDTH-1 : 0]	NAND_out;
  wire	[BENCHWIDTH-1 : 0]	OR_out;
  wire	[BENCHWIDTH-1 : 0]	NOR_out;
  wire	[BENCHWIDTH-1 : 0]	XOR_out;
  wire	[BENCHWIDTH-1 : 0]	XNOR_out;
  wire	[BENCHWIDTH-1 : 0]	NOT_out;
  
  multibit_AND	#(.WIDTH(BENCHWIDTH)) and0	( .a(a), .b(b), .out(AND_out)	);
  multibit_NAND	#(.WIDTH(BENCHWIDTH)) nand0	( .a(a), .b(b), .out(NAND_out)	);
  multibit_OR	#(.WIDTH(BENCHWIDTH)) or0	( .a(a), .b(b), .out(OR_out)	);
  multibit_NOR	#(.WIDTH(BENCHWIDTH)) nor0	( .a(a), .b(b), .out(NOR_out)	);
  multibit_XOR	#(.WIDTH(BENCHWIDTH)) xor0	( .a(a), .b(b), .out(XOR_out)	);
  multibit_XNOR	#(.WIDTH(BENCHWIDTH)) xnor0	( .a(a), .b(b), .out(XNOR_out)	);
  multibit_NOT	#(.WIDTH(BENCHWIDTH)) not0	( .a(a),        .out(NOT_out)	);
  
  // Instantiate the modules
  binaryMultiplier	#(.WIDTH(BENCHWIDTH)) mult_inst	(.a(a), .b(b), .MSB(MSB_Product), .LSB(LSB_Product));
  binaryDivider		#(.WIDTH(BENCHWIDTH)) div_inst	(.a(a), .b(b), .ans(Quotient), .rem(Remainder));
  binarySubtractor	#(.WIDTH(BENCHWIDTH)) sub_inst	(.a(a), .b(b), .carryin(carryin), .out(Difference), .carryout(CarryOut_Difference));
  binaryAdder		#(.WIDTH(BENCHWIDTH)) add_inst	(.a(a), .b(b), .carryin(carryin), .out(Sum), .carryout(CarryOut_Sum));
  multiShift		#(.WIDTH(BENCHWIDTH)) shift_inst	(.in(a), .control(b), .outSubject(Shift_Subject), .outOverflow(Shift_Overflow));
  
  
  
  // Stimulus
  initial begin
    
    // Dump waves to file to be read by wave viewer
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
    // Test vectors
    a = 4'b0000;
    b = 4'b1111;
    carryin = 1'b0;
    #1;
    a = 4'b0101;
    b = 4'b0101;
    carryin = 1'b1;
    #1;
    a = 4'b0101;
    b = 4'b1010;
    carryin = 1'b0;
    #1;
    a = 4'b1010;
    b = 4'b1010;
    carryin = 1'b1;
    #1;
    a = 4'b0011;
    b = 4'b0110;
    carryin = 1'b0;
    #1;
    a = 4'b0011;
    b = 4'b1100;
    carryin = 1'b1;
    #40;
    
  end

endmodule
