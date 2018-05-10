---
title: "Comparator Funcs"
description: "Comparator Funcs in R"
layout: "guide"
icon: "code-file"
weight: 6
---

###### {$page.description}

<article id="1">

## ascend

Convert a function into an ascending comparator.

```javascript
Func f = (Func)R.ascend.run(R.identity);
System.debug(f.run(1, 2));
// -1
```

</article>


<article id="2">

## cascade

Combine the comparator functions into one.

```javascript
Func f = (Func)R.cascade.run(
    (Func)R.ascend.run(R.prop.apply('FirstName')),
    (Func)R.ascend.run(R.prop.apply('Description'))
);
```

</article>


<article id="3">

## clamp

Limit the value between the min and the max.

```javascript
R.clamp.run(1, 3, 5)
// 3
```

</article>


<article id="4">

## comparator

Convert a Boolean-returning comparator to an Integer-returning comparator.

```javascript
Func f = (Func)R.comparator.run(R.lt);
System.debug(f.run(1, 2));
// -1
```

</article>


<article id="5">

## compare

Compare two objects.

```javascript
R.compare.run(1, 2)
// -1
```

</article>


<article id="6">

## descend

Convert a function into an descending comparator.

```javascript
Func f = (Func)R.descend.run(R.identity);
System.debug(f.run(1, 2));
// 1
```

</article>
