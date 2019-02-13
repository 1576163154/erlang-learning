-module(recursion).
-export([fac/1]).
-export([len/1,fac2/1,len2/1]).
% 或者 -export([fac/1,len/1]).
fac(N) when N == 0 -> 1;
fac(N) when N > 0 -> N * fac(N-1).

%用模式匹配改写
% fac(0) -> 1;
% fac(N) -> N * fac(N-1).

%windows 下werl.exe相关命令
%cd(e:/……）.  切换目录
%c(recursion). 编译
% recursion:fac(3). 调用模块函数

%利用 | 构造运算符，对一个List 进行递归

len([]) -> 0; %递归基准，空List
%len([_]) -> 1;
len([_|T]) -> 1 + len(T).

%tail recursion
%在函数调用过程中，用临时变量记录计算结果，减少对栈的使用
%这仍然是递归

% N 阶乘
fac2(N) -> fac2(N,1).


fac2(0,Acc) -> Acc;
fac2(N,Acc) -> fac2(N-1,N*Acc).%每一次递归都会对当前递归进行求值

len2(L) -> len2(L,0).

len2([],Acc) -> Acc;
len2([_|L],Acc) -> len2(L,Acc+1).
 
