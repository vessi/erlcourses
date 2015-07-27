-module(com_server).
-export([listen/0]).

listen() ->
  receive
    {hello, Name} ->
      io:format("Hello, ~s~n", [Name]),
      listen();
    {bye, Name} ->
      io:format("Bye, ~s~n", [Name]),
      listen();
    _ ->
      listen()
  end.
