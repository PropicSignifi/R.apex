---
title: "Function with Variadic Arguments"
description: "Create a function that takes variadic arguments"
buttonTitle: "Done"
parentId: "getting_started"
layout: "tutorial"
time: 90
weight: 4
---

## {$page.title}

So far so good. What if we need to handle functions that take variadic arguments? Let's extend our `AddFunc` to allow adding multiple numbers.

```javascript
public class AddFunc extends Func {
    public AddFunc() {
        super(-1);
    }

    public override Object execN(List<Object> args) {
        Integer sum = 0;
        for(Object arg : args) {
            sum += (Integer)arg;
        }
        return sum;
    }
}
```

Now this time, we specify the length of the function to be -1, which means that it takes any number of arguments. Also we have our `execN(List<Object>)` overridden to get the sum of all the numbers.

By the way, the default length is -1, so if we want a variadic function, we don't even need to call `super(-1)`. In our case, we can simply omit the constructor.
