---
title: "String Funcs"
description: "String Funcs in R"
layout: "guide"
icon: "code-file"
weight: 9
---

###### {$page.description}

<article id="1">

## capitalize

Capitalize the string.

```javascript
R.capitalize.run('cat')
// Cat
```

</article>


<article id="2">

## match

Check regex match.

```javascript
R.match.run('.*(a).*', 'cat')
// (cat, a)
```

</article>


<article id="3">

## pad

Pad the string to the length, with given padding.

```javascript
R.pad.run(5, '*', 'cat')
// *cat*
```

</article>


<article id="4">

## padLeft

Pad the string to the left to the length, with given padding.

```javascript
R.pad.run(5, '*', 'cat')
// **cat
```

</article>


<article id="5">

## padRight

Pad the string to the right to the length, with given padding.

```javascript
R.pad.run(5, '*', 'cat')
// cat**
```

</article>


<article id="6">

## replace

Replace the string with replacement, only for the first occurrence of the matching.

```javascript
R.replace.run('cat', 'dog', 'I love cats')
// I love dogs
```

</article>


<article id="7">

## replaceAll

Replace the string with replacement, for all occurrences of the matching.

```javascript
R.replaceAll.run('cat', 'dog', 'I love cats')
// I love dogs
```

</article>


<article id="8">

## split

Split the string into a list.

```javascript
R.split.run(' ', 'a b c')
// (a, b, c)
```

</article>


<article id="9">

## test

Test for the string matching.

```javascript
R.test.run('.*a.*', 'cat')
// true
```

</article>


<article id="10">

## toLower

Convert the string into lowercase.

```javascript
R.toLower.run('ABC')
// abc
```

</article>


<article id="11">

## toUpper

Convert the string into uppercase.

```javascript
R.toUpper.run('abc')
// ABC
```

</article>


<article id="12">

## trim

Trim the string.

```javascript
R.trim.run(' abc ')
// abc
```

</article>
