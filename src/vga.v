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

  localparam smile001  = 59'b00000000000000000000000000000000000000000000000000010000000;
  localparam smile002  = 59'b00000000000000000000000000000000000000000000000000111000000;
  localparam smile003  = 59'b00000000000000000000000000000000000000000000000000111110000;
  localparam smile004  = 59'b00000000000000000000000000000000000000000000000001111111000;
  localparam smile005  = 59'b00000000000000000000000000000000000000000000000011111111100;
  localparam smile006  = 59'b00000000000000000000000000000000000000000000000111111111110;
  localparam smile007  = 59'b00000000000000000000000000000000000000000000000111111111110;
  localparam smile008  = 59'b00000000000000000000000000000000000000000000001111111111100;
  localparam smile009  = 59'b00000000000000000000000000000000000000000000011111111111100;
  localparam smile010  = 59'b00000000000000000000000000000000000000000000011111111111000;
  localparam smile011  = 59'b00000000000000000000000000000000000000000000111111111110000;
  localparam smile012  = 59'b00000000000000000000000000000000000000000001111111111110000;
  localparam smile013  = 59'b00000000000000000000000000000000000000000001111111111100000;
  localparam smile014  = 59'b00000000000000000000000000000000000000000011111111111100000;
  localparam smile015  = 59'b00000000000000000000000000000000000000000011111111111000000;
  localparam smile016  = 59'b00000000000000000000000000000000000000000111111111110000000;
  localparam smile017  = 59'b00000000000000000000000000000000000000000111111111110000000;
  localparam smile018  = 59'b00000000000000000000000000000000000000001111111111100000000;
  localparam smile019  = 59'b00000000000000000000000000000000000000001111111111100000000;
  localparam smile020  = 59'b00000000000000000000000000000000000000011111111111000000000;
  localparam smile021  = 59'b00000000000000000000000000000000000000011111111111000000000;
  localparam smile022  = 59'b00000000000000000000000000000000000000111111111111000000000;
  localparam smile023  = 59'b00000000000000000000000000000000000000111111111110000000000;
  localparam smile024  = 59'b00000000000000000000000000000000000001111111111110000000000;
  localparam smile025  = 59'b00000000000000000000000000000000000001111111111100000000000;
  localparam smile026  = 59'b00000000000000000000000000000000000001111111111100000000000;
  localparam smile027  = 59'b00000000000000000000000000000000000011111111111100000000000;
  localparam smile028  = 59'b00000111111100000000000000000000000011111111111000000000000;
  localparam smile029  = 59'b00011111111111000000000000000000000011111111111000000000000;
  localparam smile030  = 59'b00111111111111100000000000000000000111111111111000000000000;
  localparam smile031  = 59'b01111111111111110000000000000000000111111111110000000000000;
  localparam smile032  = 59'b11111111111111111000000000000000000111111111110000000000000;
  localparam smile033  = 59'b11111111111111111000000000000000000111111111110000000000000;
  localparam smile034  = 59'b11111111111111111000000000000000001111111111110000000000000;
  localparam smile035  = 59'b11111111111111111100000000000000001111111111100000000000000;
  localparam smile036  = 59'b11111111111111111100000000000000001111111111100000000000000;
  localparam smile037  = 59'b11111111111111111100000000000000001111111111100000000000000;
  localparam smile038  = 59'b11111111111111111000000000000000001111111111100000000000000;
  localparam smile039  = 59'b11111111111111111000000000000000001111111111100000000000000;
  localparam smile040  = 59'b01111111111111111000000000000000011111111111000000000000000;
  localparam smile041  = 59'b01111111111111110000000000000000011111111111000000000000000;
  localparam smile042  = 59'b00111111111111100000000000000000011111111111000000000000000;
  localparam smile043  = 59'b00011111111111000000000000000000011111111111000000000000000;
  localparam smile044  = 59'b00000111111100000000000000000000011111111111000000000000000;
  localparam smile045  = 59'b00000000000000000000000000000000011111111111000000000000000;
  localparam smile046  = 59'b00000000000000000000000000000000011111111111000000000000000;
  localparam smile047  = 59'b00000000000000000000000000000000011111111111000000000000000;
  localparam smile048  = 59'b00000000000000000000000000000000111111111110000000000000000;
  localparam smile049  = 59'b00000000000000000000000000000000111111111110000000000000000;
  localparam smile050  = 59'b00000000000000000000000000000000111111111110000000000000000;
  localparam smile051  = 59'b00000000000000000000000000000000111111111110000000000000000;
  localparam smile052  = 59'b00000000000000000000000000000000111111111110000000000000000;
  localparam smile053  = 59'b00000000000000000000000000000000111111111110000000000000000;
  localparam smile054  = 59'b00000000000000000000000000000000111111111110000000000000000;
  localparam smile055  = 59'b00000000000000000000000000000000111111111110000000000000000;
  localparam smile056  = 59'b00000000000000000000000000000000111111111110000000000000000;
  localparam smile057  = 59'b00000000000000000000000000000000111111111110000000000000000;
  localparam smile058  = 59'b00000000000000000000000000000000111111111110000000000000000;
  localparam smile059  = 59'b00000000000000000000000000000000111111111110000000000000000;
  localparam smile060  = 59'b00000000000000000000000000000000111111111110000000000000000;
  localparam smile061  = 59'b00000000000000000000000000000000111111111110000000000000000;
  localparam smile062  = 59'b00000000000000000000000000000000111111111110000000000000000;
  localparam smile063  = 59'b00000000000000000000000000000000111111111110000000000000000;
  localparam smile064  = 59'b00000000000000000000000000000000111111111110000000000000000;
  localparam smile065  = 59'b00000000000000000000000000000000111111111110000000000000000;
  localparam smile066  = 59'b00000000000000000000000000000000011111111111000000000000000;
  localparam smile067  = 59'b00000000000000000000000000000000011111111111000000000000000;
  localparam smile068  = 59'b00000000000000000000000000000000011111111111000000000000000;
  localparam smile069  = 59'b00000000000000000000000000000000011111111111000000000000000;
  localparam smile070  = 59'b00000000000000000000000000000000011111111111000000000000000;
  localparam smile071  = 59'b00000000000000000000000000000000011111111111000000000000000;
  localparam smile072  = 59'b00000000000000000000000000000000011111111111000000000000000;
  localparam smile073  = 59'b00000000000000000000000000000000011111111111000000000000000;
  localparam smile074  = 59'b00000000000000000000000000000000011111111111100000000000000;
  localparam smile075  = 59'b00000000000000000000000000000000001111111111100000000000000;
  localparam smile076  = 59'b00000000000000000000000000000000001111111111100000000000000;
  localparam smile077  = 59'b00000001110000000000000000000000001111111111100000000000000;
  localparam smile078  = 59'b00001111111110000000000000000000001111111111100000000000000;
  localparam smile079  = 59'b00011111111111100000000000000000001111111111110000000000000;
  localparam smile080  = 59'b00111111111111110000000000000000000111111111110000000000000;
  localparam smile081  = 59'b01111111111111110000000000000000000111111111110000000000000;
  localparam smile082  = 59'b11111111111111111000000000000000000111111111111000000000000;
  localparam smile083  = 59'b11111111111111111000000000000000000111111111111000000000000;
  localparam smile084  = 59'b11111111111111111000000000000000000011111111111000000000000;
  localparam smile085  = 59'b11111111111111111100000000000000000011111111111100000000000;
  localparam smile086  = 59'b11111111111111111100000000000000000011111111111100000000000;
  localparam smile087  = 59'b11111111111111111000000000000000000001111111111100000000000;
  localparam smile088  = 59'b11111111111111111000000000000000000001111111111110000000000;
  localparam smile089  = 59'b11111111111111111000000000000000000001111111111110000000000;
  localparam smile090  = 59'b01111111111111110000000000000000000000111111111110000000000;
  localparam smile091  = 59'b00111111111111110000000000000000000000111111111111000000000;
  localparam smile092  = 59'b00111111111111100000000000000000000000111111111111000000000;
  localparam smile093  = 59'b00001111111110000000000000000000000000011111111111100000000;
  localparam smile094  = 59'b00000011111000000000000000000000000000011111111111100000000;
  localparam smile095  = 59'b00000000000000000000000000000000000000001111111111110000000;
  localparam smile096  = 59'b00000000000000000000000000000000000000001111111111110000000;
  localparam smile097  = 59'b00000000000000000000000000000000000000000111111111111000000;
  localparam smile098  = 59'b00000000000000000000000000000000000000000111111111111000000;
  localparam smile099  = 59'b00000000000000000000000000000000000000000011111111111100000;
  localparam smile100  = 59'b00000000000000000000000000000000000000000001111111111110000;
  localparam smile101  = 59'b00000000000000000000000000000000000000000001111111111110000;
  localparam smile102  = 59'b00000000000000000000000000000000000000000000111111111111000;
  localparam smile103  = 59'b00000000000000000000000000000000000000000000111111111111000;
  localparam smile104  = 59'b00000000000000000000000000000000000000000000011111111111100;
  localparam smile105  = 59'b00000000000000000000000000000000000000000000001111111111110;
  localparam smile106  = 59'b00000000000000000000000000000000000000000000000111111111110;
  localparam smile107  = 59'b00000000000000000000000000000000000000000000000111111111111;
  localparam smile108  = 59'b00000000000000000000000000000000000000000000000011111111110;
  localparam smile109  = 59'b00000000000000000000000000000000000000000000000001111111100;
  localparam smile110  = 59'b00000000000000000000000000000000000000000000000000111111000;
  localparam smile111  = 59'b00000000000000000000000000000000000000000000000000011110000;
  localparam smile112  = 59'b00000000000000000000000000000000000000000000000000011000000;

  wire            blank;
  reg             blank_h;
  reg             blank_v;

  assign blank = (blank_h | blank_v);

  // 2^10  = 1024
  reg [9:0]       count_h;
  // 2^15 = 32768
  reg [14:0]      count_v;

  wire            red;
  wire            grn;
  reg             blu;
  reg             wht;
  reg             hs_out;
  reg             vs_out;

  reg [3:0]       fb[3:0];

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

  assign red = wht;
  assign grn = wht;

  always @ (blank) begin
    if (blank) begin
      blu <= 1'b0;
      wht <= 1'b0;
    end else begin
      blu <= 1'b1;
      if (count_v > 99 && count_v < 211 && count_h > 80 && count_h < 140) begin
        case(count_v-99)
            1 : wht <= smile001[count_h-80];
            2 : wht <= smile002[count_h-80];
            3 : wht <= smile003[count_h-80];
            4 : wht <= smile004[count_h-80];
            5 : wht <= smile005[count_h-80];
            6 : wht <= smile006[count_h-80];
            7 : wht <= smile007[count_h-80];
            8 : wht <= smile008[count_h-80];
            9 : wht <= smile009[count_h-80];
           10 : wht <= smile010[count_h-80];
           11 : wht <= smile011[count_h-80];
           12 : wht <= smile012[count_h-80];
           13 : wht <= smile013[count_h-80];
           14 : wht <= smile014[count_h-80];
           15 : wht <= smile015[count_h-80];
           16 : wht <= smile016[count_h-80];
           17 : wht <= smile017[count_h-80];
           18 : wht <= smile018[count_h-80];
           19 : wht <= smile019[count_h-80];
           20 : wht <= smile020[count_h-80];
           21 : wht <= smile021[count_h-80];
           22 : wht <= smile022[count_h-80];
           23 : wht <= smile023[count_h-80];
           24 : wht <= smile024[count_h-80];
           25 : wht <= smile025[count_h-80];
           26 : wht <= smile026[count_h-80];
           27 : wht <= smile027[count_h-80];
           28 : wht <= smile028[count_h-80];
           80 : wht <= smile029[count_h-80];
           30 : wht <= smile030[count_h-80];
           31 : wht <= smile031[count_h-80];
           32 : wht <= smile032[count_h-80];
           33 : wht <= smile033[count_h-80];
           34 : wht <= smile034[count_h-80];
           35 : wht <= smile035[count_h-80];
           36 : wht <= smile036[count_h-80];
           37 : wht <= smile037[count_h-80];
           38 : wht <= smile038[count_h-80];
           39 : wht <= smile039[count_h-80];
           40 : wht <= smile040[count_h-80];
           41 : wht <= smile041[count_h-80];
           42 : wht <= smile042[count_h-80];
           43 : wht <= smile043[count_h-80];
           44 : wht <= smile044[count_h-80];
           45 : wht <= smile045[count_h-80];
           46 : wht <= smile046[count_h-80];
           47 : wht <= smile047[count_h-80];
           48 : wht <= smile048[count_h-80];
           49 : wht <= smile049[count_h-80];
           50 : wht <= smile050[count_h-80];
           51 : wht <= smile051[count_h-80];
           52 : wht <= smile052[count_h-80];
           53 : wht <= smile053[count_h-80];
           54 : wht <= smile054[count_h-80];
           55 : wht <= smile055[count_h-80];
           56 : wht <= smile056[count_h-80];
           57 : wht <= smile057[count_h-80];
           58 : wht <= smile058[count_h-80];
           59 : wht <= smile059[count_h-80];
           60 : wht <= smile060[count_h-80];
           61 : wht <= smile061[count_h-80];
           62 : wht <= smile062[count_h-80];
           63 : wht <= smile063[count_h-80];
           64 : wht <= smile064[count_h-80];
           65 : wht <= smile065[count_h-80];
           66 : wht <= smile066[count_h-80];
           67 : wht <= smile067[count_h-80];
           68 : wht <= smile068[count_h-80];
           69 : wht <= smile069[count_h-80];
           70 : wht <= smile070[count_h-80];
           71 : wht <= smile071[count_h-80];
           72 : wht <= smile072[count_h-80];
           73 : wht <= smile073[count_h-80];
           74 : wht <= smile074[count_h-80];
           75 : wht <= smile075[count_h-80];
           76 : wht <= smile076[count_h-80];
           77 : wht <= smile077[count_h-80];
           78 : wht <= smile078[count_h-80];
           79 : wht <= smile079[count_h-80];
           80 : wht <= smile080[count_h-80];
           81 : wht <= smile081[count_h-80];
           82 : wht <= smile082[count_h-80];
           83 : wht <= smile083[count_h-80];
           84 : wht <= smile084[count_h-80];
           85 : wht <= smile085[count_h-80];
           86 : wht <= smile086[count_h-80];
           87 : wht <= smile087[count_h-80];
           88 : wht <= smile088[count_h-80];
           89 : wht <= smile089[count_h-80];
           90 : wht <= smile090[count_h-80];
           91 : wht <= smile091[count_h-80];
           92 : wht <= smile092[count_h-80];
           93 : wht <= smile093[count_h-80];
           94 : wht <= smile094[count_h-80];
           95 : wht <= smile095[count_h-80];
           96 : wht <= smile096[count_h-80];
           97 : wht <= smile097[count_h-80];
           98 : wht <= smile098[count_h-80];
           99 : wht <= smile099[count_h-80];
          100 : wht <= smile100[count_h-80];
          101 : wht <= smile101[count_h-80];
          102 : wht <= smile102[count_h-80];
          103 : wht <= smile103[count_h-80];
          104 : wht <= smile104[count_h-80];
          105 : wht <= smile105[count_h-80];
          106 : wht <= smile106[count_h-80];
          107 : wht <= smile107[count_h-80];
          108 : wht <= smile108[count_h-80];
          109 : wht <= smile109[count_h-80];
          110 : wht <= smile110[count_h-80];
          111 : wht <= smile111[count_h-80];
          112 : wht <= smile112[count_h-80];
          default: wht <= 1'b0;
        endcase
      end else begin
        wht <= 1'b0;
      end
    end
  end

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
      count_v <= 15'b111_1111_1111_1111;
      blank_v <= 1'b1;
      vs_out  <= 1'b0;
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
