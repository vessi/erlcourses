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

Let's create our first application step by step. It will just receive messages and show them.
---
# OTP
## Application structure

Please create a folder named `app_2`. It will be our project root. And we need some additional folders inside - it's `ebin`, which will contain our BEAMs, it's `include` which will contain our record definitions (will not be used here) and it's `source` which will contain our source files.
---
# OTP
## Application structure

Please create a folder named `app_2`. It will be our project root. And we need some additional folders inside - it's `ebin`, which will contain our BEAMs, it's `include` which will contain our record definitions (will not be used here) and it's `source` which will contain our source files.

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
  app_2_sup:start_link(). % we need to launch top level supervisor here
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
