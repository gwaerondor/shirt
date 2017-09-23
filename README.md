# Shirt
When I went on a business trip to Finland, my colleagues gave me a super cool Erlang shirt.
This repo contains an implementation of the shirt.

## Sounds like a riddle...
Here's the shirt.
![alt text](https://github.com/gwaerondor/shirt/raw/master/shirt.jpg "The shirt.")

It has a weird string at the end, ```M$8xU=c_ux5=ux;=u_x8[```, which probably is the output of a certain string that has been encrypted with this algorithm. So I guess the only thing to do is to write a function that decrypts it...

## Progress report
- I have written a refactored version of the module. While doing this, I realized that the encryption method that is being used is a substitution cipher with random substitutions.

- I have broken the cipher through a brute-force attack. Though not much force was needed. This is how I did it.

I assumed that a string of length 20 must have at least one character that is a space. I know that the original string must also be of length 20 as it is a substitution cipher. This would make it easier to sort out at least some of the hits.

```erlang
Enc = "M$8xU=c_ux5=ux;=u_x8[",
Contains_space = fun(L) -> lists:any(fun($\s) -> true; (_) -> false end, L) end,
Dec = [{Seed, enc:decrypt(Enc, Seed)} || Seed <- lists:seq(0, 1000)],
Filtered = [{Seed, D} || {Seed, D} <- Dec, Contains_space(D)].
```

In the resulting list we will see quite quickly that the seed was 3, so the filtering proved to be quite unnecessary. A manual brute-force trying a few seeds would be enough to break it.

```erlang
[{2,"sp z*0k64ze04z?046z r"},
 {3,"You might fit with us"},
 {8," }u{4al5Q{KaQ{gaQ5{uw"}|...]
```
