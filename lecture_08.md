class: center, middle

![Hey, Erlang](/images/hey_erlang.svg)
# Pre-alpha [Kottans](http://kottans.org) courses
---
class: center,middle

# `gen_server` and `gen_fsm`
## Lecture 8.
---
class: center,middle
# `gen_server` behaviour
---
class: center
# `gen_server` behaviour

<p align="center">
  <img src="/images/8_server.svg" height="80%" width="80%" />
</p>
---
# `gen_server` behaviour

For which purpose server is used? First than all client-server relationship is about sharing resources. So, `gen_server` behaviour is a special behaviour which used when we need to share some resource. Now it's a time to take a look on `gen_server` callbacks.
---
# `gen_server` behaviour

For which purpose server is used? First than all client-server relationship is about sharing resources. So, `gen_server` behaviour is a special behaviour which used when we need to share some resource. Now it's a time to take a look on `gen_server` callbacks.

* `init/1` - special callback to initialize module using `gen_server`.
---
# `gen_server` behaviour

For which purpose server is used? First than all client-server relationship is about sharing resources. So, `gen_server` behaviour is a special behaviour which used when we need to share some resource. Now it's a time to take a look on `gen_server` callbacks.

* `init/1` - special callback to initialize module using `gen_server`.
* `handle_call/3` - callback to handle synchronous calls (for calls which need to return result to client)
---
# `gen_server` behaviour

For which purpose server is used? First than all client-server relationship is about sharing resources. So, `gen_server` behaviour is a special behaviour which used when we need to share some resource. Now it's a time to take a look on `gen_server` callbacks.

* `init/1` - special callback to initialize module using `gen_server`.
* `handle_call/3` - callback to handle synchronous calls (for calls which need to return result to client)
* `handle_cast/2` - callback to handle asynchronous casts (for requests which don't need to return any result)
---
# `gen_server` behaviour

For which purpose server is used? First than all client-server relationship is about sharing resources. So, `gen_server` behaviour is a special behaviour which used when we need to share some resource. Now it's a time to take a look on `gen_server` callbacks.

* `init/1` - special callback to initialize module using `gen_server`.
* `handle_call/3` - callback to handle synchronous calls (for calls which need to return result to client)
* `handle_cast/2` - callback to handle asynchronous casts (for requests which don't need to return any result)
* `handle_info/2` - callback to handle all other requests. If server receives request other than call or cast - it is handled here
---
# `gen_server` behaviour

For which purpose server is used? First than all client-server relationship is about sharing resources. So, `gen_server` behaviour is a special behaviour which used when we need to share some resource. Now it's a time to take a look on `gen_server` callbacks.

* `init/1` - special callback to initialize module using `gen_server`.
* `handle_call/3` - callback to handle synchronous calls (for calls which need to return result to client)
* `handle_cast/2` - callback to handle asynchronous casts (for requests which don't need to return any result)
* `handle_info/2` - callback to handle all other requests. If server receives request other than call or cast - it is handled here
* `terminate/2` - callback which called when your server need to be stopped. All cleanups are performed here
---
# `gen_server` behaviour

For which purpose server is used? First than all client-server relationship is about sharing resources. So, `gen_server` behaviour is a special behaviour which used when we need to share some resource. Now it's a time to take a look on `gen_server` callbacks.

* `init/1` - special callback to initialize module using `gen_server`.
* `handle_call/3` - callback to handle synchronous calls (for calls which need to return result to client)
* `handle_cast/2` - callback to handle asynchronous casts (for requests which don't need to return any result)
* `handle_info/2` - callback to handle all other requests. If server receives request other than call or cast - it is handled here
* `terminate/2` - callback which called when your server need to be stopped. All cleanups are performed here
* `code_change/3` - callback which called when you update your code in realtime. All state migrations go here
---
# `gen_server` behaviour

And now let's take a look how does full flow look like.
---
# `gen_server` behaviour

And now let's take a look how does full flow look like.

* First than all, `gen_server:start` is called. It contains lightweight initialization clauses needed for real server start.
---
# `gen_server` behaviour

And now let's take a look how does full flow look like.

* First than all, `gen_server:start` is called. It contains lightweight initialization clauses needed for real server start.
* After that, `gen_server:start_link` prepares and creates `gen_server` process as a part of supervision tree. It awaits for next function call to complete.
---
# `gen_server` behaviour

And now let's take a look how does full flow look like.

* First than all, `gen_server:start` is called. It contains lightweight initialization clauses needed for real server start.
* After that, `gen_server:start_link` prepares and creates `gen_server` process as a part of supervision tree. It awaits for next function call to complete.
* `?MODULE:init/1` is called by `gen_server:start_link` and returns `{ok, State}` or `{ok, State, Timeout}` or `{ok, State, hibernate}` or `{stop,Reason}`. If timeout is passed, our server will receive `timeout` message each `Timeout` amount of milliseconds. `{ok,State}` is equal to `{ok,State,infinity}`. If `hibernate` atom is passed, `gen_server` will hibernate our target server - this will reduce amount of memory used and number of reductions scheduled for process.
---
# `gen_server` behaviour

And now let's take a look how does full flow look like.

* First than all, `gen_server:start` is called. It contains lightweight initialization clauses needed for real server start.
* After that, `gen_server:start_link` prepares and creates `gen_server` process as a part of supervision tree. It awaits for next function call to complete.
* `?MODULE:init/1` is called by `gen_server:start_link` and returns `{ok, State}` or `{ok, State, Timeout}` or `{ok, State, hibernate}` or `{stop,Reason}`. If timeout is passed, our server will receive `timeout` message each `Timeout` amount of milliseconds. `{ok,State}` is equal to `{ok,State,infinity}`. If `hibernate` atom is passed, `gen_server` will hibernate our target server - this will reduce amount of memory used and number of reductions scheduled for process.
* At time of call, `gen_server:call` or `gen_server:multi_call` take care of call and calls final handler `?MODULE:handle_call/3`. Result can be `{reply,Reply,NewState}`, `{reply,Reply,NewState,Timeout}` or `{reply,Reply,NewState,hibernate}`. `Reply` is forwarded to initial caller, and `Timeout` and `hibernate` operate as in `?MODULE:init/1`. If function returns `{noreply,NewState}`, `{noreply,NewState,Timeout}` or `{noreply,NewState,hibernate}` - `gen_server` will just continue it's execution without sending any answer with `NewState`. Any reply need to be given explicitly using `gen_server:reply/2`. The last option is to reply with `{stop,Reason,Reply,NewState}` or `{stop,Reason,NewState}` - it will initiate `?MODULE:terminate/2`.
---
# `gen_server` behaviour

And now let's take a look how does full flow look like.

* First than all, `gen_server:start` is called. It contains lightweight initialization clauses needed for real server start.
* After that, `gen_server:start_link` prepares and creates `gen_server` process as a part of supervision tree. It awaits for next function call to complete.
* `?MODULE:init/1` is called by `gen_server:start_link` and returns `{ok, State}` or `{ok, State, Timeout}` or `{ok, State, hibernate}` or `{stop,Reason}`. If timeout is passed, our server will receive `timeout` message each `Timeout` amount of milliseconds. `{ok,State}` is equal to `{ok,State,infinity}`. If `hibernate` atom is passed, `gen_server` will hibernate our target server - this will reduce amount of memory used and number of reductions scheduled for process.
* At time of call, `gen_server:call` or `gen_server:multi_call` take care of call and calls final handler `?MODULE:handle_call/3`. Result can be `{reply,Reply,NewState}`, `{reply,Reply,NewState,Timeout}` or `{reply,Reply,NewState,hibernate}`. `Reply` is forwarded to initial caller, and `Timeout` and `hibernate` operate as in `?MODULE:init/1`. If function returns `{noreply,NewState}`, `{noreply,NewState,Timeout}` or `{noreply,NewState,hibernate}` - `gen_server` will just continue it's execution without sending any answer with `NewState`. Any reply need to be given explicitly using `gen_server:reply/2`. The last option is to reply with `{stop,Reason,Reply,NewState}` or `{stop,Reason,NewState}` - it will initiate `?MODULE:terminate/2`.
* The same is actual for `gen_server:cast` or `gen_server:abcast`. Result can be only tuples with `noreply` or `stop` atom.
---
# `gen_server` behaviour

And now let's take a look how does full flow look like.

* First than all, `gen_server:start` is called. It contains lightweight initialization clauses needed for real server start.
* After that, `gen_server:start_link` prepares and creates `gen_server` process as a part of supervision tree. It awaits for next function call to complete.
* `?MODULE:init/1` is called by `gen_server:start_link` and returns `{ok, State}` or `{ok, State, Timeout}` or `{ok, State, hibernate}` or `{stop,Reason}`. If timeout is passed, our server will receive `timeout` message each `Timeout` amount of milliseconds. `{ok,State}` is equal to `{ok,State,infinity}`. If `hibernate` atom is passed, `gen_server` will hibernate our target server - this will reduce amount of memory used and number of reductions scheduled for process.
* At time of call, `gen_server:call` or `gen_server:multi_call` take care of call and calls final handler `?MODULE:handle_call/3`. Result can be `{reply,Reply,NewState}`, `{reply,Reply,NewState,Timeout}` or `{reply,Reply,NewState,hibernate}`. `Reply` is forwarded to initial caller, and `Timeout` and `hibernate` operate as in `?MODULE:init/1`. If function returns `{noreply,NewState}`, `{noreply,NewState,Timeout}` or `{noreply,NewState,hibernate}` - `gen_server` will just continue it's execution without sending any answer with `NewState`. Any reply need to be given explicitly using `gen_server:reply/2`. The last option is to reply with `{stop,Reason,Reply,NewState}` or `{stop,Reason,NewState}` - it will initiate `?MODULE:terminate/2`.
* The same is actual for `gen_server:cast` or `gen_server:abcast`. Result can be only tuples with `noreply` or `stop` atom.
* And `?MODULE:handle_info` is used for all other messages, not cast nor call (for example, exit messages).
---
# `gen_server` behaviour

Good practice is to back your server with methods which will call corresponding `gen_server` call or cast. For example, we decide to create user. So let's start with API call for this:

```erlang
create_user(Name) ->
  gen_server:cast(?SERVER, {create, Name}).
```
---
# `gen_server` behaviour

Good practice is to back your server with methods which will call corresponding `gen_server` call or cast. For example, we decide to create user. So let's start with API call for this:

```erlang
create_user(Name) ->
  gen_server:cast(?SERVER, {create, Name}).
```

And let's add corresponding cast for this:

```erlang
handle_cast({create, Name}, State) ->
  {noreply, [Name|State]};
handle_cast(_Msg, State) ->
  {noreply, State}.
```
---
# `gen_server` behaviour

Good practice is to back your server with methods which will call corresponding `gen_server` call or cast. For example, we decide to create user. So let's start with API call for this:

```erlang
create_user(Name) ->
  gen_server:cast(?SERVER, {create, Name}).
```

And let's add corresponding cast for this:

```erlang
handle_cast({create, Name}, State) ->
  {noreply, [Name|State]};
handle_cast(_Msg, State) ->
  {noreply, State}.
```

This code awaits from us to initialize `State` as a list.

```erlang
init(_Args) ->
  {ok, []}.
```
---
# `gen_server` behaviour

Good practice is to back your server with methods which will call corresponding `gen_server` call or cast. For example, we decide to create user. So let's start with API call for this:

```erlang
create_user(Name) ->
  gen_server:cast(?SERVER, {create, Name}).
```

And let's add corresponding cast for this:

```erlang
handle_cast({create, Name}, State) ->
  {noreply, [Name|State]};
handle_cast(_Msg, State) ->
  {noreply, State}.
```

This code awaits from us to initialize `State` as a list.

```erlang
init(_Args) ->
  {ok, []}.
```

HW Part 1: Please complete this code to be full and complete `gen_server` module. 
---
class: center,middle
# `gen_fsm` behaviour
---
class: center
# `gen_fsm` behaviour

<p align="center">
  <img src="/images/8_fsm.svg" width="80%" height="80%" />
</p>
---
# `gen_fsm` behaviour

`gen_fsm` generally looks like `gen_server`, but it has support of state transitions. They are implemented in next form:

```erlang
StateName(Event, StateData) ->
    .. code for actions here ...
    {next_state, StateName', StateData'}
```
---
# `gen_fsm` behaviour

Let's take a look at example of `gen_fsm` module.

```erlang
-module(code_lock).
-behaviour(gen_fsm).

-export([start_link/1]).
-export([button/1]).
-export([init/1, locked/2, open/2]).

start_link(Code) ->
    gen_fsm:start_link({local, code_lock}, code_lock, lists:reverse(Code), []).

button(Digit) ->
    gen_fsm:send_event(code_lock, {button, Digit}).

init(Code) ->
    {ok, locked, {[], Code}}.
% part 2 goes on next page
```
---
# `gen_fsm` behaviour

```erlang
% page 1 goes on previous page
locked({button, Digit}, {SoFar, Code}) ->
    case [Digit|SoFar] of
        Code ->
            do_unlock(),
            {next_state, open, {[], Code}, 30000};
        Incomplete when length(Incomplete)<length(Code) ->
            {next_state, locked, {Incomplete, Code}};
        _Wrong ->
            {next_state, locked, {[], Code}}
    end.

open(timeout, State) ->
    do_lock(),
    {next_state, locked, State}.
```
---
# Homework

Your HW Part 2 will be to create table with differences between implementations of `gen_fsm` and `gen_server`.

And third part of homework will be the largest one:

Create application `app_3`, which allows us to use some key-value storage backed by `gen_server` implementation. This implementation need to have API calls `set/2` and `get/1`.

For challengers: please implement `gen_fsm` module which is an abstraction of some car. This car can have stopped engine, starting engine, started engine. Engine goes to start after 1 second of starting. So states chain will look like this:

```
StoppedEngine (start_engine) -> StartingEngine (1 second) -> StartedEngine
```
---
class: center,middle
# End of Lecture 8
## Subject of next lecture: Testing in Erlang. EUnit.
---
class: center,middle
# Bye, folks!

<img src="/images/1_joe_notebook.svg" alt="Joe with notebook" height="80%" width="80%" />
