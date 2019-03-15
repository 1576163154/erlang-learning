-module(proc).
-compile(export_all).

%do not use fun
func() -> 
    A = 2+2,
    io:format("~n~p",[A]).
add(A,B) -> A+B.

% spawn(fun proc:func/0).


 func(X) -> timer:sleep(100), 
            io:format("~p~n", [X]).

% [spawn(proc,func,[X]) || X <- lists:seq(1,10)].

%ipc

%接收消息，通过io 输出
dolphin1() ->
    % receive ? switch(msg)?
    receive
        do_a_flip -> 
            io:format("~n received do a flip");
        fish -> 
            io:format("~n received fish");
        _ ->
            io:format("~n received other info")
        end
    .

%  Pid = spawn(proc,dolphin1,[]).
%  Pid ! fish.


%直接给 源进程回复消息
dolphin2() ->
    receive
        {FromPid, do_a_flip} ->
            FromPid ! "received do a flip";
        {FromPid, fish} -> 
             FromPid ! "received fish";
        {FromPid, _} ->
             FromPid ! "received ohter info"
        end
    .
%  Pid2 = spawn(proc,dolphin2,[]).
%  Pid2 ! {self(), do_a_flip}. 
%  flush().

dolphin3() ->
    receive
        {From, do_a_flip} ->
            From ! "How about no?",
            dolphin3();%通过递归 不让进程结束
        {From, fish} ->
            From ! "So long and thanks for all the fish!";
            %之后没有再调用自己不能发信息
        _ ->
            io:format("Heh, we're smarter than you humans.~n"),
            dolphin3()
        end
    .
