---
title: "Function Funcs"
description: "Function Funcs in R"
layout: "guide"
icon: "code-file"
weight: 5
---

###### {$page.description}

<article id="1">

## always

Return a function which returns the value whenever called.


```javascript
Func f = (Func)R.always.run(1);
System.debug(f.run(2));
```

</article>


<article id="2">

## applySpec

Given a spec object recursively mapping properties to functions, creates a function producing an object of the same structure,
by mapping each property to the result of calling its associated function with the supplied arguments.


```javascript
Map<String, Object> spec = new Map<String, Object>{
    'add' => R.add,
    'subtract' => R.subtract
};
System.debug(R.applySpec.run(spec, 1, 2));
// {add=3, subtract=-1}
```

</article>


<article id="3">

## binary

Make the function accept only two arguments. See `nAry`.

</article>


<article id="4">

## compose

Compose the functions in a composing style.
Composed functions are executed from right to left.

```javascript
Func f = (Func)R.pipe.run(
    R.add.apply(1),
    R.multiply.apply(2)
);
System.debug(f.run(1));
// 3
```

</article>


<article id="5">

## converge

Accepts a converging function and branching functions and returns a new function.
When invoked, this new function is applied to some arguments, each branching function is applied to those same arguments.
The results of each branching function are passed as arguments to the converging function to produce the return value.

```javascript
Func f = (Func)R.converge.run(
    R.multiply,
    R.add,
    R.subtract
);
System.debug(f.run(1, 2));
// -3
```

</article>


<article id="6">

## evlove

Creates a new object by recursively evolving a copy of object, according to the transformation functions.


```javascript
R.evolve.run(new Map<String, Object>{ 'name' => R.append.apply('$') }, new Map<String, Object>{ 'name' => 'test' })
// {name=test$}
```

</article>


<article id="7">

## flip

Flip the first two arguments of a function.

```javascript
Func f = (Func)R.flip.run(R.subtract);
System.debug(f.run(1, 2));
// 1
```

</article>


<article id="8">

## identity

Return whatever is passed in.

```javascript
R.identity.run('abc')
// abc
```

</article>


<article id="9">

## juxt

Applies a list of functions to a list of values.


```javascript
List<Func> fns = new List<Func>{ R.add, R.subtract };
System.debug(R.juxt.run(fns, 1, 2));
// (3, -1)
```

</article>


<article id="10">

## memoize

Wrap the function to make it memoizable.


```javascript
Func testF = (Func)R.memoize.run(
   R.add.apply(1),
   'testF',
   R.toString
);
```

</article>


<article id="11">

## nAry

Wrap the function to make it accept only N arguments.


```javascript
Func f = (Func)R.nAry.run(2, R.product);
System.debug(f.run(1, 2, 3));
// 2
```

</article>


<article id="12">

## once

Wrap the function to make it call only by once.


```javascript
Func testF = (Func)R.once.run(R.add.apply(1), 'testF');
testF.run(1) // 2
testF.run(2) // 2
```

</article>


<article id="13">

## pipe

Compose the functions in a piping style.
Composed functions are executed from left to right.

```javascript
Func f = (Func)R.pipe.run(
    R.add.apply(1),
    R.multiply.apply(2)
);
System.debug(f.run(1));
// 4
```

</article>


<article id="14">

## placeholder

A placeholder in the applied arguments.

```javascript
R.subtract.apply(R.placeholder, 2).run(1)
// -1
```

</article>


<article id="15">

## transform

Apply the function to the target.


```javascript
R.transform.run(R.inc, 1)
// 2
```

</article>


<article id="16">

## unary

Make the function accept only one argument. See `nAry`.

</article>


<article id="17">

## useWith

Accepts a function fn and other functions and returns a new function.
When the new function is invoked, it calls the function fn with parameters consisting 
of the result of calling each supplied handler on successive arguments to the new function.

```javascript
Func f = (Func)R.useWith.run(
    R.multiply,
    R.add.apply(1),
    R.subtract.apply(1)
);
System.debug(f.run(1, 2));
// -2
```

</article>
