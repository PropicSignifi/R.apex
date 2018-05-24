---
title: "Utility Funcs"
description: "Utility Funcs in R"
layout: "guide"
icon: "code-file"
weight: 11
---

###### {$page.description}

<article id="1">

## F

A function that always returns false.

```javascript
R.F.run()
// false
```

</article>


<article id="2">

## T

A function that always returns true.

```javascript
R.T.run()
// true
```

</article>


<article id="3">

## compact

Remove any null value from the elements.

```javascript
R.compact.run(R.with(1, null, 2))
// (1, 2)
```

</article>


<article id="4">

## debug

Print the debug log.

```javascript
R.debug.run(1)
// 1
```

</article>


<article id="5">

## defaultTo

Default to a value.

```javascript
R.defaultTo.run(5, null)
// 5
```

</article>


<article id="6">

## doClone

Get the clone.

```javascript
R.doClone.run(new Account())
// Account:{}
```

</article>


<article id="7">

## isNil

Check if it is null.

```javascript
R.isNil.run(null)
// true
```

</article>


<article id="8">

## isNotNil

Check if it is not null.

```javascript
R.isNotNil.run(null)
// false
```

</article>


<article id="9">

## isNotNull

Same as `isNotNil`.

</article>


<article id="10">

## isNull

Same as `isNil`.

</article>


<article id="11">

## isNumber

Check if it is number.

```javascript
R.isNumber.run(1)
// true
```

</article>


<article id="12">

## noop

No op function.

```javascript
R.noop.run()
// null
```

</article>

<article id="13">

## assert

Do System assert

```javascript
R.assert.run(1 == 1, 'should equal');
```

</article>

<article id="14">

## assertEquals

Do System assertEquals

```javascript
R.assertEquals.run(1, 1, 'should equal');
```

</article>

<article id="15">

## assertNotEquals

Do System assertNotEquals

```javascript
R.assertNotEquals.run(1, 2, 'should not equal');
```

</article>
