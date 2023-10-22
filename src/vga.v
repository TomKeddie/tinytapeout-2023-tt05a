module vga(
	   input  clk,
	   input  rst,
	   output r0,
	   output r1,
	   output r2,
	   output r3,
	   output g0,
	   output g1,
	   output g2,
	   output g3,
	   output b0,
	   output b1,
	   output b2,
	   output b3,
	   output hs,
	   output vs
	   );

   localparam	  max_h = 640;
   localparam	  max_v = 480;

   // 2^10  = 1024
   reg [9:0]	  count_h;
   // 2^9 = 512
   reg [8:0]	  count_v;
   reg		  red;
   reg		  grn;
   reg		  blu;
   reg		  hs_out;
   reg		  vs_out;

   assign r0 = red;
   assign r1 = red;
   assign r2 = red;
   assign r3 = red;
   assign b0 = blu;
   assign b1 = blu;
   assign b2 = blu;
   assign b3 = blu;
   assign g0 = grn;
   assign g1 = grn;
   assign g2 = grn;
   assign g3 = grn;
   assign hs = hs_out;
   assign vs = vs_out;

   always @ (posedge clk) begin
      if (rst) begin
         count_h <= 0;
	 count_v <= 0;
	 red <= 1'b0;
	 grn <= 1'b0;
	 blu <= 1'b0;
      end else if (count_h != max_h) begin
	 hs_out <= 1'b0;
	 vs_out <= 1'b0;
         count_h <= count_h + 1;
      end else begin
         count_h <= 0;
	 hs_out <= 1'b1;
         if (count_v != max_v) begin
            count_v <= count_v + 1;
         end else begin
            count_v <= 0;
	    vs_out <= 1'b1;
         end
      end
   end


endmodule
