---
title: "Condition Funcs"
description: "Condition Funcs in R"
layout: "guide"
icon: "code-file"
weight: 7
---

###### {$page.description}

<article id="1">

## cond

Returns a function, fn, which encapsulates if/else, if/else, logic.
It takes a list of functions, alternated by predicate and transformer.
All of the arguments to fn are applied to each of the predicates in turn until one returns a "truthy" value,
at which point fn returns the result of applying its arguments to the corresponding transformer.

```javascript
Func testF = (Func)R.cond.runN(new List<Object>{
    R.lt.apply(0), R.always.run(1),
    R.gt.apply(0), R.always.run(-1),
    R.equals.apply(0), R.always.run(0)
});
testF.run(3); // 1
```

</article>


<article id="2">

## doWhen

Tests the final argument by passing it to the given predicate function.
If the predicate is satisfied, the function will return the result of calling the whenTrueFn function with the same argument.
If the predicate is not satisfied, the argument is returned as a wrapping list.

```javascript
Func testF = (Func)R.doWhen.run(
    R.lt.apply(0),
    R.always.run(1)
);
testF.run(3); // 1
```

</article>


<article id="3">

## ifElse

Creates a function that will process either the onTrue or the onFalse function depending upon the result of the condition predicate.

```javascript
Func testF = (Func)R.ifElse.run(
    R.lt.apply(0),
    R.always.run(1),
    R.always.run(0)
);
testF.run(3); // 1
```

</article>


<article id="4">

## unless

Tests the final argument by passing it to the given predicate function.
If the predicate is not satisfied, the function will return the result of calling the whenFalseFn function with the same argument.
If the predicate is satisfied, the argument is returned as a wrapping list.

```javascript
Func testF = (Func)R.unless.run(
    R.lt.apply(0),
    R.always.run(0)
);
testF.run(-3); // 0
```

</article>
