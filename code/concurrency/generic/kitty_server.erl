-module(kitty_server).

-export([start_link/0, order_cat/4, return_cat/2, close_shop/1]).
-export([init/1, handle_call/3, handle_cast/2]).


-record(cat, {name, color=green, description}).

%% Client API
start_link() ->
	my_server:start_link(?MODULE, []).

%% Synchronous call
order_cat(Pid, Name, Color, Description) ->
	my_server:call(Pid, {order, Name, Color, Description}).

%% This call is async
return_cat(Pid, Cat =  #cat{}) ->
	my_server:cast(Pid, {return, Cat}).

%% Synchronous call
close_shop(Pid) ->
	my_server:call(Pid , terminate).

%% server functions (functions that are called from server.)
init([]) -> [].

handle_call({order, Name, Color, Description}, From, Cats) ->
	if Cats =:= [] ->
			my_server:reply(From, make_cat(Name, Color, Description)),
			Cats;
	   Cats =/= [] ->
			my_server:reply(From, hd(Cats)),
			tl(cats)
	end;

handle_call(terminate, From, Cats) ->
	my_server:reply(From, ok),
	terminate(Cats).

handle_cast({return, Cat=#cat{}}, Cats) ->
	[Cat|Cats].



%%% Private functions
make_cat(Name, Color, Desc) ->
	#cat{name=Name, color=Color, description=Desc}.

terminate(Cats) ->
	[io:format("~p was set free. ~n", [C#cat.name]) || C <- Cats],
	exit(normal).
	



