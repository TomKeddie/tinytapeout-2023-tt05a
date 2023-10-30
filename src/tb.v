`default_nettype none
`timescale 1ns/1ps

module tb (
           // testbench is controlled by test.py
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

  // this part dumps the trace to a vcd file that can be viewed with GTKWave
  initial begin
    $dumpfile ("tb.vcd");
    $dumpvars (0, tb.clk);
    $dumpvars (0, tb.rst);
    $dumpvars (0, tb.r0);
    $dumpvars (0, tb.g0);
    $dumpvars (0, tb.b0);
    $dumpvars (0, tb.vga.wht);
    $dumpvars (0, tb.hs);
    $dumpvars (0, tb.vs);
    $dumpvars (0, tb.vga.blank);
    $dumpvars (0, tb.vga.count_h);
    $dumpvars (0, tb.vga.blank_h);
    $dumpvars (0, tb.vga.count_v);
    $dumpvars (0, tb.vga.blank_v);
    $dumpvars (0, tb.vga.row);
    #1;
  end

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
