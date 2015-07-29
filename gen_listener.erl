-module(gen_listener).
-export([init/1, behaviour_info/1]).

init(Mod) ->
  spawn(fun() -> loop(Mod) end).

behaviour_info(callbacks) ->
  [{parse_message, 1}];
behaviour_info(_Others) ->
  undefined.

loop(Mod) ->
  receive
    terminate ->
      ok;
    Message ->
      Mod:parse_message(Message),
      loop(Mod)
  after 0 ->
    loop(Mod)
  end.
