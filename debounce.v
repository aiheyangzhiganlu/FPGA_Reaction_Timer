module debounce(clk, rst, key_in, key_out); //消抖模块对按键进行消抖
input clk, rst;
input key_in;
output reg key_out;

parameter time_limited_20ms = 20'd1000000;//延时20ms
reg key_cnt;
reg [19:0] cnt;

always @(posedge clk or posedge rst)
begin
  if(rst)  key_cnt <= 0;
  else if(key_cnt == 0 && key_out != key_in) key_cnt <= 1;
  else if(cnt == time_limited_20ms - 1) key_cnt <= 0;
  else key_cnt <= key_cnt;
end

always @(posedge clk or posedge rst) 
begin
  if(rst) cnt <= 0;
  else if(key_cnt) cnt <= cnt+1'b1;
  else cnt <= 0;
end 

always @(posedge clk or posedge rst)
begin
   if(rst) key_out <= 1;
   else if(key_cnt == 0 && key_out != key_in) key_out <= key_in;
   else key_out <= key_out;
end
endmodule
