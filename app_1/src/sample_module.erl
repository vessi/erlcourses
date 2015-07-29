-module(sample_module).
-export([start/0]).

-include("sample_include.hrl").

start() ->
  io:format("Hello World!~n").
