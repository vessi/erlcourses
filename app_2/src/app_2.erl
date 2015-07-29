-module(app_2).
-behaviour(application).

-export([start/2, stop/1]).

start(_Type, _Args) ->
  app_2_sup:start_link(). % we need to launch top level supervisor here
stop(_Stop) ->
  ok.
