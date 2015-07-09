class: center,middle

![Hey, Erlang](/images/hey_erlang.svg)
# Pre-alpha [Kottans](http://kottans.org) courses

---
class: center,middle

# Erlang shell
## Lecture 2.

---
class: center,middle
# Prerequisites
## Installation on various operation systems
---
# Linux
## Debian-based
```
$ apt-get install erlang
```
---
# Linux
## Fedora-based
```
$ yum install erlang
```
---
# Mac OS
## Homebrew
```
$ brew install erlang
```
---
# Mac OS
## MacPorts
```
$ port install erlang
```
---
# FreeBSD
## Ports
```
$ cd /usr/ports/lang/erlang && make install clean
```
---
# FreeBSD
## Package system
```
$ pkg_add -rv erlang
```
---
# Windows

Just download Erlang binary from [this page](http://www.erlang.org/download.html), install it and add it to `PATH` variable.
---
class: middle,center

# Launching
---
# How to launch

It's simple. Just type `erl` and receive:
```
$ erl
Erlang/OTP 17 [erts-6.4] [source] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]

Eshell V6.4  (abort with ^G)
1>
```
---
# What does this mean?
`Erlang/OTP 17 [erts-6.4] [source] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]`
---
# What does this mean?
`Erlang/OTP 17 [erts-6.4] [source] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]`

* `erts` - Erlang Runtime System
---
# What does this mean?
`Erlang/OTP 17 [erts-6.4] [source] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]`

* `erts` - Erlang Runtime System
* `source` - has `ERLANG_GIT_VERSION` variable if Erlang was built from git source
---
# What does this mean?
`Erlang/OTP 17 [erts-6.4] [source] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]`

* `erts` - Erlang Runtime System
* `source` - has `ERLANG_GIT_VERSION` variable if Erlang was built from git source
* `64-bit` - appears in case of 64-bit architecture and adds `halfword` if uses half world heap
---
# What does this mean?
`Erlang/OTP 17 [erts-6.4] [source] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]`

* `erts` - Erlang Runtime System
* `source` - has `ERLANG_GIT_VERSION` variable if Erlang was built from git source
* `64-bit` - appears in case of 64-bit architecture and adds `halfword` if uses half world heap
* `smp:4:4` - appears on symmetric multiprocessor systems, first number shows total cores, second - online cores
---
# What does this mean?
`Erlang/OTP 17 [erts-6.4] [source] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]`

* `erts` - Erlang Runtime System
* `source` - has `ERLANG_GIT_VERSION` variable if Erlang was built from git source
* `64-bit` - appears in case of 64-bit architecture and adds `halfword` if uses half world heap
* `smp:4:4` - appears on symmetric multiprocessor systems, first number shows total cores, second - online cores
* `async-threads:10` - appears in case if Erlang uses threads, number means size of thread pool
---
# What does this mean?
`Erlang/OTP 17 [erts-6.4] [source] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]`

* `erts` - Erlang Runtime System
* `source` - has `ERLANG_GIT_VERSION` variable if Erlang was built from git source
* `64-bit` - appears in case of 64-bit architecture and adds `halfword` if uses half world heap
* `smp:4:4` - appears on symmetric multiprocessor systems, first number shows total cores, second - online cores
* `async-threads:10` - appears in case if Erlang uses threads, number means size of thread pool
* `hipe` - appears in case of usage HiPE. HiPE means High Performance Erlang, efficient Erlang compiler integrated into OTP
---
# What does this mean?
`Erlang/OTP 17 [erts-6.4] [source] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]`

* `erts` - Erlang Runtime System
* `source` - has `ERLANG_GIT_VERSION` variable if Erlang was built from git source
* `64-bit` - appears in case of 64-bit architecture and adds `halfword` if uses half world heap
* `smp:4:4` - appears on symmetric multiprocessor systems, first number shows total cores, second - online cores
* `async-threads:10` - appears in case if Erlang uses threads, number means size of thread pool
* `hipe` - appears in case of usage HiPE. HiPE means High Performance Erlang, efficient Erlang compiler integrated into OTP
* `kernel-poll:false` - is Kernel Poll turned on or off. Kernel Poll used to improve performance if you have a number (hundreds or more) of simulanteus network connections
---
# What does this mean?
`Erlang/OTP 17 [erts-6.4] [source] [64-bit] [smp:4:4] [async-threads:10] [hipe] [kernel-poll:false] [dtrace]`

* `erts` - Erlang Runtime System
* `source` - has `ERLANG_GIT_VERSION` variable if Erlang was built from git source
* `64-bit` - appears in case of 64-bit architecture and adds `halfword` if uses half world heap
* `smp:4:4` - appears on symmetric multiprocessor systems, first number shows total cores, second - online cores
* `async-threads:10` - appears in case if Erlang uses threads, number means size of thread pool
* `hipe` - appears in case of usage HiPE. HiPE means High Performance Erlang, efficient Erlang compiler integrated into OTP
* `kernel-poll:false` - is Kernel Poll turned on or off. Kernel Poll used to improve performance if you have a number (hundreds or more) of simulanteus network connections
* `dtrace` - support of DTrace dynamic tracing framework for BEAM
---
# Launch flags
### The **short** list

Erlang shell `erl` launch flags divided into 3 groups - emulator flags, switches and plain arguments.
---
# Launch flags
### Emulator flags (some of them)

If you are using emulator flags they influence the way Erlang virtual machine works.
---
# Launch flags
### Emulator flags (some of them)

If you are using emulator flags they influence the way Erlang virtual machine works.
* `+A size` - number of threads in async thread pool
---
# Launch flags
### Emulator flags (some of them)

If you are using emulator flags they influence the way Erlang virtual machine works.
* `+A size` - number of threads in async thread pool
* `+d` - generate only core dump without crash dump. Crash dump destroys process heaps so core dump became useless
---
# Launch flags
### Emulator flags (some of them)

If you are using emulator flags they influence the way Erlang virtual machine works.
* `+A size` - number of threads in async thread pool
* `+d` - generate only core dump without crash dump. Crash dump destroys process heaps so core dump became useless
* `+L` - don't load information about source file names and line numbers. Exceptions will become useless, but used memory amount will became less
---
# Launch flags
### Emulator flags (some of them)

If you are using emulator flags they influence the way Erlang virtual machine works.
* `+A size` - number of threads in async thread pool
* `+d` - generate only core dump without crash dump. Crash dump destroys process heaps so core dump became useless
* `+L` - don't load information about source file names and line numbers. Exceptions will become useless, but used memory amount will became less
* `+pc Range` - range of characters used for heuristic string detection. Can be `latin1` or `unicode`
---
# Launch flags
### Emulator flags (some of them)

If you are using emulator flags they influence the way Erlang virtual machine works.
* `+A size` - number of threads in async thread pool
* `+d` - generate only core dump without crash dump. Crash dump destroys process heaps so core dump became useless
* `+L` - don't load information about source file names and line numbers. Exceptions will become useless, but used memory amount will became less
* `+pc Range` - range of characters used for heuristic string detection. Can be `latin1` or `unicode`
* `+R ReleaseNumber` - compatibility mode
---
# Launch flags
### Emulator flags (some of them)

If you are using emulator flags they influence the way Erlang virtual machine works.
* `+A size` - number of threads in async thread pool
* `+d` - generate only core dump without crash dump. Crash dump destroys process heaps so core dump became useless
* `+L` - don't load information about source file names and line numbers. Exceptions will become useless, but used memory amount will became less
* `+pc Range` - range of characters used for heuristic string detection. Can be `latin1` or `unicode`
* `+R ReleaseNumber` - compatibility mode
* `+V` - print emulator version
---
# Launch flags
### Emulator flags (some of them)

If you are using emulator flags they influence the way Erlang virtual machine works.
* `+A size` - number of threads in async thread pool
* `+d` - generate only core dump without crash dump. Crash dump destroys process heaps so core dump became useless
* `+L` - don't load information about source file names and line numbers. Exceptions will become useless, but used memory amount will became less
* `+pc Range` - range of characters used for heuristic string detection. Can be `latin1` or `unicode`
* `+R ReleaseNumber` - compatibility mode
* `+V` - print emulator version
* `+v` - become verbose
---
# Launch flags
### Switches (some of them)

Switches are very useful to set up initial Erlang node params.
---
# Launch flags
### Switches (some of them)

Switches are very useful to set up initial Erlang node params.

* `-async_shell_start` - start shell in parallel with Erlang node
---
# Launch flags
### Switches (some of them)

Switches are very useful to set up initial Erlang node params.

* `-async_shell_start` - start shell in parallel with Erlang node
* `-compile Mod1 Mod2...` - compile passed modules and terminate
---
# Launch flags
### Switches (some of them)

Switches are very useful to set up initial Erlang node params.

* `-async_shell_start` - start shell in parallel with Erlang node
* `-compile Mod1 Mod2...` - compile passed modules and terminate
* `-setcookie Cookie` - set security cookie for creating cluster
---
# Launch flags
### Switches (some of them)

Switches are very useful to set up initial Erlang node params.

* `-async_shell_start` - start shell in parallel with Erlang node
* `-compile Mod1 Mod2...` - compile passed modules and terminate
* `-setcookie Cookie` - set security cookie for creating cluster
* `-detached` - start Erlang node as a daemon
---
# Launch flags
### Switches (some of them)

Switches are very useful to set up initial Erlang node params.

* `-async_shell_start` - start shell in parallel with Erlang node
* `-compile Mod1 Mod2...` - compile passed modules and terminate
* `-setcookie Cookie` - set security cookie for creating cluster
* `-detached` - start Erlang node as a daemon
* `-hosts Hosts` - provide list of IP addresses of Erlang nodes, DNS names are not allowed
---
# Launch flags
### Switches (some of them)

Switches are very useful to set up initial Erlang node params.

* `-async_shell_start` - start shell in parallel with Erlang node
* `-compile Mod1 Mod2...` - compile passed modules and terminate
* `-setcookie Cookie` - set security cookie for creating cluster
* `-detached` - start Erlang node as a daemon
* `-hosts Hosts` - provide list of IP addresses of Erlang nodes, DNS names are not allowed
* `-sname Name` - short name of Erlang node
---
# Launch flags
### Switches (some of them)

Switches are very useful to set up initial Erlang node params.

* `-async_shell_start` - start shell in parallel with Erlang node
* `-compile Mod1 Mod2...` - compile passed modules and terminate
* `-setcookie Cookie` - set security cookie for creating cluster
* `-detached` - start Erlang node as a daemon
* `-hosts Hosts` - provide list of IP addresses of Erlang nodes, DNS names are not allowed
* `-sname Name` - short name of Erlang node
* `-version` - the same as emulator flag `+V`
---
class: center,middle
# Erlang documentation
---
# Erlang documentation

You can use several sources to read Erlang documentation:
---
# Erlang documentation

You can use several sources to read Erlang documentation:

* `erl -man module_name` - Erlang man pages
---
# Erlang documentation

You can use several sources to read Erlang documentation:

* `erl -man module_name` - Erlang man pages
* http://www.erlang.org/doc/
---
# Erlang documentation

You can use several sources to read Erlang documentation:

* `erl -man module_name` - Erlang man pages
* http://www.erlang.org/doc/
* Dash Mac OS X application (https://kapeli.com/dash)
---
# Erlang documentation

You can use several sources to read Erlang documentation:

* `erl -man module_name` - Erlang man pages
* http://www.erlang.org/doc/
* Dash Mac OS X application (https://kapeli.com/dash)
* http://erldocs.com/
---
class: middle,center

# Erlang shell itself
---
# Erlang ~~REPL~~ shell

* Erlang shell is not REPL at all. It isn't as in LISP
```lisp
  (loop (print (eval (read))))
```
---
# Erlang ~~REPL~~ shell

* Erlang shell is not REPL at all. It isn't as in LISP
```lisp
  (loop (print (eval (read))))
```
* shell is just another Erlang process
---
# Erlang ~~REPL~~ shell

* Erlang shell is not REPL at all. It isn't as in LISP
```lisp
  (loop (print (eval (read))))
```
* shell is just another Erlang process
* it captures `STDOUT` and `STDIN` and redirects them to process, in this case - shell
---
# Erlang ~~REPL~~ shell

* Erlang shell is not REPL at all. It isn't as in LISP
```lisp
  (loop (print (eval (read))))
```
* shell is just another Erlang process
* it captures `STDOUT` and `STDIN` and redirects them to process, in this case - shell
* multiple shells can be run in one emulator
---
# Erlang ~~REPL~~ shell

* Erlang shell is not REPL at all. It isn't as in LISP
```lisp
  (loop (print (eval (read))))
```
* shell is just another Erlang process
* it captures `STDOUT` and `STDIN` and redirects them to process, in this case - shell
* multiple shells can be run in one emulator
* even remote!
---
# Erlang shell

Erlang shell takes code as regular Erlang code except several keywords like `module` or `export`.
Please try next code in your local Erlang shell (ignore strings after percent sign):

```erlang
1> 4 + 3. % 7
2> A = 5,
2> B = A,
2> A + B. % 10
```
---
# Erlang shell

Erlang shell takes code as regular Erlang code except several keywords like `module` or `export`.
Please try next code in your local Erlang shell (ignore strings after percent sign):

```erlang
1> 4 + 3. % 7
2> A = 5,
2> B = A,
2> A + B. % 10
```

As you can see, Erlang executes code as it is, `.`(dot) is delimiter which gives instruction to execute, `,` is instruction separator (only last line of code block returns result). Line counter at prompt is not line counter but more like instruction counter.
---
class: middle,center
# The most important hotkey

<p align="center">
  <img src="/images/2_ctrl-g.svg" width="75%" height="75%"/>
</p>
---
# ~~Ctrl-Z~~ Ctrl-G!

This hotkey is used to achieve low-level CLI of Erlang shell.
After `Ctrl-G` has been pressed, you'll receive invitation like this:
```
User switch command
  -->
```
---
# ~~Ctrl-Z~~ Ctrl-G!

This hotkey is used to achieve low-level CLI of Erlang shell.
After `Ctrl-G` has been pressed, you'll receive invitation like this:
```
User switch command
  --> h
  c [nn]            - connect to job
  i [nn]            - interrupt job
  k [nn]            - kill job
  j                 - list all jobs
  s [shell]         - start local shell
  r [node [shell]]  - start remote shell
  q                 - quit erlang
  ? | h             - this message
```
---
# ~~Ctrl-Z~~ Ctrl-G!

This hotkey is used to achieve low-level CLI of Erlang shell.
After `Ctrl-G` has been pressed, you'll receive invitation like this:
```
User switch command
  --> h
  c [nn]            - connect to job
  i [nn]            - interrupt job
  k [nn]            - kill job
  j                 - list all jobs
  s [shell]         - start local shell
  r [node [shell]]  - start remote shell
  q                 - quit erlang
  ? | h             - this message
```
Let's try to start and connect to just another shell:
```
  --> s shell
  --> j
   1  {shell,start,[init]}
   2  {shell,start,[]}
  --> c 2
Eshell V6.4  (abort with ^G)
1>
```
---
# ~~Ctrl-Z~~ Ctrl-G!

And this is not all. You can easily connect to remote node in same Erlang cluster. Take a look:
```
user@node1> erl -sname node1 -setcookie secretcookie
user@node2> erl -sname node2 -setcookie secretcookie
```
Now on `node1` press `Ctrl-G` and enter following:
```
  --> r 'node2@localhost'
  --> j
   1  {shell,start,[init]}
   2  {'node2@localhost',shell,start,[]}
  --> c 2
(node2@localhost)1> node().
'node2@localhost'
```
Now press Ctrl-G again!
```
  --> c 1
1> node().
'node1@localhost'
```
---
class: center,middle
# Compile and run from shell
---
# Compile and run from shell

For first time it will be enough to be able to compile and run just single Erlang files, not applications.
Open your favourite Vim (sorry, bad joke) and create file `hello_world.erl`

```erlang
-module(hello_world).
-export([hello/0]).

hello() ->
  io:format("Hello world!~n").
```

Now launch Erlang shell and enter:
```
1>c(hello_world).
{ok, hello_world}
2>hello_world:hello().
Hello world!
ok
```

Congratulations! You have compiled your first program on Erlang. Now you can reuse it having only BEAM file.
---
class: center,middle
# What if now is XXI century and shells are in color?
---
# Shells for Erlang

`erl` is a standard shell. Of course, it's for hardcore lovers. If you need something colorful and tasty - you can use `kjell` (*nix-based systems only, sorry, Windows guys).
Kjell looks like this:

<p align="center">
  <img src="/images/2_kjell.png" width="95%" height="95%"/>
</p>

Unfortunately, it needs [Powerline fonts](https://github.com/powerline/fonts) to work properly.
---
class: center,middle
# End of Lecture 2
## Subject of next lecture: Erlang data types and primitives
---
class: center,middle
# Bye, folks!

<img src="/images/1_joe_notebook.svg" alt="Joe with notebook" height="80%" width="80%" />
