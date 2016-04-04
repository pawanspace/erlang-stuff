-module(useless).

-export([add/2, say_hello/0, say_hello_and_add/2]).

-define(sum(A,B), A+B).

-ifdef(DEBUGMODE).
-define(DEBUG(S), io:format("dbg:"++S)).
-else.
-define(DEBUG(S), ok).
-endif.

add(A,B) ->
  ?DEBUG("Trying to add two numbers ~n"),
  ?sum(A,B). % add Two numbers
  
%% Hello world in erlang
say_hello() ->
  io:format("Hello world ~n").  

say_hello_and_add(A,B) ->
  say_hello(),
  add(A,B).