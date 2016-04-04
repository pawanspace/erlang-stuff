-module(hhfun).

-export([map/2, filter/2, fold/3, prepare_alarm/1]).

map(_, []) ->
	[];
map(F, [H|X]) ->
	[F(H)|map(F, X)].
   
filter(_, []) ->
	[];
filter(Pred, [H|X]) ->
	case Pred(H) of
		true -> [H |filter(Pred, X)];
		false -> filter(Pred, X)
	end.

fold(_, [], Acc) ->
	Acc;
fold(F, [H|X], Acc) ->
	fold(F, X, F(Acc, H)).

prepare_alarm(Room) ->
	io:format("Setting alarm for ~s~n", [Room]),
	fun() ->
			io:format("Ringing Alarm for ~s~n", [Room])
	end.
				
						
	

			
