-module(gen_foo).
-export([behaviour_info/1]).

behaviour_info(callbacks) ->
  [
    {foo, 0}, % in format Function = atom(), Arity = number()
    {bar, 1},
    {baz, 2}
  ];
behaviour_info(_Other) ->
  undefined.
