-module(functions).

-export([first/1, second/1, last/1, same/2, valid_date/1, right_age/1, wrong_age/1]).

first([H|_]) ->
	H.

second([_,S|_]) ->
	S.

last ([_|L]) ->
	L.

same(X, X) ->
	true;
same(_, _) ->
	false.

valid_date({Date = {Y, M, D}, Time = {H, Min, S}}) ->
	io:format("Tuple ~p has date ~p/~p/~p~n",[Date, Y, M, D]),
	io:format("Tuple ~p has time ~p:~p:~p~n",[Time, H, Min, S]);
valid_date(_) ->
	io:format("Please feed me correct data").

%% When is a guard here: PW:Note: comma(,) between conditions repersents and condition
right_age(Age) when Age > 4, Age =< 104 ->
	true;
right_age(Age) ->
	false.

%% When is a guard here semicolon(;) repersents or condition
wrong_age(Age) when Age < 4; Age > 104 ->
	true;
wrong_age(Age) ->
	false.



