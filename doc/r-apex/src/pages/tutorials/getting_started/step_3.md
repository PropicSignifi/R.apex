---
title: "Function with Arguments"
description: "Create a function that takes arguments"
buttonTitle: "Done"
parentId: "getting_started"
layout: "tutorial"
time: 90
weight: 3
---

## {$page.title}

`HelloWorldFunc` does not make much sense, though it does a good illustration. Normally we want functions that accept arguments to do complex business logic. Here comes the `AddFunc`.

```javascript
public class AddFunc extends Func {
    public AddFunc() {
        super(2);
    }

    public override Object exec(Object arg1, Object arg2) {
        Integer a = (Integer)arg1;
        Integer b = (Integer)arg2;
        return a + b;
    }
}
```

Quite simple, right? In the constructor, we denote that this AddFunc takes two arguments(the length of the function), and correspondingly we override the exec(Object, Object) method from Func to have our custom implementation.

Try it.

```javascript
Func add = new AddFunc();
Integer result = (Integer)add.run(1, 2);
// 3
```

To conclude, we set the length of the function in its constructor, and override `exec(...)` method with correct arguments.

For example, if the length of the function is 3, we have `exec(Object, Object, Object)`. Easy, yeah?

What about a function with a length of 4? `exec(Object, Object, Object, Object)`?

Nay, when the length goes over 3, we have `execMore(List<Object>)` to override.
