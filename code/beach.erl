-module(beach).

-export([beach/1]).

beach(Temperature) ->
	case Temperature of
		{celsius, N} when N >=20,
						  N =< 45 ->
			'favourable';
		{kelvin, N} when N >= 293, 
						 N =< 318 ->
			'scientifically favourable'; %% atoms are enclosed in single qoutes if contains spaces or special chars
		{fahrenheit, N} when N >= 68,
							 N =< 113 ->
			'favourable in US';
		_ ->
			'avoid beach'
	end.
