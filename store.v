module store(in,flag,s1,s2,time1,time2,store1,store2);//存储20组比赛成绩
	input [6:0]in;
	input [2:0] flag;
	input [4:0]time1,time2;
	input [9:0]s1,s2;
	output reg [89:0] store1;
	output reg [89:0] store2;
always@ (posedge in[5])
	begin
		case(time1)
		5'd1:store1[9:0]=s1;
		5'd2:store1[19:10]=s1;
		5'd3:store1[29:20]=s1;
		5'd4:store1[39:30]=s1;
		5'd5:store1[49:40]=s1;
		5'd6:store1[59:50]=s1;
		5'd7:store1[69:60]=s1;
		5'd8:store1[79:70]=s1;
		5'd9:store1[89:80]=s1;
		default:store1[89:0]=90'd0;
		endcase
end
always@ (posedge in[4])
begin
		case(time2)
		5'd1:store2[9:0]=s2;
		5'd2:store2[19:10]=s2;
		5'd3:store2[29:20]=s2;
		5'd4:store2[39:30]=s2;
		5'd5:store2[49:40]=s2;
		5'd6:store2[59:50]=s2;
		5'd7:store2[69:60]=s2;
		5'd8:store2[79:70]=s2;
		5'd9:store2[89:80]=s2;
		default:store2[89:0]=90'd0;
		endcase
	end
endmodule
