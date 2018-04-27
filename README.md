# R.apex
R.apex is a functional library based on Apex, inspired by Lodash and Ramda.js.

## Why R.apex?
Apex is a pure object-oriented lanuage, and it does not provide any builtin features to make functional programming easier. The biggest obstacle in Apex is that functions(methods) are not First Class Citizens, the building blocks in a functional world. R.apex aims to pave the way for functional programming, and makes every attempt to mimic the functional features in Apex as much as possible. So we can adopt a functional paradigm based on R.apex.

## Features
- Handy Collection Utility
- Pseudo First Class Functions
- Function Currying and Partial Application
- Function Composition
- Function Chaining

## Examples
### Reverse a List
```java
List<Integer> reversedList = R.of(new List<Integer>{ 1, 2, 3 })
    .reverse()
    .debug()
    .toIntegerList();
// (3, 2, 1)
```

### Custom Sorting
```java
List<Account> accountList = ...;
List<Account> sortedList = R.of(accountList)
    .sortBy((Func)R.descend.run(R.prop.apply('LastName')))
    .toSObjectList();
// Sort account list by the last name, in descending order
```

### Combine Top 5 Elements from Two Lists
```java
List<String> list1 = ...;
List<String> list2 = ...;
List<String> wordList = R.of(list1)
    .take(5)
    .concat(R.of(list2).take(5))
    .toStringList();
// Combine and get List<String>
```

### Find Element
```java
List<Account> accountList = ...;
Account acc = (Account)R.of(accountList)
    .find(R.whereEq.apply(new Map<String, Object>{
        'LastName' => 'Wilson',
        'IsDeleted' => false
    }))
    .toSObject();
// Find the first account that is not deleted and has last name as 'Wilson'
```

### Get Account Id List
```java
List<Account> accountList = [ select id from account limit 10 ];
List<Id> accIdList = R.of(accountList)
    .pluck('Id')
    .debug()
    .toStringList();
```

### Convert Account List to Map by Id
```java
List<Account> accountList = [ select id from account limit 10 ];
Map<String, SObject> accMap = R.of(accountList)
    .indexBy(R.prop.apply('Id'))
    .debug()
    .toSObjectMap();
```

## Get Started
Copy `Func.cls`, `R.cls` and `RTest.cls`(optional) to your Org, and you are ready to go!

## Into the Functional World

### HelloWorld Function
Apex does not support first class functions, and we have NO WAY to get around it. However, we can create an invocable object camouflaged as a function, and it is referred to as a Func. Or more precisely, it is an instance of class Func. In R.apex, we roughly refer to instances of Func when we mention functions, to make things clear.

Here is how we create a function that returns `Hello World`.
```java
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
```java
Func helloworld = new HelloWorldFunc();
```

Let's invoke this function.
```java
String message = (String)helloworld.run();
System.debug(message);
// Hello World
```

That's how easy it is to create a function in R.apex.

### Function with Arguments
`HelloWorldFunc` does not make much sense, though it does a good illustration. Normally we want functions that accept arguments to do complex business logic. Here comes the `AddFunc`.
```java
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
Quite simple, right? In the constructor, we denote that this `AddFunc` takes two arguments(the length of the function), and correspondingly we override the `exec(Object, Object)` method from Func to have our custom implementation.

Try it.
```java
Func add = new AddFunc();
Integer result = (Integer)add.run(1, 2);
// 3
```
To conclude, we set the length of the function in its constructor, and override `exec(...)` method with correct arguments.

For example, if the length of the function is 3, we have `exec(Object, Object, Object)`. Easy, yeah?

What about a function with a length of 4? `exec(Object, Object, Object, Object)`?

Nay, when the length goes over 3, we have `execMore(List<Object>)` to override.

### Function with Variadic Arguments
So far so good. What if we need to handle functions that take variadic arguments? Let's extend our `AddFunc` to allow adding multiple numbers.
```java
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

### Partial Application
Well, all is good until we find something is missing. In functional programming, we can easily partially apply a function with arguments.

Say, we have a function, `f: (a, b, c) => a + b + c`, and we should fairly easily find out that:
```
var newFa = f(a);
var newFb = newFa(b);
var newFc = newFb(c);
```
Every time function `f` is applied part of the arguments it expects, it will save them and return a new function. This is great, as it guarrantees us the following:
```
f(a, b, c) ===
f(a, b)(c) ===
f(a)(b, c) ===
f(a)(b)(c)
```
Beautiful, yeah? We do hope that we can grant this magic to our function. Fortunately, R.apex has always been built with this idea in mind and implementing this is nothing but a piece of cake. See this:
```java
Func f1 = add.apply(1);
Func f2 = f1.apply(2);
Integer result = (Integer)f2.run();
```
Here, we have formally introduced `apply`, as a builtin method of Func. And also notice the biggest caveat in R.apex. *`Apply` does not trigger function invocation, while `run` does.* Even if the function has received enough arguments, it will not run until `run` is explicitly called.
Naturally, we have partial application available here.
```java
f.run(a, b, c) ===
f.apply(a, b, c).run() ===
f.apply(a, b).apply(c).run() ===
f.apply(a).apply(b, c).run() ===
f.apply(a).apply(b).apply(c).run()
```

Another thing to notice is that in functional programming, we tend to put the data we are manipulating in the last position in the argument list. For example,
```java
R.filter.run(R.isNotNull, myList);
// NOT
// R.filter.run(myList, R.isNotNull);
```
This is for the convenience of functional composition, which we will cover in the next section.

### Function Composition
Hopefully you have got some understanding on how to write a custom function by now. But that's far not enough. Writing functions by extending Func is still somehow bloate with boilerplates and it is kind of tedious. Better ways ahead.

The charm of functional programming lies not only in the fact of function currying and partial application, but also in the ability that they can compose. It is composition and decomposition that helps us to build a large application out of small bits and pieces in a functional world. And we adore the power.

So it is not hard to understand that functional composition is strongly recommended in R.apex, to write clean and clear codes. Let's take a leap to check it out.

```java
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
```java
Func f = (Func)R.pipe.run(
    R.multiply.apply(2),
    R.add.apply(1)
);
Integer result = (Integer)f.run(2);
// 5
```

It is actually the same as the previous one, only different in the composition style, namely, top-bottom, or left-to-right.

Getting familiar with functional composition is the approach to harness the power of functional programming. It takes time to sharpen the skill, and still there are more tools in functional composition in R.apex waiting to be discovered.

### Function Chaining
It is totally okay if you feel the last section a little too strange, not quite like the code we usually write. We have the alternate option for you: the easy way of function composition through chaining.

R.apex adopts the similar chaining style as that of jQuery, Lodash or Promise. If you have experiences of any of these libraries, you will easily pick up R.apex.

Here is what function chaining looks like:
```java
Integer sum = R.with(1, 2, 3)
    .doMap(R.inc)
    .sum()
    .toInteger();
```

Pretty familiar, right? In fact, most functions in R.apex are designed to be avaiable both in function composition and function chaining. Check this example:
```java
Func sum = (Func)R.pipe.run(
    R.doMap.apply(R.inc),
    R.sum,
    R.toInteger
);
Integer result = (Integer)sum.run(R.with(1, 2, 3));
```

This example is a rewrite of the previous example in functional composition style, and they are equivalent.

### Extend R.apex
It is your personal preference to choose between functional composition and function chaining. And the key takeaway is to use whatever is suitable in your case.

It is sad that the discovery of R.apex almost comes to an end. Realizing that the functions provided by R.apex is limited, you have to come up with your functions to tackle all the difficult business logic. The suggestion will be to encapsulate your core business logic in small custom functions and glue them together with the power of R.apex to build your own application. And this is the way you extend R.apex.

## Known Limitations

### Limited Support for Set and Map
Support for List is actually quite good, as `List<Object>` can be easily casted. However, Set and Map cannot be dynamically casted in Apex, and that makes it impossible to provide a full support. Currently, R.apex supports only `Set<String>` and `Map<String, Object>`.

### Reserved Keywords Conflict
Most of us have become familiar with some of the key functions in functional programming, but will come to a surprise that they are not available in R.apex. The fact is that they are indeed available in R.apex, but just under different names. The root cause is that Apex has reserved these keywords, and we are forced to use other names.

To list the renamed functions,

| Original Function Name | Actual Function Name |
| ---------------------- | -------------------- |
| and | doAnd |
| or | doOr |
| not | doNot |
| map | doMap |
| clone | doClone |
| insert | doInsert |
| insertAll | doInsertAll |
| join | doJoin |
| merge | doMerge |
| update | doUpdate |
| when | doWhen |

