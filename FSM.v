module FSM(in,clk,rst,flag,counter,time1,time2,s1,s2);  //状态机模块，不同按键按下跳转至不同状态
input clk,rst;
input [6:0]in;
input [9:0]counter; 
output reg [2:0] flag;   //计数器状态
output reg [4:0]time1;
output reg [4:0]time2;
output reg [9:0]s1;
output reg [9:0]s2;
reg r1;
reg r2;

parameter idle = 5'b00000, START = 5'b10000, STOP1 = 5'b01000, STOP2 = 5'b00100, 
WINNER = 5'b00010, MIN = 5'b00001, p1=5'b11000, p2=5'b10100;
reg [4:0] cs,ns;
 
always @(posedge clk or posedge rst)
begin  
  if(rst)  cs = idle;
  else   cs = ns;
end  
  
//flag=0 清除状态   flag=1 计数状态   flag=2,3 不变状态   flag=4 查询每组比赛胜者成绩  flag=5 查询最好成绩  flag=6查询选手1历史成绩  flag=7查询选手2历史成绩
always @(*)  
	begin
	case (cs) 
		idle: begin
			r1=0;
			r2=0;
	       if(in==7'b1000000)      
				begin 
					ns = START; 
					flag = 1;   
				end
		   else if(in==7'b0001000)  
					begin   
						ns = WINNER;
						flag = 4; 
					end 
		   else if(in==7'b0000100)  
					begin   
						ns = MIN; 
						flag = 5;     
					end
					else  if(in==7'b0000010)
						begin 
						ns = p1; 
						flag = 6;
					end
			 else  if(in==7'b0000001)
						begin
						ns=p2;
						flag=7;
					end
			 else begin	
					ns=idle;
					flag=0;
					end
 	 end
	START: begin
			r1=0;
			r2=0;
           if(in==7'b0100000) 
					begin 
						ns = STOP1; 
						flag = 2;
					end
		   else if(in==7'b0010000)
					begin 
						ns = STOP2; 
						flag = 3;
					end 
		   else if(in==7'b0000100) 
					begin 
						ns = MIN ;
						flag = 5;
					end
		   else if(in==7'b0001000)  
					begin 
						ns = WINNER; 
						flag = 4; 
					end
			else  if(in==7'b0000010)
						begin 
						ns = p1; 
						flag = 6;
					end
			 else  if(in==7'b0000001)
						begin
						ns=p2;
						flag=7;
					end	
		    else  begin  
						ns = START; 
						flag = 1; 
					end
	end	 
    STOP1: begin
			r1=1;
			r2=0;	 
            if(in==7'b0001000)  
					begin 
						ns = WINNER; 
						flag = 4; 
					end 
			else if(in==7'b0000100)  
					begin 
						ns = MIN; 
						flag = 5; 
					end
			else  if(in==7'b0000010)
						begin 
						ns = p1; 
						flag = 6;
					end
			 else  if(in==7'b0000001)
						begin
						ns=p2;
						flag=7;
					end		
           else  begin 
						ns = STOP1; 
						flag = 2; 
					end
	end		
	 STOP2: begin
			r1=0;
			r2=1; 
	        if(in==7'b0001000)  
					begin 
						ns = WINNER; 
						flag = 4; 
					end 
			else if(in==7'b0000100)  
					begin 
						ns = MIN; 
						flag = 5; 
					end
			else  if(in==7'b0000010)
						begin 
						ns = p1; 
						flag = 6;
					end
			 else  if(in==7'b0000001)
						begin
						ns=p2;
						flag=7;
					end				
	        else begin
						ns = STOP2; 
						flag = 3; 
					end
	end
     WINNER: begin
				r1=0;
				r2=0;
	        if(in==7'b0000100) 
                begin 
						ns = MIN;
						flag = 5;
					end
			else  if(in==7'b0000010)
						begin 
						ns = p1; 
						flag = 6;
					end
			 else  if(in==7'b0000001)
						begin
						ns=p2;
						flag=7;
					end				
			else begin 
						ns = WINNER; 
						flag = 4; 
					end
	end
  	  MIN: begin
				r1=0;
				r2=0;
	         if(in==7'b0001000) 
					begin 
						ns = WINNER ;
						flag = 4;
					end
				else  if(in==7'b0000010)
						begin 
						ns = p1; 
						flag = 6;
					end
			 else  if(in==7'b0000001)
						begin
						ns=p2;
						flag=7;
					end				
	         else begin 
						ns = MIN; 
						flag = 5; 
						end
			end
		p1: begin
				r1=0;
				r2=0;
				if(in==7'b0001000) 
					begin 
						ns = WINNER;
						flag = 4;
					end
				else  if(in==7'b0000001)
						begin
						ns=p2;
						flag=7;
					end				
	         else if(in==7'b0000100)
					begin 
						ns = MIN; 
						flag = 5; 
						end
				else begin 
						ns = p1; 
						flag = 6;
						end
			end
		p2: begin
				r1=0;
				r2=0;
				if(in==7'b0001000) 
					begin 
						ns = WINNER ;
						flag = 4;
					end
				else  if(in==7'b0000010)
						begin
						ns=p1;
						flag=6;
					end				
	         else if(in==7'b0000100)
					begin 
						ns = MIN; 
						flag = 5; 
						end
				else begin 
						ns = p2; 
						flag = 7;
						end
				end		
endcase 
end
always@(posedge r1)
begin
	time1<=time1+5'd1;
	s1<=counter+10'd1;
end
always@(posedge r2)
begin
	time2<=time2+5'd1;
	s2<=counter+10'd1;
end
endmodule
