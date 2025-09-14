module ctrl(clk,rst,x,led,flag,counter,winner,r1,r2);  
input clk,rst;
input [6:0] x;
input [3:0]flag;
input [2:0]led;
output reg [9:0]counter;
output reg [9:0]winner;
output reg [4:0]r1;
output reg [4:0]r2;
reg [9:0]s1=10'd999;
reg [9:0]s2=10'd999;
reg p1=0;
reg p2=0;
reg [1:0] en;  

always @(posedge clk)  
begin 
	if(flag==1 && led[2]==1) en <= 2'b01;      //计时状态
	else if(flag==2 &&led[2]==0) en <= 2'b11;  //犯规状态
	else if(flag==3 &&led[2]==0) en <= 2'b11;  //犯规状态
	else if(flag==0)  en <= 2'b00;  //清零状态
	else en<=2'b10;
end

always @ (posedge clk or posedge rst)//计时模块
begin
	if(rst) counter <= 0;
	else if(en==2'b01)
			begin 
				if(counter == 10'd999)
						counter <= counter;
				else  
						counter <= counter+10'd1;  
			end  
				else if(en==2'b00)  counter <= 10'd0;
				else if(en==2'b11)  counter <= 10'd999;	
				else counter <= counter;
end

always @(posedge clk)
begin
		if(flag==2)  s1<=counter;
		else if(flag==3)  s2<=counter;
end
always@(posedge x[3] or posedge (x[6])) //一组比赛结果进行比较，显示胜者，并存储胜场数
begin
		if(x[6])
		begin
			p1<=0;
			p2<=0;
		end
		else if(s1<s2)
			begin
			winner<=s1;
			p1<=1;
			p2<=0;
			end
	else  if(s1>s2)
			begin
			winner<=s2;
			p1<=0;
			p2<=1;
			end
	else  begin
			winner<=10'd0;
			p1<=0;
			p2<=0;
			end
end
always@(posedge p1)
begin
	r1<=r1+5'd1;
end
always@ (posedge p2)
begin
	r2<=r2+5'd1;
end
endmodule
