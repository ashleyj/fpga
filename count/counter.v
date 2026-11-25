module counter #(
  // divider to slow down the counter process
  parameter integer DIV = (27000000 / 2)
)(
    input wire clk,
    input wire reset,
    output wire [3:0] led
);

  reg [31:0] blink_counter;
  reg [3:0] count = 4'b0000;

  //bind led to counter
  assign led = ~count;

  always @(posedge clk) begin
    // reset button push (idle high, so look for a low)
    if (!reset) begin
      // reset all the things
      blink_counter <= 0;
      count <= 4'b0000;
    end else if (blink_counter < (DIV - 1)) begin
      blink_counter <= blink_counter + 1;
    end else begin
      //reset counter, set LEDs
      blink_counter <= 0;
      count <= count + 1;
    end
  end

endmodule
