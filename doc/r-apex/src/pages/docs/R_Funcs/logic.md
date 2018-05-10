---
title: "Logic Funcs"
description: "Logic Funcs in R"
layout: "guide"
icon: "code-file"
weight: 3
---

###### {$page.description}

<article id="1">

## allPass

Create a function that combines all predicates with 'and'.

```javascript
Func f = (Func)R.allPass.run(
    R.startsWith.apply('c'),
    R.endsWith.apply('t')
);
system.debug(f.run('cat'));
// true
```

</article>


<article id="2">

## anyPass

Create a function that combines all predicates with 'or'.

```javascript
Func f = (Func)R.anyPass.run(
    R.startsWith.apply('c'),
    R.endsWith.apply('t')
);
system.debug(f.run('cc'));
// true
```

</article>


<article id="3">

## complement

Create a function that negate the predicate.

```javascript
Func f = (Func)R.complement.run(R.equals.apply('cat'));
system.debug(f.run('cat'));
// false
```

</article>


<article id="4">

## doAnd

Test logic 'and'.

```javascript
R.doAnd.run(true, false)
// false
```

</article>


<article id="5">

## doNot

Test logic 'not'.

```javascript
R.doNot.run(false)
// true
```

</article>


<article id="6">

## doOr

Test logic 'or'.

```javascript
R.doOr.run(true, false)
// true
```

</article>
