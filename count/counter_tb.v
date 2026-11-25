module counter_tb ();
  reg clk;
  reg reset;
  wire [3:0] count;

  counter #(
    .DIV(2)
  ) counter (
      .clk(clk),
      .reset(reset),
      .led(count)
  );

  // bind led to count because we need the inverse
  wire [3:0] led = ~count;

  task check_count(input [3:0] expected);
    if (led !== expected) $error("FAIL at t=%0t: expected=%b actual=%b", $time, expected, led);
    else $display("PASS at t=%0t: count=%b", $time, led);
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
    reset = 0;
    #12 reset = 1;

    repeat (3) @(negedge clk);
    check_count(4'b0001);
    repeat (2) @(negedge clk);
    check_count(4'b0010);
    repeat (2) @(negedge clk);
    check_count(4'b0011);

    #200 $finish;
  end
endmodule
