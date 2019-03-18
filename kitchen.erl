-module(kitchen).
-compile(export_all).

fridge1() ->
    receive
        {From, {store, _Food}} ->
            From ! {self(), ok},
            fridge1();
        {From, {take,_Food}} ->
            From ! {self(), not_found},
            fridge1();
        terminate ->
            ok
        end
    .

fridge2(FoodList) ->
    receive
        {From, {store, _Food}} ->
            From ! {self(), ok},
            fridge2([_Food | FoodList]);
        {From, {take, _Food}} ->
            case lists:member(_Food,FoodList) of
                true ->
                    From ! {self(), {ok, _Food}},
                    fridge2(lists:delete(_Food,FoodList));
                false ->
                    From ! {self(), {not_found, _Food}},
                    fridge2(FoodList)
                end
            ;
        terminate ->
            ok
        end
    .

%% 将 store 和 take 实现为方法
store(Pid, Food) ->
    Pid ! {self(), {store, Food}},
    %并在方法中处理消息
    receive
        {From, Msg} -> Msg
    end
.

take(Pid, Food) ->
    Pid ! {self(), {take, Food}},
    receive
        {From, Msg} -> Msg
    end
.


%%为消息接受增加 超时 处理  millsecond 
store2(Pid, Food) ->
    Pid ! {self(), {store, Food}},
    %并在方法中处理消息
    receive
        {From, Msg} -> Msg
    after 3000 ->
        timeout
    end
.

take2(Pid, Food) ->
    Pid ! {self(), {take, Food}},
    receive
        {From, Msg} -> Msg
    after 3000 ->
        timeout
    end
.

%将创建线程也实现为方法
start(FoodList) ->
    spawn(?MODULE, fridge2, [FoodList]).


%%selective Receives
important() ->
    receive
        {Priority, Msg} when Priority > 10 ->
            [Msg | important()]
    after 0 ->
        normal()
    end.

normal() ->
    receive
        {_, Msg} ->
            [Msg | normal()]
    after 0 ->
        []
    end.


