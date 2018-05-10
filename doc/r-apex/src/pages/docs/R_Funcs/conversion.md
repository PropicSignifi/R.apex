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
| List | toList |
| Set | toSet |
| Map | toMap |
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
| Boolean | toBooleanList |
| Integer | toIntegerList |
| Long | toLongList |
| Double | toDoubleList |
| Decimal | toDecimalList |
| String | toStringList |
| Date | toDateList |
| Time | toTimeList |
| Datetime | toDatetimeList |
| Func | toFuncList |
| R.Pair | toPairList |
| SObject | toSObjectList |

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
| Boolean | toBooleanMap |
| Integer | toIntegerMap |
| Long | toLongMap |
| Double | toDoubleMap |
| Decimal | toDecimalMap |
| String | toStringMap |
| Date | toDateMap |
| Time | toTimeMap |
| Datetime | toDatetimeMap |
| Func | toFuncMap |
| R.Pair | toPairMap |
| SObject | toSObjectMap |

</article>

<article id="4">

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
| List | isListLike |
| Set | isSetLike |
| Map | isMapLike |
| R.Pair | isPairLike |
| SObject | isSObjectLike |

</article>
