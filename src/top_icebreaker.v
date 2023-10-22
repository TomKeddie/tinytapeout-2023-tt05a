module top
  (
   input  CLK,
   output P1A1,
   output P1A2,
   output P1A3,
   output P1A4,
   output P1A7,
   output P1A8,
   output P1A9,
   output P1A10,
   output P1B1,
   output P1B2,
   output P1B3,
   output P1B4,
   output P1B7,
   output P1B8
   );

   reg [0:9] rst_counter = 10'b11_1111_1111;

   reg	  rst;

   // POR delay
   always @ (posedge CLK) begin
      if (rst_counter != 0) begin
	 rst <= 1'b1;
	 rst_counter <= rst_counter - 1;
      end else begin
	 rst <= 1'b0;
      end
   end

   vga vga(.clk(CLK), 
	   .rst(rst),
	   .r0(P1A1),
	   .r1(P1A2),
	   .r2(P1A3),
	   .r3(P1A4),
	   .b0(P1A7),
	   .b1(P1A8),
	   .b2(P1A9),
	   .b3(P1A10),
	   .g0(P1B1),
	   .g1(P1B2),
	   .g2(P1B3),
	   .g3(P1B4),
	   .hs(P1B7),
	   .vs(P1B8));
endmodule
