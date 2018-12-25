-module(functions).
-import(io,[format/1,format/2]).
-compile(export_all).

%pattern matching
head([ H | _ ]) ->
    H.

second([ _ ,S | _]) ->
    S.


%用模式匹配处理分支
valid_time({Date= {Y,M,D}, Time = {H,Min,S}}) ->
    format("Date tuple (~p) says today is : ~p/~p/~p,~n",[Date,Y,M,D]),
    format("Time tuple (~p) indicates ~p/~p/~p,~n",[Time,H,Min,S]);
valid_time(_) ->
    format("Wrong data！！").