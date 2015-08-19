-module(fibonacci_04).
-include_lib("eunit/include/eunit.hrl").

fib(_) -> undefined.

fibonacci_negative_test() -> undefined = fib(-5).
fibonacci_0_test() -> 0 = fib(0).
fibonacci_1_test() -> 1 = fib(1).
fibonacci_2_test() -> 1 = fib(2).
fibonacci_5_test() -> 5 = fib(5).
