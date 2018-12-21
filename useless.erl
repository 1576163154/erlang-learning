-module(useless).  % 定义module name：useless
-import(io,[format/1]).

%定义modle函数
-export([add/2,hello/0,hello_and_add/1]).     
add(A,B) -> A + B.  %函数的具体操作

hello() -> 
    format("call format（） directly！~n"), %-import 直接调用
    io:format("Hello,world!~n"). %


%函数中调用函数
hello_and_add(A) ->
    hello(),
    add(A,2).

