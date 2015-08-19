-module(fibonacci_05).
-include_lib("eunit/include/eunit.hrl").

fib(0) -> 0;
fib(1) -> 1;
fib(N) when N < 0 -> undefined;
fib(N) -> fib(N-1)+fib(N-2).

fibonacci_negative_test() -> undefined = fib(-5).
fibonacci_0_test() -> 0 = fib(0).
fibonacci_1_test() -> 1 = fib(1).
fibonacci_2_test() -> 1 = fib(2).
fibonacci_5_test() -> 5 = fib(5).
