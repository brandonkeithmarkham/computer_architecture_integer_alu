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
