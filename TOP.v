module keshe(clk,clear,lu,x,win_rate,SEG_switch,SEG,led);//顶层文件
input clk,clear;
input [6:0]x; 
input [1:0]win_rate;
input [4:0]lu;  
output [7:0]SEG;
output [2:0]SEG_switch;
output [2:0]led;


wire [6:0] key_out;
wire clk1k;
wire [9:0] counter;
wire [9:0] winner;
wire [2:0] flag;
wire [89:0] store1,store2;
wire [4:0]	time1,time2;
wire [4:0] r1,r2;
wire [9:0] s1,s2;

debounce u1(.clk(clk), .rst(clear), .key_in(x[6]), .key_out(key_out[6]));
debounce u2(.clk(clk), .rst(clear), .key_in(x[5]), .key_out(key_out[5]));
debounce u3(.clk(clk), .rst(clear), .key_in(x[4]), .key_out(key_out[4]));
debounce u4(.clk(clk), .rst(clear), .key_in(x[3]), .key_out(key_out[3]));
debounce u5(.clk(clk), .rst(clear), .key_in(x[2]), .key_out(key_out[2]));
debounce u6(.clk(clk), .rst(clear), .key_in(x[1]), .key_out(key_out[1]));
debounce u7(.clk(clk), .rst(clear), .key_in(x[0]), .key_out(key_out[0]));
FSM u8(.in(key_out),.clk(clk),.rst(clear),.flag(flag),.counter(counter),.time1(time1),.time2(time2),.s1(s1),.s2(s2),);
clk_divider u9(.clk(clk),.rst(clear),.clk1k(clk1k));
led u10(.clk(clk1k),.rst(clear),.flag(flag),.led(led));
ctrl u11(.clk(clk1k),.rst(clear),.x(key_out),.led(led),.flag(flag),.counter(counter),.winner(winner),.r1(r1),.r2(r2));
store u12(.in(key_out),.flag(flag),.s1(s1),.s2(s2),.time1(time1),.time2(time2),.store1(store1),.store2(store2));
scan_seg u13(.clk(clk),.clk1k(clk1k),.rst(clear),.lu(lu),.win_rate(win_rate),.led(led),.counter(counter),.r1(r1),.r2(r2),
.winner(winner),.time1(time1),.time2(time2),.s1(s1),.s2(s2),.store1(store1),.store2(store2),
.flag(flag),.SEG_switch(SEG_switch),.SEG(SEG));
endmodule
