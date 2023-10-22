`default_nettype none

module tt_um_tomkeddie_a
  (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
   );

   wire r0;
   wire r1;
   wire r2;
   wire r3;
   wire b0;
   wire b1;
   wire b2;
   wire b3;
   wire g0;
   wire g1;
   wire g2;
   wire g3;
   wire hs;
   wire vs;
   wire	rst;

   assign uo_out[0]  = r0;
   assign uo_out[1]  = r1;
   assign uo_out[2]  = r2;
   assign uo_out[3]  = r3;
   assign uo_out[4]  = b0;
   assign uo_out[5]  = b1;
   assign uo_out[6]  = b2;
   assign uo_out[7]  = b3;
   assign uio_out[0] = g0;
   assign uio_out[1] = g1;
   assign uio_out[2] = g2;
   assign uio_out[3] = g3;
   assign uio_out[4] = hs;
   assign uio_out[5] = vs;
   assign uio_out[6] = 1'b0;
   assign uio_out[7] = 1'b0;
   assign uio_oe     = 8'b11111111;

   assign rst       = !rst_n;

   // instantiate the DUT
   vga vga(.clk(clk), 
	   .rst(rst),
	   .r0(r0),
	   .r1(r1),
	   .r2(r2),
	   .r3(r3),
	   .b0(b0),
	   .b1(b1),
	   .b2(b2),
	   .b3(b3),
	   .g0(g0),
	   .g1(g1),
	   .g2(g2),
	   .g3(g3),
	   .hs(hs),
	   .vs(vs));
  
endmodule
