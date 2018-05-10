---
title: "HelloWorld Function"
description: "Create a simple HelloWorld function"
buttonTitle: "Done"
parentId: "getting_started"
layout: "tutorial"
time: 90
weight: 2
---

## {$page.title}

Apex does not support first class functions, and we have NO WAY to get around it. However, we can create an invocable object camouflaged as a function, and it is referred to as a Func. Or more precisely, it is an instance of class Func. In R.apex, we roughly refer to instances of Func when we mention functions, to make things clear.

Here is how we create a function that returns `Hello World`.

```javascript
public class HelloWorldFunc extends Func {
    public HelloWorldFunc() {
        super(0);
    }

    public override Object exec() {
        return 'Hello World';
    }
}
```

And then we get a function!

```javascript
Func helloworld = new HelloWorldFunc();
```

Let's invoke this function.

```javascript
String message = (String)helloworld.run();
System.debug(message);
// Hello World
```

That's how easy it is to create a function in R.apex.
