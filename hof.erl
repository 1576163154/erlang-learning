-module(hof).

-compile(export_all).
%higer order funciton

one() -> 1.
two() -> 2.

add(X,Y) -> X() + Y().

%在 werl 中使用
% hof:add(fun hof:one/0,fun hof:two/0).

%map 传入函数对List每个元素进行处理
incre([]) -> [];
incre([H|R]) -> [H+1|incre(R)].

desc([]) -> [];
desc([H|R]) -> [H-1|desc(R)].


%更加通用的形式
map(Func,[]) -> [];
map(Func,[H|R]) -> [Func(H)|map(Func,R)].

add1(X) -> X + 1.
sub1(X) -> X - 1.

%匿名函数
%Afun = afun() -> haha end.

basa(A) -> 
    B = A+1,
    F = fun() -> C = A*B end, % C只属于 匿名函数作用域
    F().

%% only keep even numbers
even(L) -> lists:reverse(even(L,[])).
 
even([], Acc) -> Acc;
even([H|T], Acc) when H rem 2 == 0 ->
even(T, [H|Acc]);
even([_|T], Acc) ->
even(T, Acc).

even2(L) -> lists:reverse(even2(L,[])).
 
even2([], Acc) -> Acc;
even2([H|T], Acc) when H rem 2 == 0 -> even(T, [H|Acc]).

fold(Func,Start,[]) -> Start;
fold(Func,Start,[H|T]) -> fold(Func,Func(H,Start),T).

bigger(A,B) when A > B -> A;
bigger(A,B) -> B.