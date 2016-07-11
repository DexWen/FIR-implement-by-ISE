clear;
clc;
t=0:0.01:5;     %fs=100Hz
N=8;            %N=8,8阶线性FIR滤波器
Nw=N;
wc=0.25*pi;     %截止频率为0.25π
n=0:7;
alp=(N-1)/2;
m=n-alp+eps;
hd=sin(wc*m)./(pi*m);       %参考《数字信号处理》 p333页
win=hamming(N); %用窗函数方法设计，汉明窗
h=hd.*win';     %求出滤波器抽头系数，给verilog用
b=fix(h*(2^11));%输出小数，左移11位，对于16位有符号定点小数，最高位为符号位，整数部分为4位，小数部分为11位           抽头
x=0.01*sin(2*pi.*t)+0.01*sin(2*pi*40.*t);%对应第一种输入波形，f1=0.02π，f2=0.8π
%x=0.01*sin(2*pi.*t)+0.01*sin(2*pi*4.*t);    %对应第二种输入波形，f1=0.08π，f2=0.02π
y=conv(x,h);    %进行滤波器卷积运算
subplot(2,1,1); 
plot(x);        %画出输入滤波之前的波形
title('滤波前的波形');
subplot(2,1,2);
plot(y);        %画出滤波之后的波形
title('滤波后的波形');
xl=fix(x*(2^11));%把输入波形的个个取样点左移11位，取整，保存到“data_in.txt”中，为后面验证FPGA设计FIR滤波器作为数据输入
fid=fopen('data_in_dex.txt','wt');
%fid=fopen('data_in2.txt','wt'); %对应第二种波形的输出文件，供modelsim仿真用
fprintf(fid,'%d\n',xl);
fclose(fid);

a=textread('bin_dex.txt','%d')';%读取modelsim输出的数据记录“bin.txt”，画出modelsim仿真的输出波形
%a=textread('bin2.txt','%d')';%对应第二种波形输入，modelsim的输出波形文件为：bin2.txt
out=a./(2^23);   %由于输出结果是34位，在verilog运算过程中，涉及16×16乘法，整数部分4位，小数部分11位相乘，
figure(2);       %得到8位整数部分和22位小数部分，但由于加了1位无关位，所以结果要处以2^23
plot(out);
title('modelsim仿真FIR数字滤波器输出波形');
