module led(clk,rst,flag,led); //led灯控制模块
input clk,rst;
input [2:0]flag;
output reg [2:0]led;

reg flag_time;
reg [26:0]counter_rand=27'd0;
reg[26:0] cnt_rand_time=27'd0;


//随机产生1~6s的时间间隔
always @ (posedge clk or posedge rst)
begin
if(rst)  cnt_rand_time <= 13'd1000;
else if(flag==0) 
	    begin
		if(cnt_rand_time >= 13'd6000)   cnt_rand_time <= 13'd1000;
		else  cnt_rand_time <= cnt_rand_time + 1'b1;
	    end
else   cnt_rand_time <= cnt_rand_time;
end

always @(posedge clk or posedge rst)
begin 
if(rst)  begin  
         counter_rand <= 0; 
         flag_time <= 0;
         end  
else if(flag==1) 
	    begin
		if(counter_rand == cnt_rand_time)
	        begin
				flag_time <= 1;
				counter_rand<=0;
	        end
	    else	if(counter_rand<cnt_rand_time)
		    begin
		     counter_rand<= counter_rand+27'd1;
		     flag_time<=0;
	        end
		end
	else  begin  
				flag_time <= flag_time; 
				counter_rand <= counter_rand; 
			end
end

//当按下开始键并在随机间隔时间内，指示测试开始的led灯亮
always @(posedge clk, posedge rst)
begin
  if(rst)   led[2] <= 0; 
  else if(flag==1 && flag_time==1)  led[2] <= 1;
  else led[2]<=led[2];
end


always @(posedge clk, posedge rst)
begin
  if(rst)  begin 
	led[1] <= 0; 
	led[0] <= 0;
	end
  else if(flag==2)  begin led[1] <= 1; end
  else if(flag==3)  begin led[0] <= 1; end
  else   begin  
			led[1] <= 0; 
			led[0] <= 0;
			end
end
endmodule
