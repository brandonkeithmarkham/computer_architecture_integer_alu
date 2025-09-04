// Code your testbench here
// or browse Examples

`timescale 1ns / 1ps

module testbench
  #(parameter WIDTH = 32);
  
  reg [3:0] opcode;
  reg [WIDTH-1 : 0] a;
  reg [WIDTH-1 : 0] b;
  reg carryin;
  
  reg [WIDTH-1 : 0] out;
  reg [WIDTH-1 : 0] extra;
  
  ALU #(.WIDTH( WIDTH )) alu (
    .opcode( opcode ),
    .a( a ),
    .b( b ),
    .carryin( carryin ),
    .out( out ),
    .extra( extra ));
  
  integer i;
  
  initial begin
    
    // Dump waves to file to be read by wave viewer
    $dumpfile("dump.vcd");
    $dumpvars(1);
    
    
    for(i = 0; i < 12; i += 1) begin
      opcode = i;
      a = {WIDTH/4{4'b1010}};
      b = {WIDTH/4{4'b0101}};
      carryin = 0;
      #1;
      a = {WIDTH/4{4'b0110}};
      b = {WIDTH/4{4'b0110}};
      carryin = 1;
      #1;
      
    end
    
    
  end
  
endmodule