---
title: "Function Composition"
description: "Function composition in R.apex"
buttonTitle: "Done"
parentId: "getting_started"
layout: "tutorial"
time: 90
weight: 6
---

## {$page.title}

Hopefully you have got some understanding on how to write a custom function by now. But that's far not enough. Writing functions by extending Func is still somehow bloate with boilerplates and it is kind of tedious. Better ways ahead.

The charm of functional programming lies not only in the fact of function currying and partial application, but also in the ability that they can compose. It is composition and decomposition that helps us to build a large application out of small bits and pieces in a functional world. And we adore the power.

So it is not hard to understand that functional composition is strongly recommended in R.apex, to write clean and clear codes. Let's take a leap to check it out.

```javascript
Func f = (Func)R.compose.run(
    R.add.apply(1),
    R.multiply.apply(2)
);
Integer result = (Integer)f.run(2);
// 5
```

Dive into this snippet, and we will make everything clear step by step. First, `R.add.apply(1)` creates a function `f2` that takes one number and adds 1 to it. `R.multiply.apply(2)` creates a function `f1` that takes one number and multiplies 2 to it. Then `compose` is the magic. It invokes `f1` with one argument(i.e, 2) and gets the intermediate result of 4. After that, it invokes `f2` with the intermediate result(i.e, 4) and gets the final result of 5. We can see that data flows from `f1` to `f2`, namely, bottom-up, or right-to-left.

And this is simply how functional composition works.

If you are not quite comfortable with that, you can also try this:

```javascript
Func f = (Func)R.pipe.run(
    R.multiply.apply(2),
    R.add.apply(1)
);
Integer result = (Integer)f.run(2);
// 5
```

It is actually the same as the previous one, only different in the composition style, namely, top-bottom, or left-to-right.

Getting familiar with functional composition is the approach to harness the power of functional programming. It takes time to sharpen the skill, and still there are more tools in functional composition in R.apex waiting to be discovered.
