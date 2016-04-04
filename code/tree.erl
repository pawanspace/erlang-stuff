%% {node,{key, value, Smaller, Larger}}
-module(tree).

-export([empty/0, insert/3, lookup/2]).

empty() -> {node, 'nil'}.


insert({node, 'nil'}, Key, Value) ->
	{node, {Key, Value, 'nil', 'nil'}};

insert({node, {Key, Value, Smaller, _}},NewKey, NewValue) when NewKey > Key  -> 
	{node, {Key, Value, Smaller, insert({node, 'nil'}, NewKey, NewValue)}};		

insert({node, {Key, Value, _, Larger}},NewKey, NewValue) when NewKey < Key  -> 
	{node, {Key, Value, insert({node, 'nil'}, NewKey, NewValue), Larger}};

insert({node, {Key, _, Smaller, Larger}}, Key, Value) ->			
	{node, {Key, Value, Smaller, Larger}}.


lookup('nil', _) ->
	'nil';

lookup({node, 'nil'}, _) ->
	'nil';

lookup({node, {Key,Value,Smaller,Larger}}, Key) ->
	{node, {Key,Value,Smaller,Larger}};

lookup({node, {OtherKey,_,Smaller,_}}, Key) when Key < OtherKey ->
	lookup(Smaller, Key);

lookup({node, {OtherKey,_,_,Larger}}, Key) when Key > OtherKey ->
	lookup(Larger, Key).

	



