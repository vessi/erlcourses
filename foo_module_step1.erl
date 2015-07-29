-module(foo_module_step1).
-behavior(gen_foo).

foo() ->
  ok.
bar(_) ->
  ok.
