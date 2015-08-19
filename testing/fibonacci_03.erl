-module(fibonacci_03).
-include_lib("eunit/include/eunit.hrl").

fib(_) -> undefined.

fibonacci_negative_test() -> undefined = fib(-5).
