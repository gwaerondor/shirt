-module(ericsson).
-export([encrypt/2]).

encrypt(Text, Seed) ->
    rand:seed(exsplus, {1, 2, Seed}),
    C = lists:seq(32, 126),
    F = lists:sort([{rand:uniform(), X} || X <- C]),
    T = lists:zip(C, [X || {_, X} <- F]),
    I = [spawn(fun Encrypt() ->
		       receive {Pid, Idx, In} ->
			       Pid ! {Idx, Out},
			       Encrypt()
		       end
	       end) || {In, Out} <- T],
    E = lists:zip(lists:seq(1, length(Text)), Text),
    P = self(),
    [lists:nth(X - 31, I) ! {P, Idx, X} || {Idx, X} <- E],
    G = [receive Result ->
		 Result
	 end || _ <- Text],
    [X || {_, X} <- lists:sort(G)].
