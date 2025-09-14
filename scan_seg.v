module scan_seg(clk,clk1k,rst,lu,win_rate,led,counter,r1,r2,time1,time2,winner,flag,store1,store2,s1,s2,SEG,SEG_switch);//显示模块
input rst,clk1k,clk; 
input [1:0]win_rate;
input [4:0]lu;      
input [2:0] flag;
input [2:0] led;
input [4:0] r1;
input [4:0] r2;
input [4:0] time1;
input [4:0] time2;
input [9:0] counter;
input [9:0] winner;
input [9:0] s1;
input [9:0] s2;
input [89:0] store1;
input [89:0] store2;
output reg [7:0] SEG;
output reg [2:0] SEG_switch;

wire [3:0] ge;
wire [3:0] shi;
wire [3:0] bai;
reg [3:0] num;                 
reg [3:0] SEG_counter;
reg [9:0] MIN;

initial
begin
	 SEG_counter = 4'b0000;                 
    SEG_switch = 3'b000;	
    MIN = 10'd999;	
end

//所有结果中的最小值确定
always @(posedge clk1k)
begin
		if(counter < MIN && flag==2 && counter!=0 )  MIN <= counter+10'd1;
	else if(counter < MIN && flag==3 && counter!=0 )  MIN <= counter+10'd1;
	else   begin   MIN <= MIN; end
end

//选择控制数码管的位置
always @(posedge clk1k or posedge rst)
begin
 if(rst)   SEG_counter <= 0;
 else if(flag==2 && led[2]==0)  SEG_counter <= 4'b0110;
 else if(flag==3 && led[2]==0)  SEG_counter <= 4'b0110;
 else   
     begin
     if(SEG_counter==4'b0011)   SEG_counter <= 0;	
	 else  if(SEG_counter<4'b0011) SEG_counter <= SEG_counter + 4'd1;
	 end
end
//显示赋值
 assign ge = 
				(flag==7&&lu==5'd9)? (store2[89:80]%10): 
				(flag==7&&lu==5'd8)? (store2[79:70]%10): 
				(flag==7&&lu==5'd7)? (store2[69:60]%10): 
				(flag==7&&lu==5'd6)? (store2[59:50]%10): 
				(flag==7&&lu==5'd5)? (store2[49:40]%10): 
				(flag==7&&lu==5'd4)? (store2[39:30]%10): 
				(flag==7&&lu==5'd3)? (store2[29:20]%10): 
				(flag==7&&lu==5'd2)? (store2[19:10]%10):
				(flag==7&&lu==5'd1)? (store2[9:0]%10): 
				
				(flag==6&&lu==5'd9)? (store1[89:80]%10): 
				(flag==6&&lu==5'd8)? (store1[79:70]%10): 
				(flag==6&&lu==5'd7)? (store1[69:60]%10): 
				(flag==6&&lu==5'd6)? (store1[59:50]%10): 
				(flag==6&&lu==5'd5)? (store1[49:40]%10): 
				(flag==6&&lu==5'd4)? (store1[39:30]%10): 
				(flag==6&&lu==5'd3)? (store1[29:20]%10): 
				(flag==6&&lu==5'd2)? (store1[19:10]%10): 
				(flag==6&&lu==5'd1)? (store1[9:0]%10): 
				(win_rate[0]==1)? (100*r2/time2)%10:
				(win_rate[1]==1)? (100*r1/time1)%10:
				(flag==4)? winner%10 : 
				(flag==5)? MIN%10 : 
				(flag==2 && led[2]==0)? 4'd10 :
				(flag==3 && led[2]==0)? 4'd10 :
				counter%10;
assign shi =
				(flag==7&&lu==5'd9)? (store2[89:80]/10%10): 
				(flag==7&&lu==5'd8)? (store2[79:70]/10%10): 
				(flag==7&&lu==5'd7)? (store2[69:60]/10%10): 
				(flag==7&&lu==5'd6)? (store2[59:50]/10%10): 
				(flag==7&&lu==5'd5)? (store2[49:40]/10%10): 
				(flag==7&&lu==5'd4)? (store2[39:30]/10%10): 
				(flag==7&&lu==5'd3)? (store2[29:20]/10%10): 
				(flag==7&&lu==5'd2)? (store2[19:10]/10%10): 
				(flag==7&&lu==5'd1)? (store2[9:0]/10%10): 
				
				(flag==6&&lu==5'd9)? (store1[89:80]/10%10): 
				(flag==6&&lu==5'd8)? (store1[79:70]/10%10): 
				(flag==6&&lu==5'd7)? (store1[69:60]/10%10): 
				(flag==6&&lu==5'd6)? (store1[59:50]/10%10): 
				(flag==6&&lu==5'd5)? (store1[49:40]/10%10): 
				(flag==6&&lu==5'd4)? (store1[39:30]/10%10): 
				(flag==6&&lu==5'd3)? (store1[29:20]/10%10): 
				(flag==6&&lu==5'd2)? (store1[19:10]/10%10): 
				(flag==6&&lu==5'd1)? (store1[9:0]/10%10): 
				(win_rate[0]==1)? (100*r2/time2)/10%10:
				(win_rate[1]==1)? (100*r1/time1)/10%10:
				(flag==4)? winner/10%10: 
				(flag==5)? MIN/10%10 :
				(flag==2 && led[2]==0)? 4'd10 : 
				(flag==3 && led[2]==0)? 4'd10 : 
				counter/10%10;
assign bai =
				(flag==7&&lu==5'd9)? (store2[89:80]/100): 
				(flag==7&&lu==5'd8)? (store2[79:70]/100): 
				(flag==7&&lu==5'd7)? (store2[69:60]/100): 
				(flag==7&&lu==5'd6)? (store2[59:50]/100): 
				(flag==7&&lu==5'd5)? (store2[49:40]/100): 
				(flag==7&&lu==5'd4)? (store2[39:30]/100): 
				(flag==7&&lu==5'd3)? (store2[29:20]/100): 
				(flag==7&&lu==5'd2)? (store2[19:10]/100): 
				(flag==7&&lu==5'd1)? (store2[9:0]/100): 
				
				(flag==6&&lu==5'd9)? (store1[89:80]/100): 
				(flag==6&&lu==5'd8)? (store1[79:70]/100): 
				(flag==6&&lu==5'd7)? (store1[69:60]/100): 
				(flag==6&&lu==5'd6)? (store1[59:50]/100): 
				(flag==6&&lu==5'd5)? (store1[49:40]/100): 
				(flag==6&&lu==5'd4)? (store1[39:30]/100): 
				(flag==6&&lu==5'd3)? (store1[29:20]/100): 
				(flag==6&&lu==5'd2)? (store1[19:10]/100): 
				(flag==6&&lu==5'd1)? (store1[9:0]/100): 
				(win_rate[0]==1 && (100*r2/time2)/100)? 4'd12:
				(win_rate[1]==1 && (100*r1/time1)/100)? 4'd12:
				(win_rate[0]==1)? 4'd11:
				(win_rate[1]==1)? 4'd11:
				(flag==4)? winner/100 : 
				(flag==5)? MIN/100 : 
				(flag==2 && led[2]==0)? 4'd10 : 
				(flag==3 && led[2]==0)? 4'd10 : 
				counter/100;
//数码管位选
always @(*)
begin
  case(SEG_counter)
  4'b0001:
	 begin
	 SEG_switch=3'b001;
	 num=ge;
	 end
  4'b0010:
	 begin
	 SEG_switch=3'b010;
	 num=shi;
	 end
  4'b0011:
	 begin
	 SEG_switch=3'b100; 
	 num=bai;
	 end
  4'b0110:
	 begin 
	 SEG_switch=3'b111;
	 num=4'd10;
	 end
	default:
	 begin 
		SEG_switch=3'b000;
		num=4'd0;
	 end
  endcase
end

//数码管显示
always @(*)
begin
	case(num)
   4'd0 : SEG =8'b00111111;
   4'd1 : SEG =8'b00000110;
   4'd2 : SEG =8'b01011011;
   4'd3 : SEG =8'b01001111;
   4'd4 : SEG =8'b01100110;
   4'd5 : SEG =8'b01101101;
   4'd6 : SEG =8'b01111101;
   4'd7 : SEG =8'b00000111;
   4'd8 : SEG =8'b01111111;
   4'd9 : SEG =8'b01101111;
   4'd10: SEG =8'b01111001;
	4'd11: SEG =8'b10111111;
	4'd12: SEG =8'b10000110;
  default: SEG =8'b0000000;
  endcase
end
endmodule
