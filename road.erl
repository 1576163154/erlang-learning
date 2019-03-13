-module(road).
-compile(export_all).

main() -> File = "road.txt",
        {ok,Content} = file:read_file(File),
        A = parse_map(Content),
        optimal_path(A).

%带一个参数
main([Filename]) ->
    {ok,Content} = file:read_file(Filename),
        A = parse_map(Content),
        io:format("~p~n",[optimal_path(A)]),
        erlang:halt().

parse_map(Binary) when is_binary(Binary) -> parse_map(binary_to_list(Binary));
parse_map(Str) when is_list(Str) -> Values = [list_to_integer(X) || X <- string:tokens(Str, "\r\n\t ")],
                                    group_vals(Values,[]).

group_vals([],Acc) -> lists:reverse(Acc);
group_vals([A,B,X|Rest],Acc) -> group_vals(Rest, [{A,B,X} | Acc]).

shortest_step({A,B,X}, {{DistA, PathA}, {DistB, PathB}}) -> 
    OptA1 = {DistA + A, [{a,A} | PathA]},
    OptA2 = {DistB + B + X, [{x,X}, {b,B} | PathB]},
    OptB1 = {DistB + B, [{b,B}|PathB]},
    OptB2 = {DistA + A + X, [{x,X},{a,A} | PathA]},
    {erlang:min(OptA1,OptA2),erlang:min(OptB1,OptB2)}.

optimal_path(Map) -> 
    {A,B} = lists:foldl(fun shortest_step/2, {{0, []}, {0, []}},Map),
    {_Dist,Path} = if hd(element(2,A)) =/= {x,0} -> A;
                      hd(element(2,B)) =/= {x,0} -> B
                    end,
                    lists:reverse(Path).

add(A,B) -> A+B.
sum(L) -> lists:foldl(fun add/2,0,L).
