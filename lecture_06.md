class: center, middle

![Hey, Erlang](/images/hey_erlang.svg)
# Pre-alpha [Kottans](http://kottans.org) courses
---
class: center,middle

# Introduction into OTP.
## Lecture 6.
---
class: center,middle
# Erlang Make
---
class: center
# Erlang Make

<p align="center">
  <img src="/images/6_emake.svg" width="70%" height="70%" />
</p>
---
# Erlang Make
---
# Erlang Make

Erlang has it's own builtin tool for making applications and/or modules. It works with globs and can pass compile options to compiler. Take a look at sample `Emakefile` in `app_1` folder (don't forget to take a look at `app_1` structure)

```erlang
% Emakefile
{'./src/*', % glob with path to source files
  [debug_info, % include debug info into BEAM file (enlarges it's size)
  {outdir, "./ebin/"}, % output directory
  {i, "./include/."} % path for includes
  ] % compiler options
}.
```

This is the one of easiest sample to compile your Erlang application. Let's take a closer look at some selected compiler options you may need.
---
# Erlang Make
#### Compiler options
---
# Erlang Make
#### Compiler options

* `compressed` - makes compressed BEAM, useful for embedded systems
---
# Erlang Make
#### Compiler options

* `compressed` - makes compressed BEAM, useful for embedded systems
* `debug_info` - includes debug information into BEAM module which allows to connect debugger
---
# Erlang Make
#### Compiler options

* `compressed` - makes compressed BEAM, useful for embedded systems
* `debug_info` - includes debug information into BEAM module which allows to connect debugger
* `report` - print errors and warnings
---
# Erlang Make
#### Compiler options

* `compressed` - makes compressed BEAM, useful for embedded systems
* `debug_info` - includes debug information into BEAM module which allows to connect debugger
* `report` - print errors and warnings
* `verbose` - verbose mode
---
# Erlang Make
#### Compiler options

* `compressed` - makes compressed BEAM, useful for embedded systems
* `debug_info` - includes debug information into BEAM module which allows to connect debugger
* `report` - print errors and warnings
* `verbose` - verbose mode
* `{i, Dir}` - include search path, `Dir` is a list
---
# Erlang Make
#### Compiler options

* `compressed` - makes compressed BEAM, useful for embedded systems
* `debug_info` - includes debug information into BEAM module which allows to connect debugger
* `report` - print errors and warnings
* `verbose` - verbose mode
* `{i, Dir}` - include search path, `Dir` is a list
* `{outdir, Dir}` - set directory to output BEAM files. Current directory by default
---
class: center,middle
# OTP
---
class: center,middle
# OTP
## Behaviors
---
class: center
# OTP
#### Behaviors

<p align="center">
  <img src="/images/6_behaviour.svg" width="70%" height="70%" />
</p>
---
# OTP
## Behaviors
---
# OTP
## Behaviors

Behaviors is Erlang way to force module to implement some general interface. When you are going to create library or application that will be used outside with associated callbacks - behaviour is the best way to do this. Take a closer look about defining your own behaviour:
---
# OTP
## Behaviors

Behaviors is Erlang way to force module to implement some general interface. When you are going to create library or application that will be used outside with associated callbacks - behaviour is the best way to do this. Take a closer look about defining your own behaviour:

```erlang
% gen_foo.erl
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
```
---
# OTP
## Behaviors. Usage

Now, when we have our first behaviour, let's try to use it and see what happens if we fail to describe it correct. Let's create a file named `foo_module_step1.erl`

```erlang
-module(foo_module_error).
-behavior(gen_foo). % usage of our gen_foo

foo() ->
  ok.
bar(_) ->
  ok.
```
---
# OTP
## Behaviors. Usage

And now it's a time to compile our first try.

```erlang-repl
1> c(gen_foo).
{ok,gen_foo}
2> c(foo_module_step1).
foo_module_step1.erl:2: Warning: undefined callback function bar/1 (behaviour 'gen_foo')
foo_module_step1.erl:2: Warning: undefined callback function baz/2 (behaviour 'gen_foo')
foo_module_step1.erl:2: Warning: undefined callback function foo/0 (behaviour 'gen_foo')
foo_module_step1.erl:4: Warning: function foo/0 is unused
foo_module_step1.erl:6: Warning: function bar/1 is unused
{ok,foo_module_step1}
```

Why this happened? We forgot to export functions so they are private and invisible for behavior description. Now it's a time to correct our warnings. Notice, that module `foo_module_step1` is compiled anyway.
---
# OTP
## Behaviors. Usage

So, let's create second file named `foo_module_step2.erl`. It will look like this:

```erlang
-module(foo_module_step2).
-behavior(gen_foo).
-export([foo/0, bar/1, baz/2]). % export functions needed by behavior

foo() ->
  ok.
bar(_) ->
  ok.
baz(_, _) ->
  ok.
```
---
# OTP
## Behaviors. Usage

Now we need to compile it to check if everything works correctly.

```erlang-repl
1> c(foo_module_step2).
{ok,foo_module_step2}
```

As you can see everything went ok.
---
# OTP
### Behaviors. Usage

Let's complicate things a bit. Now we will create callbacks-enabled behavior. Let's create file `gen_listener.erl`

```erlang
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
```
---
# OTP
## Behavior. Usage

And now it's a time to create real `listener.erl`

```erlang
-module(listener).
-behavior(gen_listener).
-export([init/0, parse_message/1]).

init() ->
  gen_listener:init(?MODULE).

parse_message(Message) ->
  io:format("Received message ~s~n", [Message]).
```
---
# OTP
## Behavior. Usage

Now we are going to compile and test them.

```erlang-repl
1> c(gen_listener).
{ok,gen_listener}
2> c(listener).
{ok,listener}
3> Pid = listener:init().
<0.99.0>
4> Pid ! "Hello, World!"
Received message Hello, world!
"Hello, world!"
5> Pid ! terminate.
terminate
6> process_info(Pid).
undefined
```
---
class: center,middle
# OTP
## OTP introduced behaviors
---
# OTP
## OTP introduced behaviors
---
# OTP
## OTP introduced behaviors

There is a list of OTP behaviors with short explanation.
---
# OTP
## OTP introduced behaviors

There is a list of OTP behaviors with short explanation.

* `gen_server` - for implementing standard server from client-server relation
---
# OTP
## OTP introduced behaviors

There is a list of OTP behaviors with short explanation.

* `gen_server` - for implementing standard server from client-server relation
* `gen_fsm` - for finite state machines
---
# OTP
## OTP introduced behaviors

There is a list of OTP behaviors with short explanation.

* `gen_server` - for implementing standard server from client-server relation
* `gen_fsm` - for finite state machines
* `gen_event` - for implementing event handling
---
# OTP
## OTP introduced behaviors

There is a list of OTP behaviors with short explanation.

* `gen_server` - for implementing standard server from client-server relation
* `gen_fsm` - for finite state machines
* `gen_event` - for implementing event handling
* `supervisor` - for implementing supervisors from supervisors tree
---
# OTP
## OTP introduced behaviors

There is a list of OTP behaviors with short explanation.

* `gen_server` - for implementing standard server from client-server relation
* `gen_fsm` - for finite state machines
* `gen_event` - for implementing event handling
* `supervisor` - for implementing supervisors from supervisors tree
* `application` - for application callback module
---
class: center,middle
# End of Lecture 6
## Subject of next lecture: OTP. Application structure.
---
class: center,middle
# Bye, folks!

<img src="/images/1_joe_notebook.svg" alt="Joe with notebook" height="80%" width="80%" />
