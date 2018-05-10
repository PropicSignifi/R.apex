---
title: "Map Funcs"
description: "Map Funcs in R"
layout: "guide"
icon: "code-file"
weight: 10
---

###### {$page.description}

<article id="1">

## doMerge

Merge the two objects.

```javascript
R.doMerge.run(R.withObj('name', 'b'), R.withObj('name', 'a'))
// {name=b}
```

</article>


<article id="2">

## has

Check if the wrapped object has a non-null value of the field.

```javascript
R.has.run('Description', new Account())
// false
```

</article>


<article id="3">

## invert

Invert the wrapped object, with values mapped by the same key added to a list.

```javascript
R.invert.run(R.withObj('name', 'test'))
// {name=test}
```

</article>


<article id="4">

## invertObj

Invert the wrapped object.

```javascript
R.invertObj.run(R.withObj('name', 'test'))
// {name=test}
```

</article>


<article id="5">

## keys

Get the keys.

```javascript
R.keys.run(R.withObj('name', 'test'))
// {name}
```

</article>


<article id="6">

## omit

Omit the fields and pick remaining fields into a map.

```javascript
R.omit.run(R.with('Description'), new Account(Description='desc', FirstName='name'))
// {FirstName=name}
```

</article>


<article id="7">

## pick

Pick the fields into a map.

```javascript
R.pick.run(R.with('Description'), new Account(Description='desc', FirstName='name'))
// {Description=desc}
```

</article>


<article id="8">

## prop

Get the property value.

```javascript
R.prop.run('Description', new Account(Description='desc'))
// desc
```

</article>


<article id="9">

## propEq

Check that its property value equals given value.

```javascript
R.propEq.run('Description', 'desc', new Account(Description='desc'))
// true
```

</article>


<article id="10">

## propOr

Get the property value, or return the default value if it is null.

```javascript
R.propOr.run('Description', 'desc', new Account())
// desc
```

</article>


<article id="11">

## propSObject

Get the property value by 'getSObject'.

</article>


<article id="12">

## propSObjects

Get the property value by 'getSObjects'.

</article>


<article id="13">

## propSatisfies

Check if the property value satisfies the predicate.

```javascript
R.propSatisfies.run('Description', R.isNotNull, new Account())
// false
```

</article>


<article id="14">

## values

Get the values.

```javascript
R.values.run(R.withObj('name', 'test'))
// (test)
```

</article>


<article id="15">

## whereEq

Check if matching the key-values.

```javascript
R.whereEq.run(R.withObj('Description', 'desc'), new Account(Description='desc'))
// true
```

</article>


<article id="16">

## whereSatisfies

Check if matching the key-predicates.

```javascript
R.whereSatisfies.run(R.withObj('Description', R.isNotNull), new Account(Description='desc'))
// true
```

</article>
