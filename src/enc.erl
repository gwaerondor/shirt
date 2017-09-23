-module(enc).
-export([encrypt/2]).

encrypt(Text, Seed) ->
    set_seed(Seed),
    Map = make_substitution_map(),
    [substitute_char(C, Map) || C <- Text].

set_seed(Seed) ->
    rand:seed(exsplus, {1, 2, Seed}).

make_substitution_map() ->
    Candidate_chars = lists:seq($\s, $~),
    Values = [rand:uniform() || _ <- lists:seq(1, length(Candidate_chars))],
    Valued_chars = lists:zip(Values, Candidate_chars),
    Sorted = lists:sort(Valued_chars),
    Rearranged = [C || {_, C} <- Sorted],
    lists:zip(Candidate_chars, Rearranged).

substitute_char(C, Map) ->
    proplists:get_value(C, Map).
