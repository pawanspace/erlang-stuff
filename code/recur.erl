-module(recur).

-export([fac/1, tail_fac/2, tail_len/2, tail_duplicate/3, 
        tail_reverse/2, tail_sublist/3,
        tail_zip/3, quicksort/1, lc_quicksort/1]).

fac(0) ->
  1;
fac(X) when X > 0 ->
  X*fac(X-1).
  
  
tail_fac(0, Acc) ->
  Acc;
tail_fac(X, Acc) ->
   tail_fac(X-1, X*Acc).
   
   
tail_len([], Acc) ->
  Acc;
tail_len([_|L], Acc) -> % when you use underscore there is no warning of unused variable
  tail_len(L, Acc + 1).     


tail_duplicate(0, _, F) ->
  F;
tail_duplicate(C, T, F) ->
  tail_duplicate(C-1,T,[T|F]).
  
tail_reverse([],T) ->
  T;
tail_reverse([F|L],T) ->
  tail_reverse(L,[F|T]).
  
  
tail_sublist(_, N , Acc) when N =< 0 ->
  tail_reverse(Acc,[]);  
tail_sublist([], N, Acc) when N > 0 ->
  tail_reverse(Acc,[]);
tail_sublist([F|L], N, Acc) when N > 0 ->
  tail_sublist(L, N-1, [F|Acc]).
  
  
tail_zip([],_,Acc) ->
  Acc;
tail_zip(_,[],Acc) ->
  Acc;
tail_zip([F|A],[S|B],Acc) ->
  tail_zip(A,B,[{F,S}|Acc]). 

partition(_,[],Smaller,Larger) ->
  {Smaller, Larger};
partition(Pivot, [L|Rest], Smaller, Larger) ->
  if  L < Pivot ->
    partition(Pivot, Rest, [L|Smaller], Larger);
  L > Pivot ->
    partition(Pivot, Rest, Smaller, [L|Larger])
  end.    

quicksort([]) -> [];
quicksort([Pivot|Rest]) ->
  {Smaller, Larger} = partition(Pivot,Rest,[],[]),
  quicksort(Smaller) ++ [Pivot] ++ quicksort(Larger).
  

lc_quicksort([]) -> [];
lc_quicksort([Pivot|Rest]) -> 
  lc_quicksort([Smaller || Smaller <- Rest, Smaller =< Pivot])
  ++ [Pivot] ++
  lc_quicksort([Larger || Larger <- Rest, Larger > Pivot]).



  