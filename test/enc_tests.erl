-module(enc_tests).
-include_lib("eunit/include/eunit.hrl").

both_versions_should_have_the_same_encryption_result_test() ->
    Input = "This is my text.",
    Seed = 1337,
    Result_1 = ericsson:encrypt(Input, Seed),
    Result_2 = enc:encrypt(Input, Seed),
    ?assertEqual(Result_1, Result_2).

decrypt_test() ->
    Input = "Welcome to the Velvet Room",
    Seed = 3113,
    Enc = enc:encrypt(Input, Seed),
    Result = enc:decrypt(Enc, Seed),
    ?assertEqual(Input, Result).

decrypt_shirt_test() ->
    Shirt_text = "M$8xU=c_ux5=ux;=u_x8[",
    Shirt_seed = 3,
    Expected = "You might fit with us",
    Result = enc:decrypt(Shirt_text, Shirt_seed),
    ?assertEqual(Expected, Result).
