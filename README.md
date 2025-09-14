# FPGA_Reaction_Timer
FPGA迷你项目反应计时器
一、设计要求
A. 电路使用一个 LED 作为视觉刺激指示灯，在七段数码管上显示相应的信息；
B. 当按下 clear 键时，电路回到初始状态，七段数码管给出一个初始显示，同时 LED 指
示灯熄灭；
C. 当按下 start 键，七段数码管熄灭，固定或随机间隔一段时间(时长不超过 6s)之后，LED
指示灯被点亮，同时计数器开始计数。计数器每 1ms 加 1，它的值以 XXX 的格式显示
在数码管上；
D. 被测试者看到 LED 指示灯点亮后，立即按下 stop 键，此时计数器暂停计数，数码管
显示的就是被测试者的反应时间。大多数人的反应时间在 0.15-0.3s 之间；
E. 如果不按下 stop 键，计时器达到 999 之后停止计数；
F. 如果 LED 指示灯点亮前，按下 stop 键，被视为犯规，数码管上应给出犯规指示；
G. 两个人比赛，显示两人的反应时间及获胜者；
H. 可连续进行多次比赛，至少存储 20 组比赛结果；
I. 可统计参赛手的胜率和最短时间； 
二、设计方案
使用有限状态机来实现不同的模块，满足不同的要求。主要分为以下模块：
<img width="807" height="476" alt="image" src="https://github.com/user-attachments/assets/3190c3e3-0cc3-4332-a69e-831969a994ab" />
<img width="818" height="305" alt="image" src="https://github.com/user-attachments/assets/59dc4f5d-48ef-48fc-aff5-d85f0575bca8" />
Idle代表按下复位键，START代表选手按下开始键，STOP1代表选手1按下停止键，STOP2代表选手2按下停止键，MIN代表查询最佳成绩，WINNER代表查询每组比赛的获胜者。p1，p2代表分别查询选手1，选手2的成绩。
不同的状态分别控制数码管显示的不同结果。
顶层电路：
<img width="851" height="471" alt="image" src="https://github.com/user-attachments/assets/5c07ce88-6707-4452-ba37-ba5063af28ab" />
按键消抖模块：
<img width="851" height="381" alt="image" src="https://github.com/user-attachments/assets/44020bdd-30f1-405a-903f-7f57ecc02c6f" />
状态机转换模块：
<img width="851" height="509" alt="image" src="https://github.com/user-attachments/assets/2e6ad334-277d-471e-a28d-9ab29afe31ad" />
Led灯显示模块：
<img width="851" height="505" alt="image" src="https://github.com/user-attachments/assets/93ced783-d29b-43e1-b489-fb94cb223c13" />
计时模块：
<img width="851" height="554" alt="image" src="https://github.com/user-attachments/assets/89b75a53-0531-4512-a944-b378693c966d" />
三、实现效果
初始显示：
<img width="450" height="84" alt="image" src="https://github.com/user-attachments/assets/387f5f4d-2f83-427d-afcd-9e929b779e63" />
选手1完成比赛：
<img width="465" height="77" alt="image" src="https://github.com/user-attachments/assets/401edeaa-42e3-4a73-b2a3-b83d0d771960" />
选手2完成比赛：
<img width="450" height="75" alt="image" src="https://github.com/user-attachments/assets/d23143de-5e39-450e-9ac7-1c952161d62b" />
胜者显示：
<img width="445" height="66" alt="image" src="https://github.com/user-attachments/assets/904ec58e-c833-402c-b8db-30d10e07497e" />
犯规提示：
<img width="458" height="83" alt="image" src="https://github.com/user-attachments/assets/d761626e-a6da-468b-9796-f44142eaaee3" />
比赛最小值显示：
<img width="712" height="120" alt="image" src="https://github.com/user-attachments/assets/0e544c69-330e-4306-ba17-8ecdbd768d32" />
历史成绩显示：
<img width="691" height="467" alt="image" src="https://github.com/user-attachments/assets/c9aee334-e7f7-4953-b05d-b7f1b7ae4123" />
<img width="723" height="494" alt="image" src="https://github.com/user-attachments/assets/a741143e-ea80-4774-a249-3ba9f1ab6e01" />
胜率显示：
<img width="722" height="542" alt="image" src="https://github.com/user-attachments/assets/8ca8ee68-dc2b-426f-800a-c8f8fb9d088c" />



 
 




