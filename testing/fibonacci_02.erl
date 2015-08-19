-module(fibonacci_02).
-include_lib("eunit/include/eunit.hrl").

fib(_) -> ok.

fibonacci_negative_test() -> undefined = fib(-5).
