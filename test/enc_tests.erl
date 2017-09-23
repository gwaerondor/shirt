-module(enc_tests).
-include_lib("eunit/include/eunit.hrl").

both_versions_should_have_the_same_encryption_result_test() ->
    Input = "This is my text.",
    Seed = 1337,
    Result_1 = ericsson:encrypt(Input, Seed),
    Result_2 = enc:encrypt(Input, Seed),
    ?assertEqual(Result_1, Result_2).
    
