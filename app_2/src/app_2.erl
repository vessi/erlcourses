-module(app_2).
-behaviour(application).

-export([start/2, stop/1]).

start(_Type, _Args) ->
  app_2_sup:start_link().
stop(_Stop) ->
  ok.
