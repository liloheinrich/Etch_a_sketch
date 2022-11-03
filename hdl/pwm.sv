/*
  A pulse width modulation module 
*/

module pwm(clk, rst, ena, step, duty, out);

parameter N = 8;

input wire clk, rst;
input wire ena; // Enables the output.
input wire step; // Enables the internal counter. You should only increment when this signal is high (this is how we slow down the PWM to reasonable speeds).
input wire [N-1:0] duty; // The "duty cycle" input.
output logic out;

logic [N-1:0] counter;

always_comb begin
  out = ena & ( (counter < duty) | &counter );
end

always_ff @(posedge clk) begin
  if(rst) begin
    counter <=0;
  end
  else if (step) begin
    counter <= counter + 1;
  end
end

endmodule
