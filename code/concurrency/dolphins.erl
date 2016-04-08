-module(dolphins).

-compile(export_all).

dolphin1() ->
	receive
		{From, do_a_flip} ->
			From ! "How about no?";
		{From, fish} ->
			From ! "so long and thanks for all the fish!";
		_Shit ->
			io:format("Heh, We're smarter than you humans. ~n")
	end.


