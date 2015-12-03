class: center,middle

![Hey, Erlang](/images/hey_erlang.svg)
# Pre-alpha [Kottans](http://kottans.org) courses

---
class: center,middle

# Erlang data types and primitives
## Lecture 3.
---
class: center,middle
# Erlang types of data types
---
# Erlang types of data types

* Basic data types
---
# Erlang types of data types

* Basic data types
* Pseudo-types
---
# Erlang types of data types

* Basic data types
* Pseudo-types
* User-defined types
---
# Erlang types of data types

* Basic data types
* Pseudo-types
* User-defined types
* Reference
---
class: center,middle
# Basic data types
---
class: center,middle
# Basic data types
## Number
---
# Basic data types
## Number

* can be integer or float
---
# Basic data types
## Number

* can be integer or float
* can be negative or positive
---
# Basic data types
## Number

* can be integer or float
* can be negative or positive
* can be written in various forms
---
# Basic data types
## Number

* can be integer or float
* can be negative or positive
* can be written in various forms

```erlang-repl
1> 42. % positive integer
42
2> -42. % negative integer
-42
3> 16#FF. % number with base 16
255
4> 32#LOL. % number with base 32
22293
5> 32#lol. % numbers are case insensitive
22293
6> $Q. % character codes are numbers
81
7> $q. % they are case sentisive
113
```
---
# Basic data types
## Number

* can be integer or float
* can be negative or positive
* can be written in various forms

```erlang-repl
1> 12.345. % positive float
12.345
2> -12.345. % negative float
-12.345
3> 12.0E0. % float in power of 10 notation ==> 12.0 * 10^0
12.0
```
---
class: center,middle
# Basic data types
## Atom
---
class: center,top
# Basic data types
## Atom

<p align="center">
  <img src="/images/3_atom.svg" width="70%" height="70%"/>
</p>
---
# Basic data types
## Atom
---
# Basic data types
## Atom

* takes predefined place in memory like symbol in Ruby
---
# Basic data types
## Atom

* takes predefined place in memory like symbol in Ruby
* starts with lowercase
---
# Basic data types
## Atom

* takes predefined place in memory like symbol in Ruby
* starts with lowercase
* can contain spaces if quoted with single quotes
---
# Basic data types
## Atom

* takes predefined place in memory like symbol in Ruby
* starts with lowercase
* can contain spaces if quoted with single quotes
* can contain any symbol if quoted with single quotes
---
# Basic data types
## Atom

* takes predefined place in memory like symbol in Ruby
* starts with lowercase
* can contain spaces if quoted with single quotes
* can contain any symbol if quoted with single quotes

```erlang-repl
1> symbol. % just simple symbol
symbol
2> symbol_with_underscores. % symbol with underscores
symbol_with_underscores
3> 'Quoted symbol with spaces'. % quoted symbol with spaces
'Quoted symbol with spaces'
```
---
class: center,middle
# Basic data types
## Tuple
---
class: center,top
# Basic data types
## Tuple

<p align="center">
  <img src="/images/3_tuple.svg" height="70%" width="70%" />
</p>
---
# Basic data types
## Tuple
---
# Basic data types
## Tuple

* surrounded by curly brackets `{}`
---
# Basic data types
## Tuple

* surrounded by curly brackets `{}`
* can contain all other data types
---
# Basic data types
## Tuple

* surrounded by curly brackets `{}`
* can contain all other data types
* can contain tuples too
---
# Basic data types
## Tuple

* surrounded by curly brackets `{}`
* can contain all other data types
* can contain tuples too
* can be used in pattern matching to extract information
---
# Basic data types
## Tuple

* surrounded by curly brackets `{}`
* can contain all other data types
* can contain tuples too
* can be used in pattern matching to extract information

```erlang-repl
1> {42, 42, 42}. % tuple with integers
{42, 42, 42}
2> {}. % empty tuple
{}
3> {atom, 42, {another_tuple}}.
{atom, 42, {another_tuple}}
4> {name, Name} = {name, 'Joe'}. % extracting data by pattern matching
{name, 'Joe'}
5> Name.
'Joe'
6> {name, Name2} = {name}. % mismatch will lead to exception
** exception error: no match of right hand side value {name}
```
---
class: center,middle
# Basic data types
## List
---
class: center,top
# Basic data types
## List

<p align="center">
  <img src="/images/3_list.svg" width="70%" height="70%" />
</p>
---
# Basic data types
## List
---
# Basic data types
## List

* surrounded by square brackets `[]`
---
# Basic data types
## List

* surrounded by square brackets `[]`
* can contain all other data types
---
# Basic data types
## List

* surrounded by square brackets `[]`
* can contain all other data types
* can contain lists too
---
# Basic data types
## List

* surrounded by square brackets `[]`
* can contain all other data types
* can contain lists too
* can be used in pattern matching to extract information
---
# Basic data types
## List

* surrounded by square brackets `[]`
* can contain all other data types
* can contain lists too
* can be used in pattern matching to extract information
* effective grows to the left, not effective to the right
---
# Basic data types
## List

* surrounded by square brackets `[]`
* can contain all other data types
* can contain lists too
* can be used in pattern matching to extract information
* effective grows to the left, not effective to the right

```erlang-repl
1> []. % empty list
[]
2> [atom, 42, {tuple}, [list]]. % list with data
[atom, 42, {tuple}, [list]]
3> [H | T] = [1, 2, 3]. % usign pattern matching to extract head and tail of list
[1, 2, 3]
4> H. % head of list
1
5> T. % tail of list
[2, 3]
6> [5 | T]. % adding element to head of list
[5, 2, 3]
7> [5] ++ T. % merge lists
[5, 2, 3]
```
---
class: center,middle
# Basic data types
## Binary
---
# Basic data types
## Binary
---
# Basic data types
## Binary

* can represent plain binary data
---
# Basic data types
## Binary

* can represent plain binary data
* can represent strings
---
# Basic data types
## Binary

* can represent plain binary data
* can represent strings
* contains plain bits
---
# Basic data types
## Binary

* can represent plain binary data
* can represent strings
* contains plain bits
* pattern matching can be used to extract values
---
# Basic data types
## Binary

* can represent plain binary data
* can represent strings
* contains plain bits
* pattern matching can be used to extract values

```erlang-repl
1> Color = 16#FFFFFF. % bind Color variable
16777215
2> Pixel = <<Color:24>>. % use Color variable as 24-bit binary
<<"ÿÿÿ">> % this was because of heuristic string detection
3> <<R:8, G:8, B:8>> = Pixel.
<<"ÿÿÿ">>
4> R.
255
5> <<F:16, Rest/binary>> = Pixel. % pattern matching with type postfix
<<"ÿÿÿ">>
6> F.
65535
7> Rest.
<<"ÿ">>
```
---
class: center,middle
# Basic data types
## Functions
---
# Basic data types
## Functions
---
# Basic data types
## Functions

* can be anonymous or named
---
# Basic data types
## Functions

* can be anonymous or named
* have arity
---
# Basic data types
## Functions

* can be anonymous or named
* have arity
* used in generators and can accept other functions as arguments
---
# Basic data types
## Functions

* can be anonymous or named
* have arity
* used in generators and can accept other functions as arguments

```erlang-repl
1> F1 = fun(X) -> X * 2 end.
#Fun<erl_eval.6.90072148>
2> F2 = fun hello_world:hello/0.
#Fun<hello_world.hello.0>
3> F1(5).
10
4> F2().
Hello world!
ok
5> F3 = fun(X) -> X() end.
#Fun<erl_eval.6.90072148>
6> F3(F2).
Hello world!
ok
```
---
class: center,middle
# Basic data types
## PIDs
---
# Basic data types
## PIDs
---
# Basic data types
## PIDs

* PID is process identifier
---
# Basic data types
## PIDs

* PID is process identifier
* PID consists of node number, first 15 bits of process number, bits 16-18 of process number
---
# Basic data types
## PIDs

* PID is process identifier
* PID consists of node number, first 15 bits of process number, bits 16-18 of process number
* can be converted from other data types (but needs special format)
---
# Basic data types
## PIDs

* PID is process identifier
* PID consists of node number, first 15 bits of process number, bits 16-18 of process number
* can be converted from other data types (but needs special format)
* message can be sent to PID

```erlang-repl
1> PID = self().
<0.43.0>
2> PID ! ok.
ok
3> PID2 = list_to_pid("<0.239.0>").
<0.239.0>
```
---
class: center,middle
# Pseudo-types
---
# Pseudo-types

* String. String is enclosed in double quotes `""` and actually is a shorthand for list
---
# Pseudo-types

* String. String is enclosed in double quotes `""` and actually is a shorthand for list
* Record. Record is special guarded format for tuple
---
# Pseudo-types

* String. String is enclosed in double quotes `""` and actually is a shorthand for list
* Record. Record is special guarded format for tuple
* Boolean. Boolean is just atoms `true` and `false`
---
class: center,middle
# Pseudo-types
## String
---
# Pseudo-types
## String
---
# Pseudo-types
## String

* detected from list heuristically
---
# Pseudo-types
## String

* detected from list heuristically
* concatenated if written adjacent (only for 2 adjacent strings)
---
# Pseudo-types
## String

* detected from list heuristically
* concatenated if written adjacent (only for 2 adjacent strings)
* operates as list in BEAM
---
# Pseudo-types
## String

* detected from list heuristically
* concatenated if written adjacent (only for 2 adjacent strings)
* operates as list in BEAM

```erlang-repl
1> "hello". % plain string
"hello"
2> [$h, $e, $l, $l, $o]. % plain list
"hello" % was detected heuristically
3> "he" "llo". % concatenation
"hello"
4> "he" ++ "llo". % joining lists
"hello"
```
---
class: center,middle
# Pseudo-types
## Records
---
# Pseudo-types
## Records
---
# Pseudo-types
## Records

* Created for data storage
---
# Pseudo-types
## Records

* Created for data storage
* Fields can be referenced by their atom names
---
# Pseudo-types
## Records

* Created for data storage
* Fields can be referenced by their atom names
* Internally represented as a tuple `{type, Field1, Field2, ..., FieldN}`
---
# Pseudo-types
## Records

* Created for data storage
* Fields can be referenced by their atom names
* Internally represented as a tuple `{type, Field1, Field2, ..., FieldN}`
* Syntax of definition differs for source files and shell
---
## Pseudo-types
### Records

* Created for data storage
* Fields can be referenced by their atom names
* Internally represented as a tuple `{type, Field1, Field2, ..., FieldN}`
* Syntax of definition differs for source files and shell

```erlang-repl
1> rd(person, {name = "", phone = [], address}). % declare record
person
% actually analog of `-record(person, {name = "", phone = [], address}).` in source file
2> #person{phone=[0,8,2,3,4,3,1,2], name="Robert"}.
#person{name = "Robert",
        phone = [0,8,2,3,4,3,1,2],
        address = undefined}
3> #person{name = "Jakob", _ = '_'}. % non-explicit fields definition
#person{name = "Jakob",phone = '_',address = '_'}
4> P = #person{name = "Joe", phone = [0,8,2,3,4,3,1,2]}.
#person{name = "Joe",phone = [0,8,2,3,4,3,1,2],address = undefined}
5> P#person.name. % access record field
"Joe"
6> rf(). % forgot ALL record definitions
[]
7> P. % record is actually stored as tuple
{person,"Joe",[0,8,2,3,4,3,1,2],undefined}
```
---
class: center,middle
# Pseudo-types
## Boolean
---
# Pseudo-types
## Boolean
---
# Pseudo-types
## Boolean

* `true` and `false` actually are atoms
---
# Pseudo-types
## Boolean

* `true` and `false` actually are atoms
* this is all you need to know about booleans in Erlang
---
class: center,middle
# User-defined types
---
# User-defined types
---
# User-defined types

* consists from set of predefined types
---
# User-defined types

* consists from set of predefined types
* can not be named as already existant builtin types
---
# User-defined types

* consists from set of predefined types
* can not be named as already existant builtin types
* can not be declared in shell
---
# User-defined types

* consists from set of predefined types
* can not be named as already existant builtin types
* can not be declared in shell
---
class: center,middle
# Reference
---
class: center,middle
# Reference is unique across all the connected Universe!
---
class: center,middle
# Type guards
---
# Type guards
---
# Type guards

* `is_atom/1`, `is_binary/1`, `is_bitstring/1`, `is_boolean/1`, `is_float/1`, `is_function/1`
* `is_integer/1`, `is_list/1`, `is_number/1`
* `is_pid/1`, `is_port/1`, `is_record/2`
* `is_record/3`, `is_reference/1`, `is_tuple/1`
---
# Type guards

* `is_atom/1`, `is_binary/1`, `is_bitstring/1`, `is_boolean/1`, `is_float/1`, `is_function/1`
* `is_integer/1`, `is_list/1`, `is_number/1`
* `is_pid/1`, `is_port/1`, `is_record/2`
* `is_record/3`, `is_reference/1`, `is_tuple/1`
* There is no `typeof` function in Erlang. Because let it crash.
---
class: center,middle
# End of Lecture 3
## Subject of next lecture: Advanced Erlang code structures. Bye, shell!
---
class: center,middle
# Bye, folks!

<img src="/images/1_joe_notebook.svg" alt="Joe with notebook" height="80%" width="80%" />
