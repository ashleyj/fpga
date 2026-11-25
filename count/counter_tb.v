module counter_tb ();
  reg clk;
  reg reset;
  reg [3:0] cnt;

  counter counter (
      .clk  (clk),
      .reset(reset),
      .count(cnt)
  );

  task check_count(input [3:0] expected);
    if (cnt !== expected) $error("FAIL at t=%0t: expected=%b actual=%b", $time, expected, cnt);
    else $display("PASS at t=%0t: count=%b", $time, cnt);
  endtask

  // dump wave
  initial begin
    $dumpvars(0, counter_tb);
  end


  initial begin
    clk = 0;
    forever begin
      #10 clk = ~clk;
    end
  end

  initial begin
    reset = 1;
    #12 reset = 0;
    @(posedge clk);
    #1;
    check_count(4'b0001);
    @(posedge clk);
    #1;
    check_count(4'b0010);
    @(posedge clk);
    #1;
    check_count(4'b0011);
    #200 $finish;
  end
endmodule
