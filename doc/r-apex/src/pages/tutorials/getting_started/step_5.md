---
title: "Partial Application"
description: "Partial application in R.apex"
buttonTitle: "Done"
parentId: "getting_started"
layout: "tutorial"
time: 90
weight: 5
---

## {$page.title}

Well, all is good until we find something is missing. In functional programming, we can easily partially apply a function with arguments.

Say, we have a function, `f: (a, b, c) => a + b + c`, and we should fairly easily find out that:

```javascript
var newFa = f(a);
var newFb = newFa(b);
var newFc = newFb(c);
```

Every time function `f` is applied part of the arguments it expects, it will save them and return a new function. This is great, as it guarrantees us the following:

```javascript
f(a, b, c) ===
f(a, b)(c) ===
f(a)(b, c) ===
f(a)(b)(c)
```

Beautiful, yeah? We do hope that we can grant this magic to our function. Fortunately, R.apex has always been built with this idea in mind and implementing this is nothing but a piece of cake. See this:

```javascript
Func f1 = add.apply(1);
Func f2 = f1.apply(2);
Integer result = (Integer)f2.run();
```

Here, we have formally introduced `apply`, as a builtin method of Func. And also notice the biggest caveat in R.apex. `Apply` does **not** trigger function invocation, while `run` does. Even if the function has received enough arguments, it will not run until `run` is explicitly called. Naturally, we have partial application available here.

```javascript
f.run(a, b, c) ===
f.apply(a, b, c).run() ===
f.apply(a, b).apply(c).run() ===
f.apply(a).apply(b, c).run() ===
f.apply(a).apply(b).apply(c).run()
```

Another thing to notice is that in functional programming, we tend to put the data we are manipulating in the last position in the argument list. For example,

```javascript
R.filter.run(R.isNotNull, myList);
// NOT
// R.filter.run(myList, R.isNotNull);
```

This is for the convenience of functional composition, which we will cover in the next section.
