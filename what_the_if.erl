-module(what_the_if).
-export([heh_fine/0,oh_god/1,help_me/1,insert/2]).

heh_fine() ->
    if 1 =:= 1 ->
        works
    end,
    if 1 =:= 2 ->
        works
    end,
    if 1 =:= 2, 1 =:= 1 ->
        fails
    end.

oh_god(X) ->
    if X =:= 3 ->
        succeed;
    true -> always_does
end.


help_me(Animal) ->
    Talk = if Animal == dog -> "meow";
              Animal == beef -> "mooo";
              true -> "jdlkjflka"
            end,
            {Animal ,"says " ++ Talk ++ " !"}.

    

%in the case of
insert(X,[]) ->
    [X];
insert(X,Set) ->
    case lists:member(X,Set) of 
        true -> Set;
        false -> [X|Set]
    end.
