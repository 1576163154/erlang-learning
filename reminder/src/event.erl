-module(event).
-compile(export_all).
-record(state,{
    server,
    name = "",
    to_go = 0
}).




%%单次定时器时长50天
%%将更大的时间转为 [A,B,C……] A+B+C …… = Seconds
normalize(Seconds) -> 
    Limit = 49*24*60*60,
    [Seconds rem Limit | lists:duplicate(Seconds div Limit, Limit)]. %rem 取模运算符，div  / 取整

loop(S = #state{server = Server,to_go = [T|Next]}) ->
    receive
        {Server, Ref, cancel} ->
            Server ! {Ref, ok}
    after T*1000 ->
        if Next =:= [] ->
            Server ! {done, S#state.name};
           Next =/= [] ->
               loop(S#state{to_go = Next})
        end
    end
.

start(EventName, Delay) ->
    spawn(?MODULE, init, [self(), EventName, Delay]).

start_link(EventName, Delay) ->
    spawn_link(?MODULE, init, [self(), EventName, Delay]).

time_to_go(TimeOut = {{Year, Month, Day}, {Hour, Minute, Seconds}}) ->
    Now = calendar:local_time(),
    Sec = calendar:datetime_to_gregorian_seconds(TimeOut) - 
            calendar:datetime_to_gregorian_seconds(Now),
    LastSeconds = if Sec > 0 -> Sec;
                     Sec =< 0 -> 0
                    end,
    normalize(LastSeconds).


init(Server, EventName, Delay) ->
    loop(#state{
        server = Server,
        name = EventName,
        to_go = normalize(Delay)
    }).



cancel(Pid) ->
    Ref = erlang:monitor(process, Pid),
    Pid ! {self(), Ref, cancel},
    receive 
        {Ref, ok} ->
            erlang:demonitor(Ref, [flush]),
            ok;
        {"DOWN", Ref, process, Pid, _Reason} ->
            ok
        end
    .
