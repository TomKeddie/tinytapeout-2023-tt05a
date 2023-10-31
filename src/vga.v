
module vga(
	       input  clk,
	       input  rst,
           input  left_up,
           input  left_down,
           input  right_up,
           input  right_down,
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

  localparam      paddle_size = 40;

  wire            blank;
  reg             blank_h;
  reg             blank_v;

  assign blank = (blank_h | blank_v);

  // 2^10  = 1024
  reg [9:0]       count_h;
  // 2^9 = 512
  reg [8:0]       count_v;

  reg [8:0]       pos_l;
  reg [8:0]       pos_r;

  reg             red;
  reg             grn;
  wire            blu;
  wire            wht;
  reg             hs_out;
  reg             vs_out;

  reg             left_up_1d;
  reg             left_down_1d;
  reg             right_up_1d;
  reg             right_down_1d;
  
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
               // dashed net down the centre
               (count_h > 317 && count_h < 323 && count_v[4] == 1'b0) ? 1'b1 :
               // left paddle
               (count_h > 10 && count_h < 16 && count_v > (pos_l-paddle_size/2) && count_v < (pos_l+paddle_size/2)) ? 1'b1 :
               // right paddle
               (count_h > 624 && count_h < 630 && count_v > (pos_r-paddle_size/2) && count_v < (pos_r+paddle_size/2)) ? 1'b1 :
               1'b0;

  // Horizontal
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

  // Vertical
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

  // Paddles
  always @ (posedge clk) begin
    if (rst) begin
      pos_l <= v_visible/2;
      pos_r <= v_visible/2;
    end else begin
      left_up_1d    <= left_up;
      left_down_1d  <= left_down;
      right_up_1d   <= right_up;  
      right_down_1d <= right_down;      
      if (left_up == 1'b1 && left_up_1d == 1'b0) begin
        if (pos_l > paddle_size/2) begin
          pos_l <= pos_l - 1;
        end
      end else if (left_down == 1'b1 && left_down_1d == 1'b0) begin
        if (pos_l < v_visible - paddle_size/2) begin
          pos_l <= pos_l + 1;
        end
      end else if (right_up == 1'b1 && right_up_1d == 1'b0) begin
        if (pos_r > paddle_size/2) begin
          pos_r <= pos_r - 1;
        end
      end else if (right_down == 1'b1 && right_down_1d == 1'b0) begin
        if (pos_r < v_visible - paddle_size/2) begin
          pos_r <= pos_r + 1;
        end
      end
    end
  end
endmodule
