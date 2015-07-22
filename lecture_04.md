class: center, middle

![Hey, Erlang](/images/hey_erlang.svg)
# Pre-alpha [Kottans](http://kottans.org) courses

---
class: center,middle

# Advanced Erlang code structures
## Lecture 4.
---
class: center,middle

# Modules
---
# Modules
---
# Modules

* Erlang module is a group of connected functions in common namespace
---
# Modules

* Erlang module is a group of connected functions in common namespace
* can contain attributes
---
# Modules

* Erlang module is a group of connected functions in common namespace
* can contain attributes
* the only required attribute is module name (`-module(Module)`)
---
# Modules

* Erlang module is a group of connected functions in common namespace
* can contain attributes
* the only required attribute is module name (`-module(Module)`)
* can export functions (`-export(Functions)`)
---
# Modules

* Erlang module is a group of connected functions in common namespace
* can contain attributes
* the only required attribute is module name (`-module(Module)`)
* can export functions (`-export(Functions)`)
* can import functions (`-import(Module, Functions)`)
---
# Modules

* Erlang module is a group of connected functions in common namespace
* can contain attributes
* the only required attribute is module name (`-module(Module)`)
* can export functions (`-export(Functions)`)
* can import functions (`-import(Module, Functions)`)
* can receive options for compiler (`-compile(Options)`)
---
# Modules

* Erlang module is a group of connected functions in common namespace
* can contain attributes
* the only required attribute is module name (`-module(Module)`)
* can export functions (`-export(Functions)`)
* can import functions (`-import(Module, Functions)`)
* can receive options for compiler (`-compile(Options)`)
* can contain version (`-vsn(Version)`)
---
# Modules

* Erlang module is a group of connected functions in common namespace
* can contain attributes
* the only required attribute is module name (`-module(Module)`)
* can export functions (`-export(Functions)`)
* can import functions (`-import(Module, Functions)`)
* can receive options for compiler (`-compile(Options)`)
* can contain version (`-vsn(Version)`)
* can execute function on loading (`-on_load(Function)`)
---
# Modules
---
# Modules

In general modules can contain:
---
# Modules

In general modules can contain:

* function declarations
---
# Modules

In general modules can contain:

* function declarations
* type declarations
---
# Modules

In general modules can contain:

* function declarations
* type declarations
* record declarations
---
# Modules

In general modules can contain:

* function declarations
* type declarations
* record declarations
* macros
---
# Modules

In general modules can contain:

* function declarations
* type declarations
* record declarations
* macros
* another attributes
---
class: center, middle
# Modules
## Function declarations
---
# Modules
## Function declarations
---
# Modules
## Function declarations

* is a sequence of function clauses separated by `;`
---
# Modules
## Function declarations

* is a sequence of function clauses separated by `;`
* consists of clause head and clause body, separated by `->`
---
# Modules
## Function declarations

* is a sequence of function clauses separated by `;`
* consists of clause head and clause body, separated by `->`
* *head* consists of name, argument list and optional guard
---
# Modules
## Function declarations

* is a sequence of function clauses separated by `;`
* consists of clause head and clause body, separated by `->`
* *head* consists of name, argument list and optional guard
* *body* consists of sequence of expressions separated by `,`
---
# Modules
## Function declarations

* is a sequence of function clauses separated by `;`
* consists of clause head and clause body, separated by `->`
* *head* consists of name, argument list and optional guard
* *body* consists of sequence of expressions separated by `,`

```erlang
fact(N) when N>0 -> % first clause head (name atom, args list + guard)
  N * fact(N-1);    % first clause body
fact(0) ->          % second clause head
  1.                % second clause body and end of function
```
---
class: center,middle
# Modules
## Type declarations and specifications
---
# Modules
## Type declarations and specifications
---
# Modules
## Type declarations and specifications

Erlang allows developer to define user types. This definitions can be used internally for function specifications, externally (known as *remote types*) and in records.
---
# Modules
## Type declarations and specifications

Erlang allows developer to define user types. This definitions can be used internally for function specifications, externally (known as *remote types*) and in records.

* has to be derived from predefined types
---
# Modules
## Type declarations and specifications

Erlang allows developer to define user types. This definitions can be used internally for function specifications, externally (known as *remote types*) and in records.

* has to be derived from predefined types
* has to have unique name if exported (inside module)
---
# Modules
## Type declarations and specifications

Erlang allows developer to define user types. This definitions can be used internally for function specifications, externally (known as *remote types*) and in records.

* has to be derived from predefined types
* has to have unique name if exported (inside module)
* can be used for static type analyzer tool like Dialyzer or for documentation
---
# Modules
## Type declarations and specifications

Erlang allows developer to define user types. This definitions can be used internally for function specifications, externally (known as *remote types*) and in records.

* has to be derived from predefined types
* has to have unique name if exported (inside module)
* can be used for static type analyzer tool like Dialyzer or for documentation

```erlang
-module(mod).
-type orddict(Key, Val) :: [{Key, Val}]. % type with name orddict and args Key and Val
-export_type([orddict/2]). % list with types and their arity

% example of usage in record
-record(ordrec, {field1 :: orddict()}). % record can contain field1 which is orddict
% example of usage in specification
-spec fact(N :: integer()) -> integer(). % N argument of function fact can only be integer and result is integer too
```
---
class: center,middle
# Modules
## Record declarations
---
# Modules
## Record declarations
---
# Modules
## Record declarations

As you remember, record is syntax sugar for tuple with named fields.

```erlang
-record(person, {name = "", phone = [], address}). % definition of record in module
-record(name, {first = "Robert", last = "Ericsson"}).
-record(person, {name = #name{}, phone}). % example of nested record
```
---
class: center,middle
# Modules
## Macros
---
# Modules
## Macros

Macro is an special instruction for compiler. They can be user-defined or predefined.

```erlang
-define(Const, Replacement). % Const will be replaced in time of compiling with Replacement value
-define(TIMEOUT, 200). % example of above

-define(MACRO1(X, Y), {a, X, b, Y}). % example of parameters in macros
```
---
# Modules
## Macros

Macro is an special instruction for compiler. They can be user-defined or predefined.

* `?MODULE` - atom name of current module
---
# Modules
## Macros

Macro is an special instruction for compiler. They can be user-defined or predefined.

* `?MODULE` - atom name of current module
* `?MODULE_STRING` - string name of current module
---
# Modules
## Macros

Macro is an special instruction for compiler. They can be user-defined or predefined.

* `?MODULE` - atom name of current module
* `?MODULE_STRING` - string name of current module
* `?FILE` - file name of current module
---
# Modules
## Macros

Macro is an special instruction for compiler. They can be user-defined or predefined.

* `?MODULE` - atom name of current module
* `?MODULE_STRING` - string name of current module
* `?FILE` - file name of current module
* `?LINE` - current line number
---
# Modules
## Macros

Macro is an special instruction for compiler. They can be user-defined or predefined.

* `?MODULE` - atom name of current module
* `?MODULE_STRING` - string name of current module
* `?FILE` - file name of current module
* `?LINE` - current line number
* `?MACHINE` - virtual machine name, `BEAM`
---
class: center,middle
# Expressions
---
class: center,middle
# Expressions
## Case
---
# Expressions
## Case

```erlang
case Expr of
  Pattern1 [when GuardSeq1] ->
    Body1;
  ...;
  PatternN [when GuardSeqN] ->
    BodyN
end
```
---
class: center,middle
# Expressions
## If
---
# Expressions
## If

```erlang
if
  GuardSeq1 ->
    Body1;
  ...;
  GuardSeqN ->
    BodyN;
  true -> % works as else branch
    Result
end
```
---
class: center,middle
# Expressions
## Try...catch...after
---
# Expressions
## Try...catch...after

```erlang
try Exprs of
  Pattern1 [when GuardSeq1] ->
    Body1;
  ...;
  PatternN [when GuardSeqN] ->
    BodyN
catch
  [Class1:]ExceptionPattern1 [when ExceptionGuardSeq1] ->
    ExceptionBody1;
  ...;
  [ClassN:]ExceptionPatternN [when ExceptionGuardSeqN] ->
    ExceptionBodyN
after
  AfterBody
end
```
---
class: center,middle
# Expressions
## Receive
---
# Expressions
## Receive

```erlang
receive
  Pattern1 [when GuardSeq1] ->
    Body1;
  ...;
  PatternN [when GuardSeqN] ->
    BodyN
after
  ExprT -> % ExprT :: integer(), timeout for receive loop
    BodyT
end
```
---
class: center,middle
# Comparison
---
# Comparison

* `==` - equal to
---
# Comparison

* `==` - equal to
* `/=` - not equal to
---
# Comparison

* `==` - equal to
* `/=` - not equal to
* `=<` - less than
---
# Comparison

* `==` - equal to
* `/=` - not equal to
* `=<` - less than or equal to
* `<`  - less than
---
# Comparison

* `==` - equal to
* `/=` - not equal to
* `=<` - less than or equal to
* `<`  - less than
* `>=` - greater than or equal to
---
# Comparison

* `==` - equal to
* `/=` - not equal to
* `=<` - less than or equal to
* `<`  - less than
* `>=` - greater than or equal to
* `>`  - greater than
---
# Comparison

* `==` - equal to
* `/=` - not equal to
* `=<` - less than or equal to
* `<`  - less than
* `>=` - greater than or equal to
* `>`  - greater than
* `=:=` - exactly equal to
---
# Comparison

* `==` - equal to
* `/=` - not equal to
* `=<` - less than or equal to
* `<`  - less than
* `>=` - greater than or equal to
* `>`  - greater than
* `=:=` - exactly equal to
* `=/=` - exactly not equal to
---
# Comparison

* `==` - equal to
* `/=` - not equal to
* `=<` - less than or equal to
* `<`  - less than
* `>=` - greater than or equal to
* `>`  - greater than
* `=:=` - exactly equal to
* `=/=` - exactly not equal to
* types comparison order: `number < atom < reference < fun < port < pid < tuple < list < bit string`
---
class: center,middle
# End of Lecture 4
## Subject of next lecture: Concurrency, scaling, multiprocessing.
---
class: center,middle
# Bye, folks!

<img src="/images/1_joe_notebook.svg" alt="Joe with notebook" height="80%" width="80%" />
