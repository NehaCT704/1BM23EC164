//top.sv
module top;
bit clk;
D_inter i1(clk);
D_FF Dut(i1);
test T1(i1);
always #5 clk=~clk;
initial
begin
$dumpfile("top.vcd");
$dumpvars;
$monitor("time=%d, clk=%b, reset=%b,set=%b, d=%b, q=%b", $time, clk, i1.reset, i1.set, 
i1.d, i1.q);
end
endmodule
