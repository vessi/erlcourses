class: center, middle

![Hey, Erlang](/images/hey_erlang.svg)
# Pre-alpha [Kottans](http://kottans.org) courses

---
class: center,middle

# Concurrency, scaling, multiprocessing
## Lecture 5.
---
class: center,middle
# Processes
---
class: center
# Processes

<p align="center">
  <img src="/images/5_process.svg" height="70%" width="70%" />
</p>
---
# Processes

Processes in Erlang are built-in concept. Here are few key notes about processes in Erlang:
---
# Processes

Processes in Erlang are built-in concept. Here are few key notes about processes in Erlang:

* they are isolated
---
# Processes

Processes in Erlang are built-in concept. Here are few key notes about processes in Erlang:

* they are isolated
* they have their own garbage collector (GC) per process
---
# Processes

Processes in Erlang are built-in concept. Here are few key notes about processes in Erlang:

* they are isolated
* they have their own garbage collector (GC) per process
* they have no shared state
---
# Processes

Processes in Erlang are built-in concept. Here are few key notes about processes in Erlang:

* they are isolated
* they have their own garbage collector (GC) per process
* they have no shared state
* they are cheap
---
# Processes

Processes in Erlang are built-in concept. Here are few key notes about processes in Erlang:

* they are isolated
* they have their own garbage collector (GC) per process
* they have no shared state
* they are cheap
* they are VM-based, not OS-based
---
# Processes

Processes in Erlang are built-in concept. Here are few key notes about processes in Erlang:

* they are isolated
* they have their own garbage collector (GC) per process
* they have no shared state
* they are cheap
* they are VM-based, not OS-based
* they can communicate via messages
---
# Processes

Processes in Erlang are built-in concept. Here are few key notes about processes in Erlang:

* they are isolated
* they have their own garbage collector (GC) per process
* they have no shared state
* they are cheap
* they are VM-based, not OS-based
* they can communicate via messages
* they can spawn and be spawned by another process
---
# Processes

Processes in Erlang are built-in concept. Here are few key notes about processes in Erlang:

* they are isolated
* they have their own garbage collector (GC) per process
* they have no shared state
* they are cheap
* they are VM-based, not OS-based
* they can communicate via messages
* they can spawn and be spawned by another process
* in case of fault they can send message to spawner with fault description
---
class: center,middle
# Processes
## Spawn
---
# Processes
## Spawn
---
# Processes
## Spawn

Let's spawn some processes. This is `hello_server.erl`, our precisious server.

```erlang
-module(hello_server).
-export([loop/0]).

loop() ->
  loop().
```
---
# Processes
## Spawn

Now let's compile and spawn it!

```erlang-repl
1> c(hello_server).
{ok, hello_server}
2> Client = spawn(fun hello_server:loop/0).
<0.98.0>
3> i(). % this is like ps in *nix
Pid                   Initial Call                          Heap     Reds Msgs
Registered            Current Function                     Stack
<0.0.0>               otp_ring0:start/2                      610     5895    0
init                  init:loop/1                              2
% ...
<0.98.0>              erlang:apply/2                         233 20621685    0
                      hello_server:loop/0                      0
% here is our server
Total                                                      40075 43316007    1
                                                             239
```
---
# Processes
## Spawn

Spawn knows about other nodes. You can spawn function on other node. 

Launch node 1:
```shell
node1> erl -sname node1 -setcookie secret
```
Launch node 2:
```shell
node2> erl -sname node2 -setcookie secret
```
---
# Processes
## Spawn

Spawn knows about other nodes. You can spawn function on other node. 

On node1:
```erlang-repl
1> RemoteClient = spawn('node2@localhost', fun hello_server:loop/0).
<10095.72.0>
```
On node2:
```erlang-repl
1> i().
Pid                   Initial Call                          Heap     Reds Msgs
Registered            Current Function                     Stack
<0.72.0>              net_kernel:spawn_func/6                233 12425589    0
                      hello_server:loop/0                      0
Total                                                      68150 12439263    0
                                                             297
```

Your first semi-distributed app is ready! But don't shut down nodes, we'll need them.
---
class: center,middle
# Processes
## Messages
---
# Processes
## Messages

How do processes communicate if they are isolated? They send messages! Each process has his own mailbox. Let's take a look.
---
# Processes
## Messages

How do processes communicate if they are isolated? They send messages! Each process has his own mailbox. Let's take a look.

On node 1:
```erlang-repl
2> RemoteClient ! {hello, world}
{hello, world}
```
---
# Processes
## Messages

How do processes communicate if they are isolated? They send messages! Each process has his own mailbox. Let's take a look.

On node 1:
```erlang-repl
2> RemoteClient ! {hello, world}
{hello, world}
```

On node 2 take PID from i() output and:
```erlang-repl
2> Pid = list_to_pid("<0.72.0>").
<0.72.0>
3> process_info(Pid, message_queue_len).
{message_queue_len,1}
4> process_info(Pid, messages).
{messages,[{hello,world}]}
```
---
class: center,middle
# Processes
## Messages (receiving)
---
# Processes
## Messages (receiving)
---
# Processes
## Messages (receiving)

So we need not only receive messages but also receive them. We can do it by tricky way like

```erlang
Mailbox = process_info(self(), messages),
[H|T] = Mailbox. % KILL ME PLS
```
---
# Processes
## Messages (receiving)

But on last lecture we have learnt less tricky way, the glorious `receive` function. So let's create `com_server.erl`

```erlang
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
```

This will create listen loop.

*Special note*. Can you find more DRY way to do this?
---
# Processes
## Messages (receiving)

Let's try spawn our process and send message to it.

```erlang-repl
1> c(com_server).
{ok, com_server}
2> Pid = spawn(fun com_server:listen/0).
<0.71.0>
3> Pid ! "World"
Hello, World
ok
```
---
class: center,middle
# Processes
## Terminating (suicide)
---
# Processes
## Terminating (suicide)

In general there are two ways to do this - normal and with exception.
---
# Processes
## Terminating (suicide)

In general there are two ways to do this - normal and with exception.

```erlang
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
      exit(failure); % if catched, transformed to message {'EXIT', failure}
    _ ->
      loop()
  end.
```
---
class: center,middle
# Processes
## Selective receive
---
# Processes
## Selective receive
---
# Processes
## Selective receive

Sometimes you need to pass some of messages first and all other after. This is the way how it's implemented in `selective.erl`

```erlang
-module(selective).
-export([important/0]).

important() ->
  receive
    {Priority, Message} when Priority > 10 ->
      [Message | important()]
    after 0 ->
      normal()
  end.
 
normal() ->
  receive
    {_, Message} ->
      [Message | normal()]
    after 0 ->
      []
  end.
```
---
# Processes
## Selective receive

Let's take a look, how it works.

```erlang-repl
1> c(selective).
{ok,selective}
2> self() ! {15, high}, self() ! {7, low}, self() ! {1, lowest}, self() ! {17, highest}.
{17,high}
3> process_info(self(), messages).
{messages,[{15,high},{7,low},{1,lowest},{17,highest}]}
4> selective:important().
[high,highest,low,lowest]
```

*Special note:* Please rewrite this module to take care of ranges of priorities without numbers, just by atoms:

* lowest
* low
* high
* highest
---
class:center,middle
# Processes
## Registered processes
---
# Processes
## Registered processes
---
# Processes
## Registered processes

Processes can be registered to avoid entering or passing PIDs. Take a look at example `registered.erl`:
---
# Processes
##### Registered processes

Processes can be registered to avoid entering or passing PIDs. Take a look at example `registered.erl`:

```erlang
-module(registered).
-export([start/0, ping/1, pong/0]).

ping(0) ->
  pong ! finished,
  io:format("Ping finished~n", []);
ping(N) ->
  pong ! {ping, self()},
  receive
    pong ->
      io:format("Ping received pong~n", [])
  end,
  ping(N - 1).
% continued on next page
```
---
# Processes
##### Registered processes

```erlang
% beginning on previous page
pong() ->
  receive
    finished ->
      io:format("Pong finished~n", []);
    {ping, Ping_PID} ->
      io:format("Pong received ping~n", []),
      Ping_PID ! pong,
      pong()
  end.

start() ->
  register(pong, spawn(registered, pong, [])),
  spawn(registered, ping, [3]),
  ok.
```
---
# Processes
## Registered processes

Let's test them in shell.

```erlang-repl
1> c(registered).
{ok,registered}
2> registered:start().
Pong received ping
<0.151.0>
Ping received pong
Pong received ping
Ping received pong
Pong received ping
Ping received pong
Ping finished
Pong finished
```
---
class: center,middle
# Processes
## Linked processes
---
# Processes
## Linked processes
---
# Processes
## Linked processes

Sometimes it's needed to know when your spawned process crashed. That's why process links exists.
---
# Processes
## Linked processes

Sometimes it's needed to know when your spawned process crashed. That's why process links exists. Take a look at module `linked.erl`

```erlang
-module(linked).
-export([chain/1]).

chain(0) ->
  receive
    _ -> ok
  after 2000 ->
    exit("chain dies here")
  end;
chain(N) ->
  Pid = spawn(fun() -> chain(N-1) end),
  link(Pid),
  receive
    _ -> ok
  end.
```
---
# Processes
## Linked processes

Let's test it in the shell.

```erlang-repl
1> c(linked).
{ok,linked}
2> link(spawn(linked, chain, [3])).
true
** exception error: "chain dies here"
```

What happened here? `chain(3)` linked `chain(2)`, `chain(2)` linked `chain(1)`, `chain(1)` linked `chain(0)`. `chain(0)` received timeout and throwed exception. It was populated upper and upper because of link, so all chains died up to shell. Shell was restarted by supervisor.
---
class: center,middle
# End of Lecture 5
## Subject of next lecture: Introduction into OTP.
---
class: center,middle
# Bye, folks!

<img src="/images/1_joe_notebook.svg" alt="Joe with notebook" height="80%" width="80%" />
