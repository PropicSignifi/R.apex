---
title: "Conversion Funcs"
description: "Conversion Funcs in R"
layout: "guide"
icon: "code-file"
weight: 1
---

###### {$page.description}

<article id="1">

## Single Value Conversion

Convert single values. Examples are like:

```javascript
Object a = ...;
String str = R.toString.run(a);
```

| Type | Func |
| ---- | ---- |
| Boolean | toBoolean |
| Integer | toInteger |
| Long | toLong |
| Double | toDouble |
| Decimal | toDecimal |
| String | toString |
| Date | toDate |
| Time | toTime |
| Datetime | toDatetime |
| Func | toFunc |
| R.Pair | toPair |
| SObject | toSObject |

</article>

<article id="2">

## List Value Conversion

Convert list values. Examples are like:

```javascript
Object a = ...;
List<String> strList = R.toStringList.run(a);
```

| Type | Func |
| ---- | ---- |
| List&lt;Object&gt; | toList |
| List&lt;Boolean&gt; | toBooleanList |
| List&lt;Integer&gt; | toIntegerList |
| List&lt;Long&gt; | toLongList |
| List&lt;Double&gt; | toDoubleList |
| List&lt;Decimal&gt; | toDecimalList |
| List&lt;String&gt; | toStringList |
| List&lt;Date&gt; | toDateList |
| List&lt;Time&gt; | toTimeList |
| List&lt;Datetime&gt; | toDatetimeList |
| List&lt;Func&gt; | toFuncList |
| List&lt;R.Pair&gt; | toPairList |
| List&lt;SObject&gt; | toSObjectList |

</article>

<article id="3">

## Map Value Conversion

Convert map values. Examples are like:

```javascript
Object a = ...;
Map<String, String> strMap = R.toStringMap.run(a);
```

| Type | Func |
| ---- | ---- |
| Map&lt;String, Object&gt; | toMap |
| Map&lt;String, Boolean&gt; | toBooleanMap |
| Map&lt;String, Integer&gt; | toIntegerMap |
| Map&lt;String, Long&gt; | toLongMap |
| Map&lt;String, Double&gt; | toDoubleMap |
| Map&lt;String, Decimal&gt; | toDecimalMap |
| Map&lt;String, String&gt; | toStringMap |
| Map&lt;String, Date&gt; | toDateMap |
| Map&lt;String, Time&gt; | toTimeMap |
| Map&lt;String, Datetime&gt; | toDatetimeMap |
| Map&lt;String, Func&gt; | toFuncMap |
| Map&lt;String, R.Pair&gt; | toPairMap |
| Map&lt;String, SObject&gt; | toSObjectMap |

</article>

<article id="4">

## Set Value Conversion

Convert set values. Examples are like:

```javascript
Object a = ...;
Set<String> strSet = R.toSet.run(a);
Set<Id> strSet = R.toIdSet.run(a);
```

| Type | Func |
| ---- | ---- |
| Set&lt;String&gt; | toSet |
| Set&lt;Id&gt; | toIdSet |

</article>

<article id="5">

## Conversion Check

Check if conversions can be made. Examples are like:

```javascript
Object a = ...;
Boolean b = R.isStringLike.run(a);
```

| Type | Func |
| ---- | ---- |
| String | isStringLike |
| Func | isFuncLike |
| List&lt;Object&gt; | isListLike |
| Set&lt;String&gt; | isSetLike |
| Map&lt;String, Object&gt; | isMapLike |
| R.Pair | isPairLike |
| SObject | isSObjectLike |

</article>
