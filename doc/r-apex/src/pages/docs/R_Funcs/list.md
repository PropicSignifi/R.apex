---
title: "List Funcs"
description: "List Funcs in R"
layout: "guide"
icon: "code-file"
weight: 8
---

###### {$page.description}

<article id="1">

## adjust

Adjust the element using the function.

```javascript
R.adjust.run(R.inc, 1, R.with(1, 2, 3))
// (1, 3, 3)
```

</article>


<article id="2">

## all

Check if all elements match the predicate.

```javascript
R.all.run(R.isNotNull, R.with(1, 2, 3))
// true
```

</article>


<article id="3">

## append

Append an element to the elements.

```javascript
R.append.run(1, R.with(1, 2, 3))
// (1, 2, 3, 1)
```

</article>


<article id="4">

## assoc

Set the key value.

```javascript
R.assoc.run('name', 'test', new Map<String, Object>())
// {name=test}
```

</article>


<article id="5">

## biMap

Map over both the keys and values.

```javascript
R.bimap.run(R.append.apply('_key'), R.append.apply('_value'), R.withObj('name', 'test'))
// {test_key=test_value}
```

</article>


<article id="6">

## concat

Concatenate two objects.

```javascript
R.concat.run(R.with(1, 2, 3), R.with(4, 5, 6))
// (4, 5, 6, 1, 2, 3)
```

</article>


<article id="7">

## contains

Check if the element is contained.

```javascript
R.contains.run(1, R.with(1, 2, 3))
// true
```

</article>


<article id="8">

## containsBy

Check if the element is contained by the comparator returning boolean.

```javascript
R.containsBy.run(R.equals, 1, R.with(1, 2, 3))
// true
```

</article>


<article id="9">

## containsKey

Check if the key is contained.

```javascript
R.containsKey.run('name', new Map<String, Object>{ 'name' => 'test' })
// true
```

</article>


<article id="10">

## countBy

Get counts by the key.

```javascript
R.countBy.run(R.identity, R.with(1, 2, 2))
// {1=1, 2=2}
```

</article>


<article id="11">

## difference

Make a difference of the two objects.

```javascript
R.difference.run(R.with(1, 2, 3), R.with(2, 3, 4))
// (4)
```

</article>


<article id="12">

## dissoc

Remove the key value.

```javascript
R.dissoc.run('name', new Map<String, Object>{ 'name' => 'test' })
// {}
```

</article>


<article id="13">

## doInsert

Insert element at the index.

```javascript
R.doInsert.run(1, 'x', R.with(1, 2, 3))
// (1, x, 2, 3)
```

</article>


<article id="14">

## doInsertAll

Insert elements at the index.

```javascript
R.doInsertAll.run(1, R.with('x', 'y'), R.with(1, 2, 3))
// (1, x, y, 2, 3)
```

</article>


<article id="15">

## doJoin

Join the elements by the separator.

```javascript
R.doJoin.run('-', R.with(1, 2, 3))
// 1-2-3
```

</article>


<article id="16">

## doMap

Map over the elements.

```javascript
R.doMap.run(R.inc, R.with(1, 2, 3))
// (2, 3, 4)
```

</article>


<article id="17">

## doUpdate

Update an element of the elements.

```javascript
R.doUpdate.run(1, 3, R.with(1, 2, 3))
// (1, 3, 3)
```

</article>


<article id="18">

## drop

Drop first N elements.

```javascript
R.drop.run(1, 'abc')
// bc
```

</article>


<article id="19">

## dropRight

Drop first N elements from right.

```javascript
R.dropRight.run(1, 'abc')
// ab
```

</article>


<article id="20">

## dropRightWhile

Drop elements from right until not satisfied.

```javascript
R.dropRightWhile.run(R.equals.apply('a'), 'abc')
// abc
```

</article>


<article id="21">

## dropWhile

Drop elements until not satisfied.

```javascript
R.dropWhile.run(R.equals.apply('a'), 'abc')
// bc
```

</article>


<article id="22">

## endsWith

Check ending with.

```javascript
R.endsWith('a', 'abc')
// false
```

</article>


<article id="23">

## every

Same as `all`.

</article>


<article id="24">

## filter

Filter on the elements.

```javascript
R.filter.run(R.isNotNull, R.with('a', null, 'b'))
// (a, b)
```

</article>


<article id="25">

## find

Find the first element that matches the predicate.

```javascript
R.find.run(R.equals.apply('a'), R.with('a', 'b'))
// a
```

</article>


<article id="26">

## findIndex

Find the index of the first element that matches the predicate.

```javascript
R.findIndex.run(R.equals.apply('a'), R.with('a', 'b'))
// 0
```

</article>


<article id="27">

## findLast

Find the first element from last that matches the predicate.

```javascript
R.findLast.run(R.equals.apply('a'), R.with('a', 'b'))
// a
```

</article>


<article id="28">

## findLastIndex

Find the index of the first element from last that matches the predicate.

```javascript
R.findLastIndex.run(R.equals.apply('a'), R.with('a', 'b'))
// 0
```

</article>


<article id="29">

## first

Get the first element.

```javascript
R.first.run(R.with(1, 2, 3))
// 1
```

</article>


<article id="30">

## flatten

Flatten the elements recursively.

```javascript
R.flatten.run(R.with(1, R.with(2, R.with(3))))
// (1, 2, 3)
```

</article>


<article id="31">

## forEach

Do for-each on the elements.

```javascript
R.forEach.run(R.debug, R.with(1, 2, 3));
// 1
// 2
// 3
```

</article>


<article id="32">

## fromPairs

Convert a list of pairs to map.

```javascript
R.fromPairs.run(R.with(new R.Pair('a', 1)))
// {a=1}
```

</article>


<article id="33">

## groupBy

Get groups by the key.

```javascript
R.groupBy.run(R.identity, R.with(1, 2, 2))
// {1=(1), 2=(2, 2)}
```

</article>


<article id="34">

## head

Same as `first`.

</article>


<article id="35">

## indexBy

Get indexes by the key.

```javascript
R.indexBy.run(R.identity, R.with(1, 2, 2))
// {1=1, 2=2}
```

</article>


<article id="36">

## indexOf

Get the index of the first element found.

```javascript
R.indexOf.run(1, R.with(1, 2, 3))
// 0
```

</article>


<article id="37">

## init

Get the elements except the last.

```javascript
R.init.run(R.with(1, 2, 3))
// (1, 2)
```

</article>


<article id="38">

## intersection

Make an intersection of the two objects.

```javascript
R.intersection.run(R.with(1, 2, 3), R.with(2, 3, 4))
// (2, 3)
```

</article>


<article id="39">

## isEmpty

Check if it is empty.

```javascript
R.isEmpty.run(R.with(1, 2, 3))
// false
```

</article>


<article id="40">

## last

Get the last element.

```javascript
R.last.run(R.with(1, 2, 3))
// 3
```

</article>


<article id="41">

## lastIndexOf

Get the index of the first element found from the last.

```javascript
R.lastIndexOf.run(1, R.with(1, 2, 3))
// 0
```

</article>


<article id="42">

## length

Get the length.

```javascript
R.length.run(R.with(1, 2, 3))
// 3
```

</article>


<article id="43">

## none

Check if none of the elements match the predicate.

```javascript
R.none.run(R.isNotNull, R.with(1, 2, 3))
// true
```

</article>


<article id="44">

## nth

Get the nth element.

```javascript
R.nth.run(1, R.with(1, 2, 3))
// 2
```

</article>


<article id="45">

## pair

Create a pair.

```javascript
R.pair.run(1, 2)
// Pair:[fst=1, snd=2]
```

</article>


<article id="46">

## partition

Create a partitioned pair using the predicate.

```javascript
R.partition.run(R.equals.apply('a'), R.with('a', 'b', 'c'))
// Pair:[fst=(a), snd=(b, c)]
```

</article>


<article id="47">

## pluck

Pluck the fields out of elements.

```javascript
R.pluck.run('Description', R.with(new Account(Description='desc')))
// (desc)
```

</article>


<article id="48">

## prepend

Prepend an element to the elements.

```javascript
R.prepend.run(1, R.with(1, 2, 3))
// (1, 1, 2, 3)
```

</article>


<article id="49">

## project

Project elements into other elements according to the fields.

```javascript
R.project.run(R.with('Description'), R.with(new Account(Description='desc')))
// ({Description=desc})
```

</article>


<article id="50">

## range

Generate a range of decimals.

```javascript
R.range.run(1, 3)
// (1, 2)
```

</article>


<article id="51">

## reduce

Reduce over the elements.

```javascript
R.reduce.run(R.add, 0, R.with(1, 2, 3))
// 6
```

</article>


<article id="52">

## reject

Reject on the elements.

```javascript
R.reject.run(R.isNull, R.with('a', null, 'b'))
// (a, b)
```

</article>


<article id="53">

## remove

Remove elements.

```javascript
R.remove.run(1, 2, R.with(1, 2, 3))
// (1)
```

</article>


<article id="54">

## repeat

Repeat the target to generate elements.

```javascript
R.repeat.run(5, 'a')
// (a, a, a, a, a)
```

</article>


<article id="55">

## reverse

Reverse the elements.

```javascript
R.reverse.run('abc')
// cba
```

</article>


<article id="56">

## sample

Get a random element.

```javascript
R.sample.run('abcdef')
// e
```

</article>


<article id="57">

## sampleSize

Get a list of random elements.

```javascript
R.sampleSize.run(2, 'abcdef')
// df
```

</article>


<article id="58">

## shuffle

Create a shuffled collection.

```javascript
R.shuffle.run('abcdef')
// fdeabc
```

</article>


<article id="59">

## size

Get the size. See `length`.

</article>


<article id="60">

## slice

Get a slice of the elements.

```javascript
R.slice.run(0, 1, R.with(1, 2, 3))
// (1)
```

</article>


<article id="61">

## some

Check if some elements match the predicate.

```javascript
R.some.run(R.isNotNull, R.with(1, 2, 3))
// false
```

</article>


<article id="62">

## sortBy

Sort by the comparator.

```javascript
R.sortBy.run(R.compare, R.with(3, 2, 1))
// (1, 2, 3)
```

</article>


<article id="63">

## sortDefault

Sort by default.

```javascript
R.sortDefault.run(R.with(3, 2, 1))
// (1, 2, 3)
```

</article>


<article id="64">

## startsWith

Check starting with.

```javascript
R.startsWith('a', 'abc')
// true
```

</article>


<article id="65">

## sum

Get the sum.

```javascript
R.sum.run(R.with(1, 2, 3))
// 6
```

</article>


<article id="66">

## tail

Get the elements except the first.

```javascript
R.tail.run(R.with(1, 2, 3))
// (2, 3)
```

</article>


<article id="67">

## take

Take the first N elements.

```javascript
R.take.run(1, 'abc')
// a
```

</article>


<article id="68">

## takeRight

Take the first N elements from right.

```javascript
R.takeRight.run(1, 'abc')
// c
```

</article>


<article id="69">

## takeRightWhile

Take elements from right until not satisfied.

```javascript
R.takeRightWhile.run(R.equals.apply('a'), 'abc')
//
```

</article>


<article id="70">

## takeWhile

Take elements until not satisfied.

```javascript
R.takeWhile.run(R.equals.apply('a'), 'abc')
// a
```

</article>


<article id="71">

## times

Invoke a function for N times.

```javascript
R.times.run(3, R.identity)
// (0, 1, 2)
```

</article>


<article id="72">

## toPairs

Convert a map to a list of pairs.

```javascript
R.toPairs.run(new Map<String, Object>{ 'name' => 'test' })
// (Pair:[fst=name, snd=test])
```

</article>


<article id="73">

## union

Make a union of the two objects.

```javascript
R.union.run(R.with(1, 2, 3), R.with(2, 3, 4))
// (2, 3, 4, 1)
```

</article>


<article id="74">

## uniq

Get a unique collection of the elements.

```javascript
R.uniq.run(R.with(1, 2, 2))
// (1, 2)
```

</article>


<article id="75">

## unnest

Flatten the elements by one level.

```javascript
R.unnest.run(R.with(1, R.with(2, 3)))
// (1, 2, 3)
```

</article>


<article id="76">

## without

Same with `difference`.

</article>


<article id="77">

## xor

Make an xor of the two objects.

```javascript
R.xor.run(R.with(1, 2, 3), R.with(2, 3, 4))
// (4, 1)
```

</article>


<article id="78">

## zip

Zip two collections to create a list of pairs.

```javascript
R.zip.run(R.with('a', 'b'), R.with(1, 2))
// (Pair:[fst=a, snd=1], Pair:[fst=b, snd=2])
```

</article>


<article id="79">

## zipObj

Zip two collections to create a map.

```javascript
R.zipObj.run(R.with('a', 'b'), R.with(1, 2))
// {a=1, b=2}
```

</article>
