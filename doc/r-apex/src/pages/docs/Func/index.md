---
title: "Func"
description: "Documentation of Func Object"
layout: "guide"
icon: "flash"
weight: 1
---

###### {$page.description}

<article id="1">

## What is a Func object?

A Func object represents a function, namely a block of business logic. Users can create new functions by composing smaller functions, or extend from this class to create any custom functions.

</article>

<article id="2">

## How to create a Func object?

Here is a sample custom function:

```javascript
class CustomFunc extends Func {
    public CustomFunc() {
        super(2);
    }
    public override Object exec(Object arg1, Object arg2) {
        // TODO
        return null;
    }
}

Func f = new CustomFunc();
```

In the constructor, we may specify the length of the Func by calling `super(2)`, or we can skip this to allow a variadic argument function.

There are a few `exec` methods from Func that we can override to provide our own implementations.

Extend `exec()` if our Func does not accept any argument.

Extend `exec(Object)` if our Func accepts one argument.

Extend `exec(Object, Object)` if our Func accepts two arguments.

Extend `exec(Object, Object, Object)` if our Func accepts three arguments.

Extend `execMore(List<Object>)` if our Func accepts more than three arguments.

Extend `execN(List<Object>)` if our Func accepts variadic arguments.

Here is the guide to help us decide which one is invoked.

If Func length is not specified, the `exec` method is invoked according to the
actual number of arguments.

If Func length is 0, only the `exec()` method is invoked.

If Func length is 1, only the `exec(Object)` method is invoked.

If Func length is 2, only the `exec(Object, Object)` method is invoked.

If Func length is 3, only the `exec(Object, Object, Object)` method is invoked.

If Func length is more than 3, only the `execMore(List<Object>)` method is invoked.

</article>

<article id="3">

## How to invoke a Func object?

There are two stages when invoking a Func:

a) Applying (optional)

Applying is the stage where the Func receives some arguments and stores them for invocation in the future.

Here is how we apply a Func:

```javascript
Func f = R.equals.apply(1);
```

If we want to apply more than 3 arguments, we have to use:

```javascript
Func f = SomeFunc.applyN(a, b, c, d, ...);
```

Each applying will in fact create a new Func, which means that the original Func will not get affected.

b) Running

Running is the stage where the Func uses all the arguments it has collected and produces the final result.

Here is how we run a Func:

```javascript
Object result = f.run(1);
```

If we want to run the func with more than 3 arguments, we have to use:

```javascript
Object result = f.runN(a, b, c, d, ...);
```

Suppose Func f takes three arugments, the following cases are equivalent:

```javascript
f.apply(a, b, c).run() ===
f.run(a, b, c) ===
f.apply(a).apply(b).apply(c).run() ===
f.apply(a).apply(b, c).run() ===
f.apply(a, b).apply(c)
```

</article>

<article id="4">

## Func Package

In R.apex, you can bundle your Funcs and export them as a Func Package. Func packages can be used
by others without interacting directly with your apex classes.

Here is how we define a Func Package:

```javascript
public class CustomPackage extends Func.DefaultPackage {
    public override void init() {
        this.export('plus', R.add);
    }
}
```

And you can then require the Func somewhere else.

```javascript
Func plus = Func.require('Custom.plus');
Object result = plus.run(1, 2);
```

The best practice is that you put your package class as a top level class, so that you leave the freedom
to users, who can then decide if they are going to use the Func Package, which relies on R.apex.

</article>
