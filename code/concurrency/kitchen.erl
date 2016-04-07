-module(kitchen).
-compile(export_all).

store(Pid, Food) ->
	Pid ! {self(), {store, Food}},
	receive
		{Pid, Msg} -> Msg
	after 3000 -> timeout
	end.

take(Pid, Food) ->
	Pid ! {self(), {take, Food}},
	receive
		{Pid, Msg} -> Msg
	after 3000 ->
		timeout
	end.


fridge(FoodList) ->
	receive
		{From, {store, Food}} ->
			From ! {self(), ok},
			fridge([Food|FoodList]);
		{From, {take, Food}} ->
			case lists:member(Food, FoodList) of
				true ->
					From ! {self(), {ok, Food}},
					fridge(lists:delete(Food, FoodList));
				false ->
					From ! {self(), not_found},
					fridge(FoodList)
			end;
		terminate ->
			ok
	end.

start(FoodList) ->
	spawn(?MODULE, fridge, [FoodList]).


sleep(T) ->
	receive
	after T->
			ok
	end.


important() ->
	receive
		{Priority, Message} when Priority > 10 ->
			[Message | important()]
	after 0 ->			
			normal()
	end.

normal() ->
	receive
		{_, Message} ->
			[Message | normal()]
	after 0 ->
			[]
	end.
						

