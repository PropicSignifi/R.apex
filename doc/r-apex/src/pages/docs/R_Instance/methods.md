---
title: "Methods"
description: "methods of R"
layout: "guide"
icon: "cloud"
weight: 3
---

###### {$page.description}

<article id="1">

## adjust

Update the element at index with the function.

```javascript
R.with(1, 2, 3).adjust(R.add.apply(1), 1).debug(); // (1, 3, 3)
```

</article>


<article id="2">

## all

Check if all elements match the predicate.

```javascript
R.with(1, 2, 3).all(R.equals.apply(1)).debug(); // false
```

</article>


<article id="3">

## append

Append the element to the elements.

```javascript
R.with(1, 2, 3).append(4).debug(); // (1, 2, 3, 4)
```

</article>


<article id="4">

## assoc

Associate the value to the key.

```javascript
R.withObj('name', 'value').assoc('name', 'newValue').debug(); // {name=newValue}
```

</article>


<article id="5">

## capitalize

Return a new string with the first letter in uppercase.

```javascript
R.of('cat').capitalize().debug(); // Cat
```

</article>


<article id="6">

## clamp

Return a value that is limited between the min and the max.

```javascript
R.of(4).clamp(1, 3).debug(); // 3
```

</article>


<article id="7">

## compact

Remove null values from the elements.

```javascript
R.with('a', null, 0).compact().debug();
// (a, 0)
```

</article>


<article id="8">

## concat

Concatenate the other.

```javascript
R.with(1, 2, 3).concat(R.with(4, 5, 6)).debug();
```

</article>


<article id="9">

## contains

Check if the target is contained.

```javascript
R.with(1, 2, 3).contains(2).debug(); // true
```

</article>


<article id="10">

## containsBy

Check if the target is contained by the predicate.

```javascript
R.with(1, 2, 3).containsBy(R.equals, 2).debug(); // true
```

</article>


<article id="11">

## containsKey

Check if the key is contained.

```javascript
R.withObj('name', 'test').containsKey('name').debug(); // true
```

</article>


<article id="12">

## countBy

Get a result of count mapped by the key.

```javascript
R.with(1, 2, 2).countBy(R.identity).debug();
```

</article>


<article id="13">

## debug

Print debug information.

```javascript
R.with(1, 2).debug(); // (1, 2)
```

</article>


<article id="14">

## defaultTo

Get the default value.

```javascript
R.of(null).defaultTo(3).debug(); // 3
```

</article>


<article id="15">

## difference

Do a difference with the other object.

```javascript
R.with(1, 2, 3).difference(R.with(2, 3, 4)).debug(); // (1)
```

</article>


<article id="16">

## dissoc

Remove the value mapped by the key.

```javascript
R.withObj('name', 'value').dissoc('name').debug(); // {}
```

</article>


<article id="17">

## doClone

Get a clone.

```javascript
R.with(1, 2, 3).doClone().debug(); // (1, 2, 3)
```

</article>


<article id="18">

## doInsert

Insert the element at the index.

```javascript
R.with(1, 2, 3).doInsert(1, 'x').debug(); // (1, x, 2, 3)
```

</article>


<article id="19">

## doInsertAll

Insert all the elements at the index.

```javascript
R.with(1, 2, 3).doInsertAll(1, R.with('x', 'y')).debug(); // (1, x, y, 2, 3)
```

</article>


<article id="20">

## doJoin

Join the elements with the separator.

```javascript
R.with(1, 2, 3).doJoin('-').debug(); // 1-2-3
```

</article>


<article id="21">

## doMap

Map a function over the elements.

```javascript
R.with(1, 2, 3).doMap(R.add.apply(1)).debug(); // (2, 3, 4)
```

</article>


<article id="22">

## doMerge

Merge the source.

```javascript
R.withObj('name', 'test').doMerge(R.withObj('name', 'newTest')).debug();
// {name=newTest}
```

</article>


<article id="23">

## doUpdate

Update the element at the specified index.

```javascript
R.with(1, 2, 3).doUpdate(1, 3).debug(); // (1, 3, 3)
```

</article>


<article id="24">

## drop

Drop the first N elements.

```javascript
R.with(1, 2, 3).drop(2).debug(); // (3)
```

</article>


<article id="25">

## dropRight

Drop the first N elements from right.

```javascript
R.with(1, 2, 3).dropRight(2).debug(); // (1)
```

</article>


<article id="26">

## dropRightWhile

Drop from right until the predicate is not satisfied.

```javascript
R.with(1, 2, 3).dropRightWhile(R.equals.apply(1)).debug(); // (1, 2, 3)
```

</article>


<article id="27">

## dropWhile

Drop until the predicate is not satisfied.

```javascript
R.with(1, 2, 3).dropWhile(R.equals.apply(1)).debug(); // (2, 3)
```

</article>


<article id="28">

## endsWith

Check if the elements end with the value.

```javascript
R.of('abc').endsWith('bc').debug(); // true
```

</article>


<article id="29">

## every

Check if every element matches the predicate.

```javascript
R.with(1, 2, 3).every(R.equals.apply(1)).debug(); // false
```

</article>


<article id="30">

## evolve

Apply the function to the value mapped by the same key and calculate the evolved object.

```javascript
R.withObj('name', 'test').evolve(new Map<String, Object>{ 'name' => R.append.apply('more') }).debug();
// {name=testmore}
```

</article>


<article id="31">

## filter

Call the function to filter the elements of instance R.

```javascript
R.with(1, 2, 3).filter(R.equals.apply(2)).debug(); // (2)
R.with(new Account(Description = 'desc'), new Account()).filter('Description').debug(); // (Account:{Description=desc})
R.with(new Account(Description = 'desc'), new Account()).filter('Description', 'desc').debug(); // (Account:{Description=desc})
R.with(new Account(Description = 'desc'), new Account()).filter(new Map<String, Object>{ 'Description' => 'desc' }).debug();
// (Account:{Description=desc})
```

</article>


<article id="32">

## find

Find the first element that satisfies the predicate.

```javascript
R.with(1, 2, 3).find(R.equals.apply(2)).debug(); // 2
```

</article>


<article id="33">

## findIndex

Find the index of the first element that matches the predicate.

```javascript
R.with(1, 2, 3).findIndex(R.equals.apply(2)).debug(); // 1
```

</article>


<article id="34">

## findLast

Find the first element that satisfies the predicate from last.

```javascript
R.with(1, 2, 3).findLast(R.equals.apply(2)).debug(); // 2
```

</article>


<article id="35">

## findLastIndex

Find the index of the first element that matches the predicate from last.

```javascript
R.with(1, 2, 3).findLastIndex(R.equals.apply(2)).debug(); // 1
```

</article>


<article id="36">

## first

Get the first element.

```javascript
R.with(1, 2, 3).first().debug(); // 1
```

</article>


<article id="37">

## flatten

Flatten the elements recursively.

```javascript
R.with(1, new List<Object>{ 2, new List<Object>{ 3 } }, 4).flatten().debug();
// (1, 2, 3, 4)
```

</article>


<article id="38">

## forEach

Call the function to each element of instance R.

```javascript
R.with(1, 2, 3).forEach(R.debug);
// 1
// 2
// 3
```

</article>


<article id="39">

## fromPairs

Convert from a list of pairs to a map.

```javascript
R.with(new R.Pair('name', 'test')).fromPairs().debug();
// {name=test}
```

</article>


<article id="40">

## groupBy

Get a result of count mapped by the key.

```javascript
R.with(1, 2, 2).countBy(R.identity).debug();
```

</article>


<article id="41">

## head

Get the first element.

```javascript
R.with(1, 2, 3).head().debug(); // 1
```

</article>


<article id="42">

## indexBy

Get object indexed by the key.

```javascript
R.with(1, 2, 2).indexBy(R.identity).debug();
```

</article>


<article id="43">

## indexOf

Get the index of the target.

```javascript
R.with(1, 2, 3).indexOf(2).debug(); // 1
```

</article>


<article id="44">

## init

Get the elements except the last.

```javascript
R.with(1, 2, 3).init().debug(); // (1, 2)
```

</article>


<article id="45">

## intersection

Do an intersection with the other object.

```javascript
R.with(1, 2, 3).intersection(R.with(2, 3, 4)).debug(); // (2, 3)
```

</article>


<article id="46">

## invert

Get an inverted map, values mapped by duplicate keys are put in a list.

```javascript
R.withObj('name', 'test').invert().debug();
```

</article>


<article id="47">

## invertObj

Get an inverted map.

```javascript
R.withObj('name', 'test').invertObj().debug();
// {test=name}
```

</article>


<article id="48">

## isEmpty

Check if it is empty.

```javascript
R.with(1, 2, 3).isEmpty().debug(); // false
```

</article>


<article id="49">

## keys

Get the keys of the wrapped map.

```javascript
R.withObj('name', 'test').keys().debug();
// {name}
```

</article>


<article id="50">

## last

Get the last element.

```javascript
R.with(1, 2, 3).last().debug(); // 3
```

</article>


<article id="51">

## lastIndexOf

Get the index of the target from the last.

```javascript
R.with(1, 2, 3).lastIndexOf(2).debug(); // 1
```

</article>


<article id="52">

## length

Get the length, same as size().

```javascript
R.with(1, 2, 3).length().debug(); // 3
```

</article>


<article id="53">

## match

Get a list of matched groups after doing a regex match.

```javascript
R.of('abc').match('.*(a).*').debug();
// (abc, a)
```

</article>


<article id="54">

## none

Check if none of the elements matches the predicate.

```javascript
R.with(1, 2, 3).none(R.equals.apply(1)).debug(); // false
```

</article>


<article id="55">

## nth

Get the nth element.

```javascript
R.with(1, 2, 3).nth(1).debug(); // 2
```

</article>


<article id="56">

## omit

Omit the values specified by the list of keys.

```javascript
R.of(new Account(FirstName='test', Description='desc')).omit(new List<String>{ 'Description' }).debug();
// {FirstName=test}
```

</article>


<article id="57">

## pad

Pad the string to the length.

```javascript
R.of('cat').pad(5, '*').debug(); // *cat*
```

</article>


<article id="58">

## padLeft

Pad the string to the length from the left.

```javascript
R.of('cat').padLeft(5, '*').debug(); // **cat
```

</article>


<article id="59">

## padRight

Pad the string to the length from the right.

```javascript
R.of('cat').padRight(5, '*').debug(); // cat**
```

</article>


<article id="60">

## partition

Create a paritioned pair using the predicate.

```javascript
R.with(1, 2, 3).partition(R.equals.apply(1)).debug();
// Pair:[fst=(1), snd=(2, 3)]
```

</article>


<article id="61">

## pick

Pick the values specified by the list of keys.

```javascript
R.of(new Account(FirstName='test', Description='desc')).pick(new List<String>{ 'Description' }).debug();
// {Description=desc}
```

</article>


<article id="62">

## pluck

Extract the field out of the object to a new list.

```javascript
R.with(new Account(Description='desc')).pluck('Description').debug();
// (desc)
```

</article>


<article id="63">

## prepend

Prepend the element to the elements.

```javascript
R.with(1, 2, 3).prepend(4).debug(); // (4, 1, 2, 3)
```

</article>


<article id="64">

## project

Project a list of objects using the list of fields.

```javascript
R.with(new Account(Description='desc', FirstName='test')).project(new List<String>{ 'Description' }).debug();
// ({Description=desc})
```

</article>


<article id="65">

## reduce

Reduce over the elements.

```javascript
R.with(1, 2, 3).reduce(R.add, 0).debug(); // 6
```

</article>


<article id="66">

## reject

Reject the elements by checking with the predicate.

```javascript
R.with(new Account(Description = 'desc'), new Account()).reject((Func)R.complement.run(R.has.apply('Description'))).debug();
// (Account:{Description=desc})

R.with(new Account(Description = 'desc'), new Account()).reject('Description').debug();
// (Account:{})

R.with(new Account(Description = 'desc'), new Account()).reject('Description', 'desc').debug();
// (Account:{})

R.with(new Account(Description = 'desc'), new Account()).reject(new Map<String, Object>{ 'Description' => 'desc' }).debug();
// (Account:{})
```

</article>


<article id="67">

## remove

Remove elements starting at the index and specified by the count.

```javascript
R.with(1, 2, 3).remove(1, 3).debug();
// (1)
```

</article>


<article id="68">

## repeat

Create a list of elements by repeating the element.

```javascript
R.of('a').repeat(3).debug(); // (a, a, a)
```

</article>


<article id="69">

## replace

Replace the string according to the pattern and replacement.

```javascript
R.of('I love cats').replace('cat', 'dog').debug();
// I love dogs
```

</article>


<article id="70">

## replaceAll

Replace all the strings according to the pattern and replacement.

```javascript
R.of('I love cats').replaceAll('cat', 'dog').debug();
// I love dogs
```

</article>


<article id="71">

## reverse

Reverse the elements.

```javascript
R.with(1, 2, 3).reverse().debug(); // (3, 2, 1)
```

</article>


<article id="72">

## sample

Get a random element.

```javascript
R.with(1, 2, 3).sample().debug(); // 3
```

</article>


<article id="73">

## sampleSize

Get a list of random elements.

```javascript
R.with(1, 2, 3).sampleSize(2).debug(); // (3, 1)
```

</article>


<article id="74">

## shuffle

Create a shuffled list of elements.

```javascript
R.with(1, 2, 3).shuffle().debug(); // (3, 1, 2)
```

</article>


<article id="75">

## size

Get the size, same as length().

```javascript
R.with(1, 2, 3).size().debug(); // 3
```

</article>


<article id="76">

## slice

Get a slice of the elements.

```javascript
R.with(1, 2, 3).slice(1, 2).debug(); // (2)
```

</article>


<article id="77">

## some

Check if some elements match the predicate.

```javascript
R.with(1, 2, 3).some(R.equals.apply(1)).debug(); // true
```

</article>


<article id="78">

## sortBy

Sort the elements by the comparator.

```javascript
R.with(new Account(Description='abc'), new Account(Description='def')).sortBy((Func)R.descend.run(R.prop.apply('Description'))).debug();
// (Account:{Description=def}, Account:{Description=abc})
```

</article>


<article id="79">

## sortDefault

Sort the elements by default.

```javascript
R.with(3, 2, 1).sortDefault().debug(); // (1, 2, 3)
```

</article>


<article id="80">

## split

Split the string by the separator.

```javascript
R.of('a/b/c').split('/').debug();
// (a, b, c)
```

</article>


<article id="81">

## startsWith

Check if the elements start with the value.

```javascript
R.with(1, 2, 3).startsWith(new List<Integer>{ 1, 2 }).debug(); // true
```

</article>


<article id="82">

## sum

Get the sum.

```javascript
R.with(1, 2, 3).sum().debug(); // 6
```

</article>


<article id="83">

## tail

Get the elements except the first.

```javascript
R.with(1, 2, 3).tail().debug(); // (2, 3)
```

</article>


<article id="84">

## take

Take the first N elements.

```javascript
R.with(1, 2, 3).take(2).debug(); // (1, 2)
```

</article>


<article id="85">

## takeRight

Take the first N elements from right.

```javascript
R.with(1, 2, 3).takeRight(2).debug(); // (2, 3)
```

</article>


<article id="86">

## takeRightWhile

Take elements from right until the predicate is not satisfied.

```javascript
R.with(1, 2, 3).takeRightWhile(R.equals.apply(1)).debug(); // ()
```

</article>


<article id="87">

## takeWhile

Take elements until the predicate is not satisfied.

```javascript
R.with(1, 2, 3).takeWhile(R.equals.apply(1)).debug(); // (1)
```

</article>


<article id="88">

## test

Test the string according to the pattern.

```javascript
R.of('cat').test('.*b.*').debug(); // false
```

</article>


<article id="89">

## toLower

Convert the string to lowercase.

```javascript
R.of('Cat').toLower().debug(); // cat
```

</article>


<article id="90">

## toPairs

Convert a map to a list of pairs.

```javascript
R.withObj('name', 'test').toPairs().debug();
// (Pair:[fst=name, snd=test])
```

</article>


<article id="91">

## toUpper

Convert the string to uppercase.

```javascript
R.of('cat').toUpper().debug(); // CAT
```

</article>


<article id="92">

## transform

Transform the wrapped value using the function.

```javascript
R.with(1, 2, 3).transform(R.size).debug(); // 3
```

</article>


<article id="93">

## trim

Trim the string.

```javascript
R.of('  a  ').trim().debug(); // a
```

</article>


<article id="94">

## union

Do a union with the other object.

```javascript
R.with(1, 2, 3).union(R.with(2, 3, 4)).debug(); // (1, 2, 3, 4)
```

</article>


<article id="95">

## uniq

Return unique elements.

```javascript
R.with(1, 2, 2).uniq().debug(); // (1, 2)
```

</article>


<article id="96">

## unnest

Flatten the elements by one level.

```javascript
R.with(1, new List<Object>{ 2, 3 }, 4).unnest().debug();
// (1, 2, 3, 4)
```

</article>


<article id="97">

## values

Get the values of the wrapped map.

```javascript
R.withObj('name', 'test').values().debug();
// (test)
```

</article>


<article id="98">

## without

Same as `difference`.

```javascript
R.with(1, 2, 3).without(R.with(2, 3, 4)).debug(); // (1)
```

</article>


<article id="99">

## xor

Do an xor with the other object.

```javascript
R.with(1, 2, 3).xor(R.with(2, 3, 4)).debug(); // (1, 4)
```

</article>


<article id="100">

## zip

Create a zipped list of pairs according to the mList.

```javascript
R.with('a', 'b').zip(new List<Object>{ 1, 2 }).debug();
// (Pair:[fst=1, snd=a], Pair:[fst=2, snd=b])
```

</article>


<article id="101">

## zipObj

Create a zipped map according to the mList.

```javascript
R.with('a', 'b').zipObj(new List<Object>{ 1, 2 }).debug();
// {1=a, 2=b}
```

</article>
