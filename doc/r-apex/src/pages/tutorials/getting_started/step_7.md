---
title: "Function Chaining"
description: "Function chaining in R.apex"
buttonTitle: "Done"
parentId: "getting_started"
layout: "tutorial"
time: 90
weight: 7
---

## {$page.title}

It is totally okay if you feel the last section a little too strange, not quite like the code we usually write. We have the alternate option for you: the easy way of function composition through chaining.

R.apex adopts the similar chaining style as that of jQuery, Lodash or Promise. If you have experiences of any of these libraries, you will easily pick up R.apex.

Here is what function chaining looks like:

```javascript
Integer sum = R.with(1, 2, 3)
    .doMap(R.inc)
    .sum()
    .toInteger();
```

Pretty familiar, right? In fact, most functions in R.apex are designed to be avaiable both in function composition and function chaining. Check this example:

```javascript
Func sum = (Func)R.pipe.run(
    R.doMap.apply(R.inc),
    R.sum,
    R.toInteger
);
Integer result = (Integer)sum.run(R.with(1, 2, 3));
```

This example is a rewrite of the previous example in functional composition style, and they are equivalent.
