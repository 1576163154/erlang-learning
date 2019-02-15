-module(recursion).
-export([fac/1]).
-export([len/1,fac2/1,len2/1]).
-export([duplicate/2,duplicate2/2]).
-export([reverse/1,reverse2/1,reverse3/1]).
-export([zip2/2]).
-export([test/1]).

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
 
%more recursion function

duplicate(0,_) -> [];
duplicate(N,Val) when N > 0 -> [Val | duplicate(N-1,Val)].

%tail recursion version

duplicate2(N,Val) -> duplicate2(N,Val,[]).

duplicate2(0,Val,Temp) -> Temp;
duplicate2(N,Val,Temp) when N>0 -> duplicate2(N-1,Val,[Val|Temp]). %误用 [Temp|Val]
%[Head|List] 这个表达式： 将Head 插入 List 的最前面作为第一个元素

reverse([]) -> [];
reverse([Head|Rest]) -> reverse(Rest)++[Head].

reverse2(List) -> reverse2(List,[]).

reverse2([],Temp) -> Temp;
reverse2([Head|Rest],Temp) -> reverse2(Rest,[Head|Temp]).

%erlang 自带的 lists:reverse/1
% lists:reverse([4,3,2]).

%assigment zip tail recursion version
zip2(A,B) -> lists:reverse(zip2(A,B,[])).

%递归基准
zip2([],B,Temp) -> Temp;
zip2(A,[],Temp) -> Temp;
zip2([],[],Temp) -> Temp;

zip2([Ahead|Arest],[Bhead|Brest],Temp) -> zip2(Arest,Brest,[{Ahead,Bhead}|Temp]).

reverse3(List) ->lists:reverse(List).

test([H|Rest]) ->
    [Smaller || Smaller <- Rest,Smaller =< H]. %not <=
    