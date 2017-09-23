-module(encryption_tests).
-include_lib("eunit/include/eunit.hrl").

both_modules_should_encrypt_the_same_test() ->
    Input = "This is my string",
    Seed = 1337,
    Result_1 = ericsson:encrypt(Input, Seed),
    Result_2 = enc:encrypt(Input, Seed),
    ?assertEqual(Result_1, Result_2).
