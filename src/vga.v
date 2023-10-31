
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
  localparam	  h_frontporch = 640 + 16;
  localparam	  h_sync       = 640 + 16 + 96;
  localparam	  h_backporch  = 640 + 16 + 96 + 47;

  // while h_sync is being sent, vertical counts h_sync pulses, for
  // porch and sync, it counts clocks
  localparam	  v_visible    = 480;
  localparam	  v_frontporch = 480 + 22;
  localparam	  v_sync       = 480 + 22 + 3;
  localparam	  v_backporch = 480 + 22 + 3 + 1;

  wire            blank;
  reg             blank_h;
  reg             blank_v;

  assign blank = (blank_h | blank_v);

  // 2^10  = 1024
  reg [9:0]       count_h;
  // 2^15 = 32768
  reg [14:0]      count_v;

  

  reg             red;
  reg             grn;
  wire            blu;
  wire            wht;
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
  assign hs = !hs_out;
  assign vs = !vs_out;

  always @ (posedge clk) begin
    if (rst) begin
      red <= 1'b0;
      grn <= 1'b0;
    end else begin
      red <= wht;
      grn <= wht;
    end
  end

  assign blu = (blank) ? 1'b0 : 1'b1;

  assign wht = (blank) ? 1'b0 :
               (count_h > 317 && count_h < 323 && count_v[4] == 1'b0) ? 1'b1 :
               1'b0;

  always @ (posedge clk) begin
    hs_out <= 1'b0;
    if (rst) begin
      count_h <= 10'b11_1111_1111;
      blank_h <= 1'b1;
    end else if (count_h < h_visible) begin
	  // horizontal visible
      count_h <= count_h + 1;
    end else if (count_h < h_frontporch) begin
	  // horizontal front porch
      count_h <= count_h + 1;
      blank_h <= 1'b1;
    end else if (count_h < h_sync) begin
	  // horizontal sync
      count_h <= count_h + 1;
	  hs_out <= 1'b1;
    end else if (count_h < h_backporch) begin
	  // horizontal back porch
      count_h <= count_h + 1;
    end else begin
      count_h <= 1;
      blank_h <= 1'b0;
    end
  end

  always @ (posedge clk) begin
    if (rst) begin
      count_v              <= 15'b111_1111_1111_1111;
      blank_v              <= 1'b1;
      vs_out               <= 1'b0;
      end else if (count_h >= h_backporch) begin
      if (count_v < v_visible) begin
        count_v <= count_v + 1;
      end else if (count_v < v_backporch) begin
        count_v <= count_v + 1;
        blank_v <= 1'b1;
        if (count_v > v_frontporch && count_v < v_sync) begin
          vs_out <= 1'b1;
        end else begin
          vs_out <= 1'b0;
        end
      end else begin
        count_v <= 1;
        blank_v <= 1'b0;
      end
    end
  end
  
endmodule
