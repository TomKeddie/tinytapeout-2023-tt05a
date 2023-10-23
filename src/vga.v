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

  localparam	  h_visible    = 640;
  localparam	  h_frontporch = 640 + 24;
  localparam	  h_sync       = 640 + 24 + 95;
  localparam	  h_backporch  = 640 + 24 + 95 + 48;

  // while h_sync is being sent, vertical counts h_sync pulses, for
  // porch and sync, it counts clocks
  localparam	  v_visible    = 480;
  localparam	  v_frontporch = 480 + 13847;
  localparam	  v_sync       = 480 + 13847 + 1612;
  localparam	  v_backporch  = 480 + 13847 + 1612 + 504;

  // 2^10  = 1024
  reg [9:0]       count_h;
  // 2^15 = 32768
  reg [14:0]      count_v;
  reg             red;
  reg             grn;
  reg             blu;
  reg             hs_out;
  reg             vs_out;

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
    hs_out <= 1'b0;
    vs_out <= 1'b0;
    if (rst) begin
      count_h <= 10'b1;
	  count_v <= 9'b1;
    end else if (count_h < h_visible) begin
      count_h <= count_h + 1;
	  // horizontal visible
	  red <= 1'b1;
	  grn <= 1'b1;
	  blu <= 1'b1;
    end else if (count_h < h_frontporch) begin
      count_h <= count_h + 1;
	  // horizontal front porch
	  red <= 1'b0;
	  grn <= 1'b0;
	  blu <= 1'b0;
    end else if (count_h < h_sync) begin
      count_h <= count_h + 1;
	  // horizontal sync
	  hs_out <= 1'b1;
	  red <= 1'b0;
	  grn <= 1'b0;
	  blu <= 1'b0;
    end else if (count_h < h_backporch-1) begin
      count_h <= count_h + 1;
	  // horizontal back porch
	  red <= 1'b0;
	  grn <= 1'b0;
	  blu <= 1'b0;
    end else begin
      if (count_v < v_visible) begin
        count_v <= count_v + 1;
	    // vertical visible
        count_h <= 0;
      end else if (count_v < v_frontporch) begin
        count_v <= count_v + 1;
	    // vertical front porch
	    red <= 1'b0;
	    grn <= 1'b0;
	    blu <= 1'b0;
      end else if (count_v < v_sync) begin
        count_v <= count_v + 1;
	    // vertical sync
	    vs_out <= 1'b1;
	    red <= 1'b0;
	    grn <= 1'b0;
	    blu <= 1'b0;
	  end else if (count_v < v_backporch-1) begin
        count_v <= count_v + 1;
	    // vertical back porch
	    red <= 1'b0;
	    grn <= 1'b0;
	    blu <= 1'b0;
	  end else begin
        count_v <= 0;
      end
    end
  end


endmodule
