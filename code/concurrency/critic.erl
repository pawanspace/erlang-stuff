-module(critic).
-compile(export_all).

start_critic() ->
	spawn(?MODULE, restarter, []).

restarter() ->
	process_flag(trap_exit, true),
	Pid = spawn_link(?MODULE, critic, []),
	register(critic, Pid),

	receive
		{'EXIT', Pid, normal} -> % Did not crash
			ok;
		{'EXIT', Pid, shutdown} -> % manual termination and did not crash
			ok;
		{'EXIT', Pid, _} ->
			restarter()
	end.
	
% No need to pass Pid get process from registry using atom.
judge(Band, Album) ->
	Ref = make_ref(),
	% Here critic is atom registered in restarter method.
	critic ! {self(), Ref,  {Band, Album}}, 
	receive
		{Ref, Criticism} -> Criticism
	after 2000 ->
			timeout
	end.

critic() ->
	receive 
		{From, Ref, {"A R Rahman", "Swades"}} ->
			From ! {Ref, "He is awesome"};
		 {From, Ref, {"Anu Malik", "Anything"}} ->
			From ! {Ref, "He is a piece of shit!"};
		{From, Ref, {"Himesh", "All albums"}} ->
			From ! {Ref, "He is ok!"};
		{From, Ref, {_Band, _Album}} ->
			From ! {Ref, "Everything else is stupid"}
	end,
	critic().
