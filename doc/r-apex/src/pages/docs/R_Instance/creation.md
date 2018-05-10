---
title: "Creation Methods"
description: "Creation methods of R"
layout: "guide"
icon: "cloud"
weight: 1
---

###### {$page.description}

<article id="1">

## emptyList

Factory function to create instance of R(empty list).

```javascript
R.emptyList().size().debug(); // 0
```

</article>


<article id="2">

## emptyMap

Factory function to create instance of R(empty set).

```javascript
R.emptySet().size().debug(); // 0
```

</article>


<article id="3">

## emptySet

Factory function to create instance of R(empty set).

```javascript
R.emptySet().size().debug(); // 0
```

</article>


<article id="4">

## emptyString

Factory function to create instance of R(empty string).

```javascript
R.emptyString().size().debug(); // 0
```

</article>


<article id="5">

## of

Factory function to create instance of R.

```javascript
R.of('message').size().debug(); // 7
```

</article>


<article id="6">

## range

Factory function to create instance of R(list of decimals in range).

```javascript
R.range(1, 3).debug(); // (1, 2)
```

</article>


<article id="7">

## with

Factory function to create instance of R(List).

```javascript
R.with(1).size().debug(); // 1
R.with(1, 2).size().debug(); // 2
R.with(1, 2, 3).size().debug(); // 3
```

</article>


<article id="8">

## withObj

Factory function to create instance of R(Map).

```javascript
R.withObj('name', 'test').size().debug(); // 1
```

</article>
