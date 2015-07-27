-module(crash_server).
-export([loop/0]).

loop() ->
  receive
    {From, type1, Message} ->
      % ...
      loop();
    {From, type2, Message} ->
      % ...
      loop();
    {From, terminate} ->
      From ! {self(), ok};
    {From, exit} ->
      exit(failure);
    _ ->
      loop()
  end.
