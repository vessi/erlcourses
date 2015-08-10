class: center, middle

![Hey, Erlang](/images/hey_erlang.svg)
# Pre-alpha [Kottans](http://kottans.org) courses
---
class: center,middle

# OTP. Application structure.
## Lecture 7.
---
class: center,middle
# OTP
## Application structure
---
class: center
# OTP
#### Application structure

<p align="center">
  <img src="/images/6_app_tree.svg" width="70%" height="70%" />
</p>
---
# OTP
## Application structure

What is application in OTP? It's a component that can be started and stopped as a stand-alone unit and which can be reused by other applications. Also it's a base module for building OTP application (it uses behaviour `application`).
---
# OTP
## Application structure

What is application in OTP? It's a component that can be started and stopped as a stand-alone unit and which can be reused by other applications. Also it's a base module for building OTP application (it uses behaviour `application`).

At second, application in OTP is, frankly speaking, a supervision tree. Application module launches first supervisor, supervisor launches other workers and supervisors. You can see supervision tree of application using Erlang observer. It usually launches as standalone node in same claster to avoid impact to target system. Let's try it:

```
1$> erl -sname node1 -setcookie secret
2$> erl -sname observer -setcookie secret -hidden -run observer
```
---
# OTP
## Application structure

What is application in OTP? It's a component that can be started and stopped as a stand-alone unit and which can be reused by other applications. Also it's a base module for building OTP application (it uses behaviour `application`).

At second, application in OTP is, frankly speaking, a supervision tree. Application module launches first supervisor, supervisor launches other workers and supervisors. You can see supervision tree of application using Erlang observer. It usually launches as standalone node in same claster to avoid impact to target system. Let's try it:

```
1$> erl -sname node1 -setcookie secret
2$> erl -sname observer -setcookie secret -hidden -run observer
```

For now let's create our first application step by step. It will just receive messages and show them.
---
# OTP
## Application structure

Please create a folder named `app_2`. It will be our project root. And we need some additional folders inside - it's `ebin`, which will contain our BEAMs, it's `include` which will contain our record definitions (will not be used here) and it's `source` which will contain our source files.
---
# OTP
## Application structure

Please create a folder named `app_2`. It will be our project root. And we need some additional folders inside - it's `ebin`, which will contain our BEAMs, it's `include` which will contain our record definitions (will not be used here) and it's `source` which will contain our source files.

```
$> mkdir app_2
$> mkdir app_2/{ebin,include,source}
```
---
# OTP
## Application structure

Please create a folder named `app_2`. It will be our project root. And we need some additional folders inside - it's `ebin`, which will contain our BEAMs, it's `include` which will contain our record definitions (will not be used here) and it's `source` which will contain our source files.

```
$> mkdir app_2
$> mkdir app_2/{ebin,include,source}
```

Let's start with application resource file.
---
# OTP
## Application structure

Let's create `app_2.app` file in project root. Here is the contents:

```erlang
{application, app_2,
 [{description, "First application"},
  {vsn, "1.0"},
  {modules, []}, % for now we leave this empty, but we should add modules here after
  {registered, []}, % registered processes
  {applications, [kernel, stdlib]}, % dependecies
  {mod, {app_2,[]}} % it's a module, in which function `start` will be called
  ]}.
```
---
# OTP
## Application structure.

If we'll start application with `application:load(app_2)`, we'll receive an error, because we haven't module named `app_2` with function `start` in it. Let's create it in `src` folder.

```erlang
-module(app_2).
-behaviour(application).

-export([start/2, stop/1]).

start(_Type, _Args) ->
  ok.
stop(_Stop) ->
  ok.
```
---
# OTP
## Application structure

But to compile created file we need to make it first. Let's create `Emakefile`

```erlang
{'src/*', 
  [debug_info,
  {outdir, "ebin/"},
  {i, "include/."},
  verbose
  ]
}.
```

And compile it:

```
%> erl -make
Recompile: src/app_2
```

`app_2.beam` appeared in `ebin`!
---
# OTP
## Application structure

So, it's time to try to start our application. What we need to do? Let's take a look at loaded applications list before:

```erlang-repl
1> application:loaded_applications().
[{kernel,"ERTS  CXC 138 10","3.2"},
 {stdlib,"ERTS  CXC 138 10","2.4"}]
```
---
# OTP
## Application structure

So, it's time to try to start our application. What we need to do? Let's take a look at loaded applications list before:

```erlang-repl
1> application:loaded_applications().
[{kernel,"ERTS  CXC 138 10","3.2"},
 {stdlib,"ERTS  CXC 138 10","2.4"}]
```

And now it's time to try to load our application.

```erlang-repl
2> application:load(app_2).
ok
3> application:loaded_applications().
[{app_2,"First application","1.0"},
 {kernel,"ERTS  CXC 138 10","3.2"},
 {stdlib,"ERTS  CXC 138 10","2.4"}]
```
---
# OTP
## Application structure

But when we'll try to launch our application, we'll receive failure.

```erlang-repl
1> application:start(app_2).
{error,{bad_return,{{app_2,start,[normal,[]]},
                    {'EXIT',{undef,[{app_2,start,[normal,[]],[]},
                                    {application_master,start_it_old,4,
                                                        [{file,"application_master.erl"},{line,272}]}]}}}}}

=INFO REPORT==== 10-Aug-2015::17:49:20 ===
    application: app_2
    exited: {bad_return,
                {{app_2,start,[normal,[]]},
                 {'EXIT',
                     {undef,
                         [{app_2,start,[normal,[]],[]},
                          {application_master,start_it_old,4,
                              [{file,"application_master.erl"},
                               {line,272}]}]}}}}
    type: temporary
```
---
# OTP
## Application structure

This happened because application behaviour expects from us return in other format. Let's take a look at `kernel/application_master:start_it_old`.

```erlang
start_it_old(Tag, From, Type, ApplData) ->
    {M,A} = ApplData#appl_data.mod,
    case catch M:start(Type, A) of
  {ok, Pid} ->
      link(Pid),
      From ! {Tag, {ok, self()}},
      loop_it(From, Pid, M, []);
  {ok, Pid, AppState} ->
      link(Pid),
      From ! {Tag, {ok, self()}},
      loop_it(From, Pid, M, AppState);
  {'EXIT', normal} ->
      From ! {Tag, {error, {{'EXIT',normal},{M,start,[Type,A]}}}};
  {error, Reason} ->
      From ! {Tag, {error, {Reason, {M,start,[Type,A]}}}};
  Other ->
      From ! {Tag, {error, {bad_return,{{M,start,[Type,A]},Other}}}}
    end.
```
---
# OTP
## Application structure

Ah ok. So we need to return tuple with `{ok, PID}` or `{ok, PID, AppState}`. The simpliest solution will be to return PID. But which process we need to launch? So, let's come back to supervisor and their trees.
---
# OTP
## Application structure

Ah ok. So we need to return tuple with `{ok, PID}` or `{ok, PID, AppState}`. The simpliest solution will be to return PID. But which process we need to launch? So, let's come back to supervisor and their trees.

As you remember from previous explanations, application launches master, or root, supervisor which is needed to run all other processes within our applications. Let's go deeper with supervisor and how it works.
---
class: center,middle
# OTP
## Supervisor
---
class: center
# OTP
#### Supervisor

<p align="center">
  <img src="/images/7_supervisor.svg" width="75%" height="75%" />
</p>
---
# OTP
## Supervisor

So, supervisor is responsible for starting, stopping and monitoring it's child processes. List of child processes is specified by child specification list. It's passed as argument by first function you need from this behaviour named `start_link`.
---
# OTP
## Supervisor

So, supervisor is responsible for starting, stopping and monitoring it's child processes. List of child processes is specified by child specification list. It's passed as argument by first function you need from this behaviour named `start_link`.

What is child specification? It's next tuple:

```erlang
child_spec() = #{id => child_id(),       % mandatory
                 start => mfargs(),      % mandatory
                 restart => restart(),   % optional
                 shutdown => shutdown(), % optional
                 type => worker(),       % optional
                 modules => modules()}   % optional
    child_id() = term()
    mfargs() = {M :: module(), F :: atom(), A :: [term()]}
    modules() = [module()] | dynamic
    restart() = permanent | transient | temporary
    shutdown() = brutal_kill | timeout()
    worker() = worker | supervisor
```
---
# OTP
## Supervisor

Let's take a look at easiest form of child specification:

```erlang
#{id => ch3, % id of child
  start => {ch3, start_link, []} % we'll call ch3:start_link
  shutdown => brutal_kill} % we'll terminate child using exit(Child,kill). another option is integer timeout(), 
  % and supervisor will send exit(Child, shutdown) and await corresponding exit signal from child.
```
---
# OTP
## Supervisor

Let's take a closer look on supervisor child specification params:
---
# OTP
## Supervisor

Let's take a closer look on supervisor child specification params:

* `id` - it's internal id of this child in supervisor registry.
---
# OTP
## Supervisor

Let's take a closer look on supervisor child specification params:

* `id` - it's internal id of this child in supervisor registry.
* `start` - defines a function call used to start the child process. It must return `{ok, Pid}` with PID of child, or `{ok, Pid, State}`, but this State is ignored by supervisor.
---
# OTP
## Supervisor

Let's take a closer look on supervisor child specification params:

* `id` - it's internal id of this child in supervisor registry.
* `start` - defines a function call used to start the child process. It must return `{ok, Pid}` with PID of child, or `{ok, Pid, State}`, but this State is ignored by supervisor.
* `restart` - defines a strategy of children relaunch. `permanent` will always be restarted, `temporary` will never be restarted and `transient` will restart if exit signal of child differs from `normal`, `shutdown` or `{shutdown, Term}`.
---
# OTP
## Supervisor

Let's take a closer look on supervisor child specification params:

* `id` - it's internal id of this child in supervisor registry.
* `start` - defines a function call used to start the child process. It must return `{ok, Pid}` with PID of child, or `{ok, Pid, State}`, but this State is ignored by supervisor.
* `restart` - defines a strategy of children relaunch. `permanent` will always be restarted, `temporary` will never be restarted and `transient` will restart if exit signal of child differs from `normal`, `shutdown` or `{shutdown, Term}`.
* `shutdown` - defines how child process will be terminated. You can pass `brutal_kill` or integer `timeout` here. In case of `brutal_kill` supervisor will just terminate child using `exit(Child, kill)` signal, and in case of timeout we'll send `exit(Child, shutdown)` and await for answer first, but finish with `exit(Child,kill)` if timeout has been reached.
---
# OTP
## Supervisor

Let's take a closer look on supervisor child specification params:

* `id` - it's internal id of this child in supervisor registry.
* `start` - defines a function call used to start the child process. It must return `{ok, Pid}` with PID of child, or `{ok, Pid, State}`, but this State is ignored by supervisor.
* `restart` - defines a strategy of children relaunch. `permanent` will always be restarted, `temporary` will never be restarted and `transient` will restart if exit signal of child differs from `normal`, `shutdown` or `{shutdown, Term}`.
* `shutdown` - defines how child process will be terminated. You can pass `brutal_kill` or integer `timeout` here. In case of `brutal_kill` supervisor will just terminate child using `exit(Child, kill)` signal, and in case of timeout we'll send `exit(Child, shutdown)` and await for answer first, but finish with `exit(Child,kill)` if timeout has been reached.
* `type` specifies if child process is supervisor or worker.
---
# OTP
## Supervisor

Now we are ready to take a look at `start_link/0` and `init/1` callbacks of supervisor.
---
# OTP
## Supervisor

Now we are ready to take a look at `start_link/0` and `init/1` callbacks of supervisor.

`start_link/0` is the callback function which need to launch original `supervisor:start_link/2` and pass as params the atom name of callback module and params for `init/1`.
---
# OTP
## Supervisor

Now we are ready to take a look at `start_link/0` and `init/1` callbacks of supervisor.

`start_link/0` is the callback function which need to launch original `supervisor:start_link/2` and pass as params the atom name of callback module and params for `init/1`.

`init/1` in general looks like:

```erlang
init(_Args) ->
    SupFlags = #{},
    ChildSpecs = [#{id => ch3,
                    start => {ch3, start_link, []},
                    shutdown => brutal_kill}],
    {ok, {SupFlags, ChildSpecs}}.
```
---
# OTP
## Supervisor

Let's take a look at supervisor flags.

```erlang
sup_flags() = #{strategy => strategy(),         % optional
                intensity => non_neg_integer(), % optional
                period => pos_integer()}        % optional
                % If more than "intensity" restarts occurs in "period",
                % supervisor will terminate child processes and then itself.
    strategy() = one_for_all
               | one_for_one
               | rest_for_one
               | simple_one_for_one
```
---
# OTP
## Supervisor

Strategies. We know at least:
---
# OTP
## Supervisor

Strategies. We know at least:

* `one_for_one`. If child process is terminated, only that process is restarted.
---
# OTP
## Supervisor

Strategies. We know at least:

* `one_for_one`. If child process is terminated, only that process is restarted.
* `one_for_all`. If child process is terminated, all other child processes are terminated, and all of them are restarted.
---
# OTP
## Supervisor

Strategies. We know at least:

* `one_for_one`. If child process is terminated, only that process is restarted.
* `one_for_all`. If child process is terminated, all other child processes are terminated, and all of them are restarted.
* `rest_for_one`. If child process is terminated, the rest of the child processes (that is, the child processes after the terminated process in start order) are terminated. Then the terminated child process and the rest of the child processes are restarted.
---
# OTP
## Application structure

Let's come back to our simple application. So to launch application in proper way we need to a supervisor before. Our supervisor have to implement 2 functions: `start_link/0` and `init/1` which is launched after proper starting of link.
---
# OTP
## Application structure

Let's come back to our simple application. So to launch application in proper way we need to a supervisor before. Our supervisor have to implement 2 functions: `start_link/0` and `init/1` which is launched after proper starting of link.

```erlang
-module(app_2_sup).
-export([start_link/0, init/1]).

-behaviour(supervisor).

start_link() ->
  supervisor:start_link(app_2_sup, []).

init(_Args) ->
  {ok, {one_for_one, 1, 60}, []}.
```
---
# OTP
## Application structure

And we need to change our `.app` file and application module itself. Application module goes first:

```erlang
-module(app_2).
-behaviour(application).

-export([start/2, stop/1]).

start(_Type, _Args) ->
  app_2_sup:start_link(). % we start a root supervisor from application process
stop(_Stop) ->
  ok.
```
---
# OTP
## Application structure

And we need to change our `.app` file and application module itself. Application specification goes second:

```erlang
{application, app_2,
 [{description, "First application"},
  {vsn, "1.0"},
  {modules, [app_2_sup]}, % we've added our supervisor here
  {registered, []},
  {applications, [kernel, stdlib]},
  {mod, {app_2,[]}}
  ]}.
```
---
class: center,middle
# End of Lecture 7
## Subject of next lecture: OTP. `gen_server` and `gen_fsm`
---
class: center,middle
# Bye, folks!

<img src="/images/1_joe_notebook.svg" alt="Joe with notebook" height="80%" width="80%" />
