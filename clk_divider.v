module clk_divider(clk,rst,clk1k); //分频器产生1kHz时钟信号
input clk,rst;
output reg clk1k;

parameter time_limited_1KHz=15'd3000;     
reg [14:0]counter_1khz;

always @(posedge clk or posedge rst)
begin
if(rst) 
	begin  
     counter_1khz <= 0;
     clk1k <= 0; 
    end  
else if(counter_1khz==time_limited_1KHz)
   begin
	 clk1k<=~clk1k;
     counter_1khz<=0;
   end
else if(counter_1khz<time_limited_1KHz)
   begin
	 counter_1khz<= counter_1khz+15'd1;
     clk1k<=clk1k; 
   end
end
endmodule
