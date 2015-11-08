class: center, middle

![Hey, Erlang](/images/hey_erlang.svg)
# Pre-alpha [Kottans](http://kottans.org) courses
---
class: center, middle
# Lecture 9
## Testing in Erlang. EUnit.
---
# EUnit
## What is EUnit?

EUnit is unit testing framework that builds on ideas from JUnit(Java) and SUnit(Smalltalk). But EUnit was developed especially to be used in functional concurrent programming language. It is as laconic as Erlang is.
---
# EUnit
## What is EUnit?

EUnit is unit testing framework that builds on ideas from JUnit(Java) and SUnit(Smalltalk). But EUnit was developed especially to be used in functional concurrent programming language. It is as laconic as Erlang is.

EUnit was developed to be least intrusive as it possibly can, so adding tests to your code will not change it. Anyway, if you plan to test only exported functions of module, you can place your tests separately - and it's widely used by application structure proposed by `rebar` build system.
---
# EUnit
## EUnit glossary
---
# EUnit
## EUnit glossary

* _Unit testing_ - testing that a program unit behaves as it supposed to do, according to its specifications.
---
# EUnit
## EUnit glossary

* _Unit testing_ - testing that a program unit behaves as it supposed to do, according to its specifications.
* _Regression testing_ - running a set of tests after program change to check that nothing was broken.
---
# EUnit
## EUnit glossary

* _Unit testing_ - testing that a program unit behaves as it supposed to do, according to its specifications.
* _Regression testing_ - running a set of tests after program change to check that nothing was broken.
* _Integration testing_ - testing that program units work together as expected.
---
# EUnit
## EUnit glossary

* _Unit testing_ - testing that a program unit behaves as it supposed to do, according to its specifications.
* _Regression testing_ - running a set of tests after program change to check that nothing was broken.
* _Integration testing_ - testing that program units work together as expected.
* _System testing_ - testing that complete system behaves according to its specification.
---
# EUnit
## EUnit glossary

* _Unit testing_ - testing that a program unit behaves as it supposed to do, according to its specifications.
* _Regression testing_ - running a set of tests after program change to check that nothing was broken.
* _Integration testing_ - testing that program units work together as expected.
* _System testing_ - testing that complete system behaves according to its specification.
* _Test Driven Development_ - methodology of development based on writing tests (as a future code specification) before your source code. Helps developer to avoid hyper-complication and ease refactoring.
---
# EUnit
## EUnit glossary

* _Unit testing_ - testing that a program unit behaves as it supposed to do, according to its specifications.
* _Regression testing_ - running a set of tests after program change to check that nothing was broken.
* _Integration testing_ - testing that program units work together as expected.
* _System testing_ - testing that complete system behaves according to its specification.
* _Test Driven Development_ - methodology of development based on writing tests (as a future code specification) before your source code. Helps developer to avoid hyper-complication and ease refactoring.
* _Mock object_ - fake object that behaves like real (maybe still not implemented or not available) object.
---
# EUnit
## EUnit glossary

* _Unit testing_ - testing that a program unit behaves as it supposed to do, according to its specifications.
* _Regression testing_ - running a set of tests after program change to check that nothing was broken.
* _Integration testing_ - testing that program units work together as expected.
* _System testing_ - testing that complete system behaves according to its specification.
* _Test Driven Development_ - methodology of development based on writing tests (as a future code specification) before your source code. Helps developer to avoid hyper-complication and ease refactoring.
* _Mock object_ - fake object that behaves like real (maybe still not implemented or not available) object.
* _Test case_ - single test that detects that something atomic works as expected. Test can only *pass* or *fail*.
---
# EUnit
## EUnit glossary

* _Unit testing_ - testing that a program unit behaves as it supposed to do, according to its specifications.
* _Regression testing_ - running a set of tests after program change to check that nothing was broken.
* _Integration testing_ - testing that program units work together as expected.
* _System testing_ - testing that complete system behaves according to its specification.
* _Test Driven Development_ - methodology of development based on writing tests (as a future code specification) before your source code. Helps developer to avoid hyper-complication and ease refactoring.
* _Mock object_ - fake object that behaves like real (maybe still not implemented or not available) object.
* _Test case_ - single test that detects that something atomic works as expected. Test can only *pass* or *fail*.
* _Test suite_ - collection of test cases joined together by specific target (e.g. single function or module). May be composed of other test suites.
---
# EUnit
## Adding EUnit to your module

We are going to write, for example, simple calculator of Fibonacci sequence. Let's start with module `fibonacci.erl` (`testing/fibonacci_00.erl` in courses source code).

```erlang
% testing/fibonacci_00.erl
-module(fibonacci_00).
```
---
# EUnit
## Adding EUnit to your module

Let's take a look on module info:

```erlang-repl
1> c(fibonacci_00).
{ok,fibonacci_00}
2> fibonacci_00:module_info().
[{module,fibonacci_00},
 {exports,[{module_info,0},{module_info,1}]},
 {attributes,[{vsn,[261853951541325737780411885127686387569]}]},
 {compile,[{options,[]},
           {version,"6.0"},
           {time,{2015,8,19,13,39,38}},
           {source,"/Users/vessi/edu/erlcourses/testing/fibonacci_00.erl"}]},
 {native,false},
 {md5,<<196,255,60,147,250,56,166,39,213,231,192,152,192,
        83,119,113>>}]
```
---
# EUnit
## Adding EUnit to your module

So the first step will be to add EUnit support to our Fibonacci calculator. This can be done by adding EUnit header.

```erlang
% testing/fibonacci_01.erl
-module(fibonacci_01).
-include_lib("eunit/include/eunit.hrl").
```
---
# EUnit
## Adding EUnit to your module

Let's see what has changed.

```erlang-repl
3> c(fibonacci_01).
{ok,fibonacci_01}
4> fibonacci_01:module_info().
[{module,fibonacci_01},
 {exports,[{test,0},{module_info,0},{module_info,1}]},
 {attributes,[{vsn,[297479195634998726548445758768610341143]}]},
 {compile,[{options,[]},
           {version,"6.0"},
           {time,{2015,8,19,13,42,38}},
           {source,"/Users/vessi/edu/erlcourses/testing/fibonacci_01.erl"}]},
 {native,false},
 {md5,<<223,204,104,184,217,68,52,0,87,80,38,225,164,88,
        241,23>>}]
```

As you can see, `eunit.hrl` added `test/0` function to `exports` section of our module. Let's run it because we are strong and courageous!

<small>please avoid running unknown functions in real life</small>
---
# EUnit
## Adding EUnit to your module

```erlang-repl
5> fibonacci_01:test()
  There were no tests to run.
ok
```
---
# EUnit
## Adding EUnit to your module

```erlang-repl
5> fibonacci_01:test()
  There were no tests to run.
ok
```

Yes, this is ok, because we haven't wrote any test yet. Thanks, Captain Obvious!
---
# EUnit
## Adding EUnit to your module

```erlang-repl
5> fibonacci_01:test()
  There were no tests to run.
ok
```

Yes, this is ok, because we haven't wrote any test yet. Thanks, Captain Obvious!

So it's time to add some. About Fibonacci sequence we know some rules:
---
# EUnit
## Adding EUnit to your module

```erlang-repl
5> fibonacci_01:test()
  There were no tests to run.
ok
```

Yes, this is ok, because we haven't wrote any test yet. Thanks, Captain Obvious!

So it's time to add some. About Fibonacci sequence we know some rules:

* it starts from 0 and equals to 0 for 0
---
# EUnit
## Adding EUnit to your module

```erlang-repl
5> fibonacci_01:test()
  There were no tests to run.
ok
```

Yes, this is ok, because we haven't wrote any test yet. Thanks, Captain Obvious!

So it's time to add some. About Fibonacci sequence we know some rules:

* it starts from 0 and equals to 0 for 0
* for 1 it equals to 1
---
# EUnit
## Adding EUnit to your module

```erlang-repl
5> fibonacci_01:test()
  There were no tests to run.
ok
```

Yes, this is ok, because we haven't wrote any test yet. Thanks, Captain Obvious!

So it's time to add some. About Fibonacci sequence we know some rules:

* it starts from 0 and equals to 0 for 0
* for 1 it equals to 1
* for N it equals to fib(N-2)+fib(N-1)
---
# EUnit
## Writing our first test

So, we are going to write our first test that claims that Fibonacci sequence does not exists for negative numbers. EUnit recognize simple tests by `_test()` in name, so let's create `fib_negative_test()` function. And don't forget to create `fib/1` function because we want to use it for test.

```erlang
% testing/fibonacci.erl
-module(fibonacci_02).
-include("eunit/include/eunit.hrl").

fib(_) -> ok.

fib_negative_test() -> undefined = fib(-5).
```
---
# EUnit
## Writing our first test

Let's compile it and try to run our tests.

```erlang-repl
6> c(fibonacci_02).
{ok,fibonacci_02}
7> fibonacci_02:test().
fibonacci_02: fibonacci_negative_test (module 'fibonacci_02')...*failed*
in function fibonacci_02:fibonacci_negative_test/0 (fibonacci_02.erl, line 6)
**error:{badmatch,ok}
  output:<<"">>

=======================================================
  Failed: 1.  Skipped: 0.  Passed: 0.
```
---
# EUnit
## Writing our first test

Let's compile it and try to run our tests.

```erlang-repl
6> c(fibonacci_02).
{ok,fibonacci_02}
7> fibonacci_02:test().
fibonacci_02: fibonacci_negative_test (module 'fibonacci_02')...*failed*
in function fibonacci_02:fibonacci_negative_test/0 (fibonacci_02.erl, line 6)
**error:{badmatch,ok}
  output:<<"">>

=======================================================
  Failed: 1.  Skipped: 0.  Passed: 0.
```

Obviously it's failed because we don't return `undefined` atom so matching was failed. We are going to fix it.
---
# EUnit
## Writing our first test

```erlang
% testing/fibonacci_03.erl
-module(fibonacci_03).
-include_lib("eunit/include/eunit.hrl").

fib(_) -> undefined.

fibonacci_negative_test() -> undefined = fib(-5).
```
---
# EUnit
## Writing our first test

```erlang
% testing/fibonacci_03.erl
-module(fibonacci_03).
-include_lib("eunit/include/eunit.hrl").

fib(_) -> undefined.

fibonacci_negative_test() -> undefined = fib(-5).
```

Now it's time to compile and see the results.
---
# EUnit
## Writing our first test

```erlang-repl
8> c(fibonacci_03).
{ok,fibonacci_03}
9> fibonacci_03:test().
  Test passed.
ok
```

Congratulations! Our first test was passed.
---
# EUnit
## Writing test suite

Ok, let's complete our tests.

```erlang
% testing/fibonacci_04.erl
-module(fibonacci_04).
-include_lib("eunit/include/eunit.hrl").

fib(_) -> undefined.

fibonacci_negative_test() -> undefined = fib(-5).
fibonacci_0_test() -> 0 = fib(0).
fibonacci_1_test() -> 1 = fib(1).
fibonacci_2_test() -> 1 = fib(2).
fibonacci_5_test() -> 5 = fib(5).
```
---
# EUnit
## Writing test suite

Now let's try to launch our test suite.

```erlang-repl
10> c(fibonacci_04).
{ok,fibonacci_04}
11> fibonacci_04:test().
fibonacci_04: fibonacci_0_test...*failed*
in function fibonacci_04:fibonacci_0_test/0 (fibonacci_04.erl, line 7)
% skipped
fibonacci_04: fibonacci_1_test...*failed*
in function fibonacci_04:fibonacci_1_test/0 (fibonacci_04.erl, line 8)
% skipped
fibonacci_04: fibonacci_2_test...*failed*
in function fibonacci_04:fibonacci_2_test/0 (fibonacci_04.erl, line 9)
% skipped
fibonacci_04: fibonacci_5_test...*failed*
in function fibonacci_04:fibonacci_5_test/0 (fibonacci_04.erl, line 10)
% skipped
=======================================================
  Failed: 4.  Skipped: 0.  Passed: 1.
error
```
---
# EUnit
## Writing test suite

```erlang
% testing/fibonacci_05.erl
-module(fibonacci_05).
-include_lib("eunit/include/eunit.hrl").

fib(0) -> 0;
fib(1) -> 1;
fib(N) when N < 0 -> undefined;
fib(N) -> fib(N-1)+fib(N-2).

fibonacci_negative_test() -> undefined = fib(-5).
fibonacci_0_test() -> 0 = fib(0).
fibonacci_1_test() -> 1 = fib(1).
fibonacci_2_test() -> 1 = fib(2).
fibonacci_5_test() -> 5 = fib(5).
```
---
# EUnit
## Writing test suite

Let's run our tests and check our perfect code:

```erlang-repl
1> c(fibonacci_05).erl
{ok,fibonacci_05}
2> fibonacci_05:test().
  All 5 tests passed.
ok
```

So, our tests have passed. Mission accomplished.
---
# EUnit
## EUnit macros

EUnit introduces a lot of macros to simplify it's usage. Take a look at the list
---
# EUnit
## EUnit macros

EUnit introduces a lot of macros to simplify it's usage. Take a look at the list

* `_test(Expr)` - it turns `Expr` into thing named "test object", which technically is the tuple `{?LINE, fun() -> (Expr) end}`
---
# EUnit
## EUnit macros

EUnit introduces a lot of macros to simplify it's usage. Take a look at the list

* `_test(Expr)` - it turns `Expr` into thing named "test object", which technically is the tuple `{?LINE, fun() -> (Expr) end}`
* `EUNIT` - this macro is always defined to `true` and can be used for `-ifdef(EUNIT)...-endif.` instructions. The best way to disable compiling your test for production.
---
# EUnit
## EUnit macros

EUnit introduces a lot of macros to simplify it's usage. Take a look at the list

* `_test(Expr)` - it turns `Expr` into thing named "test object", which technically is the tuple `{?LINE, fun() -> (Expr) end}`
* `EUNIT` - this macro is always defined to `true` and can be used for `-ifdef(EUNIT)...-endif.` instructions. The best way to disable compiling your test for production.
* `TEST` - the same as before but more general and can be used for another test frameworks.
---
# EUnit
## EUnit macros

EUnit introduces a lot of macros to simplify it's usage. Take a look at the list

* `_test(Expr)` - it turns `Expr` into thing named "test object", which technically is the tuple `{?LINE, fun() -> (Expr) end}`
* `EUNIT` - this macro is always defined to `true` and can be used for `-ifdef(EUNIT)...-endif.` instructions. The best way to disable compiling your test for production.
* `TEST` - the same as before but more general and can be used for another test frameworks.
* `EUNIT_NOAUTO` - disables autoexport of test functions (check `fibonacci_05:module_info/0` to see something interesting!)
---
# EUnit
## EUnit utility macros

And also we have some utility macros in EUnit framework
---
# EUnit
## EUnit utility macros

And also we have some utility macros in EUnit framework

* `LET(Var, Arg, Expr)` - creates local binding for `Var` with `Arg` in `Expr`. It's same to `(fun(Var)->(Expr)end)(Arg)`.
---
# EUnit
## EUnit utility macros

And also we have some utility macros in EUnit framework

* `LET(Var, Arg, Expr)` - creates local binding for `Var` with `Arg` in `Expr`. It's same to `(fun(Var)->(Expr)end)(Arg)`.
* `IF(Cond, TrueCase, FalseCase)` - evaluates `TrueCase` if `Cond` evaluates to `true` otherwise `FalseCase`. This is the same as `(case (Cond) of true -> (TrueCase); false -> (FalseCase) end.)`
---
# EUnit
## EUnit assert macros

And now macros that simplifies testing itself.
---
# EUnit
## EUnit assert macros

And now macros that simplifies testing itself.

* `assert(Bool)` - evaluates boolean expression `Bool`. Can be used anywhere in program
---
# EUnit
## EUnit assert macros

And now macros that simplifies testing itself.

* `assert(Bool)` - evaluates boolean expression `Bool`. Can be used anywhere in program
* `assertNot(Bool)` - equivalent to `assert(not(Bool))`
---
# EUnit
## EUnit assert macros

And now macros that simplifies testing itself.

* `assert(Bool)` - evaluates boolean expression `Bool`. Can be used anywhere in program
* `assertNot(Bool)` - equivalent to `assert(not(Bool))`
* `assertMatch(GuardedPattern, Expr)` - evaluates `Expr` and matches against `GuardedPattern`. This macro has inversed version `assertNotMatch`
---
# EUnit
## EUnit assert macros

And now macros that simplifies testing itself.

* `assert(Bool)` - evaluates boolean expression `Bool`. Can be used anywhere in program
* `assertNot(Bool)` - equivalent to `assert(not(Bool))`
* `assertMatch(GuardedPattern, Expr)` - evaluates `Expr` and matches against `GuardedPattern`. This macro has inversed version `assertNotMatch`
* `assertEqual(Expect, Expr)` - evaluates `Expect` and `Expr` and compares them. More informative than `?assert(Expect =:= Expr)`. Has inversed version `assertNotEqual`
---
# EUnit
## EUnit equal forms

EUnit has several equal forms:

* `fun() -> ?assert(1 + 1 =:= 2) end.` is equal to `?assert(1 + 1 =:= 2).` because EUnit wraps simple tests as fun expressions
* `?_test(?assert(1 + 1 =:= 2)).` provides more service information:

```erlang-repl
fib:19: fib_test_...*failed*
in function fib:'-fib_test_/0-fun-14-'/0 (fib.erl, line 19)
**error:{assert,[{module,fib}, % look, here we have extended information!
         {line,19},
         {expression,"fib ( 31 ) =:= 2178309"},
         {expected,true},
         {value,false}]}
  output:<<"">>
```

* `?_assert(1 + 1 =:= 2).` is equal to `?_test(?assert(1 + 1 =:= 2)).`
---
# Homework

Please rewrite our Fibonacci calculator tests to one test function usign `?_assert` form.
---
class: center,middle
# End of Lecture 9
## Subject of next lecture: Build systems in Erlang. Rebar.
---
class: center,middle
# Bye, folks!

<img src="/images/1_joe_notebook.svg" alt="Joe with notebook" height="80%" width="80%" />
