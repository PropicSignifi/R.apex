/**
 * MIT License
 *
 * Copyright (c) 2018 Click to Cloud Pty Ltd
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 **/
/**
 * Functional Library for Apex
 *
 * Apex is a pure OOP, and there is no way to make it a FP, because we cannot use functions
 * as the First Class Citizens
 *
 * The goal of this library is to make it possible to mimic the functional features as much
 * as possible
 *
 * Func Objects
 *
 * We do not have first class functions, but we can create Func objects to simulate function behaviors
 * Refer to Func.cls for detailed information
 *
 * Favors in two styles of composition
 *
 * a) Functional Composition
 * Example:
 * // f(x) = 2 * (1 + x)
 * // f :: Number -> Number
 * Func f = (Func)R.pipe.run(
 *     R.add.apply(1),
 *     R.multiply.apply(2)
 * );
 * Decimal result = (Decimal)f.run(1); // 4
 *
 * b) Functional Chaining
 * Example:
 * R.of(new List<Integer>{ 1, 2 })
 *     .doMap(R.multiply.apply(2))
 *     .sum()
 *     .debug(); // 6
 *
 * Functions in R do not mutate the wrapped values
 *
 * Some function names are reserved keywords in Apex, so they are prefixed with 'do'
 *
 * For example, 'map' is changed to 'doMap', and 'join' to 'doJoin'
 * */
public class R implements Func.IPackage {
    /**
     * Value contained in instance of R
     * Preferred to be List<Object>, Set<String>, Map<String, Object> and String.
     * */
    private Object val;

    /**
     * Construct instance of R
     * */
    private R(Object val) {
        this.val = val;
    }

    /**
     * This is only for reflection
     * Please do not use this
     * */
    public R() {
        this(null);
    }

    /**
     * Export the Funcs of this package
     *
     * @return Map<String, Func>
     * */
    public Map<String, Func> export() {
        return R.API;
    }

    /**
     * Require the Func by name
     *
     * @param funcName The name of the Func
     * @return Func
     * */
    public Func require(String funcName) {
        return R.API.get(funcName);
    }

    /**
     * Factory function to create instance of R
     *
     * Example:
     * R.of('message').size().debug(); // 7
     *
     * @param val The raw value to be wrapped
     * @return R
     * */
    public static R of(Object val) {
        return new R(val);
    }

    /**
     * Factory function to create instance of R(List)
     *
     * Example:
     * R.with(1).size().debug(); // 1
     *
     * @param arg The first element
     * @return R
     * */
    public static R with(Object arg) {
        return R.of(new List<Object>{ arg });
    }

    /**
     * Factory function to create instance of R(List)
     *
     * Example:
     * R.with(1, 2).size().debug(); // 2
     *
     * @param arg1 The first element
     * @param arg2 The second element
     * @return R
     * */
    public static R with(Object arg1, Object arg2) {
        return R.of(new List<Object>{ arg1, arg2 });
    }

    /**
     * Factory function to create instance of R(List)
     *
     * Example:
     * R.with(1, 2, 3).size().debug(); // 3
     *
     * @param arg1 The first element
     * @param arg2 The second element
     * @param arg3 The third element
     * @return R
     * */
    public static R with(Object arg1, Object arg2, Object arg3) {
        return R.of(new List<Object>{ arg1, arg2, arg3 });
    }

    /**
     * Factory function to create instance of R(Map)
     *
     * Example:
     * R.withObj('name', 'test').size().debug(); // 1
     *
     * @param arg1 The key
     * @param arg2 The value
     * @return R
     * */
    public static R withObj(Object arg1, Object arg2) {
        return R.of(new Map<String, Object>{ toString(arg1) => arg2 });
    }

    /**
     * Factory function to create instance of R(empty list)
     *
     * Example:
     * R.emptyList().size().debug(); // 0
     *
     * @return R
     * */
    public static R emptyList() {
        return R.of(EMPTY_LIST);
    }

    /**
     * Factory function to create instance of R(empty set)
     *
     * Example:
     * R.emptySet().size().debug(); // 0
     *
     * @return R
     * */
    public static R emptySet() {
        return R.of(EMPTY_SET);
    }

    /**
     * Factory function to create instance of R(empty set)
     *
     * Example:
     * R.emptySet().size().debug(); // 0
     *
     * @return R
     * */
    public static R emptyMap() {
        return R.of(EMPTY_MAP);
    }

    /**
     * Factory function to create instance of R(empty string)
     *
     * Example:
     * R.emptyString().size().debug(); // 0
     *
     * @return R
     * */
    public static R emptyString() {
        return R.of(EMPTY_STRING);
    }

    /**
     * Factory function to create instance of R(list of decimals in range)
     *
     * Example:
     * R.range(1, 3).debug(); // (1, 2)
     *
     * @param first The starting decimal(inclusive)
     * @param last The ending decimal(exclusive)
     * @return R
     * */
    public static R range(Decimal first, Decimal last) {
        return R.of(R.range.run(first, last));
    }

    /**
     * Extract wrapped value
     *
     * Example:
     * R.of('abc').toObject(); // 'abc'
     *
     * @return R
     * */
    public Object toObject() {
        return this.val;
    }

    /**
     * Check if the wrapped value is an instance of List<Object>
     *
     * Example:
     * R.emptyList().isList(); // true
     *
     * @return True if the wrapped value is an instance of List<Object>, otherwise false
     * */
    public Boolean isList() {
        return this.val instanceof List<Object>;
    }

    /**
     * Convert the wrapped value to List<Object>
     *
     * Example:
     * R.emptyList().toList(); // ()
     *
     * @return wrapped List<Object>
     * */
    public List<Object> toList() {
        return (List<Object>)this.val;
    }

    /**
     * Check if wrapped value is an instance of Set<String>
     *
     * Example:
     * R.emptySet().isSet(); // true
     *
     * @return True if the wrapped value is an instance of Set<String>, otherwise false
     * */
    public Boolean isSet() {
        return this.val instanceof Set<String>;
    }

    /**
     * Convert the wrapped value to Set<String>
     *
     * Example:
     * R.emptySet().toSet(); // {}
     *
     * @return instance of Set<String>
     * */
    public Set<String> toSet() {
        return (Set<String>)toSet.run(this.val);
    }

    /**
     * Convert the wrapped value to Set<Id>
     *
     * Example:
     * R.emptySet().toIdSet(); // {}
     *
     * @return instance of Set<Id>
     * */
    public Set<Id> toIdSet() {
        return (Set<Id>)toIdSet.run(this.val);
    }

    /**
     * Check if the wrapped value is an instance of Map<String, Object>
     *
     * Example:
     * R.emptyMap().isMap(); // true
     *
     * @return True if the wrapped value is an instance of Map<String, Object>, otherwise false
     * */
    public Boolean isMap() {
        return this.val instanceof Map<String, Object>;
    }

    /**
     * Convert wrapped value to instance of Map<String, Object>
     *
     * Example:
     * R.emptyMap().toMap(); // {}
     *
     * @return instance of Map<String, Object>
     * */
    public Map<String, Object> toMap() {
        return (Map<String, Object>)this.val;

    }

    /**
     * Convert wrapped value to List<Map<String, Object>>
     *
     * @return List<Map<String, Object>>
     * */
    public List<Map<String, Object>> toMapList() {
        return (List<Map<String, Object>>)R.toMapList.run(this.val);
    }

    /**
     * Print debug information
     *
     * Example:
     * R.with(1, 2).debug(); // (1, 2)
     *
     * @return same instance of R
     * */
    public R debug() {
        R.debug.run(this.val);
        return this;
    }

    /**
     * Check if the wrapped values are equal
     *
     * Example:
     * R.emptyList().equals(R.emptyList()); // true
     *
     * @param other The other object
     * @return True only when the two R contain wrapped values that are equal
     * */
    public Boolean equals(Object other) {
        return other instanceof R && (Boolean)R.equals.run(this.val, ((R)other).val);
    }

    /**
     * Get the hash code
     *
     * Example:
     * R.emptyList().hashCode(); // 1
     *
     * @return The hash code of the wrapped value
     * */
    public Integer hashCode() {
        return this.val.hashCode();
    }

    /**
     * Convert the wrapped value to List<SObject>
     *
     * Example:
     * R.with(new Account()).toSObjectList(); // (Account:{})
     *
     * @return List of SObject
     * */
    public List<SObject> toSObjectList() {
        return (List<SObject>)R.toSObjectList.run(this.val);
    }

    /**
     * Convert the wrapped value to Map<String, SObject>
     *
     * Example:
     * R.withObj('acc', new Account()).toSObjectMap(); // {acc=Account:{}}
     *
     * @return Map of String SObject
     * */
    public Map<String, SObject> toSObjectMap() {
        return (Map<String, SObject>)R.toSObjectMap.run(this.val);
    }

    /**
     * Convert the wrapped value to SObject
     *
     * Example:
     * R.of(new Account()).toSObject(); // Account:{}
     *
     * @return SObject
     * */
    public SObject toSObject() {
        return (SObject)R.toSObject.run(this.val);
    }

    /**
     * Convert wrapped value to List<Integer>
     *
     * Example:
     * R.with(1, 2).toIntegerList(); // (1, 2)
     *
     * @return Integer list
     * */
    public List<Integer> toIntegerList() {
        return (List<Integer>)R.toIntegerList.run(this.val);
    }

    /**
     * Convert wrapped value to Map<String, Integer>
     *
     * Example:
     * R.withObj('name', 3).toIntegerMap(); // {name=3}
     *
     * @return Map of string integer
     * */
    public Map<String, Integer> toIntegerMap() {
        return (Map<String, Integer>)R.toIntegerMap.run(this.val);
    }

    /**
     * Convert wrapped value to integer
     *
     * Example:
     * R.of(3).toInteger(); // 3
     *
     * @return integer
     * */
    public Integer toInteger() {
        return (Integer)R.toInteger.run(this.val);
    }

    /**
     * Convert wrapped value to long list
     *
     * Example:
     * R.with(1, 2).toLongList(); // (1, 2)
     *
     * @return list of Long
     * */
    public List<Long> toLongList() {
        return (List<Long>)R.toLongList.run(this.val);
    }

    /**
     * Convert wrapped value to Map<String, Long>
     *
     * Example:
     * R.withObj('name', 2).toLongMap(); // {name=2}
     *
     * @return Map<String, Long>
     * */
    public Map<String, Long> toLongMap() {
        return (Map<String, Long>)R.toLongMap.run(this.val);
    }

    /**
     * Convert wrapped value to long
     *
     * Example:
     * R.of(3).toLong(); // 3
     *
     * @return Long
     * */
    public Long toLong() {
        return (Long)R.toLong.run(this.val);
    }

    /**
     * Convert wrapped value to List<Decimal>
     *
     * Example:
     * R.with(1.5, 3).toDecimalList(); // (1.5, 3)
     *
     * @return List<Decimal>
     * */
    public List<Decimal> toDecimalList() {
        return (List<Decimal>)R.toDecimalList.run(this.val);
    }

    /**
     * Convert wrapped value to Map<String, Decimal>
     *
     * Example:
     * R.withObj('name', 3).toDecimalMap(); // {name=3}
     *
     * @return Map<String, Decimal>
     * */
    public Map<String, Decimal> toDecimalMap() {
        return (Map<String, Decimal>)R.toDecimalMap.run(this.val);
    }

    /**
     * Convert wrapped value to Decimal
     *
     * Example:
     * R.of(3).toDecimal(); // 3
     *
     * @return Decimal
     * */
    public Decimal toDecimal() {
        return (Decimal)R.toDecimal.run(this.val);
    }

    /**
     * Convert wrapped value to List<Double>
     *
     * Example:
     * R.with(1.1, 1.2).toDoubleList(); // (1.1, 1.2)
     *
     * @return List<Double>
     * */
    public List<Double> toDoubleList() {
        return (List<Double>)R.toDoubleList.run(this.val);
    }

    /**
     * Convert wrapped valut to Map<String, Double>
     *
     * Example:
     * R.withObj('weight', 3.2).toDoubleMap(); // {weight=3.2}
     *
     * @return Map<String, Double>
     * */
    public Map<String, Double> toDoubleMap() {
        return (Map<String, Double>)R.toDoubleMap.run(this.val);
    }

    /**
     * Convert wrapped value to Double
     *
     * Example:
     * R.of(1.5).toDouble(); // 1.5
     *
     * @return Double
     * */
    public Double toDouble() {
        return (Double)R.toDouble.run(this.val);
    }

    /**
     * Convert wrapped value to List<String>
     *
     * Example:
     * R.with('a', 'b').toStringList(); // (a, b)
     *
     * @return List<String>
     * */
    public List<String> toStringList() {
        return (List<String>)R.toStringList.run(this.val);
    }

    /**
     * Convert wrapped value to Map<String, String>
     *
     * Example:
     * R.withObj('name', 'test').toStringMap(); // {name=test}
     *
     * @return Map<String, String>
     * */
    public Map<String, String> toStringMap() {
        return (Map<String, String>)R.toStringMap.run(this.val);
    }

    /**
     * Check if the wrapped value is string
     *
     * Example:
     * R.of('abc').isString(); // true
     *
     * @return True if the wrapped value is string
     * */
    public Boolean isString() {
        return this.val instanceof String;
    }

    /**
     * Convert wrapped value to string
     *
     * Example:
     * R.of('abc').toString(); // abc
     *
     * @return String representation
     * */
    public override String toString() {
        return String.valueOf(this.val);
    }

    /**
     * Convert wrapped value to List<Boolean>
     *
     * Example:
     * R.with(true, false).toBooleanList(); // (true, false)
     *
     * @return List<Boolean>
     * */
    public List<Boolean> toBooleanList() {
        return (List<Boolean>)R.toBooleanList.run(this.val);
    }

    /**
     * Convert wrapped value of Map<String, Boolean>
     *
     * Example:
     * R.withObj('disabled', false).toBooleanMap(); // {disabled=false}
     *
     * @return Map<String, Boolean>
     * */
    public Map<String, Boolean> toBooleanMap() {
        return (Map<String, Boolean>)R.toBooleanMap.run(this.val);
    }

    /**
     * Convert wrapped value to Boolean
     *
     * Example:
     * R.of(true).toBoolean(); // true
     *
     * @return Boolean
     * */
    public Boolean toBoolean() {
        return (Boolean)R.toBoolean.run(this.val);
    }

    /**
     * Convert wrapped value to List<Date>
     *
     * Example:
     * R.with(Date.newInstance(2018, 1, 1)).toDateList(); // (2018-01-01 00:00:00)
     *
     * @return List<Date>
     * */
    public List<Date> toDateList() {
        return (List<Date>)R.toDateList.run(this.val);
    }

    /**
     * Convert wrapped value to Map<String, Date>
     *
     * Example:
     * R.withObj('created', Date.newInstance(2018, 1, 1)).toDateMap(); // {created=2018-01-01 00:00:00}
     *
     * @return Map<String, Date>
     * */
    public Map<String, Date> toDateMap() {
        return (Map<String, Date>)R.toDateMap.run(this.val);
    }

    /**
     * Convert wrapped value to Date
     *
     * Example:
     * R.of(Date.newInstance(2018, 1, 1)).toDate(); // 2018-01-01 00:00:00
     *
     * @return Date
     * */
    public Date toDate() {
        return (Date)R.toDate.run(this.val);
    }

    /**
     * Convert wrapped value to List<Time>
     *
     * Example:
     * R.with(Time.newInstance(8, 0, 0, 0)).toTimeList(); // (08:00:00.000Z)
     *
     * @return List<Time>
     * */
    public List<Time> toTimeList() {
        return (List<Time>)R.toTimeList.run(this.val);
    }

    /**
     * Convert wrapped value to Time
     *
     * Example:
     * R.of(Time.newInstance(8, 0, 0, 0)).toTime(); // 08:00:00.000Z
     *
     * @return Time
     * */
    public Time toTime() {
        return (Time)R.toTime.run(this.val);
    }

    /**
     * Convert wrapped value to Map<String, Time>
     *
     * Example:
     * R.withObj('time', Time.newInstance(8, 0, 0, 0)).toTimeMap(); // {time=08:00:00.000Z}
     *
     * @return Map<String, Time>
     * */
    public Map<String, Time> toTimeMap() {
        return (Map<String, Time>)R.toTimeMap.run(this.val);
    }

    /**
     * Convert wrapped value to List<Datetime>
     *
     * Example:
     * R.with(Datetime.now()).toDatetimeList(); // (2018-04-25 04:43:37)
     *
     * @return List<Datetime>
     * */
    public List<Datetime> toDatetimeList() {
        return (List<Datetime>)R.toDatetimeList.run(this.val);
    }

    /**
     * Convert wrapped value to Map<String, Datetime>
     *
     * Example:
     * R.withObj('timestamp', Datetime.now()).toDatetimeMap(); // {timestamp=2018-04-25 04:44:24}
     *
     * @return Map<String, Datetime>
     * */
    public Map<String, Datetime> toDatetimeMap() {
        return (Map<String, Datetime>)R.toDatetimeMap.run(this.val);
    }

    /**
     * Convert wrapped value to Datetime
     *
     * Example:
     * R.of(Datetime.now()).toDatetime(); // 2018-04-25 04:45:28
     *
     * @return Datetime
     * */
    public Datetime toDatetime() {
        return (Datetime)R.toDatetime.run(this.val);
    }

    /**
     * Convert wrapped value to List<Func>
     *
     * Example:
     * R.with(R.identity).toFuncList(); // (IdentityFunc:[Func.args=(), Func.length=-1])
     *
     * @return List<Func>
     * */
    public List<Func> toFuncList() {
        return (List<Func>)R.toFuncList.run(this.val);
    }

    /**
     * Convert wrapped value to Map<String, Func>
     *
     * Example:
     * R.withObj('id', R.identity).toFuncMap(); // {id=IdentityFunc:[Func.args=(), Func.length=-1]}
     *
     * @return Map<String, Func>
     * */
    public Map<String, Func> toFuncMap() {
        return (Map<String, Func>)R.toFuncMap.run(this.val);
    }

    /**
     * Convert wrapped value to Func
     *
     * Example:
     * R.of(R.identity).toFunc(); // IdentityFunc:[Func.args=(), Func.length=-1]
     *
     * @return Func
     * */
    public Func toFunc() {
        return (Func)R.toFunc.run(this.val);
    }

    /**
     * Convert wrapped value to List<R.Pair>
     *
     * Example:
     * R.with(new R.Pair(1, 2)).toPairList(); // (Pair:[fst=1, snd=2])
     *
     * @return List<R.Pair>
     * */
    public List<Pair> toPairList() {
        return (List<Pair>)R.toPairList.run(this.val);
    }

    /**
     * Convert wrapped value to Map<String, R.Pair>
     *
     * Example:
     * R.withObj('pair', new R.Pair(1, 2)).toPairMap(); // {pair=Pair:[fst=1, snd=2]}
     *
     * @return Map<String, R.Pair>
     * */
    public Map<String, R.Pair> toPairMap() {
        return (Map<String, R.Pair>)R.toPairMap.run(this.val);
    }

    /**
     * Convert wrapped value to Pair
     *
     * Example:
     * R.of(new R.Pair(1, 2)).toPair(); // Pair:[fst=1, snd=2]
     *
     * @return Pair
     * */
    public Pair toPair() {
        return (Pair)R.toPair.run(this.val);
    }

    /**
     * Call the function to each element of instance R
     *
     * Example:
     * R.with(1, 2, 3).forEach(R.debug);
     * // 1
     * // 2
     * // 3
     *
     * R.withObj('name', 'test').forEach(R.debug);
     * // (test, name)
     *
     * @param fn The function to invoke on each element
     * @return R
     * */
    public R forEach(Func fn) {
        return R.of(R.forEach.run(fn, this.val));
    }

    /**
     * Call the function to filter the elements of instance R
     *
     * Example:
     * R.with(1, 2, 3).filter(R.equals.apply(2)).debug(); // (2)
     *
     * @param pred The predicate: a -> Boolean
     * @return R
     * */
    public R filter(Func pred) {
        return R.of(R.filter.run(pred, this.val));
    }

    /**
     * Filter the list by checking that each element of the list has a non null value of this field
     *
     * Example:
     * R.with(new Account(Description = 'desc'), new Account()).filter('Description').debug(); // (Account:{Description=desc})
     *
     * @param field The field name of the element to be filtered
     * @return R
     * */
    public R filter(String field) {
        return R.of(R.filter.run(field, this.val));
    }

    /**
     * Filter the list by checking that each element has the value matched by the field
     *
     * Example:
     * R.with(new Account(Description = 'desc'), new Account()).filter('Description', 'desc').debug(); // (Account:{Description=desc})
     *
     * @param field The field name of the element to be filtered
     * @param value The field value of the element to be filtered
     * @return R
     * */
    public R filter(String field, Object value) {
        return R.of(R.filter.run(field, value, this.val));
    }

    /**
     * Filter the list by checking that each element matches the field-value specified in the data
     *
     * Example:
     * R.with(new Account(Description = 'desc'), new Account()).filter(new Map<String, Object>{ 'Description' => 'desc' }).debug();
     * // (Account:{Description=desc})
     *
     * @param data The field-value criteria
     * @return R
     * */
    public R filter(Map<String, Object> data) {
        return R.of(R.filter.run(data, this.val));
    }

    /**
     * Reject the elements by checking with the predicate
     *
     * Example:
     * R.with(new Account(Description = 'desc'), new Account()).reject((Func)R.complement.run(R.has.apply('Description'))).debug();
     * // (Account:{Description=desc})
     *
     * @param pred The predicate
     * @return R
     * */
    public R reject(Func pred) {
        return R.of(R.reject.run(pred, this.val));
    }

    /**
     * Reject the elements that has the specified field
     *
     * Example:
     * R.with(new Account(Description = 'desc'), new Account()).reject('Description').debug();
     * // (Account:{})
     *
     * @param field The field name to reject
     * @return R
     * */
    public R reject(String field) {
        return R.of(R.reject.run(field, this.val));
    }

    /**
     * Reject elements that equal with the value specified by the field
     *
     * Example:
     * R.with(new Account(Description = 'desc'), new Account()).reject('Description', 'desc').debug();
     * // (Account:{})
     *
     * @param field The name of the field
     * @param value The value of the field
     * @return R
     * */
    public R reject(String field, Object value) {
        return R.of(R.reject.run(field, value, this.val));
    }

    /**
     * Reject elements that match the criteria data of field-value mappings
     *
     * Example:
     * R.with(new Account(Description = 'desc'), new Account()).reject(new Map<String, Object>{ 'Description' => 'desc' }).debug();
     * // (Account:{})
     *
     * @param data The field-value mapping criteria
     * @return R
     * */
    public R reject(Map<String, Object> data) {
        return R.of(R.reject.run(data, this.val));
    }

    /**
     * Map a function over the elements
     *
     * Example:
     * R.with(1, 2, 3).doMap(R.add.apply(1)).debug(); // (2, 3, 4)
     *
     * @param fn The function to be used in the map
     * @return R
     * */
    public R doMap(Func fn) {
        return R.of(R.doMap.run(fn, this.val));
    }

    /**
     * Extract the field out of the object to a new list
     *
     * Example:
     * R.with(new Account(Description='desc')).pluck('Description').debug();
     * // (desc)
     *
     * @param field The field to be plucked
     * @return R
     * */
    public R pluck(String field) {
        return R.of(R.pluck.run(field, this.val));
    }

    /**
     * Reduce over the elements
     *
     * Example:
     * R.with(1, 2, 3).reduce(R.add, 0).debug(); // 6
     *
     * @param reducer The reducing function which accepts two arguments
     * @param initialValue The initialValue in the reduction
     * @return R
     * */
    public R reduce(Func reducer, Object initialValue) {
        return R.of(R.reduce.run(reducer, initialValue, this.val));
    }

    /**
     * Get the length, same as size()
     *
     * Example:
     * R.with(1, 2, 3).length().debug(); // 3
     *
     * @return R
     * */
    public R length() {
        return R.of(((Decimal)R.length.run(this.val)).intValue());
    }

    /**
     * Get the size, same as length()
     *
     * Example:
     * R.with(1, 2, 3).size().debug(); // 3
     *
     * @return R
     * */
    public R size() {
        return R.of(((Decimal)R.size.run(this.val)).intValue());
    }

    /**
     * Check if it is empty
     *
     * Example:
     * R.with(1, 2, 3).isEmpty().debug(); // false
     *
     * @return R
     * */
    public R isEmpty() {
        return R.of((Boolean)R.isEmpty.run(this.val));
    }

    /**
     * Check if it is empty
     *
     * Example:
     * R.with(1, 2, 3).isNotEmpty().debug(); // true
     *
     * @return R
     * */
    public R isNotEmpty() {
        return R.of((Boolean)R.isNotEmpty.run(this.val));
    }

    /**
     * Get the sum
     *
     * Example:
     * R.with(1, 2, 3).sum().debug(); // 6
     *
     * @return R
     * */
    public R sum() {
        return R.of((Decimal)R.sum.run(this.val));
    }

    /**
     * Get a slice of the elements
     *
     * Example:
     * R.with(1, 2, 3).slice(1, 2).debug(); // (2)
     *
     * @param first The first index(inclusive)
     * @param last The last index(exclusive)
     * @return R
     * */
    public R slice(Integer first, Integer last) {
        return R.of(R.slice.run(first, last, this.val));
    }

    /**
     * Take the first N elements
     *
     * Example:
     * R.with(1, 2, 3).take(2).debug(); // (1, 2)
     *
     * @param num The number of elements to take
     * @return R
     * */
    public R take(Integer num) {
        return R.of(R.take.run(num, this.val));
    }

    /**
     * Take the first N elements from right
     *
     * Example:
     * R.with(1, 2, 3).takeRight(2).debug(); // (2, 3)
     *
     * @param num The number of elements to take
     * @return R
     * */
    public R takeRight(Integer num) {
        return R.of(R.takeRight.run(num, this.val));
    }

    /**
     * Take elements until the predicate is not satisfied
     *
     * Example:
     * R.with(1, 2, 3).takeWhile(R.equals.apply(1)).debug(); // (1)
     *
     * @param pred The predicate
     * @return R
     * */
    public R takeWhile(Func pred) {
        return R.of(R.takeWhile.run(pred, this.val));
    }

    /**
     * Take elements from right until the predicate is not satisfied
     *
     * Example:
     * R.with(1, 2, 3).takeRightWhile(R.equals.apply(1)).debug(); // ()
     *
     * @param pred The predicate
     * @return R
     * */
    public R takeRightWhile(Func pred) {
        return R.of(R.takeRightWhile.run(pred, this.val));
    }

    /**
     * Drop the first N elements
     *
     * Example:
     * R.with(1, 2, 3).drop(2).debug(); // (3)
     *
     * @param num The number of elements to drop
     * @return R
     * */
    public R drop(Integer num) {
        return R.of(R.drop.run(num, this.val));
    }

    /**
     * Drop the first N elements from right
     *
     * Example:
     * R.with(1, 2, 3).dropRight(2).debug(); // (1)
     *
     * @param num The number of elements to drop
     * @return R
     * */
    public R dropRight(Integer num) {
        return R.of(R.dropRight.run(num, this.val));
    }

    /**
     * Drop until the predicate is not satisfied
     *
     * Example:
     * R.with(1, 2, 3).dropWhile(R.equals.apply(1)).debug(); // (2, 3)
     *
     * @param pred The predicate
     * @return R
     * */
    public R dropWhile(Func pred) {
        return R.of(R.dropWhile.run(pred, this.val));
    }

    /**
     * Drop from right until the predicate is not satisfied
     *
     * Example:
     * R.with(1, 2, 3).dropRightWhile(R.equals.apply(1)).debug(); // (1, 2, 3)
     *
     * @param pred The predicate
     * @return R
     * */
    public R dropRightWhile(Func pred) {
        return R.of(R.dropRightWhile.run(pred, this.val));
    }

    /**
     * Reverse the elements
     *
     * Example:
     * R.with(1, 2, 3).reverse().debug(); // (3, 2, 1)
     *
     * @return R
     * */
    public R reverse() {
        return R.of(R.reverse.run(this.val));
    }

    /**
     * Sort the elements by the comparator
     *
     * Example:
     * R.with(new Account(Description='abc'), new Account(Description='def')).sortBy((Func)R.descend.run(R.prop.apply('Description'))).debug();
     * // (Account:{Description=def}, Account:{Description=abc})
     *
     * @param comparator The comparator function that takes two arguments and return a number
     * @return R
     * */
    public R sortBy(Func comparator) {
        return R.of(R.sortBy.run(comparator, this.val));
    }

    /**
     * Sort the elements by default
     *
     * Example:
     * R.with(3, 2, 1).sortDefault().debug(); // (1, 2, 3)
     *
     * @return R
     * */
    public R sortDefault() {
        return R.of(R.sortDefault.run(this.val));
    }

    /**
     * Check if the target is contained
     *
     * Example:
     * R.with(1, 2, 3).contains(2).debug(); // true
     *
     * @param target The target object
     * @return R
     * */
    public R contains(Object target) {
        return R.of((Boolean)R.contains.run(target, this.val));
    }

    /**
     * Check if the target is contained by the predicate
     *
     * Example:
     * R.with(1, 2, 3).containsBy(R.equals, 2).debug(); // true
     *
     * @param pred The predicate that takes two arguments and return boolean
     * @param target The target object
     * @return R
     * */
    public R containsBy(Func pred, Object target) {
        return R.of((Boolean)R.containsBy.run(pred, target, this.val));
    }

    /**
     * Check if the key is contained
     *
     * Example:
     * R.withObj('name', 'test').containsKey('name').debug(); // true
     *
     * @param key The key
     * @return R
     * */
    public R containsKey(String key) {
        return R.of((Boolean)R.containsKey.run(key, this.val));
    }

    /**
     * Return unique elements
     *
     * Example:
     * R.with(1, 2, 2).uniq().debug(); // (1, 2)
     *
     * @return R
     * */
    public R uniq() {
        return R.of(R.uniq.run(this.val));
    }

    /**
     * Do a union with the other object
     *
     * Example:
     * R.with(1, 2, 3).union(R.with(2, 3, 4)).debug(); // (1, 2, 3, 4)
     *
     * @param other The other object
     * @return R
     * */
    public R union(Object other) {
        return R.of(R.union.run(other, this.val));
    }

    /**
     * Do an intersection with the other object
     *
     * Example:
     * R.with(1, 2, 3).intersection(R.with(2, 3, 4)).debug(); // (2, 3)
     *
     * @param other The other object
     * @return R
     * */
    public R intersection(Object other) {
        return R.of(R.intersection.run(other, this.val));
    }

    /**
     * Do an xor with the other object
     *
     * Example:
     * R.with(1, 2, 3).xor(R.with(2, 3, 4)).debug(); // (1, 4)
     *
     * @param other The other object
     * @return R
     * */
    public R xor(Object other) {
        return R.of(R.xor.run(other, this.val));
    }

    /**
     * Do a difference with the other object
     *
     * Example:
     * R.with(1, 2, 3).difference(R.with(2, 3, 4)).debug(); // (1)
     *
     * @param other The other object
     * @return R
     * */
    public R difference(Object other) {
        return R.of(R.difference.run(other, this.val));
    }

    /**
     * Same as difference
     *
     * Example:
     * R.with(1, 2, 3).without(R.with(2, 3, 4)).debug(); // (1)
     *
     * @param other The other object
     * @return R
     * */
    public R without(Object other) {
        return R.of(R.without.run(other, this.val));
    }

    /**
     * Update the element at index with the function
     *
     * Example:
     * R.with(1, 2, 3).adjust(R.add.apply(1), 1).debug(); // (1, 3, 3)
     *
     * @param fn The function to work on the element
     * @param index The index of the element
     * @return R
     * */
    public R adjust(Func fn, Integer index) {
        return R.of(R.adjust.run(fn, index, this.val));
    }

    /**
     * Check if all elements match the predicate
     *
     * Example:
     * R.with(1, 2, 3).all(R.equals.apply(1)).debug(); // false
     *
     * @param pred The predicate
     * @return R
     * */
    public R all(Func pred) {
        return R.of((Boolean)R.all.run(pred, this.val));
    }

    /**
     * Check if every element matches the predicate
     *
     * Example:
     * R.with(1, 2, 3).every(R.equals.apply(1)).debug(); // false
     *
     * @param pred The predicate
     * @return R
     * */
    public R every(Func pred) {
        return R.of((Boolean)R.every.run(pred, this.val));
    }

    /**
     * Check if some elements match the predicate
     *
     * Example:
     * R.with(1, 2, 3).some(R.equals.apply(1)).debug(); // true
     *
     * @param pred The predicate
     * @return R
     * */
    public R some(Func pred) {
        return R.of((Boolean)R.some.run(pred, this.val));
    }

    /**
     * Check if none of the elements matches the predicate
     *
     * Example:
     * R.with(1, 2, 3).none(R.equals.apply(1)).debug(); // false
     *
     * @param pred The predicate
     * @return R
     * */
    public R none(Func pred) {
        return R.of((Boolean)R.none.run(pred, this.val));
    }

    /**
     * Append the element to the elements
     *
     * Example:
     * R.with(1, 2, 3).append(4).debug(); // (1, 2, 3, 4)
     *
     * @param element The element
     * @return R
     * */
    public R append(Object element) {
        return R.of(R.append.run(element, this.val));
    }

    /**
     * Prepend the element to the elements
     *
     * Example:
     * R.with(1, 2, 3).prepend(4).debug(); // (4, 1, 2, 3)
     *
     * @param element The element
     * @return R
     * */
    public R prepend(Object element) {
        return R.of(R.prepend.run(element, this.val));
    }

    /**
     * Transform the wrapped value using the function
     *
     * Example:
     * R.with(1, 2, 3).transform(R.size).debug(); // 3
     *
     * @param fn The transforming function
     * @return R
     * */
    public R transform(Func fn) {
        return R.of(R.transform.run(fn, this.val));
    }

    /**
     * Associate the value to the key
     *
     * Example:
     * R.withObj('name', 'value').assoc('name', 'newValue').debug(); // {name=newValue}
     *
     * @param field The field name
     * @param value The field value
     * @return R
     * */
    public R assoc(Object field, Object value) {
        return R.of(R.assoc.run(field, value, this.val));
    }

    /**
     * Remove the value mapped by the key
     *
     * Example:
     * R.withObj('name', 'value').dissoc('name').debug(); // {}
     *
     * @param field The field name
     * @return R
     * */
    public R dissoc(Object field) {
        return R.of(R.dissoc.run(field, this.val));
    }

    /**
     * Return a value that is limited between the min and the max
     *
     * Example:
     * R.of(4).clamp(1, 3).debug(); // 3
     *
     * @param min The min value
     * @param max The max value
     * @return R
     * */
    public R clamp(Object min, Object max) {
        return R.of(R.clamp.run(min, max, this.val));
    }

    /**
     * Get a clone
     *
     * Example:
     * R.with(1, 2, 3).doClone().debug(); // (1, 2, 3)
     *
     * @return R
     * */
    public R doClone() {
        return R.of(R.doClone.run(this.val));
    }

    /**
     * Concatenate the other
     *
     * Example:
     * R.with(1, 2, 3).concat(R.with(4, 5, 6)).debug();
     * // (1, 2, 3, 4, 5, 6)
     *
     * @param other The other
     * @return R
     * */
    public R concat(Object other) {
        return R.of(R.concat.run(other, this.val));
    }

    /**
     * Get a result of count mapped by the key
     *
     * Example:
     * R.with(1, 2, 2).countBy(R.identity).debug();
     * // {1=1, 2=2}
     *
     * @param fn The function to calculate the key
     * @return R
     * */
    public R countBy(Func fn) {
        return R.of(R.countBy.run(fn, this.val));
    }

    /**
     * Get groups mapped by the key
     *
     * Example:
     * R.with(1, 2, 2).groupBy(R.identity).debug();
     * // {1=(1), 2=(2, 2)}
     *
     * @param fn The function to calculate the key
     * @return R
     * */
    public R groupBy(Func fn) {
        return R.of(R.groupBy.run(fn, this.val));
    }

    /**
     * Get object indexed by the key
     *
     * Example:
     * R.with(1, 2, 2).indexBy(R.identity).debug();
     * // {1=1, 2=2}
     *
     * @param fn The function to calculate the key
     * @return R
     * */
    public R indexBy(Func fn) {
        return R.of(R.indexBy.run(fn, this.val));
    }

    /**
     * Get the default value
     *
     * Example:
     * R.of(null).defaultTo(3).debug(); // 3
     *
     * @param val The default value
     * @return R
     * */
    public R defaultTo(Object val) {
        return R.of(R.defaultTo.run(val, this.val));
    }

    /**
     * Check if the elements start with the value
     *
     * Example:
     * R.with(1, 2, 3).startsWith(new List<Integer>{ 1, 2 }).debug(); // true
     *
     * @param val The value
     * @return R
     * */
    public R startsWith(Object val) {
        return R.of(R.startsWith.run(val, this.val));
    }

    /**
     * Check if the elements end with the value
     *
     * Example:
     * R.of('abc').endsWith('bc').debug(); // true
     *
     * @param val The value
     * @return R
     * */
    public R endsWith(Object val) {
        return R.of(R.endsWith.run(val, this.val));
    }

    /**
     * Apply the function to the value mapped by the same key and calculate the evolved object
     *
     * Example:
     * R.withObj('name', 'test').evolve(new Map<String, Object>{ 'name' => R.append.apply('more') }).debug();
     * // {name=testmore}
     *
     * @param spec The map of functions(may nest other spec object) mapped by the key
     * @return R
     * */
    public R evolve(Map<String, Object> spec) {
        return R.of(R.evolve.run(spec, this.val));
    }

    /**
     * Find the first element that satisfies the predicate
     *
     * Example:
     * R.with(1, 2, 3).find(R.equals.apply(2)).debug(); // 2
     *
     * @param pred The predicate
     * @return R
     * */
    public R find(Func pred) {
        return R.of(R.find.run(pred, this.val));
    }

    /**
     * Find the first element that satisfies the predicate from last
     *
     * Example:
     * R.with(1, 2, 3).findLast(R.equals.apply(2)).debug(); // 2
     *
     * @param pred The predicate
     * @return R
     * */
    public R findLast(Func pred) {
        return R.of(R.findLast.run(pred, this.val));
    }

    /**
     * Find the index of the first element that matches the predicate
     *
     * Example:
     * R.with(1, 2, 3).findIndex(R.equals.apply(2)).debug(); // 1
     *
     * @param pred The predicate
     * @return R
     * */
    public R findIndex(Func pred) {
        return R.of(R.findIndex.run(pred, this.val));
    }

    /**
     * Find the index of the first element that matches the predicate from last
     *
     * Example:
     * R.with(1, 2, 3).findLastIndex(R.equals.apply(2)).debug(); // 1
     *
     * @param pred The predicate
     * @return R
     * */
    public R findLastIndex(Func pred) {
        return R.of(R.findLastIndex.run(pred, this.val));
    }

    /**
     * Flatten the elements by one level
     *
     * Example:
     * R.with(1, new List<Object>{ 2, 3 }, 4).unnest().debug();
     * // (1, 2, 3, 4)
     *
     * @return R
     * */
    public R unnest() {
        return R.of(R.unnest.run(this.val));
    }

    /**
     * Flatten the elements recursively
     *
     * Example:
     * R.with(1, new List<Object>{ 2, new List<Object>{ 3 } }, 4).flatten().debug();
     * // (1, 2, 3, 4)
     *
     * @return R
     * */
    public R flatten() {
        return R.of(R.flatten.run(this.val));
    }

    /**
     * Convert from a list of pairs to a map
     *
     * Example:
     * R.with(new R.Pair('name', 'test')).fromPairs().debug();
     * // {name=test}
     *
     * @return R
     * */
    public R fromPairs() {
        return R.of(R.fromPairs.run(this.val));
    }

    /**
     * Convert a map to a list of pairs
     *
     * Example:
     * R.withObj('name', 'test').toPairs().debug();
     * // (Pair:[fst=name, snd=test])
     *
     * @return R
     * */
    public R toPairs() {
        return R.of(R.toPairs.run(this.val));
    }

    /**
     * Get the first element
     *
     * Example:
     * R.with(1, 2, 3).first().debug(); // 1
     *
     * @return R
     * */
    public R first() {
        return R.of(R.first.run(this.val));
    }

    /**
     * Get the first element
     *
     * Example:
     * R.with(1, 2, 3).head().debug(); // 1
     *
     * @return R
     * */
    public R head() {
        return R.of(R.head.run(this.val));
    }

    /**
     * Get the last element
     *
     * Example:
     * R.with(1, 2, 3).last().debug(); // 3
     *
     * @return R
     * */
    public R last() {
        return R.of(R.last.run(this.val));
    }

    /**
     * Get the elements except the last
     *
     * Example:
     * R.with(1, 2, 3).init().debug(); // (1, 2)
     *
     * @return R
     * */
    public R init() {
        return R.of(R.init.run(this.val));
    }

    /**
     * Get the elements except the first
     *
     * Example:
     * R.with(1, 2, 3).tail().debug(); // (2, 3)
     *
     * @return R
     * */
    public R tail() {
        return R.of(R.tail.run(this.val));
    }

    /**
     * Get the index of the target
     *
     * Example:
     * R.with(1, 2, 3).indexOf(2).debug(); // 1
     *
     * @param target The target
     * @return R
     * */
    public R indexOf(Object target) {
        return R.of(R.indexOf.run(target, this.val));
    }

    /**
     * Get the index of the target from the last
     *
     * Example:
     * R.with(1, 2, 3).lastIndexOf(2).debug(); // 1
     *
     * @param target The target
     * @return R
     * */
    public R lastIndexOf(Object target) {
        return R.of(R.lastIndexOf.run(target, this.val));
    }

    /**
     * Insert the element at the index
     *
     * Example:
     * R.with(1, 2, 3).doInsert(1, 'x').debug(); // (1, x, 2, 3)
     *
     * @param index The index to be inserted at
     * @param target The target
     * @return R
     * */
    public R doInsert(Integer index, Object target) {
        return R.of(R.doInsert.run(index, target, this.val));
    }

    /**
     * Insert all the elements at the index
     *
     * Example:
     * R.with(1, 2, 3).doInsertAll(1, R.with('x', 'y')).debug(); // (1, x, y, 2, 3)
     *
     * @param index The index to be inserted on
     * @param target The target
     * @return R
     * */
    public R doInsertAll(Integer index, Object target) {
        return R.of(R.doInsertAll.run(index, target, this.val));
    }

    /**
     * Get an inverted map, values mapped by duplicate keys are put in a list
     *
     * Example:
     * R.withObj('name', 'test').invert().debug();
     * // {test=(name)}
     *
     * @return R
     * */
    public R invert() {
        return R.of(R.invert.run(this.val));
    }

    /**
     * Get an inverted map
     *
     * Example:
     * R.withObj('name', 'test').invertObj().debug();
     * // {test=name}
     *
     * @return R
     * */
    public R invertObj() {
        return R.of(R.invertObj.run(this.val));
    }

    /**
     * Join the elements with the separator
     *
     * Example:
     * R.with(1, 2, 3).doJoin('-').debug(); // 1-2-3
     *
     * @param separator The separator string
     * @return R
     * */
    public R doJoin(String separator) {
        return R.of(R.doJoin.run(separator, this.val));
    }

    /**
     * Get the keys of the wrapped map
     *
     * Example:
     * R.withObj('name', 'test').keys().debug();
     * // {name}
     *
     * @return R
     * */
    public R keys() {
        return R.of(R.keys.run(this.val));
    }

    /**
     * Get the values of the wrapped map
     *
     * Example:
     * R.withObj('name', 'test').values().debug();
     * // (test)
     *
     * @return R
     * */
    public R values() {
        return R.of(R.values.run(this.val));
    }

    /**
     * Get a list of matched groups after doing a regex match
     *
     * Example:
     * R.of('abc').match('.*(a).*').debug();
     * // (abc, a)
     *
     * @param regex The regular expression
     * @return R
     * */
    public R match(String regex) {
        return R.of(R.match.run(regex, this.val));
    }

    /**
     * Merge the source
     *
     * Example:
     * R.withObj('name', 'test').doMerge(R.withObj('name', 'newTest')).debug();
     * // {name=newTest}
     *
     * @param other The other
     * @return R
     * */
    public R doMerge(Object other) {
        return R.of(R.doMerge.run(other, this.val));
    }

    /**
     * Get the nth element
     *
     * Example:
     * R.with(1, 2, 3).nth(1).debug(); // 2
     *
     * @param index The index
     * @return R
     * */
    public R nth(Integer index) {
        return R.of(R.nth.run(index, this.val));
    }

    /**
     * Pick the values specified by the list of keys
     *
     * Example:
     * R.of(new Account(FirstName='test', Description='desc')).pick(new List<String>{ 'Description' }).debug();
     * // {Description=desc}
     *
     * @param keys The list of keys
     * @return R
     * */
    public R pick(Object keys) {
        return R.of(R.pick.run(keys, this.val));
    }

    /**
     * Omit the values specified by the list of keys
     *
     * Example:
     * R.of(new Account(FirstName='test', Description='desc')).omit(new List<String>{ 'Description' }).debug();
     * // {FirstName=test}
     *
     * @param keys The list of keys
     * @return R
     * */
    public R omit(Object keys) {
        return R.of(R.omit.run(keys, this.val));
    }

    /**
     * Create a paritioned pair using the predicate
     *
     * Example:
     * R.with(1, 2, 3).partition(R.equals.apply(1)).debug();
     * // Pair:[fst=(1), snd=(2, 3)]
     *
     * @param pred The predicate
     * @return R
     * */
    public R partition(Func pred) {
        return R.of(R.partition.run(pred, this.val));
    }

    /**
     * Project a list of objects using the list of fields
     *
     * Example:
     * R.with(new Account(Description='desc', FirstName='test')).project(new List<String>{ 'Description' }).debug();
     * // ({Description=desc})
     *
     * @param fields
     * @return R
     * */
    public R project(Object fields) {
        return R.of(R.project.run(fields, this.val));
    }

    /**
     * Remove elements starting at the index and specified by the count
     *
     * Example:
     * R.with(1, 2, 3).remove(1, 3).debug();
     * // (1)
     *
     * @param first The index of the first element to be removed
     * @param count The count of the elements to be removed
     * @return R
     * */
    public R remove(Integer first, Integer count) {
        return R.of(R.remove.run(first, count, this.val));
    }

    /**
     * Create a list of elements by repeating the element
     *
     * Example:
     * R.of('a').repeat(3).debug(); // (a, a, a)
     *
     * @param count The count to repeat
     * @return R
     * */
    public R repeat(Integer count) {
        return R.of(R.repeat.run(count, this.val));
    }

    /**
     * Replace the string according to the pattern and replacement
     *
     * Example:
     * R.of('I love cats').replace('cat', 'dog').debug();
     * // I love dogs
     *
     * @param pattern The pattern
     * @param replacement The replacement string
     * @return R
     * */
    public R replace(String pattern, String replacement) {
        return R.of(R.replace.run(pattern, replacement, this.val));
    }

    /**
     * Replace all the strings according to the pattern and replacement
     *
     * Example:
     * R.of('I love cats').replaceAll('cat', 'dog').debug();
     * // I love dogs
     *
     * @param pattern The pattern
     * @param replacement The replacement string
     * @return R
     * */
    public R replaceAll(String pattern, String replacement) {
        return R.of(R.replaceAll.run(pattern, replacement, this.val));
    }

    /**
     * Split the string by the separator
     *
     * Example:
     * R.of('a/b/c').split('/').debug();
     * // (a, b, c)
     *
     * @param separator The separator string
     * @return R
     * */
    public R split(String separator) {
        return R.of(R.split.run(separator, this.val));
    }

    /**
     * Test the string according to the pattern
     *
     * Example:
     * R.of('cat').test('.*b.*').debug(); // false
     *
     * @param pattern The pattern string
     * @return R
     * */
    public R test(String pattern) {
        return R.of(R.test.run(pattern, this.val));
    }

    /**
     * Convert the string to uppercase
     *
     * Example:
     * R.of('cat').toUpper().debug(); // CAT
     *
     * @return R
     * */
    public R toUpper() {
        return R.of(R.toUpper.run(this.val));
    }

    /**
     * Convert the string to lowercase
     *
     * Example:
     * R.of('Cat').toLower().debug(); // cat
     *
     * @return R
     * */
    public R toLower() {
        return R.of(R.toLower.run(this.val));
    }

    /**
     * Trim the string
     *
     * Example:
     * R.of('  a  ').trim().debug(); // a
     *
     * @return R
     * */
    public R trim() {
        return R.of(R.trim.run(this.val));
    }

    /**
     * Update the element at the specified index
     *
     * Example:
     * R.with(1, 2, 3).doUpdate(1, 3).debug(); // (1, 3, 3)
     *
     * @param index The index of the element to be updated
     * @param val The new value
     * @return R
     * */
    public R doUpdate(Integer index, Object val) {
        return R.of(R.doUpdate.run(index, val, this.val));
    }

    /**
     * Create a zipped list of pairs according to the mList
     *
     * Example:
     * R.with('a', 'b').zip(new List<Object>{ 1, 2 }).debug();
     * // (Pair:[fst=1, snd=a], Pair:[fst=2, snd=b])
     *
     * @param mList The other list
     * @return R
     * */
    public R zip(Object mList) {
        return R.of(R.zip.run(mList, this.val));
    }

    /**
     * Create a zipped map according to the mList
     *
     * Example:
     * R.with('a', 'b').zipObj(new List<Object>{ 1, 2 }).debug();
     * // {1=a, 2=b}
     *
     * @param mList The other list
     * @return R
     * */
    public R zipObj(Object mList) {
        return R.of(R.zipObj.run(mList, this.val));
    }

    /**
     * Remove null values from the elements
     *
     * Example:
     * R.with('a', null, 0).compact().debug();
     * // (a, 0)
     *
     * @return R
     * */
    public R compact() {
        return R.of(R.compact.run(this.val));
    }

    /**
     * Create a shuffled list of elements
     *
     * Example:
     * R.with(1, 2, 3).shuffle().debug(); // (3, 1, 2)
     *
     * @return R
     * */
    public R shuffle() {
        return R.of(R.shuffle.run(this.val));
    }

    /**
     * Get a random element
     *
     * Example:
     * R.with(1, 2, 3).sample().debug(); // 3
     *
     * @return R
     * */
    public R sample() {
        return R.of(R.sample.run(this.val));
    }

    /**
     * Get a list of random elements
     *
     * Example:
     * R.with(1, 2, 3).sampleSize(2).debug(); // (3, 1)
     *
     * @param size The size of the random elements
     * @return R
     * */
    public R sampleSize(Integer size) {
        return R.of(R.sampleSize.run(size, this.val));
    }

    /**
     * Return a new string with the first letter in uppercase
     *
     * Example:
     * R.of('cat').capitalize().debug(); // Cat
     *
     * @return R
     * */
    public R capitalize() {
        return R.of(R.capitalize.run(this.val));
    }

    /**
     * Pad the string to the length
     *
     * Example:
     * R.of('cat').pad(5, '*').debug(); // *cat*
     *
     * @param length The target length
     * @param fill The string used to fill
     * @return R
     * */
    public R pad(Integer length, String fill) {
        return R.of(R.pad.run(length, fill, this.val));
    }

    /**
     * Pad the string to the length from the left
     *
     * Example:
     * R.of('cat').padLeft(5, '*').debug(); // **cat
     *
     * @param length The target length
     * @param fill The string used to fill
     * @return R
     * */
    public R padLeft(Integer length, String fill) {
        return R.of(R.padLeft.run(length, fill, this.val));
    }

    /**
     * Pad the string to the length from the right
     *
     * Example:
     * R.of('cat').padRight(5, '*').debug(); // cat**
     *
     * @param length The target length
     * @param fill The string used to fill
     * @return R
     * */
    public R padRight(Integer length, String fill) {
        return R.of(R.padRight.run(length, fill, this.val));
    }

    // EOR(End of R)


    // ----------------------------------------------------------------------------
    // --   Conversion                                                           --
    // ----------------------------------------------------------------------------

    // Boolean

    /**
     * Convert to Boolean
     *
     * Example:
     * R.toBoolean.run('abc')
     * // false
     *
     * @param arg The target object
     * @return Object(Boolean)
     * */
    public static Func toBoolean = new ToBooleanFunc();

    /**
     * Convert to Boolean List
     *
     * Example:
     * R.toBooleanList.run(new List<Object>{ true, false })
     * // (true, false)
     *
     * @param arg The target object
     * @return Object(List<Boolean>)
     * */
    public static Func toBooleanList = new ToBooleanListFunc();

    /**
     * Convert to Boolean Map
     *
     * Example:
     * R.toBooleanMap.run(new Map<String, Object>{ 'name' => true })
     * // {name=true}
     *
     * @param arg The target object
     * @return Object(Map<String, Boolean>)
     * */
    public static Func toBooleanMap = new ToBooleanMapFunc();

    // Integer

    /**
     * Convert to Integer
     *
     * Example:
     * R.toInteger.run('1')
     * // 1
     *
     * @param arg The raw object
     * @return Object(Integer)
     * */
    public static Func toInteger = new ToIntegerFunc();

    /**
     * Convert to Integer List
     *
     * Example:
     * R.toIntegerList.run(new List<Object>{ '1' })
     * // (1)
     *
     * @param arg The raw object
     * @return Object(List<Integer>)
     * */
    public static Func toIntegerList = new ToIntegerListFunc();

    /**
     * Convert to Integer Map
     *
     * Example:
     * R.toIntegerMap.run(new Map<String, Object>{ 'name' => '2' })
     * // {name=2}
     *
     * @param arg The raw object
     * @return Object(Map<String, Integer>)
     * */
    public static Func toIntegerMap = new ToIntegerMapFunc();

    // Long

    /**
     * Convert to Long
     *
     * Example:
     * R.toLong.run('1')
     * // 1
     *
     * @param arg The raw object
     * @return Object(Long)
     * */
    public static Func toLong = new ToLongFunc();

    /**
     * Convert to Long List
     *
     * Example:
     * R.toLongList.run(new List<Object>{ '1' })
     * // (1)
     *
     * @param arg The raw object
     * @return Object(List<Long>)
     * */
    public static Func toLongList = new ToLongListFunc();

    /**
     * Convert to Long Map
     *
     * Example:
     * R.toLongMap.run(new Map<String, Object>{ 'name' => '2' })
     * // {name=2}
     *
     * @param arg The raw object
     * @return Object(Map<String, Long>)
     * */
    public static Func toLongMap = new ToLongMapFunc();

    // Double

    /**
     * Convert to Double
     *
     * Example:
     * R.toDouble.run('1.5')
     * // 1.5
     *
     * @param arg The raw object
     * @return Object(Double)
     * */
    public static Func toDouble = new ToDoubleFunc();

    /**
     * Convert to Double List
     *
     * Example:
     * R.toDoubleList.run(new List<Object>{ '1.5' })
     * // (1.5)
     *
     * @param arg The raw object
     * @return Object(List<Double>)
     * */
    public static Func toDoubleList = new ToDoubleListFunc();

    /**
     * Convert to Double Map
     *
     * Example:
     * R.toDoubleMap.run(new Map<String, Object>{ 'name' => '1.5' })
     * // {name=1.5}
     *
     * @param arg The raw object
     * @return Object(Map<String, Double>)
     * */
    public static Func toDoubleMap = new ToDoubleMapFunc();

    // Decimal

    /**
     * Convert to Decimal
     *
     * Example:
     * R.toDecimal.run(2)
     * // 2
     *
     * @param arg The raw object
     * @return Object(Decimal)
     * */
    public static Func toDecimal = new ToDecimalFunc();

    /**
     * Convert to Decimal List
     *
     * Example:
     * R.toDecimalList.run(new List<Object> { 2 })
     * // (2)
     *
     * @param arg The raw object
     * @return Object(List<Decimal>)
     * */
    public static Func toDecimalList = new ToDecimalListFunc();

    /**
     * Convert to Decimal Map
     *
     * Example:
     * R.toDecimalMap.run(new Map<String, Object>{ 'name' => 3 })
     * // {name=3}
     *
     * @param arg The raw object
     * @return Object(Map<String, Decimal>)
     * */
    public static Func toDecimalMap = new ToDecimalMapFunc();

    // String

    /**
     * Convert to String
     *
     * Example:
     * R.toString.run('abc')
     * // abc
     *
     * @param arg The raw object
     * @return Object(String)
     * */
    public static Func toString = new ToStringFunc();

    /**
     * Check if it can be converted to String
     *
     * Example:
     * R.isStringLike.run('abc')
     * // true
     *
     * @param arg The raw object
     * @return Object(Boolean)
     * */
    public static Func isStringLike = new IsStringLikeFunc();

    /**
     * Convert to String List
     *
     * Example:
     * R.toStringList.run(new List<Object>{ 1, 2 })
     * // (1, 2)
     *
     * @param arg The raw object
     * @return Object(List<String>)
     * */
    public static Func toStringList = new ToStringListFunc();

    /**
     * Convert to String Map
     *
     * Example:
     * R.toStringMap.run(new Map<String, Object>{ 'name' => 2 })
     * // {name=2}
     *
     * @param arg The raw object
     * @return Object(Map<String, String>)
     * */
    public static Func toStringMap = new ToStringMapFunc();

    /**
     * Convert to List of Chars
     *
     * Example:
     * R.toCharList.run('abc')
     * // (a, b, c)
     *
     * @param arg The raw object
     * @return Object(List<String>)
     * */
    public static Func toCharList = new ToCharListFunc();

    // Date & Time

    /**
     * Convert to Date
     *
     * Example:
     * R.toDate.run(Date.newInstance(2018, 1, 1))
     * // 2018-01-01 00:00:00
     *
     * @param arg The raw object
     * @return Object(Date)
     * */
    public static Func toDate = new ToDateFunc();

    /**
     * Convert to Date List
     *
     * Example:
     * R.toDateList.run(new List<Object>{ Date.newInstance(2018, 1, 1)})
     * // (2018-01-01 00:00:00)
     *
     * @param arg The raw object
     * @return Object(List<Date>)
     * */
    public static Func toDateList = new ToDateListFunc();

    /**
     * Convert to Date Map
     *
     * Example:
     * R.toDateMap.run(new Map<String, Object>{ 'date' => Date.newInstance(2018, 1, 1)})
     * // {date=2018-01-01 00:00:00}
     *
     * @param arg The raw object
     * @return Object(Map<String, Date>)
     * */
    public static Func toDateMap = new ToDateMapFunc();

    /**
     * Convert to Time
     *
     * Example:
     * R.toTime.run(Time.newInstance(8, 0, 0, 0))
     * // 08:00:00.000Z
     *
     * @param arg The raw object
     * @return Object(Time)
     * */
    public static Func toTime = new ToTimeFunc();

    /**
     * Convert to Time List
     *
     * Example:
     * R.toTimeList.run(new List<Object>{ Time.newInstance(8, 0, 0, 0) })
     * // (08:00:00.000Z)
     *
     * @param arg The raw object
     * @return Object(List<Time>)
     * */
    public static Func toTimeList = new ToTimeListFunc();

    /**
     * Convert to Time Map
     *
     * Example:
     * R.toTimeMap.run(new Map<String, Object>{ 'time' => Time.newInstance(8, 0, 0, 0) })
     * // {time=08:00:00.000Z}
     *
     * @param arg The raw object
     * @return Object(Map<String, Time>)
     * */
    public static Func toTimeMap = new ToTimeMapFunc();

    /**
     * Convert to Datetime
     *
     * Example:
     * R.toDatetime.run(Datetime.now())
     * // 2018-04-25 23:29:43
     *
     * @param arg The raw object
     * @return Object(Datetime)
     * */
    public static Func toDatetime = new ToDatetimeFunc();

    /**
     * Convert to Datetime List
     *
     * Example:
     * R.toDatetimeList.run(new List<Object>{ Datetime.now() })
     * // (2018-04-25 23:30:24)
     *
     * @param arg The raw object
     * @return Object(List<Datetime>)
     * */
    public static Func toDatetimeList = new ToDatetimeListFunc();

    /**
     * Convert to Datetime Map
     *
     * Example:
     * R.toDatetimeMap.run(new Map<String, Object>{ 'datetime' => Datetime.now() })
     * // {datetime=2018-04-25 23:35:27}
     *
     * @param arg The raw object
     * @return Object(Map<String, Datetime>)
     * */
    public static Func toDatetimeMap = new ToDatetimeMapFunc();

    // Func

    /**
     * Convert to Func
     *
     * Example:
     * R.toFunc.run(R.identity)
     * // IdentityFunc:[Func.args=(), Func.length=-1]
     *
     * @param arg The raw object
     * @return Object(Func)
     * */
    public static Func toFunc = new ToFuncFunc();

    /**
     * Check if it can be converted to Func
     *
     * Example:
     * R.isFuncLike.run(R.identity)
     * // true
     *
     * @param arg The raw object
     * @return Object(Boolean)
     * */
    public static Func isFuncLike = new IsFuncLikeFunc();

    /**
     * Convert to Func List
     *
     * Example:
     * R.toFuncList.run(new List<Object>{ R.identity })
     * // (IdentityFunc:[Func.args=(), Func.length=-1])
     *
     * @param arg The raw object
     * @return Object(List<Func>)
     * */
    public static Func toFuncList = new ToFuncListFunc();

    /**
     * Convert to Func Map
     *
     * Example:
     * R.toFuncMap.run(new Map<String, Object>{ 'func' => R.identity })
     * // {func=IdentityFunc:[Func.args=(), Func.length=-1]}
     *
     * @param arg The raw object
     * @return Object(Map<String, Func>)
     * */
    public static Func toFuncMap = new ToFuncMapFunc();

    // List

    /**
     * Convert to List
     *
     * Example:
     * R.toList.run(R.with(1, 2, 3))
     * // (1, 2, 3)
     *
     * @param arg The raw object
     * @return Object(List<Object>)
     * */
    public static Func toList = new ToListFunc();

    /**
     * Check if it can be converted to List
     *
     * Example:
     * R.isListLike.run(R.with(1, 2, 3))
     * // true
     *
     * @param arg The raw object
     * @return Object(Boolean)
     * */
    public static Func isListLike = new IsListLikeFunc();

    // Set

    /**
     * Covnert to Set
     *
     * Example:
     * R.toSet.run(new Set<String>{ 'a' })
     * // {a}
     *
     * @param arg The raw object
     * @return Object(Set<String>)
     * */
    public static Func toSet = new ToSetFunc();

    /**
     * Covnert to Set
     *
     * Example:
     * R.toIdSet.run(new Set<Id>{ 'a' })
     * // {a}
     *
     * @param arg The raw object
     * @return Object(Set<Id>)
     * */
    public static Func toIdSet = new ToIdSetFunc();

    /**
     * Check if it can be converted to Set
     *
     * Example:
     * R.isSetLike.run(new Set<String>{ 'a' })
     * // true
     *
     * @param arg The raw object
     * @return Object(Boolean)
     * */
    public static Func isSetLike = new IsSetLikeFunc();

    // Map

    /**
     * Convert to Map
     *
     * Example:
     * R.toMap.run(R.withObj('name', 'test'))
     * // {name=test}
     *
     * @param arg The raw object
     * @return Object(Map<String, Object>)
     * */
    public static Func toMap = new ToMapFunc();

    /**
     * Check if it can be converted to Map
     *
     * Example:
     * R.isMapLike.run(R.withObj('name', 'test'))
     * // true
     *
     * @param arg The raw object
     * @return Object(Boolean)
     * */
    public static Func isMapLike = new IsMapLikeFunc();

    /**
     * Convert to Map List
     *
     * @param arg The raw object
     * @return Object(List<Map<String, Object>>)
     * */
    public static Func toMapList = new ToMapListFunc();

    /**
     * Convert to Pair
     *
     * Example:
     * R.toPair.run(R.with(1, 2))
     * // Pair:[fst=1, snd=2]
     *
     * @param arg The raw object
     * @return Object(R.Pair)
     * */
    public static Func toPair = new ToPairFunc();

    /**
     * Check if it can be converted to Pair
     *
     * Example:
     * R.isPairLike.run(new R.Pair(1, 2))
     * // true
     *
     * @param arg The raw object
     * @return Object(Boolean)
     * */
    public static Func isPairLike = new IsPairLikeFunc();

    /**
     * Convert to Pair List
     *
     * Example:
     * R.toPairList.run(new List<Object>{ R.with(1, 2) })
     * // (Pair:[fst=1, snd=2])
     *
     * @param arg The raw object
     * @return Object(List<R.Pair>)
     * */
    public static Func toPairList = new ToPairListFunc();

    /**
     * Convert to Pair Map
     *
     * Example:
     * R.toPairMap.run(new Map<String, Object>{ 'pair' => R.with(1, 2) })
     * // {pair=Pair:[fst=1, snd=2]}
     *
     * @param arg The raw object
     * @return Object(Map<String, R.Pair>)
     * */
    public static Func toPairMap = new ToPairMapFunc();

    // SObject

    /**
     * Convert to SObject
     *
     * Example:
     * R.toSObject.run(new Account())
     * // Account:{}
     *
     * @param arg The raw object
     * @return Object(SObject)
     * */
    public static Func toSObject = new ToSObjectFunc();

    /**
     * Check if it can be convertd to SObject
     *
     * Example:
     * R.isSObjectLike.run(new Account())
     * // true
     *
     * @param arg The raw object
     * @return Object(Boolean)
     * */
    public static Func isSObjectLike = new IsSObjectLikeFunc();

    /**
     * Convert to SObject List
     *
     * Example:
     * R.toSObjectList.run(new List<Object>{ new Account() })
     * // (Account:{})
     *
     * @param arg The raw object
     * @return Object(List<SObject>)
     * */
    public static Func toSObjectList = new ToSObjectListFunc();

    /**
     * Convert to SObject Map
     *
     * Example:
     * R.toSObjectMap.run(new Map<String, Object>{ 'acc' => new Account() })
     * // {acc=Account:{}}
     *
     * @param arg The raw object
     * @return Object(Map<String, SObject>)
     * */
    public static Func toSObjectMap = new ToSObjectMapFunc();

    // ----------------------------------------------------------------------------
    // --   Arithmetic                                                           --
    // ----------------------------------------------------------------------------
    /**
     * Add two numbers
     *
     * Example:
     * R.add.run(1, 2)
     * // 3
     *
     * @param arg1 The first number
     * @param arg2 The second number
     * @return Object(Decimal)
     * */
    public static Func add = new AddFunc();

    /**
     * Subtract two numbers
     *
     * Example:
     * R.subtract.run(1, 2)
     * // -1
     *
     * @param arg1 The first number
     * @param arg2 The second number
     * @return Object(Decimal)
     * */
    public static Func subtract = new SubtractFunc();

    /**
     * Multiply two numbers
     *
     * Example:
     * R.multiply.run(1, 2)
     * // 2
     *
     * @param arg1 The first number
     * @param arg2 The second number
     * @return Object(Decimal)
     * */
    public static Func multiply = new MultiplyFunc();

    /**
     * Divide two numbers
     *
     * Example:
     * R.divide.run(1, 2)
     * // 0.5
     *
     * @param arg1 The first number
     * @param arg2 The second number
     * @return Object(Decimal)
     * */
    public static Func divide = new DivideFunc();

    /**
     * Mod two numbers
     *
     * Example:
     * R.mod.run(1, 2)
     * // 1
     *
     * @param arg1 The first number
     * @param arg2 The second number
     * @return Object(Decimal)
     * */
    public static Func mod = new ModFunc();

    /**
     * Increment the number
     *
     * Example:
     * R.inc.run(1)
     * // 2
     *
     * @param arg The number
     * @return Object(Decimal)
     * */
    public static Func inc = add.apply(1);

    /**
     * Decrement the number
     *
     * Example:
     * R.dec.run(1)
     * // 0
     *
     * @param arg The number
     * @return Object(Decimal)
     * */
    public static Func dec = add.apply(-1);

    /**
     * Negate the number
     *
     * Example:
     * R.negate.run(1)
     * // -1
     *
     * @param arg The number
     * @return Object(Decimal)
     * */
    public static Func negate = subtract.apply(0);

    /**
     * Multiply all the numbers
     *
     * Example:
     * R.product.run(1, 2, 3)
     * // 6
     *
     * @param <args> Dynamic arguments
     * @return Object(Decimal)
     * */
    public static Func product = new ProductFunc();

    // ----------------------------------------------------------------------------
    // --   Logic                                                                --
    // ----------------------------------------------------------------------------

    /**
     * Create a function that combines all predicates with 'and'
     *
     * Example:
     * Func f = (Func)R.allPass.run(
     *     R.startsWith.apply('c'),
     *     R.endsWith.apply('t')
     * );
     * system.debug(f.run('cat'));
     * // true
     *
     * @param <args> Dynamic arguments of Func
     * @return Object(Func)
     * */
    public static Func allPass = new AllPassFunc();

    /**
     * Create a function that combines all predicates with 'or'
     *
     * Example:
     * Func f = (Func)R.anyPass.run(
     *     R.startsWith.apply('c'),
     *     R.endsWith.apply('t')
     * );
     * system.debug(f.run('cc'));
     * // true
     *
     * @param <args> Dynamic arguments of Func
     * @return Object(Func)
     * */
    public static Func anyPass = new AnyPassFunc();

    /**
     * Create a function that negate the predicate
     *
     * Example:
     * Func f = (Func)R.complement.run(R.equals.apply('cat'));
     * system.debug(f.run('cat'));
     * // false
     *
     * @param arg The predicate
     * @return Object(Func)
     * */
    public static Func complement = new ComplementFunc();

    /**
     * Test logic 'and'
     *
     * Example:
     * R.doAnd.run(true, false)
     * // false
     *
     * @param <args> Dynamic arguments of Boolean
     * @return Object(Boolean)
     * */
    public static Func doAnd = new AndFunc();

    /**
     * Test logic 'or'
     *
     * Example:
     * R.doOr.run(true, false)
     * // true
     *
     * @param <args> Dynamic arguments of Boolean
     * @return Object(Boolean)
     * */
    public static Func doOr = new OrFunc();

    /**
     * Test logic 'not'
     *
     * Example:
     * R.doNot.run(false)
     * // true
     *
     * @param arg Boolean value
     * @return Object(Boolean)
     * */
    public static Func doNot = new NotFunc();

    // ----------------------------------------------------------------------------
    // --   Relation                                                             --
    // ----------------------------------------------------------------------------

    /**
     * Check if two values are equal
     *
     * Example:
     * R.equals.run(1, 1)
     * // true
     *
     * @param arg1 The first object
     * @param arg2 The second object
     * @return Object(Boolean)
     * */
    public static Func equals = new EqualsFunc();

    /**
     * Check for 'less than'
     *
     * Example:
     * R.lt.run(1, 2)
     * // true
     *
     * @param arg1 The first object
     * @param arg2 The second object
     * @return Object(Boolean)
     * */
    public static Func lt = new LtFunc();

    /**
     * Check for 'less than or equal'
     *
     * Example:
     * R.lte.run(1, 2)
     * // true
     *
     * @param arg1 The first object
     * @param arg2 The second object
     * @return Object(Boolean)
     * */
    public static Func lte = new LteFunc();

    /**
     * Check for 'greater than'
     *
     * Example:
     * R.gt.run(3, 2)
     * // true
     *
     * @param arg1 The first object
     * @param arg2 The second object
     * @return Object(Boolean)
     * */
    public static Func gt = new GtFunc();

    /**
     * Check for 'greater than or equal'
     *
     * Example:
     * R.gte.run(3, 2)
     * // true
     *
     * @param arg1 The first object
     * @param arg2 The second object
     * @return Object(Boolean)
     * */
    public static Func gte = new GteFunc();

    /**
     * Check for the max value between the two
     *
     * Example:
     * R.max.run(1, 2)
     * // 2
     *
     * @param arg1 The first object
     * @param arg2 The second object
     * @return Object
     * */
    public static Func max = new MaxFunc();

    /**
     * Check for the min value between the two
     *
     * Example:
     * R.min.run(1, 2)
     * // 1
     *
     * @param arg1 The first object
     * @param arg2 The second object
     * @return Object
     * */
    public static Func min = new MinFunc();

    // ----------------------------------------------------------------------------
    // --   Function                                                             --
    // ----------------------------------------------------------------------------

    /**
     * A placeholder in the applied arguments
     *
     * Example:
     * R.subtract.apply(R.placeholder, 2).run(1)
     * // -1
     *
     * @param <args> Should not pass in any arguments
     * @return null Should not use the return value
     * */
    public static Func placeholder = new PlaceholderFunc();

    /**
     * Compose the functions in a piping style
     * Composed functions are executed from left to right
     *
     * Example:
     * Func f = (Func)R.pipe.run(
     *     R.add.apply(1),
     *     R.multiply.apply(2)
     * );
     * System.debug(f.run(1));
     * // 4
     *
     * @param <args> Dynamic arguments of Func
     * @return Object(Func)
     * */
    public static Func pipe = new PipeFunc();

    /**
     * Compose the functions in a composing style
     * Composed functions are executed from right to left
     *
     * Example:
     * Func f = (Func)R.pipe.run(
     *     R.add.apply(1),
     *     R.multiply.apply(2)
     * );
     * System.debug(f.run(1));
     * // 3
     *
     * @param <args> Dynamic arguments of Func
     * @return Object(Func)
     * */
    public static Func compose = new ComposeFunc();

    /**
     * Flip the first two arguments of a function
     *
     * Example:
     * Func f = (Func)R.flip.run(R.subtract);
     * System.debug(f.run(1, 2));
     * // 1
     *
     * @param arg The function
     * @return Object(Func)
     * */
    public static Func flip = new FlipFunc();

    /**
     * Accepts a converging function and branching functions and returns a new function
     * When invoked, this new function is applied to some arguments, each branching function is applied to those same arguments
     * The results of each branching function are passed as arguments to the converging function to produce the return value
     *
     * Example:
     * Func f = (Func)R.converge.run(
     *     R.multiply,
     *     R.add,
     *     R.subtract
     * );
     * System.debug(f.run(1, 2));
     * // -3
     *
     * @param fn The converging function
     * @param <args> The branching functions
     * @return Object(Func)
     * */
    public static Func converge = new ConvergeFunc();

    /**
     * Accepts a function fn and other functions and returns a new function
     * When the new function is invoked, it calls the function fn with parameters consisting of the result
     * of calling each supplied handler on successive arguments to the new function
     *
     * Example:
     * Func f = (Func)R.useWith.run(
     *     R.multiply,
     *     R.add.apply(1),
     *     R.subtract.apply(1)
     * );
     * System.debug(f.run(1, 2));
     * // -2
     *
     * @param fn The main function
     * @param <args> The other functions
     * @return Object(Func)
     * */
    public static Func useWith = new UseWithFunc();

    /**
     * Return whatever is passed in
     *
     * Example:
     * R.identity.run('abc')
     * // abc
     *
     * @param arg The passed in object
     * @return Object
     * */
    public static Func identity = new IdentityFunc();

    /**
     * Return a function which returns the value whenever called
     *
     * Example:
     * Func f = (Func)R.always.run(1);
     * System.debug(f.run(2));
     * // 1
     *
     * @param val The applied value
     * @return Object(Func)
     * */
    public static Func always = new AlwaysFunc();

    /**
     * Return a function which returns the value whenever called
     *
     * Example:
     * Func f = R.constant.apply(1);
     * System.debug(f.run(2));
     * // 1
     *
     * @param val The applied value
     * @return Object
     * */
    public static Func constant = new ConstantFunc();

    /**
     * Throw an exception
     *
     * Example:
     * R.throwException.run(new Func.FuncException('test'));
     * // throw exception
     *
     * @param e The exception
     * @return Object
     * */
    public static Func throwException = new ThrowExcpetionFunc();

    /**
     * Wrap the function to make it call only by once
     *
     * Example:
     * Func testF = (Func)R.once.run(R.add.apply(1), 'testF');
     * testF.run(1) // 2
     * testF.run(2) // 2
     *
     * @param fn The raw function
     * @param key The unique key for this function
     * @return Object(Func)
     * */
    public static Func once = new OnceFunc();

    /**
     * Wrap the function to make it memoizable
     *
     * Example:
     * Func testF = (Func)R.memoize.run(
     *    R.add.apply(1),
     *    'testF',
     *    R.toString
     *);
     *
     * @param fn The raw function
     * @param key The unique key for this function
     * @param keyFn The function to generate the memoizing key
     * @return Object(Func)
     * */
    public static Func memoize = new MemoizeFunc();

    /**
     * Wrap the function to make it accept only N arguments
     *
     * Example:
     * Func f = (Func)R.nAry.run(2, R.product);
     * System.debug(f.run(1, 2, 3));
     * // 2
     *
     * @param arity The size of arguments allowed
     * @param fn The function to be wrapped
     * @return Object(Func)
     * */
    public static Func nAry = new NAryFunc();

    /**
     * Make the function accept only one argument
     *
     * @see nAry
     * */
    public static Func unary = nAry.apply(1);

    /**
     * Make the function accept only two arguments
     *
     * @see nAry
     * */
    public static Func binary = nAry.apply(2);

    /**
     * Apply the function to the target
     *
     * Example:
     * R.transform.run(R.inc, 1)
     * // 2
     *
     * @param fn The transforming function
     * @param target The target object
     * @return Object
     * */
    public static Func transform = new TransformFunc();

    /**
     * Given a spec object recursively mapping properties to functions, creates a function producing an object of the same structure,
     * by mapping each property to the result of calling its associated function with the supplied arguments
     *
     * Example:
     * Map<String, Object> spec = new Map<String, Object>{
     *     'add' => R.add,
     *     'subtract' => R.subtract
     * };
     * System.debug(R.applySpec.run(spec, 1, 2));
     * // {add=3, subtract=-1}
     *
     * @param spec Map of function specs
     * @param <args> Other arguments
     * @return Object
     * */
    public static Func applySpec = new ApplySpecFunc();

    /**
     * Applies a list of functions to a list of values
     *
     * Example:
     * List<Func> fns = new List<Func>{ R.add, R.subtract };
     * System.debug(R.juxt.run(fns, 1, 2));
     * // (3, -1)
     *
     * @param juxt List of functions
     * @param <args> Other arguments
     * @return Object
     * */
    public static Func juxt = new JuxtFunc();

    /**
     * Creates a new object by recursively evolving a copy of object, according to the transformation functions
     *
     * Example:
     * R.evolve.run(new Map<String, Object>{ 'name' => R.append.apply('$') }, new Map<String, Object>{ 'name' => 'test' })
     * // {name=test$}
     *
     * @param spec Map of spec functions
     * @param target The target object
     * @return Object
     * */
    public static Func evolve = new EvolveFunc();

    // ----------------------------------------------------------------------------
    // --   Comparator                                                           --
    // ----------------------------------------------------------------------------

    /**
     * Convert a Boolean-returning comparator to an Integer-returning comparator
     *
     * Example:
     * Func f = (Func)R.comparator.run(R.lt);
     * System.debug(f.run(1, 2));
     * // -1
     *
     * @param comparator The Boolean-returning function that takes two arguments
     * @return Object(Func)
     * */
    public static Func comparator = new ComparatorFunc();

    /**
     * Compare two objects
     *
     * Example:
     * R.compare.run(1, 2)
     * // -1
     *
     * @param arg1 The first object
     * @param arg2 The second object
     * @return Object(Integer)
     * */
    public static Func compare = new CompareFunc();

    /**
     * Convert a function into an ascending comparator
     *
     * Example:
     * Func f = (Func)R.ascend.run(R.identity);
     * System.debug(f.run(1, 2));
     * // -1
     *
     * @param fn The function that takes one argument and returns one
     * @return Object(Func)
     * */
    public static Func ascend = new AscendFunc();

    /**
     * Convert a function into an descending comparator
     *
     * Example:
     * Func f = (Func)R.descend.run(R.identity);
     * System.debug(f.run(1, 2));
     * // 1
     *
     * @param fn The function that takes one argument and returns one
     * @return Object(Func)
     * */
    public static Func descend = new DescendFunc();

    /**
     * Combine the comparator functions into one
     *
     * Example:
     * Func f = (Func)R.cascade.run(
     *     (Func)R.ascend.run(R.prop.apply('FirstName')),
     *     (Func)R.ascend.run(R.prop.apply('Description'))
     * );
     *
     * @param <args> List of comparator functions
     * @return Object(Func)
     * */
    public static Func cascade = new CascadeFunc();

    /**
     * Limit the value between the min and the max
     *
     * Example:
     * R.clamp.run(1, 3, 5)
     * // 3
     *
     * @param min The min value
     * @param max The max value
     * @param target The target value
     * @return Object
     * */
    public static Func clamp = new ClampFunc();

    // ----------------------------------------------------------------------------
    // --   Condition                                                            --
    // ----------------------------------------------------------------------------

    /**
     * Returns a function, fn, which encapsulates if/else, if/else, logic
     * It takes a list of functions, alternated by predicate and transformer
     * All of the arguments to fn are applied to each of the predicates in turn until one returns a "truthy" value,
     * at which point fn returns the result of applying its arguments to the corresponding transformer
     *
     * Example:
     * Func testF = (Func)R.cond.runN(new List<Object>{
     *     R.lt.apply(0), R.always.run(1),
     *     R.gt.apply(0), R.always.run(-1),
     *     R.equals.apply(0), R.always.run(0)
     * });
     * testF.run(3); // 1
     *
     * @param <args> List of functions, alternated by predicate and transformer
     * @return Object(Func)
     * */
    public static Func cond = new CondFunc();

    /**
     * Creates a function that will process either the onTrue or the onFalse function depending upon the result of the condition predicate
     *
     * Example:
     * Func testF = (Func)R.ifElse.run(
     *     R.lt.apply(0),
     *     R.always.run(1),
     *     R.always.run(0)
     * );
     * testF.run(3); // 1
     *
     * @param predicate The condition
     * @param onTrue The function on true condition
     * @param onFalse The function on false condition
     * @return Object(Func)
     * */
    public static Func ifElse = new IfElseFunc();

    /**
     * Tests the final argument by passing it to the given predicate function
     * If the predicate is satisfied, the function will return the result of calling the whenTrueFn function with the same argument
     * If the predicate is not satisfied, the argument is returned as a wrapping list
     *
     * Example:
     * Func testF = (Func)R.doWhen.run(
     *     R.lt.apply(0),
     *     R.always.run(1)
     * );
     * testF.run(3); // 1
     *
     * @param predicate The condition
     * @param whenTrueFn The function on true
     * @return Object(Func)
     * */
    public static Func doWhen = new WhenFunc();

    /**
     * Tests the final argument by passing it to the given predicate function
     * If the predicate is not satisfied, the function will return the result of calling the whenFalseFn function with the same argument
     * If the predicate is satisfied, the argument is returned as a wrapping list
     *
     * Example:
     * Func testF = (Func)R.unless.run(
     *     R.lt.apply(0),
     *     R.always.run(0)
     * );
     * testF.run(-3); // 0
     *
     * @param predicate The condition
     * @param whenFalseFn The function on false
     * @return Object(Func)
     * */
    public static Func unless = new UnlessFunc();

    // ----------------------------------------------------------------------------
    // --   List                                                                 --
    // ----------------------------------------------------------------------------

    /**
     * Do for-each on the elements
     *
     * Example:
     * R.forEach.run(R.debug, R.with(1, 2, 3));
     * // 1
     * // 2
     * // 3
     *
     * @param fn The iterating function
     * @param target The target object
     * @return Object
     * */
    public static Func forEach = new ForEachFunc();

    /**
     * Filter on the elements
     *
     * Example:
     * R.filter.run(R.isNotNull, R.with('a', null, 'b'))
     * // (a, b)
     *
     * @param fn The filter function
     * @param target The target object
     * @return Object
     * */
    public static Func filter = new FilterFunc(false);

    /**
     * Reject on the elements
     *
     * Example:
     * R.reject.run(R.isNull, R.with('a', null, 'b'))
     * // (a, b)
     *
     * @param fn The reject function
     * @param target The target object
     * @return Object
     * */
    public static Func reject = new FilterFunc(true);

    /**
     * Map over the elements
     *
     * Example:
     * R.doMap.run(R.inc, R.with(1, 2, 3))
     * // (2, 3, 4)
     *
     * @param fn The mapping function
     * @param target The target object
     * @return Object
     * */
    public static Func doMap = new MapFunc();

    /**
     * Map over both the keys and values
     *
     * Example:
     * R.bimap.run(R.append.apply('_key'), R.append.apply('_value'), R.withObj('name', 'test'))
     * // {test_key=test_value}
     *
     * @param keyFn The function to map to generate keys
     * @param valueFn The function to map to generate values
     * @return Object(Map<String, Object>)
     * */
    public static Func biMap = new BimapFunc();

    /**
     * Pluck the fields out of elements
     *
     * Example:
     * R.pluck.run('Description', R.with(new Account(Description='desc')))
     * // (desc)
     *
     * @param field The field name to pluck
     * @param target The target object
     * @return Object(List<Object>)
     * */
    public static Func pluck = new PluckFunc();

    /**
     * Reduce over the elements
     *
     * Example:
     * R.reduce.run(R.add, 0, R.with(1, 2, 3))
     * // 6
     *
     * @param reducerFn The reducing function
     * @param initialValue The initial value
     * @param target The target object
     * @return Object
     * */
    public static Func reduce = new ReduceFunc();

    /**
     * Get the length
     *
     * Example:
     * R.length.run(R.with(1, 2, 3))
     * // 3
     *
     * @param target The target object
     * @return Object(Integer)
     * */
    public static Func length = R.reduce.apply(
        R.nAry.run(1, R.add.apply(1)),
        0
    );

    /**
     * Get the size
     *
     * @see length
     * */
    public static Func size = R.length;

    /**
     * Check if it is empty
     *
     * Example:
     * R.isEmpty.run(R.with(1, 2, 3))
     * // false
     *
     * @param target The target object
     * @return Object(Boolean)
     * */
    public static Func isEmpty = (Func)R.pipe.run(
        R.length,
        R.equals.apply(0)
    );

    /**
     * Check if it is not empty
     *
     * Example:
     * R.isNotEmpty.run(R.with(1, 2, 3))
     * // true
     *
     * @param target The target object
     * @return Object(Boolean)
     * */
    public static Func isNotEmpty = (Func)R.complement.run(R.isEmpty);

    /**
     * Get the sum
     *
     * Example:
     * R.sum.run(R.with(1, 2, 3))
     * // 6
     *
     * @param target The target object
     * @return Object(Decimal)
     * */
    public static Func sum = R.reduce.apply(R.add, 0);

    /**
     * Get a slice of the elements
     *
     * Example:
     * R.slice.run(0, 1, R.with(1, 2, 3))
     * // (1)
     *
     * @param first The first index(inclusive)
     * @param last The last index(exclusive)
     * @param target The target object
     * @return Object
     * */
    public static Func slice = new SliceFunc();

    /**
     * Take the first N elements
     *
     * Example:
     * R.take.run(1, 'abc')
     * // a
     *
     * @param count The count of elements to take
     * @param target The target object
     * @return Object
     * */
    public static Func take = new TakeFunc().apply(false);

    /**
     * Take the first N elements from right
     *
     * Example:
     * R.takeRight.run(1, 'abc')
     * // c
     *
     * @param count The count of elements to take
     * @param target The target object
     * @return Object
     * */
    public static Func takeRight = new TakeFunc().apply(true);

    /**
     * Take elements until not satisfied
     *
     * Example:
     * R.takeWhile.run(R.equals.apply('a'), 'abc')
     * // a
     *
     * @param pred The predicate
     * @param target The target object
     * @return Object
     * */
    public static Func takeWhile = take;

    /**
     * Take elements from right until not satisfied
     *
     * Example
     * R.takeRightWhile.run(R.equals.apply('a'), 'abc')
     * //
     *
     * @param pred The predicate
     * @param target The target object
     * @return Object
     * */
    public static Func takeRightWhile = takeRight;

    /**
     * Drop first N elements
     *
     * Example:
     * R.drop.run(1, 'abc')
     * // bc
     *
     * @param count The count of elements to drop
     * @param target The target object
     * @return Object
     * */
    public static Func drop = new DropFunc().apply(false);

    /**
     * Drop first N elements from right
     *
     * Example:
     * R.dropRight.run(1, 'abc')
     * // ab
     *
     * @param count The count of elements to drop
     * @param target The target object
     * @return Object
     * */
    public static Func dropRight = new DropFunc().apply(true);

    /**
     * Drop elements until not satisfied
     *
     * Example:
     * R.dropWhile.run(R.equals.apply('a'), 'abc')
     * // bc
     *
     * @param pred The predicate
     * @param target The target object
     * @return Object
     * */
    public static Func dropWhile = drop;

    /**
     * Drop elements from right until not satisfied
     *
     * Example:
     * R.dropRightWhile.run(R.equals.apply('a'), 'abc')
     * // abc
     *
     * @param pred The predicate
     * @param target The target object
     * @return Object
     * */
    public static Func dropRightWhile = dropRight;

    /**
     * Reverse the elements
     *
     * Example:
     * R.reverse.run('abc')
     * // cba
     *
     * @param target The target object
     * @return Object
     * */
    public static Func reverse = new ReverseFunc();

    /**
     * Sort by the comparator
     *
     * Example:
     * R.sortBy.run(R.compare, R.with(3, 2, 1))
     * // (1, 2, 3)
     *
     * @param comparator The comparator function that returns integer
     * @param target The target object
     * @return Object
     * */
    public static Func sortBy = new SortFunc();

    /**
     * Sort by default
     *
     * Example:
     * R.sortDefault.run(R.with(3, 2, 1))
     * // (1, 2, 3)
     *
     * @param target The target object
     * @return Object
     * */
    public static Func sortDefault = new SortDefaultFunc();

    /**
     * Check if the element is contained
     *
     * Example:
     * R.contains.run(1, R.with(1, 2, 3))
     * // true
     *
     * @param element The element to check
     * @param target The target object
     * @return Object(Boolean)
     * */
    public static Func contains = new ContainsFunc();

    /**
     * Check if the element is contained by the comparator returning boolean
     *
     * Example:
     * R.containsBy.run(R.equals, 1, R.with(1, 2, 3))
     * // true
     *
     * @param comparator The comparator function returning boolean
     * @param element The element to check
     * @param target The target object
     * @return Object(Boolean)
     * */
    public static Func containsBy = new ContainsByFunc();

    /**
     * Check if the key is contained
     *
     * Example:
     * R.containsKey.run('name', new Map<String, Object>{ 'name' => 'test' })
     * // true
     *
     * @param key The key to check
     * @param target The target object
     * @return Object(Boolean)
     * */
    public static Func containsKey = new ContainsKeyFunc();

    /**
     * Get a unique collection of the elements
     *
     * Example:
     * R.uniq.run(R.with(1, 2, 2))
     * // (1, 2)
     *
     * @param target The target object
     * @return Object
     * */
    public static Func uniq = new UniqFunc();

    /**
     * Make a union of the two objects
     *
     * Example:
     * R.union.run(R.with(1, 2, 3), R.with(2, 3, 4))
     * // (2, 3, 4, 1)
     *
     * @param arg1 The first object
     * @param arg2 The second object
     * @return Object
     * */
    public static Func union = new UnionFunc();

    /**
     * Make an intersection of the two objects
     *
     * Example:
     * R.intersection.run(R.with(1, 2, 3), R.with(2, 3, 4))
     * // (2, 3)
     *
     * @param arg1 The first object
     * @param arg2 The second object
     * @return Object
     * */
    public static Func intersection = new IntersectionFunc();

    /**
     * Make an xor of the two objects
     *
     * Example:
     * R.xor.run(R.with(1, 2, 3), R.with(2, 3, 4))
     * // (4, 1)
     *
     * @param arg1 The first object
     * @param arg2 The second object
     * @return Object
     * */
    public static Func xor = new XorFunc();

    /**
     * Make a difference of the two objects
     *
     * Example:
     * R.difference.run(R.with(1, 2, 3), R.with(2, 3, 4))
     * // (4)
     *
     * @param arg1 The first object
     * @param arg2 The second object
     * @return Object
     * */
    public static Func difference = new DifferenceFunc();

    /**
     * Same as difference
     *
     * @see difference
     * */
    public static Func without = R.difference;

    /**
     * Adjust the element using the function
     *
     * Example:
     * R.adjust.run(R.inc, 1, R.with(1, 2, 3))
     * // (1, 3, 3)
     *
     * @param fn The function to update the element
     * @param index The index of the element
     * @param target The target object
     * @return Object
     * */
    public static Func adjust = new AdjustFunc();

    /**
     * Check if all elements match the predicate
     *
     * Example:
     * R.all.run(R.isNotNull, R.with(1, 2, 3))
     * // true
     *
     * @param pred The predicate
     * @param target The target object
     * @return Object(Boolean)
     * */
    public static Func all = new AllFunc();

    /**
     * Same as all
     *
     * @see all
     * */
    public static Func every = R.all;

    /**
     * Check if some elements match the predicate
     *
     * Example:
     * R.some.run(R.isNotNull, R.with(1, 2, 3))
     * // false
     *
     * @param pred The predicate
     * @param target The target object
     * @return Object(Boolean)
     * */
    public static Func some = new AnyFunc();

    /**
     * Check if none of the elements match the predicate
     *
     * Example:
     * R.none.run(R.isNotNull, R.with(1, 2, 3))
     * // true
     *
     * @param pred The predicate
     * @param target The target object
     * @return Object(Boolean)
     * */
    public static Func none = new NoneFunc();

    /**
     * Append an element to the elements
     *
     * Example:
     * R.append.run(1, R.with(1, 2, 3))
     * // (1, 2, 3, 1)
     *
     * @param element The element to append
     * @param target The target object
     * @return Object
     * */
    public static Func append = new AppendFunc();

    /**
     * Prepend an element to the elements
     *
     * Example:
     * R.prepend.run(1, R.with(1, 2, 3))
     * // (1, 1, 2, 3)
     *
     * @param element The element to prepend
     * @param target The target object
     * @return Object
     * */
    public static Func prepend = new PrependFunc();

    /**
     * Set the key value
     *
     * Example:
     * R.assoc.run('name', 'test', new Map<String, Object>())
     * // {name=test}
     *
     * @param key The key field
     * @param value The value of the key field
     * @param target The target object
     * @return Object
     * */
    public static Func assoc = new AssocFunc();

    /**
     * Remove the key value
     *
     * Example:
     * R.dissoc.run('name', new Map<String, Object>{ 'name' => 'test' })
     * // {}
     *
     * @param key The key field
     * @param target The target object
     * @return Object
     * */
    public static Func dissoc = new DissocFunc();

    /**
     * Concatenate two objects
     *
     * Example:
     * R.concat.run(R.with(1, 2, 3), R.with(4, 5, 6))
     * // (4, 5, 6, 1, 2, 3)
     *
     * @param arg1 The first object
     * @param arg2 The second object
     * @return Object
     * */
    public static Func concat = new ConcatFunc();

    /**
     * Get counts by the key
     *
     * Example:
     * R.countBy.run(R.identity, R.with(1, 2, 2))
     * // {1=1, 2=2}
     *
     * @param fn The key generating function
     * @param target The target object
     * @return Object
     * */
    public static Func countBy = new CountByFunc();

    /**
     * Get groups by the key
     *
     * Example:
     * R.groupBy.run(R.identity, R.with(1, 2, 2))
     * // {1=(1), 2=(2, 2)}
     *
     * @param fn The key generating function
     * @param target The target object
     * @return Object
     * */
    public static Func groupBy = new GroupByFunc();

    /**
     * Get indexes by the key
     *
     * Example:
     * R.indexBy.run(R.identity, R.with(1, 2, 2))
     * // {1=1, 2=2}
     *
     * @param fn The key generating function
     * @param target The target object
     * @return Object
     * */
    public static Func indexBy = new IndexByFunc();

    /**
     * Check starting with
     *
     * Example:
     * R.startsWith('a', 'abc')
     * // true
     *
     * @param pattern The pattern to check
     * @param target The target object
     * @return Object(Boolean)
     * */
    public static Func startsWith = new StartsWithFunc();

    /**
     * Check ending with
     *
     * Example:
     * R.endsWith('a', 'abc')
     * // false
     *
     * @param pattern The pattern to check
     * @param target The target object
     * @return Object(Boolean)
     * */
    public static Func endsWith = new EndsWithFunc();

    /**
     * Find the first element that matches the predicate
     *
     * Example:
     * R.find.run(R.equals.apply('a'), R.with('a', 'b'))
     * // a
     *
     * @param pred The predicate
     * @param target The target object
     * @return Object
     * */
    public static Func find = new FindFunc(false);

    /**
     * Find the first element from last that matches the predicate
     *
     * Example:
     * R.findLast.run(R.equals.apply('a'), R.with('a', 'b'))
     * // a
     *
     * @param pred The predicate
     * @param target The target object
     * @return Object
     * */
    public static Func findLast = new FindFunc(true);

    /**
     * Find the index of the first element that matches the predicate
     *
     * Example:
     * R.findIndex.run(R.equals.apply('a'), R.with('a', 'b'))
     * // 0
     *
     * @param pred The predicate
     * @param target The target object
     * @return Object(Integer)
     * */
    public static Func findIndex = new FindIndexFunc(false);

    /**
     * Find the index of the first element from last that matches the predicate
     *
     * Example:
     * R.findLastIndex.run(R.equals.apply('a'), R.with('a', 'b'))
     * // 0
     *
     * @param pred The predicate
     * @param target The target object
     * @return Object(Integer)
     * */
    public static Func findLastIndex = new FindIndexFunc(true);

    /**
     * Flatten the elements by one level
     *
     * Example:
     * R.unnest.run(R.with(1, R.with(2, 3)))
     * // (1, 2, 3)
     *
     * @param target The target object
     * @return Object(List<Object>)
     * */
    public static Func unnest = new UnnestFunc();

    /**
     * Flatten the elements recursively
     *
     * Example:
     * R.flatten.run(R.with(1, R.with(2, R.with(3))))
     * // (1, 2, 3)
     *
     * @param target The target object
     * @return Object(List<Object>)
     * */
    public static Func flatten = new FlattenFunc();

    /**
     * Create a pair
     *
     * Example:
     * R.pair.run(1, 2)
     * // Pair:[fst=1, snd=2]
     *
     * @param fst The first object
     * @param snd The second object
     * @return R.Pair
     * */
    public static Func pair = new PairFunc();

    /**
     * Convert a list of pairs to map
     *
     * Example:
     * R.fromPairs.run(R.with(new R.Pair('a', 1)))
     * // {a=1}
     *
     * @param pairs The list of pairs
     * @return Map<String, Object>
     * */
    public static Func fromPairs = new FromPairsFunc();

    /**
     * Convert a map to a list of pairs
     *
     * Example:
     * R.toPairs.run(new Map<String, Object>{ 'name' => 'test' })
     * // (Pair:[fst=name, snd=test])
     *
     * @param target The map
     * @return List<R.Pair>
     * */
    public static Func toPairs = new ToPairsFunc();

    /**
     * Get the first element
     *
     * Example:
     * R.first.run(R.with(1, 2, 3))
     * // 1
     *
     * @param target The target object
     * @return Object
     * */
    public static Func first = new FirstFunc();

    /**
     * Same as first
     *
     * @see first
     * */
    public static Func head = first;

    /**
     * Get the last element
     *
     * Example:
     * R.last.run(R.with(1, 2, 3))
     * // 3
     *
     * @param target The target object
     * @return Object
     * */
    public static Func last = new LastFunc();

    /**
     * Get the elements except the last
     *
     * Example:
     * R.init.run(R.with(1, 2, 3))
     * // (1, 2)
     *
     * @param target The target object
     * @return Object
     * */
    public static Func init = new InitFunc();

    /**
     * Get the elements except the first
     *
     * Example:
     * R.tail.run(R.with(1, 2, 3))
     * // (2, 3)
     *
     * @param target The target object
     * @return Object
     * */
    public static Func tail = new TailFunc();

    /**
     * Get the index of the first element found
     *
     * Example:
     * R.indexOf.run(1, R.with(1, 2, 3))
     * // 0
     *
     * @param element The element
     * @param target The target object
     * @return Integer
     * */
    public static Func indexOf = new IndexOfFunc(false);

    /**
     * Get the index of the first element found from the last
     *
     * Example:
     * R.lastIndexOf.run(1, R.with(1, 2, 3))
     * // 0
     *
     * @param element The element
     * @param target The target object
     * @return Integer
     * */
    public static Func lastIndexOf = new IndexOfFunc(true);

    /**
     * Insert element at the index
     *
     * Example:
     * R.doInsert.run(1, 'x', R.with(1, 2, 3))
     * // (1, x, 2, 3)
     *
     * @param index The index to insert
     * @param element The element to insert
     * @param target The target object
     * @return Object
     * */
    public static Func doInsert = new InsertFunc();

    /**
     * Insert elements at the index
     *
     * Example:
     * R.doInsertAll.run(1, R.with('x', 'y'), R.with(1, 2, 3))
     * // (1, x, y, 2, 3)
     *
     * @param index The index to insert
     * @param elements The elements to insert
     * @param target The target object
     * @return Object
     * */
    public static Func doInsertAll = new InsertAllFunc();

    /**
     * Join the elements by the separator
     *
     * Example:
     * R.doJoin.run('-', R.with(1, 2, 3))
     * // 1-2-3
     *
     * @param separator The separator string
     * @param target The target object
     * @return String
     * */
    public static Func doJoin = new JoinFunc();

    /**
     * Get the nth element
     *
     * Example:
     * R.nth.run(1, R.with(1, 2, 3))
     * // 2
     *
     * @param index The index of the element
     * @param target The target object
     * @return Object
     * */
    public static Func nth = new NthFunc();

    /**
     * Create a partitioned pair using the predicate
     *
     * Example:
     * R.partition.run(R.equals.apply('a'), R.with('a', 'b', 'c'))
     * // Pair:[fst=(a), snd=(b, c)]
     *
     * @param pred The predicate
     * @param target The target object
     * @return R.Pair
     * */
    public static Func partition = new PartitionFunc();

    /**
     * Project elements into other elements according to the fields
     *
     * Example:
     * R.project.run(R.with('Description'), R.with(new Account(Description='desc')))
     * // ({Description=desc})
     *
     * @param fields The list of fields
     * @param target The target object(List)
     * @return List<Object>
     * */
    public static Func project = new ProjectFunc();

    /**
     * Generate a range of decimals
     *
     * Example:
     * R.range.run(1, 3)
     * // (1, 2)
     *
     * @param first The first number(inclusive)
     * @param last The last number(exclusive)
     * @return List<Decimal>
     * */
    public static Func range = new RangeFunc();

    /**
     * Remove elements
     *
     * Example:
     * R.remove.run(1, 2, R.with(1, 2, 3))
     * // (1)
     *
     * @param first The index of the first object
     * @param count The number of elements to remove
     * @param target The target object
     * @return Object
     * */
    public static Func remove = new RemoveFunc();

    /**
     * Repeat the target to generate elements
     *
     * Example:
     * R.repeat.run(5, 'a')
     * // (a, a, a, a, a)
     *
     * @param count The number of repetition
     * @param target The target object to be repeated
     * @return List<Object>
     * */
    public static Func repeat = new RepeatFunc();

    /**
     * Invoke a function for N times
     *
     * Example:
     * R.times.run(3, R.identity)
     * // (0, 1, 2)
     *
     * @param count The number of repetition
     * @param fn The function to be invoked
     * @return List<Object>
     * */
    public static Func times = new TimesFunc();

    /**
     * Update an element of the elements
     *
     * Example:
     * R.doUpdate.run(1, 3, R.with(1, 2, 3))
     * // (1, 3, 3)
     *
     * @param index The index of the element to be updated
     * @param val The new value of the element
     * @param target The target object
     * @return Object
     * */
    public static Func doUpdate = new UpdateFunc();

    /**
     * Zip two collections to create a list of pairs
     *
     * Example:
     * R.zip.run(R.with('a', 'b'), R.with(1, 2))
     * // (Pair:[fst=a, snd=1], Pair:[fst=b, snd=2])
     *
     * @param arg1 The first object
     * @param arg2 The second object
     * @return List<R.Pair>
     * */
    public static Func zip = new ZipFunc(false);

    /**
     * Zip two collections to create a map
     *
     * Example:
     * R.zipObj.run(R.with('a', 'b'), R.with(1, 2))
     * // {a=1, b=2}
     *
     * @param arg1 The first object
     * @param arg2 The second object
     * @return Map<String, Object>
     * */
    public static Func zipObj = new ZipFunc(true);

    /**
     * Create a shuffled collection
     *
     * Example:
     * R.shuffle.run('abcdef')
     * // fdeabc
     *
     * @param target The target object
     * @return Object
     * */
    public static Func shuffle = new ShuffleFunc();

    /**
     * Get a list of random elements
     *
     * Example:
     * R.sampleSize.run(2, 'abcdef')
     * // df
     *
     * @param size The size of the result list
     * @param target The target object
     * @return List<Object>
     * */
    public static Func sampleSize = new SampleFunc();

    /**
     * Get a random element
     *
     * Example:
     * R.sample.run('abcdef')
     * // e
     *
     * @param target The target object
     * @return Object
     * */
    public static Func sample = (Func)R.pipe.run(
        R.sampleSize.apply(1),
        R.first
    );

    // ----------------------------------------------------------------------------
    // --   String                                                               --
    // ----------------------------------------------------------------------------

    /**
     * Check regex match
     *
     * Example:
     * R.match.run('.*(a).*', 'cat')
     * // (cat, a)
     *
     * @param pattern The regular expression pattern
     * @param target The target object
     * @return List<String> The matched groups
     * */
    public static Func match = new MatchFunc();

    /**
     * Replace the string with replacement, only for the first occurrence of the matching
     *
     * Example:
     * R.replace.run('cat', 'dog', 'I love cats')
     * // I love dogs
     *
     * @param pattern The pattern to search for
     * @param replacement The replacement string
     * @param target The target object
     * @return String
     * */
    public static Func replace = new ReplaceFunc(false);

    /**
     * Replace the string with replacement, for all occurrences of the matching
     *
     * Example:
     * R.replaceAll.run('cat', 'dog', 'I love cats')
     * // I love dogs
     *
     * @param pattern The pattern to search for
     * @param replacement The replacement string
     * @param target The target object
     * @return String
     * */
    public static Func replaceAll = new ReplaceFunc(true);

    /**
     * Split the string into a list
     *
     * Example:
     * R.split.run(' ', 'a b c')
     * // (a, b, c)
     *
     * @param separator The separator string
     * @param target The target object
     * @return List<String>
     * */
    public static Func split = new SplitFunc();

    /**
     * Test for the string matching
     *
     * Example:
     * R.test.run('.*a.*', 'cat')
     * // true
     *
     * @param pattern The regex pattern
     * @param target The target object
     * @return Boolean
     * */
    public static Func test = new TestFunc();

    /**
     * Convert the string into uppercase
     *
     * Example:
     * R.toUpper.run('abc')
     * // ABC
     *
     * @param target The target object
     * @return String
     * */
    public static Func toUpper = new ToUpperFunc();

    /**
     * Convert the string into lowercase
     *
     * Example:
     * R.toLower.run('ABC')
     * // abc
     *
     * @param target The target object
     * @return String
     * */
    public static Func toLower = new ToLowerFunc();

    /**
     * Trim the string
     *
     * Example:
     * R.trim.run(' abc ')
     * // abc
     *
     * @param target The target object
     * @return String
     * */
    public static Func trim = new TrimFunc();

    /**
     * Capitalize the string
     *
     * Example:
     * R.capitalize.run('cat')
     * // Cat
     *
     * @param target The target object
     * @return String
     * */
    public static Func capitalize = new CapitalizeFunc();

    /**
     * Pad the string to the length, with given padding
     *
     * Example:
     * R.pad.run(5, '*', 'cat')
     * // *cat*
     *
     * @param length The target length
     * @param padding The padding string
     * @param target The target object
     * @return String
     * */
    public static Func pad = new PadFunc(Padding.Both);

    /**
     * Pad the string to the left to the length, with given padding
     *
     * Example:
     * R.pad.run(5, '*', 'cat')
     * // **cat
     *
     * @param length The target length
     * @param padding The padding string
     * @param target The target object
     * @return String
     * */
    public static Func padLeft = new PadFunc(Padding.Left);

    /**
     * Pad the string to the right to the length, with given padding
     *
     * Example:
     * R.pad.run(5, '*', 'cat')
     * // cat**
     *
     * @param length The target length
     * @param padding The padding string
     * @param target The target object
     * @return String
     * */
    public static Func padRight = new PadFunc(Padding.Right);

    // ----------------------------------------------------------------------------
    // --   SObject && Map                                                       --
    // ----------------------------------------------------------------------------

    /**
     * Check if the wrapped object has a non-null value of the field
     *
     * Example:
     * R.has.run('Description', new Account())
     * // false
     *
     * @param field The name of the field
     * @param target The target object
     * @return Boolean
     * */
    public static Func has = new HasFunc();

    /**
     * Get the property value
     *
     * Example:
     * R.prop.run('Description', new Account(Description='desc'))
     * // desc
     *
     * @param field The name of the field
     * @param target The target object
     * @return Object
     * */
    public static Func prop = new PropFunc();

    /**
     * Get the property value
     *
     * Example:
     * R.path.run('Owner.Name', acc)
     * // desc
     *
     * @param field The fields, separated by '.'
     * @param target The target object
     * @return Object
     * */
    public static Func path = new PathFunc();

    /**
     * Get the property value by 'getSObject'
     *
     * @param field The name of the field
     * @param target The target object(SObject)
     * @return Object
     * */
    public static Func propSObject = new PropSObjectFunc();

    /**
     * Get the property value by 'getSObjects'
     *
     * @param field The name of the field
     * @param target The target object(SObject)
     * @return List<Object>
     * */
    public static Func propSObjects = new PropSObjectsFunc();

    /**
     * Check that its property value equals given value
     *
     * Example:
     * R.propEq.run('Description', 'desc', new Account(Description='desc'))
     * // true
     *
     * @param field The name of the field
     * @param value The value to be compared
     * @param target The target object
     * @return Boolean
     * */
    public static Func propEq = new PropEqFunc();

    /**
     * Get the property value, or return the default value if it is null
     *
     * Example:
     * R.propOr.run('Description', 'desc', new Account())
     * // desc
     *
     * @param field The name of the field
     * @param value The default value
     * @param target The target object
     * @return Object
     * */
    public static Func propOr = new PropOrFunc();

    /**
     * Check if the property value satisfies the predicate
     *
     * Example:
     * R.propSatisfies.run('Description', R.isNotNull, new Account())
     * // false
     *
     * @param field The name of the field
     * @param pred The predicate
     * @param target The target object
     * @return Boolean
     * */
    public static Func propSatisfies = new PropSatisfiesFunc();

    /**
     * Check if matching the key-values
     *
     * Example:
     * R.whereEq.run(R.withObj('Description', 'desc'), new Account(Description='desc'))
     * // true
     *
     * @param data The key-values to compare against
     * @param target The target object
     * @return Boolean
     * */
    public static Func whereEq = new WhereEqFunc();

    /**
     * Check if matching the key-predicates
     *
     * Example:
     * R.whereSatisfies.run(R.withObj('Description', R.isNotNull), new Account(Description='desc'))
     * // true
     *
     * @param specs The key-predicates
     * @param target The target object
     * @return Boolean
     * */
    public static Func whereSatisfies = new WhereSatisfiesFunc();

    /**
     * Invert the wrapped object, with values mapped by the same key added to a list
     *
     * Example:
     * R.invert.run(R.withObj('name', 'test'))
     * // {name=test}
     *
     * @param target The target object
     * @return Map<String, Object>
     * */
    public static Func invert = new InvertFunc(false);

    /**
     * Invert the wrapped object
     *
     * Example:
     * R.invertObj.run(R.withObj('name', 'test'))
     * // {name=test}
     *
     * @param target The target object
     * @return Map<String, Object>
     * */
    public static Func invertObj = new InvertFunc(true);

    /**
     * Get the keys
     *
     * Example:
     * R.keys.run(R.withObj('name', 'test'))
     * // {name}
     *
     * @param target The target object
     * @return Set<String>
     * */
    public static Func keys = new KeysFunc();

    /**
     * Get the values
     *
     * Example:
     * R.values.run(R.withObj('name', 'test'))
     * // (test)
     *
     * @param target The target object
     * @return List<Object>
     * */
    public static Func values = new ValuesFunc();

    /**
     * Merge the two objects
     *
     * Example:
     * R.doMerge.run(R.withObj('name', 'b'), R.withObj('name', 'a'))
     * // {name=b}
     *
     * @param arg1 The first object
     * @param arg2 The second object
     * @return Map<String, Object>
     * */
    public static Func doMerge = new MergeFunc();

    /**
     * Pick the fields into a map
     *
     * Example:
     * R.pick.run(R.with('Description'), new Account(Description='desc', FirstName='name'))
     * // {Description=desc}
     *
     * @param fields The fields to pick
     * @param target The target object
     * @return Map<String, Object>
     * */
    public static Func pick = new PickFunc();

    /**
     * Omit the fields and pick remaining fields into a map
     *
     * Example:
     * R.omit.run(R.with('Description'), new Account(Description='desc', FirstName='name'))
     * // {FirstName=name}
     *
     * @param fields The fields to pick
     * @param target The target object
     * @return Map<String, Object>
     * */
    public static Func omit = new OmitFunc();

    // ----------------------------------------------------------------------------
    // --   Utility                                                              --
    // ----------------------------------------------------------------------------

    /**
     * Check if it is null
     *
     * Example:
     * R.isNil.run(null)
     * // true
     *
     * @param target The target object
     * @return Boolean
     * */
    public static Func isNil = new IsNilFunc();

    /**
     * Same as isNil
     *
     * @see isNill
     * */
    public static Func isNull = isNil;

    /**
     * Check if it is not null
     *
     * Example:
     * R.isNotNil.run(null)
     * // false
     *
     * @param target The target object
     * @return Boolean
     * */
    public static Func isNotNil = (Func)R.complement.run(R.isNil);

    /**
     * Same as isNotNil
     *
     * @see isNotNil
     * */
    public static Func isNotNull = isNotNil;

    /**
     * Check if it is number
     *
     * Example:
     * R.isNumber.run(1)
     * // true
     *
     * @param target The target object
     * @return Boolean
     * */
    public static Func isNumber = new IsNumberFunc();

    /**
     * No op function
     *
     * Example:
     * R.noop.run()
     * // null
     *
     * @param <args> No argument will be used
     * @return null Meaningless null is returned
     * */
    public static Func noop = R.placeholder;

    /**
     * Default to a value
     *
     * Example:
     * R.defaultTo.run(5, null)
     * // 5
     *
     * @param defaultValue The default value
     * @param target The target object
     * @return Object
     * */
    public static Func defaultTo = new DefaultToFunc();

    /**
     * Get the clone
     *
     * Example:
     * R.doClone.run(new Account())
     * // Account:{}
     *
     * @param target The target object
     * @return Object
     * */
    public static Func doClone = new CloneFunc();

    /**
     * Print the debug log
     *
     * Example:
     * R.debug.run(1)
     * // 1
     *
     * @param <args> Arguments to debug
     * @return Object
     * */
    public static Func debug = new DebugFunc();

    /**
     * A function that always returns true
     *
     * Example:
     * R.T.run()
     * // true
     *
     * @return true
     * */
    public static Func T = (Func)R.always.run(true);

    /**
     * A function that always returns false
     *
     * Example:
     * R.F.run()
     * // false
     *
     * @return false
     * */
    public static Func F = (Func)R.always.run(false);

    /**
     * Remove any null value from the elements
     *
     * Example:
     * R.compact.run(R.with(1, null, 2))
     * // (1, 2)
     *
     * @param target The target object
     * @return List<Object>
     * */
    public static Func compact = R.filter.apply(R.isNotNil);

    /**
     * Do assert condition
     *
     * Example:
     * R.assert.run(1 == 1, 'should equal');
     *
     * @param condition The condition
     * @param msg The optional message
     * @return null
     * */
    public static Func assert = new AssertFunc();

    /**
     * Do assert equals
     *
     * Example:
     * R.assertEquals.run(1, 1, 'should equal');
     *
     * @param expected The expected value
     * @param actual The actual value
     * @param msg The optional message
     * @return null
     * */
    public static Func assertEquals = new AssertEqualsFunc();

    /**
     * Do assert not equals
     *
     * Example:
     * R.assertNotEquals.run(1, 2, 'should not equal');
     *
     * @param expected The expected value
     * @param actual The actual value
     * @param msg The optional message
     * @return null
     * */
    public static Func assertNotEquals = new AssertNotEqualsFunc();

    // ----------------------------------------------------------------------------
    // --   DML                                                                  --
    // ----------------------------------------------------------------------------

    /**
     * Query SObject(s) from database
     *
     * Example:
     * R.dbQuery.run('SELECT Id FROM Account');
     *
     * @param query The query string
     * @return Object
     * */
    public static Func dbQuery = new DbQueryFunc();

    /**
     * Insert SObject(s) to database
     *
     * Example:
     * R.dbInsert.run(new Account());
     *
     * @param obj The SObject(s)
     * @return Object
     * */
    public static Func dbInsert = new DbInsertFunc();

    /**
     * Update SObject(s) to database
     *
     * Example:
     * R.dbUpdate.run(acc);
     *
     * @param obj The SObject(s)
     * @return Object
     * */
    public static Func dbUpdate = new DbUpdateFunc();

    /**
     * Delete SObject(s) to database
     *
     * Example:
     * R.dbDelete.run(acc);
     *
     * @param obj The SObject(s)
     * @return Object
     * */
    public static Func dbDelete = new DbDeleteFunc();

    // EOF(End of Function List)

    public static final Map<String, Func> API = new Map<String, Func>{
        'toBoolean' => toBoolean,
        'toBooleanList' => toBooleanList,
        'toBooleanMap' => toBooleanMap,
        'toInteger' => toInteger,
        'toIntegerList' => toIntegerList,
        'toIntegerMap' => toIntegerMap,
        'toLong' => toLong,
        'toLongList' => toLongList,
        'toLongMap' => toLongMap,
        'toDouble' => toDouble,
        'toDoubleList' => toDoubleList,
        'toDoubleMap' => toDoubleMap,
        'toDecimal' => toDecimal,
        'toDecimalList' => toDecimalList,
        'toDecimalMap' => toDecimalMap,
        'toString' => toString,
        'isStringLike' => isStringLike,
        'toStringList' => toStringList,
        'toStringMap' => toStringMap,
        'toCharList' => toCharList,
        'toDate' => toDate,
        'toDateList' => toDateList,
        'toDateMap' => toDateMap,
        'toTime' => toTime,
        'toTimeList' => toTimeList,
        'toTimeMap' => toTimeMap,
        'toDatetime' => toDatetime,
        'toDatetimeList' => toDatetimeList,
        'toDatetimeMap' => toDatetimeMap,
        'toFunc' => toFunc,
        'isFuncLike' => isFuncLike,
        'toFuncList' => toFuncList,
        'toFuncMap' => toFuncMap,
        'toList' => toList,
        'isListLike' => isListLike,
        'toSet' => toSet,
        'toIdSet' => toIdSet,
        'isSetLike' => isSetLike,
        'toMap' => toMap,
        'isMapLike' => isMapLike,
        'toMapList' => toMapList,
        'toPair' => toPair,
        'isPairLike' => isPairLike,
        'toPairList' => toPairList,
        'toPairMap' => toPairMap,
        'toSObject' => toSObject,
        'isSObjectLike' => isSObjectLike,
        'toSObjectList' => toSObjectList,
        'toSObjectMap' => toSObjectMap,
        'add' => add,
        'subtract' => subtract,
        'multiply' => multiply,
        'divide' => divide,
        'mod' => mod,
        'inc' => inc,
        'dec' => dec,
        'negate' => negate,
        'product' => product,
        'allPass' => allPass,
        'anyPass' => anyPass,
        'complement' => complement,
        'doAnd' => doAnd,
        'doOr' => doOr,
        'doNot' => doNot,
        'equals' => equals,
        'lt' => lt,
        'lte' => lte,
        'gt' => gt,
        'gte' => gte,
        'min' => min,
        'max' => max,
        'placeholder' => placeholder,
        'pipe' => pipe,
        'compose' => compose,
        'flip' => flip,
        'converge' => converge,
        'useWith' => useWith,
        'identity' => identity,
        'always' => always,
        'constant' => constant,
        'throwException' => throwException,
        'once' => once,
        'memoize' => memoize,
        'nAry' => nAry,
        'unary' => unary,
        'binary' => binary,
        'transform' => transform,
        'applySpec' => applySpec,
        'juxt' => juxt,
        'evolve' => evolve,
        'comparator' => comparator,
        'compare' => compare,
        'ascend' => ascend,
        'descend' => descend,
        'cascade' => cascade,
        'clamp' => clamp,
        'cond' => cond,
        'ifElse' => ifElse,
        'doWhen' => doWhen,
        'unless' => unless,
        'forEach' => forEach,
        'filter' => filter,
        'reject' => reject,
        'doMap' => doMap,
        'biMap' => biMap,
        'pluck' => pluck,
        'reduce' => reduce,
        'length' => length,
        'size' => size,
        'isEmpty' => isEmpty,
        'isNotEmpty' => isNotEmpty,
        'sum' => sum,
        'slice' => slice,
        'take' => take,
        'takeRight' => takeRight,
        'takeWhile' => takeWhile,
        'takeRightWhile' => takeRightWhile,
        'drop' => drop,
        'dropRight' => dropRight,
        'dropWhile' => dropWhile,
        'dropRightWhile' => dropRightWhile,
        'reverse' => reverse,
        'sortBy' => sortBy,
        'sortDefault' => sortDefault,
        'contains' => contains,
        'containsBy' => containsBy,
        'containsKey' => containsKey,
        'uniq' => uniq,
        'union' => union,
        'intersection' => intersection,
        'xor' => xor,
        'difference' => difference,
        'without' => without,
        'adjust' => adjust,
        'all' => all,
        'every' => every,
        'some' => some,
        'none' => none,
        'append' => append,
        'prepend' => prepend,
        'assoc' => assoc,
        'dissoc' => dissoc,
        'concat' => concat,
        'countBy' => countBy,
        'groupBy' => groupBy,
        'indexBy' => indexBy,
        'startsWith' => startsWith,
        'endsWith' => endsWith,
        'find' => find,
        'findLast' => findLast,
        'findIndex' => findIndex,
        'findLastIndex' => findLastIndex,
        'unnest' => unnest,
        'flatten' => flatten,
        'pair' => pair,
        'fromPairs' => fromPairs,
        'toPairs' => toPairs,
        'first' => first,
        'head' => head,
        'last' => last,
        'init' => init,
        'tail' => tail,
        'indexOf' => indexOf,
        'lastIndexOf' => lastIndexOf,
        'doInsert' => doInsert,
        'doInsertAll' => doInsertAll,
        'doJoin' => doJoin,
        'nth' => nth,
        'partition' => partition,
        'project' => project,
        'range' => range,
        'remove' => remove,
        'repeat' => repeat,
        'times' => times,
        'doUpdate' => doUpdate,
        'zip' => zip,
        'zipObj' => zipObj,
        'shuffle' => shuffle,
        'sampleSize' => sampleSize,
        'sample' => sample,
        'match' => match,
        'replace' => replace,
        'replaceAll' => replaceAll,
        'split' => split,
        'test' => test,
        'toUpper' => toUpper,
        'toLower' => toLower,
        'trim' => trim,
        'capitalize' => capitalize,
        'pad' => pad,
        'padLeft' => padLeft,
        'padRight' => padRight,
        'has' => has,
        'prop' => prop,
        'propSObject' => propSObject,
        'propSObjects' => propSObjects,
        'propEq' => propEq,
        'propOr' => propOr,
        'propSatisfies' => propSatisfies,
        'whereEq' => whereEq,
        'whereSatisfies' => whereSatisfies,
        'invert' => invert,
        'invertObj' => invertObj,
        'keys' => keys,
        'values' => values,
        'doMerge' => doMerge,
        'pick' => pick,
        'omit' => omit,
        'isNil' => isNil,
        'isNull' => isNull,
        'isNotNil' => isNotNil,
        'isNotNull' => isNotNull,
        'isNumber' => isNumber,
        'noop' => noop,
        'defaultTo' => defaultTo,
        'doClone' => doClone,
        'debug' => debug,
        'T' => T,
        'F' => F,
        'compact' => compact,
        'assert' => assert,
        'assertEquals' => assertEquals,
        'assertNotEquals' => assertNotEquals,
        'dbInsert' => dbInsert,
        'dbUpdate' => dbUpdate,
        'dbDelete' => dbDelete,
        'path' => path
    };


    // ----------------------------------------------------------------------------
    // --   Local Common Functions                                               --
    // ----------------------------------------------------------------------------
    private static Map<String, Object> functionalCache = new Map<String, Object>();
    private static Map<String, Pattern> patternCache = new Map<String, Pattern>();
    private static List<Object> EMPTY_LIST = new List<Object>();
    private static Set<String> EMPTY_SET = new Set<String>();
    private static Map<String, Object> EMPTY_MAP = new Map<String, Object>();
    private static String EMPTY_STRING = '';

    private static Object doClone(Object source) {
        return R.doClone.run(source);
    }

    private static List<Func> toFuncList(Object arg) {
        return toFuncList(arg, false);
    }

    private static List<Func> toFuncList(Object arg, Boolean reverse) {
        if(!reverse) {
            return (List<Func>)R.toFuncList.run(arg);
        }
        else {
            return (List<Func>)R.toFuncList.run(R.reverse.run(arg));
        }
    }

    private static Integer getIndexInRange(Integer index, Integer size) {
        return index < 0 ? size + index : index;
    }

    private static Boolean isNumber(Object target) {
        return (Boolean)R.isNumber.run(target);
    }

    private static Boolean toBoolean(Object arg) {
        return (Boolean)R.toBoolean.run(arg);
    }

    private static Integer toInteger(Object arg) {
        return (Integer)R.toInteger.run(arg);
    }

    private static Long toLong(Object arg) {
        return (Long)R.toLong.run(arg);
    }

    private static Decimal toDecimal(Object arg) {
        return (Decimal)R.toDecimal.run(arg);
    }

    private static List<Decimal> toDecimalList(Object arg) {
        return (List<Decimal>)R.toDecimalList.run(arg);
    }

    private static Double toDouble(Object arg) {
        return (Double)R.toDouble.run(arg);
    }

    private static String toString(Object arg) {
        return (String)R.toString.run(arg);
    }

    private static List<String> toCharList(Object arg) {
        return (List<String>)R.toCharList.run(arg);
    }

    private static Boolean isStringLike(Object arg) {
        return (Boolean)R.isStringLike.run(arg);
    }

    private static Date toDate(Object arg) {
        return (Date)R.toDate.run(arg);
    }

    private static Time toTime(Object arg) {
        return (Time)R.toTime.run(arg);
    }

    private static Datetime toDatetime(Object arg) {
        return (Datetime)R.toDatetime.run(arg);
    }

    private static Func toFunc(Object arg) {
        return (Func)R.toFunc.run(arg);
    }

    private static Boolean isSObjectLike(Object arg) {
        return (Boolean)R.isSObjectLike.run(arg);
    }

    private static SObject toSObject(Object arg) {
        return (SObject)R.toSObject.run(arg);
    }

    private static List<Object> toList(Object arg) {
        return (List<Object>)R.toList.run(arg);
    }

    private static List<Integer> toIntegerList(Object arg) {
        return (List<Integer>)R.toIntegerList.run(arg);
    }

    private static List<String> toStringList(Object arg) {
        return (List<String>)R.toStringList.run(arg);
    }

    private static Boolean isListLike(Object arg) {
        return (Boolean)R.isListLike.run(arg);
    }

    private static Set<String> toSet(Object arg) {
        return (Set<String>)R.toSet.run(arg);
    }

    private static Boolean isSetLike(Object arg) {
        return (Boolean)R.isSetLike.run(arg);
    }

    private static Map<String, Object> toMap(Object arg) {
        return (Map<String, Object>)R.toMap.run(arg);
    }

    private static Boolean isMapLike(Object arg) {
        return (Boolean)R.isMapLike.run(arg);
    }

    private static List<Map<String, Object>> toMapList(Object arg) {
        return (List<Map<String, Object>>)R.toMapList.run(arg);
    }

    private static Pair toPair(Object arg) {
        return (Pair)R.toPair.run(arg);
    }

    private static Boolean isPairLike(Object arg) {
        return (Boolean)R.isPairLike.run(arg);
    }

    private static List<Pair> toPairList(Object arg) {
        return (List<Pair>)R.toPairList.run(arg);
    }

    private static Map<String, Pair> toPairMap(Object arg) {
        return (Map<String, Pair>)R.toPairMap.run(arg);
    }

    private static Map<String, Func> toFuncMap(Object arg) {
        return (Map<String, Func>)R.toFuncMap.run(arg);
    }

    private static Boolean isFuncLike(Object arg) {
        return (Boolean)R.isFuncLike.run(arg);
    }

    private static List<Object> slice(Integer first, Integer last, List<Object> mList) {
        return (List<Object>)R.slice.run(first, last, mList);
    }

    private static List<Object> slice(Integer first, List<Object> mList) {
        return slice(first, mList.size(), mList);
    }

    private static Integer compare(Object a, Object b) {
        return (Integer)R.compare.run(a, b);
    }

    private static Boolean equals(Object a, Object b) {
        return (Boolean)R.equals.run(a, b);
    }

    private static Object getNthElement(Integer index, List<Object> args) {
        return R.nth.run(index, args);
    }

    // ----------------------------------------------------------------------------
    // --   Helper classes                                                       --
    // ----------------------------------------------------------------------------
    private class ComparableWrapper implements Comparable {
        private Object val;
        private Func comparator;

        public ComparableWrapper(Object val, Func comparator) {
            this.val = val;
            this.comparator = comparator;
        }

        public Object getVal() {
            return this.val;
        }

        public Integer compareTo(Object other) {
            Object otherVal = ((ComparableWrapper)other).val;

            return toInteger(this.comparator.run(this.val, otherVal));
        }
    }

    public class Pair {
        public Object fst;
        public Object snd;

        public Pair(Object fst, Object snd) {
            this.fst = fst;
            this.snd = snd;
        }

        public Boolean equals(Object other) {
            if(other instanceof Pair) {
                Pair otherPair = (Pair)other;

                return this.fst == otherPair.fst && this.snd == otherPair.snd;
            }

            return false;
        }

        public Integer hashCode() {
            return (this.fst == null ? 0 : this.fst.hashCode()) + (this.snd == null ? 0 : this.snd.hashCode());
        }
    }

    public enum Padding {
        Left,
        Right,
        Both
    }


    // ----------------------------------------------------------------------------
    // --   Intermediate Helper Function Classes                                 --
    // ----------------------------------------------------------------------------
    private class FuncList extends Func {
        private List<Func> funcs;

        public FuncList(List<Func> funcs) {
            this.funcs = funcs;
        }

        public override Object execN(List<Object> args) {
            Object ret = this.funcs.get(0).runN(args);

            for(Integer i = 1; i < this.funcs.size(); i++) {
                ret = this.funcs.get(i).run(ret);
            }

            return ret;
        }
    }

    private class FuncAll extends Func {
        private List<Func> funcs;

        public FuncAll(List<Func> funcs) {
            this.funcs = funcs;
        }

        public override Object execN(List<Object> args) {
            for(Func func : this.funcs) {
                Boolean pass = toBoolean(func.runN(args));
                if(!pass) {
                    return false;
                }
            }

            return true;
        }
    }

    private class FuncAny extends Func {
        private List<Func> funcs;

        public FuncAny(List<Func> funcs) {
            this.funcs = funcs;
        }

        public override Object execN(List<Object> args) {
            for(Func func : this.funcs) {
                Boolean pass = toBoolean(func.runN(args));
                if(pass) {
                    return true;
                }
            }

            return false;
        }
    }

    private class FuncComplement extends Func {
        private Func target;

        public FuncComplement(Func target) {
            this.target = target;
        }

        public override Object execN(List<Object> args) {
            Boolean pass = toBoolean(this.target.runN(args));
            return !pass;
        }
    }

    private class FuncCond extends Func {
        private List<Func> funcs;

        public FuncCond(List<Func> funcs) {
            this.funcs = funcs;
        }

        public override Object execN(List<Object> args) {
            for(Integer i = 0; i < this.funcs.size() - 1; i += 2) {
                Func pred = this.funcs.get(i);
                Boolean pass = toBoolean(pred.runN(args));
                if(pass) {
                    Func next = this.funcs.get(i + 1);
                    return next.runN(args);
                }
            }

            throw new Func.FuncException('Case left unhandled');
        }
    }

    private class FuncIfElse extends Func {
        private List<Func> funcs;

        public FuncIfElse(List<Func> funcs) {
            this.funcs = funcs;
        }

        public override Object execN(List<Object> args) {
            if(this.funcs.size() >= 3) {
                Func pred = this.funcs.get(0);
                Func next = this.funcs.get(1);
                Func otherwise = this.funcs.get(2);
                Boolean pass = toBoolean(pred.runN(args));
                if(pass) {
                    return next.runN(args);
                }
                else {
                    return otherwise.runN(args);
                }
            }

            throw new Func.FuncException('at least 3 function objects are needed');
        }
    }

    private class FuncWhen extends Func {
        private List<Func> funcs;

        public FuncWhen(List<Func> funcs) {
            this.funcs = funcs;
        }

        public override Object execN(List<Object> args) {
            if(this.funcs.size() >= 2) {
                Func pred = this.funcs.get(0);
                Func next = this.funcs.get(1);
                Boolean pass = toBoolean(pred.runN(args));
                if(pass) {
                    return next.runN(args);
                }
            }

            return args;
        }
    }

    private class FuncUnless extends Func {
        private List<Func> funcs;

        public FuncUnless(List<Func> funcs) {
            this.funcs = funcs;
        }

        public override Object execN(List<Object> args) {
            if(this.funcs.size() >= 2) {
                Func pred = this.funcs.get(0);
                Func next = this.funcs.get(1);
                Boolean pass = toBoolean(pred.runN(args));
                if(!pass) {
                    return next.runN(args);
                }
            }

            return args;
        }
    }

    private class FuncAlways extends Func {
        private Object val;

        public FuncAlways(Object val) {
            this.val = val;
        }

        public override Object execN(List<Object> args) {
            return this.val;
        }
    }

    private class FuncFlip extends Func {
        private Func targetF;

        public FuncFlip(Func targetF) {
            this.targetF = targetF;
        }

        public override Object execN(List<Object> args) {
            if(args.size() >= 2) {
                Object arg1 = args.get(0);
                Object arg2 = args.get(1);
                args.set(0, arg2);
                args.set(1, arg1);
            }

            return this.targetF.runN(args);
        }
    }

    private class FuncConverge extends Func {
        private List<Func> funcs;

        public FuncConverge(List<Func> funcs) {
            this.funcs = funcs;
        }

        public override Object execN(List<Object> args) {
            Func targetF = this.funcs.get(0);
            List<Object> newArgs = new List<Object>();
            for(Integer i = 1; i < this.funcs.size(); i++) {
                newArgs.add(this.funcs.get(i).runN(args));
            }

            return targetF.runN(newArgs);
        }
    }

    private class FuncUseWith extends Func {
        private List<Func> funcs;

        public FuncUseWith(List<Func> funcs) {
            this.funcs = funcs;
        }

        public override Object execN(List<Object> args) {
            Func targetF = this.funcs.get(0);
            List<Object> newArgs = new List<Object>();
            for(Integer i = 1; i < this.funcs.size(); i++) {
                Object newArg = null;
                if(i - 1 < args.size()) {
                    newArg = args.get(i - 1);
                }
                newArgs.add(this.funcs.get(i).run(newArg));
            }

            return targetF.runN(newArgs);
        }
    }

    private class FuncOnce extends Func {
        private Func targetF;
        private String name;

        public FuncOnce(Func targetF, String name) {
            this.targetF = targetF;
            this.name = name;
        }

        public override Object execN(List<Object> args) {
            Boolean invoked = functionalCache.containsKey(this.name);
            if(!invoked) {
                functionalCache.put(this.name, this.targetF.runN(args));
            }

            return functionalCache.get(this.name);
        }
    }

    private class FuncMemoize extends Func {
        private Func targetF;
        private String name;
        private Func fn;

        public FuncMemoize(Func targetF, String name, Func fn) {
            this.targetF = targetF;
            this.name = name;
            this.fn = fn;
        }

        public override Object execN(List<Object> args) {
            String key = this.name + '_' + toString(fn.runN(args));
            if(!functionalCache.containsKey(key)) {
                functionalCache.put(key, this.targetF.runN(args));
            }

            return functionalCache.get(key);
        }
    }

    private class FuncNAry extends Func {
        private Integer arity;
        private Func fn;

        public FuncNAry(Integer arity, Func fn) {
            this.arity = arity;
            this.fn = fn;
        }

        public override Object execN(List<Object> args) {
            List<Object> newArgs = new List<Object>();
            for(Integer i = 0; i < this.arity; i++) {
                if(i < args.size()) {
                    newArgs.add(args.get(i));
                }
                else {
                    newArgs.add(null);
                }
            }

            return this.fn.runN(newArgs);
        }
    }

    private class FuncComparator extends Func {
        private Func fn;

        public FuncComparator(Func fn) {
            this.fn = fn;
        }

        public override Object exec(Object arg1, Object arg2) {
            Boolean ret = toBoolean(this.fn.run(arg1, arg2));

            return ret ? -1 : 1;
        }
    }

    private class FuncSortDirection extends Func {
        private Func fn;
        private Boolean isAscend;

        public FuncSortDirection(Func fn, Boolean isAscend) {
            this.fn = fn;
            this.isAscend = isAscend;
        }

        public override Object exec(Object arg1, Object arg2) {
            Object val1 = this.fn.run(arg1);
            Object val2 = this.fn.run(arg2);
            Integer ret = toInteger(R.compare.run(val1, val2));
            return this.isAscend ? ret : -ret;
        }
    }

    private class FuncCascade extends Func {
        private List<Func> funcs;

        public FuncCascade(List<Func> funcs) {
            this.funcs = funcs;
        }

        public override Object exec(Object arg1, Object arg2) {
            for(Func fn : this.funcs) {
                Integer ret = toInteger(fn.run(arg1, arg2));
                if(ret != 0) {
                    return ret;
                }
            }

            return 0;
        }
    }

    private class FuncComparable extends Func {
        private Comparable comp;

        public FuncComparable(Comparable comp) {
            this.comp = comp;
        }

        public override Object exec(Object arg) {
            return this.comp.compareTo(arg);
        }
    }


    // ----------------------------------------------------------------------------
    // --   Function Classes                                                     --
    // ----------------------------------------------------------------------------
    private class ToBooleanFunc extends Func {
        public ToBooleanFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            if(arg == null) {
                return false;
            }
            else if(arg instanceof Boolean) {
                return (Boolean)arg;
            }
            else if(arg instanceof Integer) {
                return (Integer)arg != 0;
            }
            else if(arg instanceof Long) {
                return (Long)arg != 0;
            }
            else if(arg instanceof Double) {
                return (Double)arg != 0;
            }
            else if(arg instanceof Decimal) {
                return (Decimal)arg != 0;
            }
            else if(arg instanceof String) {
                return Boolean.valueOf((String)arg);
            }
            else {
                return true;
            }
        }
    }

    private class ToBooleanListFunc extends Func {
        public ToBooleanListFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            List<Object> mList = toList(arg);
            List<Boolean> newList = new List<Boolean>();

            for (Object obj : mList) {
                newList.add(toBoolean(obj));
            }

            return newList;
        }
    }

    private class ToBooleanMapFunc extends Func {
        public ToBooleanMapFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            Map<String, Object> mMap = toMap(arg);
            Map<String, Boolean> newMap = new Map<String, Boolean>();

            for (String key : mMap.keySet()) {
                Object val = mMap.get(key);
                newMap.put(key, toBoolean(val));
            }

            return newMap;
        }
    }

    private class ToIntegerFunc extends Func {
        public ToIntegerFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            if(arg == null) {
                return null;
            }
            else if(arg instanceof Integer) {
                return (Integer)arg;
            }
            else if(arg instanceof Long) {
                return ((Long)arg).intValue();
            }
            else if(arg instanceof Double) {
                return ((Double)arg).intValue();
            }
            else if(arg instanceof Decimal) {
                return ((Decimal)arg).intValue();
            }
            else if(arg instanceof String) {
                return Integer.valueOf((String)arg);
            }

            throw new Func.FuncException('Cannot convert arg to Integer');
        }
    }

    private class ToIntegerListFunc extends Func {
        public ToIntegerListFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            List<Object> mList = toList(arg);
            List<Integer> newList = new List<Integer>();

            for (Object obj : mList) {
                newList.add(toInteger(obj));
            }

            return newList;
        }
    }

    private class ToIntegerMapFunc extends Func {
        public ToIntegerMapFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            Map<String, Object> mMap = toMap(arg);
            Map<String, Integer> newMap = new Map<String, Integer>();

            for (String key : mMap.keySet()) {
                Object val = mMap.get(key);
                newMap.put(key, toInteger(val));
            }

            return newMap;
        }
    }

    private class ToLongFunc extends Func {
        public ToLongFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            if(arg == null) {
                return null;
            }
            else if(arg instanceof Long) {
                return (Long)arg;
            }
            else if(arg instanceof Integer) {
                return (Integer)arg;
            }
            else if(arg instanceof Decimal) {
                return ((Decimal)arg).longValue();
            }
            else if(arg instanceof Double) {
                return ((Double)arg).longValue();
            }
            else if(arg instanceof String) {
                return Long.valueOf((String)arg);
            }

            throw new Func.FuncException('Cannot convert arg to Long');
        }
    }

    private class ToLongListFunc extends Func {
        public ToLongListFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            List<Object> mList = toList(arg);
            List<Long> newList = new List<Long>();

            for (Object obj : mList) {
                newList.add(toLong(obj));
            }

            return newList;
        }
    }

    private class ToLongMapFunc extends Func {
        public ToLongMapFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            Map<String, Object> mMap = toMap(arg);
            Map<String, Long> newMap = new Map<String, Long>();

            for (String key : mMap.keySet()) {
                Object val = mMap.get(key);
                newMap.put(key, toLong(val));
            }

            return newMap;
        }
    }

    private class ToDoubleFunc extends Func {
        public ToDoubleFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            if(arg == null) {
                return null;
            }
            else if(arg instanceof Double) {
                return (Double)arg;
            }
            else if(arg instanceof Integer) {
                return (Integer)arg;
            }
            else if(arg instanceof Long) {
                return (Long)arg;
            }
            else if(arg instanceof Decimal) {
                return ((Decimal)arg).doubleValue();
            }
            else if(arg instanceof String) {
                return Double.valueOf((String)arg);
            }

            throw new Func.FuncException('Cannot convert arg to Double');
        }
    }

    private class ToDoubleListFunc extends Func {
        public ToDoubleListFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            List<Object> mList = toList(arg);
            List<Double> newList = new List<Double>();

            for (Object obj : mList) {
                newList.add(toDouble(obj));
            }

            return newList;
        }
    }

    private class ToDoubleMapFunc extends Func {
        public ToDoubleMapFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            Map<String, Object> mMap = toMap(arg);
            Map<String, Double> newMap = new Map<String, Double>();

            for (String key : mMap.keySet()) {
                Object val = mMap.get(key);
                newMap.put(key, toDouble(val));
            }

            return newMap;
        }
    }

    private class ToDecimalFunc extends Func {
        public ToDecimalFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            if(arg == null) {
                return null;
            }
            else if(arg instanceof Decimal) {
                return (Decimal)arg;
            }
            else if(arg instanceof Double) {
                return Decimal.valueOf((Double)arg);
            }
            else if(arg instanceof Integer) {
                return Decimal.valueOf((Integer)arg);
            }
            else if(arg instanceof Long) {
                return Decimal.valueOf((Long)arg);
            }
            else if(arg instanceof String) {
                return Decimal.valueOf((String)arg);
            }

            throw new Func.FuncException('Cannot convert arg to Decimal');
        }
    }

    private class ToDecimalListFunc extends Func {
        public ToDecimalListFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            List<Object> mList = toList(arg);
            List<Decimal> newList = new List<Decimal>();

            for (Object obj : mList) {
                newList.add(toDecimal(obj));
            }

            return newList;
        }
    }

    private class ToDecimalMapFunc extends Func {
        public ToDecimalMapFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            Map<String, Object> mMap = toMap(arg);
            Map<String, Decimal> newMap = new Map<String, Decimal>();

            for (String key : mMap.keySet()) {
                Object val = mMap.get(key);
                newMap.put(key, toDecimal(val));
            }

            return newMap;
        }
    }

    private class ToStringFunc extends Func {
        public ToStringFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            if(arg == null) {
                return null;
            }
            else if(arg instanceof R && ((R)arg).isString()) {
                return ((R)arg).toString();
            }
            else if(arg instanceof Datetime) {
                return JSON.serialize(arg).replaceAll('"', '');
            }
            else if(arg instanceof Map<String, Object>) {
                return JSON.serialize(arg);
            }
            else if(arg instanceof List<Object>) {
                return JSON.serialize(arg);
            } else {
                return String.valueOf(arg);
            }
        }
    }

    private class IsStringLikeFunc extends Func {
        public IsStringLikeFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            return arg != null && arg instanceof String;
        }
    }

    private class ToStringListFunc extends Func {
        public ToStringListFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            List<Object> mList = toList(arg);
            List<String> newList = new List<String>();

            for (Object obj : mList) {
                newList.add(toString(obj));
            }

            return newList;
        }
    }

    private class ToStringMapFunc extends Func {
        public ToStringMapFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            Map<String, Object> mMap = toMap(arg);
            Map<String, String> newMap = new Map<String, String>();

            for (String key : mMap.keySet()) {
                Object val = mMap.get(key);
                newMap.put(key, toString(val));
            }

            return newMap;
        }
    }

    private class ToCharListFunc extends Func {
        public ToCharListFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            String str = toString(arg);
            List<String> newList = null;

            if(str == null || str == '') {
                newList = new List<String>();
            }
            else {
                newList = str.split('');
            }

            return newList;
        }
    }

    private class ToDateFunc extends Func {
        public ToDateFunc() {
            super(1);
        }

        private Date getDate(Long millis) {
            return Datetime.newInstance(millis).date();
        }

        public override Object exec(Object arg) {
            if(arg == null) {
                return null;
            }
            else if(arg instanceof Date) {
                return (Date)arg;
            }
            else if(arg instanceof Datetime) {
                return ((Datetime)arg).date();
            }
            else if(arg instanceof Integer) {
                Long millis = (Long)arg;
                return getDate(millis);
            }
            else if(arg instanceof Long) {
                Long millis = (Long)arg;
                return getDate(millis);
            }
            else if(arg instanceof Double) {
                Long millis = ((Double)arg).longValue();
                return getDate(millis);
            }
            else if(arg instanceof Decimal) {
                Long millis = ((Decimal)arg).longValue();
                return getDate(millis);
            }
            else if(arg instanceof String) {
                try {
                    return Date.valueOf((String)arg);
                } catch (Exception e1) {
                    try {
                        if (String.isBlank((String)arg)) {
                            System.debug(LoggingLevel.Error, 'Cannot convert this value to Date:' + arg);
                            return null;
                        }
                        return JSON.deserialize('"' + arg + '"', Date.class);
                    } catch (Exception e2) {
                        System.debug(LoggingLevel.Error, e2);
                        return null;
                    }
                }
            }

            throw new Func.FuncException('Cannot convert arg to Date');
        }
    }

    private class ToDateListFunc extends Func {
        public ToDateListFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            List<Object> mList = toList(arg);
            List<Date> newList = new List<Date>();

            for (Object obj : mList) {
                newList.add(toDate(obj));
            }

            return newList;
        }
    }

    private class ToDateMapFunc extends Func {
        public ToDateMapFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            Map<String, Object> mMap = toMap(arg);
            Map<String, Date> newMap = new Map<String, Date>();

            for (String key : mMap.keySet()) {
                Object val = mMap.get(key);
                newMap.put(key, toDate(val));
            }

            return newMap;
        }
    }

    private class ToTimeFunc extends Func {
        public ToTimeFunc() {
            super(1);
        }

        private Time getTime(Long millis) {
            return Datetime.newInstance(millis).time();
        }

        public override Object exec(Object arg) {
            if(arg == null) {
                return null;
            }
            else if(arg instanceof Time) {
                return (Time)arg;
            }
            else if(arg instanceof Integer) {
                Long millis = (Long)arg;
                return getTime(millis);
            }
            else if(arg instanceof Long) {
                Long millis = (Long)arg;
                return getTime(millis);
            }
            else if(arg instanceof Double) {
                Long millis = ((Double)arg).longValue();
                return getTime(millis);
            }
            else if(arg instanceof Decimal) {
                Long millis = ((Decimal)arg).longValue();
                return getTime(millis);
            }

            throw new Func.FuncException('Cannot convert arg to Time');
        }
    }

    private class ToTimeListFunc extends Func {
        public ToTimeListFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            List<Object> mList = toList(arg);
            List<Time> newList = new List<Time>();

            for (Object obj : mList) {
                newList.add(toTime(obj));
            }

            return newList;
        }
    }

    private class ToTimeMapFunc extends Func {
        public ToTimeMapFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            Map<String, Object> mMap = toMap(arg);
            Map<String, Time> newMap = new Map<String, Time>();

            for (String key : mMap.keySet()) {
                Object val = mMap.get(key);
                newMap.put(key, toTime(val));
            }

            return newMap;
        }
    }

    private class ToDatetimeFunc extends Func {
        public ToDatetimeFunc() {
            super(1);
        }

        private Datetime getDatetime(Long millis) {
            return Datetime.newInstance(millis);
        }

        private Datetime getDatetime(Date d) {
            return Datetime.newInstance(d.year(), d.month(), d.day());
        }

        public override Object exec(Object arg) {
            if(arg == null) {
                return null;
            }
            else if(arg instanceof Date) {
                return getDatetime((Date)arg);
            }
            else if(arg instanceof Datetime) {
                return (Datetime)arg;
            }
            else if(arg instanceof Integer) {
                Long millis = (Long)arg;
                return getDatetime(millis);
            }
            else if(arg instanceof Long) {
                Long millis = (Long)arg;
                return getDatetime(millis);
            }
            else if(arg instanceof Double) {
                Long millis = ((Double)arg).longValue();
                return getDatetime(millis);
            }
            else if(arg instanceof Decimal) {
                Long millis = ((Decimal)arg).longValue();
                return getDatetime(millis);
            }
            else if(arg instanceof String) {
                try {
                    return Datetime.valueOf((String)arg);
                } catch (Exception e1) {
                    try {
                        if (String.isBlank((String)arg)) {
                            System.debug(LoggingLevel.Error, 'Cannot convert this value to Datetime:' + arg);
                            return null;
                        }
                        return JSON.deserialize('"' + arg + '"', Datetime.class);
                    } catch (Exception e2) {
                        System.debug(LoggingLevel.Error, e2);
                        return null;
                    }
                }
            }

            throw new Func.FuncException('Cannot convert arg to Datetime');
        }
    }

    private class ToDatetimeListFunc extends Func {
        public ToDatetimeListFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            List<Object> mList = toList(arg);
            List<Datetime> newList = new List<Datetime>();

            for (Object obj : mList) {
                newList.add(toDatetime(obj));
            }

            return newList;
        }
    }

    private class ToDatetimeMapFunc extends Func {
        public ToDatetimeMapFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            Map<String, Object> mMap = toMap(arg);
            Map<String, Datetime> newMap = new Map<String, Datetime>();

            for (String key : mMap.keySet()) {
                Object val = mMap.get(key);
                newMap.put(key, toDatetime(val));
            }

            return newMap;
        }
    }

    private class IsFuncLikeFunc extends Func {
        public IsFuncLikeFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            return arg != null && (arg instanceof Func || arg instanceof Comparable);
        }
    }

    private class ToFuncFunc extends Func {
        public ToFuncFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            if(arg == null) {
                return R.identity;
            }
            else if(arg instanceof Func) {
                return (Func)arg;
            }
            else if(arg instanceof Comparable) {
                return new FuncComparable((Comparable)arg);
            }

            throw new Func.FuncException('Cannot convert arg to Func');
        }
    }

    private class ToFuncListFunc extends Func {
        public ToFuncListFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            List<Object> mList = toList(arg);
            List<Func> newList = new List<Func>();

            for (Object obj : mList) {
                newList.add(toFunc(obj));
            }

            return newList;
        }
    }

    private class ToFuncMapFunc extends Func {
        public ToFuncMapFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            Map<String, Object> mMap = toMap(arg);
            Map<String, Func> newMap = new Map<String, Func>();

            for (String key : mMap.keySet()) {
                Object val = mMap.get(key);
                newMap.put(key, toFunc(val));
            }

            return newMap;
        }
    }

    private class IsSObjectLikeFunc extends Func {
        public IsSObjectLikeFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            return arg != null && arg instanceof SObject;
        }
    }

    private class ToSObjectFunc extends Func {
        public ToSObjectFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            if(arg == null) {
                return null;
            }
            else if(arg instanceof SObject) {
                return (SObject)arg;
            }
            else if(arg instanceof R && ((R)arg).toObject() instanceof SObject) {
                return ((SObject)((R)arg).toObject());
            }

            throw new Func.FuncException('Cannot convert arg to SObject');
        }
    }

    private class ToSObjectListFunc extends Func {
        public ToSObjectListFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            List<Object> mList = toList(arg);
            List<SObject> newList = new List<SObject>();

            for (Object obj : mList) {
                newList.add(toSObject(obj));
            }

            return newList;
        }
    }

    private class ToSObjectMapFunc extends Func {
        public ToSObjectMapFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            Map<String, Object> mMap = toMap(arg);
            Map<String, SObject> newMap = new Map<String, SObject>();

            for (String key : mMap.keySet()) {
                Object val = mMap.get(key);
                newMap.put(key, toSObject(val));
            }

            return newMap;
        }
    }

    private class ToListFunc extends Func {
        public ToListFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            List<Object> newList = null;
            if(arg == null) {
                newList = new List<Object>();
            }
            else if(arg instanceof List<Object>) {
                newList = (List<Object>)arg;
            }
            else if(arg instanceof R && ((R)arg).isList()) {
                newList = ((R)arg).toList();
            }
            else if(arg instanceof Pair) {
                Pair mPair = (Pair)arg;
                newList = new List<Object>{ mPair.fst, mPair.snd };
            }
            else if(arg instanceof String) {
                try {
                    newList = (List<Object>)JSON.deserializeUntyped((String)arg);
                } catch(Exception e) {
                    System.debug(LoggingLevel.Error, 'ERROR (toList): ' + e);
                }
            }
            else {
                newList = new List<Object>();
            }

            return newList;
        }
    }

    private class IsListLikeFunc extends Func {
        public IsListLikeFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            return arg != null && (
                 arg instanceof List<Object> ||
                 (arg instanceof R && ((R)arg).isList()) ||
                 arg instanceof Pair
             );
        }
    }

    private class ToSetFunc extends Func {
        public ToSetFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            Set<String> newSet = new Set<String>();
            if(arg == null) {
            }
            else if(arg instanceof Set<String>) {
                newSet = (Set<String>)arg;
            }
            else if(arg instanceof Set<Id>) {
                for (Id id : (Set<Id>)arg) {
                    newSet.add(id);
                }
            }
            else if(arg instanceof List<Object>) {
                for (Object obj : (List<Object>)arg) {
                    newSet.add((String)obj);
                }
            }
            else if(arg instanceof R &&
                    (((R)arg).isSet() || ((R)arg).isList())) {
                newSet = ((R)arg).toSet();
            }

            return newSet;
        }
    }

    private class ToIdSetFunc extends Func {
        public ToIdSetFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            Set<Id> newSet = new Set<Id>();
            if(arg == null) {
            }
            else if(arg instanceof Set<Id>) {
                newSet = (Set<Id>)arg;
            }
            else if(arg instanceof Set<String>) {
                for (String str : (Set<String>)arg) {
                    newSet.add(str);
                }
            }
            else if(arg instanceof List<Object>) {
                for (Object obj : (List<Object>)arg) {
                    newSet.add((Id)obj);
                }
            }
            else if(arg instanceof R &&
                    (((R)arg).isSet() || ((R)arg).isList())) {
                newSet = ((R)arg).toIdSet();
            }

            return newSet;
        }
    }

    private class IsSetLikeFunc extends Func {
        public IsSetLikeFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            return arg != null && (
                    arg instanceof Set<String> ||
                    (arg instanceof R && ((R)arg).isSet())
                );
        }
    }

    private class ToMapFunc extends Func {
        public ToMapFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            Map<String, Object> newMap = null;
            if(arg == null) {
                newMap = new Map<String, Object>();
            }
            else if(arg instanceof Map<String, Object>) {
                newMap = (Map<String, Object>)arg;
            }
            else if(arg instanceof SObject) {
                newMap = ((SObject)arg).getPopulatedFieldsAsMap();
            }
            else if(arg instanceof R && ((R)arg).isMap()) {
                newMap = ((R)arg).toMap();
            }
            else if(arg instanceof Map<Object, Object>) {
                newMap = new Map<String, Object>();
                Map<Object, Object> srcMap = (Map<Object, Object>)arg;
                for(Object key : srcMap.keySet()) {
                    Object value = srcMap.get(key);
                    newMap.put(toString(key), value);
                }
            }
            else if(arg instanceof String) {
                try {
                    newMap = (Map<String, Object>)JSON.deserializeUntyped((String)arg);
                } catch(Exception e) {
                    System.debug(LoggingLevel.Error, 'ERROR (toMap): ' + e);
                }
            }
            else {
                try {
                    newMap = (Map<String, Object>)JSON.deserializeUntyped(JSON.serialize(arg));
                } catch(Exception e) {
                    System.debug(LoggingLevel.Error, 'ERROR (toMap): ' + e);
                }
            }

            return newMap;
        }
    }

    private class IsMapLikeFunc extends Func {
        public IsMapLikeFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            return arg != null && (
                    arg instanceof Map<String, Object> ||
                    (arg instanceof R && ((R)arg).isMap()) ||
                    arg instanceof SObject
                );
        }
    }

    private class ToMapListFunc extends Func {
        public ToMapListFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            List<Object> mList = toList(arg);
            List<Map<String, Object>> newList = new List<Map<String, Object>>();

            for (Object obj : mList) {
                newList.add(toMap(obj));
            }

            return newList;
        }
    }

    private class ToPairFunc extends Func {
        public ToPairFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            Pair newPair = null;
            if(arg == null) {
                newPair = new Pair(null, null);
            }
            else if(arg instanceof Pair) {
                newPair = (Pair)arg;
            }
            else if(isListLike(arg)) {
                List<Object> mList = toList(arg);
                newPair = new Pair(getNthElement(0, mList), getNthElement(1, mList));
            }
            else {
                newPair = new Pair(arg, arg);
            }

            return newPair;
        }
    }

    private class IsPairLikeFunc extends Func {
        public IsPairLikeFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            return arg != null && (arg instanceof Pair);
        }
    }

    private class ToPairListFunc extends Func {
        public ToPairListFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            List<Object> mList = toList(arg);
            List<Pair> newList = new List<Pair>();

            for (Object obj : mList) {
                newList.add(toPair(obj));
            }

            return newList;
        }
    }

    private class ToPairMapFunc extends Func {
        public ToPairMapFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            Map<String, Object> mMap = toMap(arg);
            Map<String, Pair> newMap = new Map<String, Pair>();

            for (String key : mMap.keySet()) {
                Object val = mMap.get(key);
                newMap.put(key, toPair(val));
            }

            return newMap;
        }
    }

    private class AddFunc extends Func {
        public AddFunc() {
            super(2);
        }

        public override Object exec(Object a, Object b) {
            Decimal d1 = toDecimal(a);
            Decimal d2 = toDecimal(b);
            if (d1 == null) d1 = 0;
            if (d2 == null) d2 = 0;
            return d1 + d2;
        }
    }

    private class SubtractFunc extends Func {
        public SubtractFunc() {
            super(2);
        }

        public override Object exec(Object a, Object b) {
            Decimal d1 = toDecimal(a);
            Decimal d2 = toDecimal(b);
            if (d1 == null) d1 = 0;
            if (d2 == null) d2 = 0;
            return d1 - d2;
        }
    }

    private class MultiplyFunc extends Func {
        public MultiplyFunc() {
            super(2);
        }

        public override Object exec(Object a, Object b) {
            Decimal d1 = toDecimal(a);
            Decimal d2 = toDecimal(b);
            if (d1 == null) d1 = 0;
            if (d2 == null) d2 = 0;
            return d1 * d2;
        }
    }

    private class DivideFunc extends Func {
        public DivideFunc() {
            super(2);
        }

        public override Object exec(Object a, Object b) {
            Decimal d1 = toDecimal(a);
            Decimal d2 = toDecimal(b);
            if (d1 == null) d1 = 0;
            if (d2 == null) d2 = 0;
            return d1 / d2;
        }
    }

    private class ModFunc extends Func {
        public ModFunc() {
            super(2);
        }

        public override Object exec(Object a, Object b) {
            Long d1 = toLong(a);
            Long d2 = toLong(b);
            if (d1 == null) d1 = 0;
            if (d2 == null) d2 = 0;
            return Math.mod(d1, d2);
        }
    }

    private class PipeFunc extends Func {
        public override Object execN(List<Object> args) {
            return new FuncList(toFuncList(args));
        }
    }

    private class ComposeFunc extends Func {
        public override Object execN(List<Object> args) {
            return new FuncList(toFuncList(args, true));
        }
    }

    private class DebugFunc extends Func {
        public override Object execN(List<Object> args) {
            if(args.size() == 1) {
                System.debug(args.get(0));
            }
            else {
                System.debug(args);
            }
            return args;
        }
    }

    private class IsNilFunc extends Func {
        public IsNilFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            return arg == null;
        }
    }

    private class IsNumberFunc extends Func {
        public IsNumberFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            return arg instanceof Integer ||
                arg instanceof Long ||
                arg instanceof Double ||
                arg instanceof Decimal;
        }
    }

    private class AllPassFunc extends Func {
        public override Object execN(List<Object> args) {
            return new FuncAll(toFuncList(args));
        }
    }

    private class AnyPassFunc extends Func {
        public override Object execN(List<Object> args) {
            return new FuncAny(toFuncList(args));
        }
    }

    private class ComplementFunc extends Func {
        public ComplementFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            return new FuncComplement(toFunc(arg));
        }
    }

    private class AndFunc extends Func {
        public override Object execN(List<Object> args) {
            for(Object arg : args) {
                Boolean b = toBoolean(arg);
                if(!b) {
                    return false;
                }
            }

            return true;
        }
    }

    private class OrFunc extends Func {
        public override Object execN(List<Object> args) {
            for(Object arg : args) {
                Boolean b = toBoolean(arg);
                if(b) {
                    return true;
                }
            }

            return false;
        }
    }

    private class NotFunc extends Func {
        public NotFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            Boolean b = toBoolean(arg);
            return !b;
        }
    }

    private class EqualsFunc extends Func {
        public EqualsFunc() {
            super(2);
        }

        public override Object exec(Object a, Object b) {
            return (a == null && b == null) ||
                (a != null && a.equals(b));
        }
    }

    private class LtFunc extends Func {
        public LtFunc() {
            super(2);
        }

        public override Object exec(Object a, Object b) {
            Decimal d1 = toDecimal(a);
            Decimal d2 = toDecimal(b);
            return d1 < d2;
        }
    }

    private class LteFunc extends Func {
        public LteFunc() {
            super(2);
        }

        public override Object exec(Object a, Object b) {
            Decimal d1 = toDecimal(a);
            Decimal d2 = toDecimal(b);
            return d1 <= d2;
        }
    }

    private class GtFunc extends Func {
        public GtFunc() {
            super(2);
        }

        public override Object exec(Object a, Object b) {
            Decimal d1 = toDecimal(a);
            Decimal d2 = toDecimal(b);
            return d1 > d2;
        }
    }

    private class GteFunc extends Func {
        public GteFunc() {
            super(2);
        }

        public override Object exec(Object a, Object b) {
            Decimal d1 = toDecimal(a);
            Decimal d2 = toDecimal(b);
            return d1 >= d2;
        }
    }

    private class PlaceholderFunc extends Func {
        public override Object execN(List<Object> args) {
            return null;
        }
    }

    private class IdentityFunc extends Func {
        public override Object execN(List<Object> args) {
            return args.isEmpty() ? null : args.get(0);
        }
    }

    private class CondFunc extends Func {
        public override Object execN(List<Object> args) {
            return new FuncCond(toFuncList(args));
        }
    }

    private class IfElseFunc extends Func {
        public override Object execN(List<Object> args) {
            return new FuncIfElse(toFuncList(args));
        }
    }

    private class WhenFunc extends Func {
        public override Object execN(List<Object> args) {
            return new FuncWhen(toFuncList(args));
        }
    }

    private class UnlessFunc extends Func {
        public override Object execN(List<Object> args) {
            return new FuncUnless(toFuncList(args));
        }
    }

    private class AlwaysFunc extends Func {
        public override Object execN(List<Object> args) {
            Object arg = args.isEmpty() ? null : args.get(0);
            return new FuncAlways(arg);
        }
    }

    private class ConstantFunc extends Func {
        public override Object execN(List<Object> args) {
            Object arg = args.isEmpty() ? null : args.get(0);
            return arg;
        }
    }

    private class ThrowExcpetionFunc extends Func {
        public ThrowExcpetionFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            if(arg instanceof Exception) {
                throw (Exception)arg;
            }

            return arg;
        }
    }

    private class FlipFunc extends Func {
        public FlipFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            return new FuncFlip(toFunc(arg));
        }
    }

    private class ConvergeFunc extends Func {
        public override Object execN(List<Object> args) {
            return new FuncConverge(toFuncList(args));
        }
    }

    private class UseWithFunc extends Func {
        public override Object execN(List<Object> args) {
            return new FuncUseWith(toFuncList(args));
        }
    }

    private class OnceFunc extends Func {
        public OnceFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            return new FuncOnce(toFunc(arg1), toString(arg2));
        }
    }

    private class MemoizeFunc extends Func {
        public MemoizeFunc() {
            super(3);
        }

        public override Object exec(Object arg1, Object arg2, Object arg3) {
            return new FuncMemoize(toFunc(arg1), toString(arg2), toFunc(arg3));
        }
    }

    private class HasFunc extends Func {
        public HasFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            String field = toString(arg1);
            Map<String, Object> data = toMap(arg2);
            return data.containsKey(field);
        }
    }

    private class PropFunc extends Func {
        public PropFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            String field = toString(arg1);
            Map<String, Object> data = toMap(arg2);
            return data.get(field);
        }
    }

    private class PathFunc extends Func {
        public PathFunc() {
            super(2);
        }

        private Object getValue(Map<String, Object> mMap, List<String> items) {
            String field = items.get(0);
            Object value = mMap.get(field);

            if(isMapLike(value) && items.size() > 1) {
                Map<String, Object> subMap = toMap(value);
                items.remove(0);
                return this.getValue(subMap, items);
            }
            else {
                return value;
            }
        }

        public override Object exec(Object arg1, Object arg2) {
            String field = toString(arg1);
            Map<String, Object> mMap = toMap(arg2);

            List<String> items = field.split('\\.');

            return this.getValue(mMap, items);
        }
    }

    private class PropEqFunc extends Func {
        public PropEqFunc() {
            super(3);
        }

        public override Object exec(Object arg1, Object arg2, Object arg3) {
            String field = toString(arg1);
            Object val = arg2;
            Map<String, Object> data = toMap(arg3);
            return equals(val, data.get(field));
        }
    }

    private class PropOrFunc extends Func {
        public PropOrFunc() {
            super(3);
        }

        public override Object exec(Object arg1, Object arg2, Object arg3) {
            String field = toString(arg1);
            Object defaultVal = arg2;
            Map<String, Object> data = toMap(arg3);
            Object val = data.get(field);
            return val == null ? defaultVal : val;
        }
    }

    private class PropSatisfiesFunc extends Func {
        public PropSatisfiesFunc() {
            super(3);
        }

        public override Object exec(Object arg1, Object arg2, Object arg3) {
            String field = toString(arg1);
            Func pred = toFunc(arg2);
            Map<String, Object> data = toMap(arg3);
            Object val = data.get(field);
            return pred.run(val);
        }
    }

    private class WhereEqFunc extends Func {
        public WhereEqFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            Map<String, Object> data = toMap(arg1);
            for(String key : data.keySet()) {
                Object val = data.get(key);
                Map<String, Object> m = toMap(arg2);
                Boolean pass = toBoolean(equals(m.get(key), val));
                if(!pass) {
                    return false;
                }
            }

            return true;
        }
    }

    private class WhereSatisfiesFunc extends Func {
        public WhereSatisfiesFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            Map<String, Func> data = toFuncMap(arg1);
            for(String key : data.keySet()) {
                Func pred = data.get(key);
                Map<String, Object> m = toMap(arg2);
                Object val = m.get(key);
                Boolean pass = toBoolean(pred.run(val));
                if(!pass) {
                    return false;
                }
            }

            return true;
        }
    }

    private class PropSObjectFunc extends Func {
        public PropSObjectFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            String field = toString(arg1);
            SObject sObj = toSObject(arg2);
            return sObj.getSObject(field);
        }
    }

    private class PropSObjectsFunc extends Func {
        public PropSObjectsFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            String field = toString(arg1);
            SObject sObj = toSObject(arg2);
            return sObj.getSObjects(field);
        }
    }

    private class NAryFunc extends Func {
        public NAryFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            Integer arity = toInteger(arg1);
            Func fn = toFunc(arg2);

            return new FuncNAry(arity, fn);
        }
    }

    private class ComparatorFunc extends Func {
        public ComparatorFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            Func fn = toFunc(arg);

            return new FuncComparator(fn);
        }
    }

    private class CompareFunc extends Func {
        public CompareFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            if(arg1 == null || arg2 == null) {
                return 0;
            }
            else if(isNumber(arg1) && isNumber(arg2)) {
                return (Integer)(toInteger(arg1) - toInteger(arg2));
            }
            else if(arg1 instanceof String && arg2 instanceof String) {
                return ((String)arg1).compareTo((String)arg2);
            }
            else if(arg1 instanceof Date && arg2 instanceof Date) {
                return (Date)arg1 < (Date)arg2 ? -1 : 1;
            }
            else if(arg1 instanceof Time && arg2 instanceof Time) {
                return (Time)arg1 < (Time)arg2 ? -1 : 1;
            }
            else if(arg1 instanceof DateTime && arg2 instanceof DateTime) {
                return (DateTime)arg1 < (DateTime)arg2 ? -1 : 1;
            }
            else if(arg1 instanceof Comparable && arg2 instanceof Comparable) {
                return ((Comparable)arg1).compareTo(arg2);
            }
            else {
                return 0;
            }
        }
    }

    private class AscendFunc extends Func {
        public AscendFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            Func fn = toFunc(arg);

            return new FuncSortDirection(fn, true);
        }
    }

    private class DescendFunc extends Func {
        public DescendFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            Func fn = toFunc(arg);

            return new FuncSortDirection(fn, false);
        }
    }

    private class CascadeFunc extends Func {
        public override Object execN(List<Object> args) {
            return new FuncCascade(toFuncList(args));
        }
    }

    private class ForEachFunc extends Func {
        public ForEachFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            Func fn = toFunc(arg1);
            if(isListLike(arg2)) {
                List<Object> mList = toList(arg2);
                for(Object obj : mList) {
                    fn.run(obj);
                }
            }
            else if(isSetLike(arg2)) {
                Set<String> mSet = toSet(arg2);
                for(String obj : mSet) {
                    fn.run(obj);
                }
            }
            else if(isMapLike(arg2)) {
                Map<String, Object> mMap = toMap(arg2);
                for(String key : mMap.keySet()) {
                    Object val = mMap.get(key);
                    fn.run(val, key);
                }
            }
            else if(isStringLike(arg2)) {
                List<String> mList = toCharList(arg2);
                for(String obj : mList) {
                    fn.run(obj);
                }
            }
            return arg2;
        }
    }

    private class FilterFunc extends Func {
        private Boolean reverse;

        public FilterFunc(Boolean reverse) {
            this.reverse = reverse;
        }

        private Boolean accept(Boolean pass) {
            return (pass && !reverse) || (!pass && reverse);
        }

        private Object filter(Func pred, Object target) {
            if(isListLike(target)) {
                List<Object> mList = toList(target);
                List<Object> newList = new List<Object>();
                for(Object obj : mList) {
                    Boolean pass = toBoolean(pred.run(obj));
                    if(accept(pass)) {
                        newList.add(obj);
                    }
                }
                return newList;
            }
            else if(isSetLike(target)) {
                Set<String> mSet = toSet(target);
                Set<String> newSet = new Set<String>();
                for(String obj : mSet) {
                    Boolean pass = toBoolean(pred.run(obj));
                    if(accept(pass)) {
                        newSet.add(obj);
                    }
                }
                return newSet;
            }
            else if(isMapLike(target)) {
                Map<String, Object> mMap = toMap(target);
                Map<String, Object> newMap = new Map<String, Object>();
                for(String key : mMap.keySet()) {
                    Object val = mMap.get(key);
                    Boolean pass = toBoolean(pred.run(val, key));
                    if(accept(pass)) {
                        newMap.put(key, val);
                    }
                }
                return newMap;
            }
            else if(isStringLike(target)) {
                List<String> mList = toCharList(target);
                List<String> newList = new List<String>();
                for(String obj : mList) {
                    Boolean pass = toBoolean(pred.run(obj));
                    if(accept(pass)) {
                        newList.add(obj);
                    }
                }
                return String.join(newList, '');
            }
            else {
                return target;
            }
        }

        public override Object exec(Object arg1, Object arg2) {
            if(isStringLike(arg1)) {
                String field = toString(arg1);
                return filter(
                    R.has.apply(field),
                    arg2
                );
            }
            else if(isFuncLike(arg1)) {
                Func pred = toFunc(arg1);
                return filter(
                    pred,
                    arg2
                );
            }
            else if(isMapLike(arg1)) {
                Map<String, Object> data = toMap(arg1);
                return filter(
                    R.whereEq.apply(data),
                    arg2
                );
            }

            throw new Func.FuncException('Invalid usage of filter');
        }

        public override Object exec(Object arg1, Object arg2, Object arg3) {
            String field = toString(arg1);
            Object val = arg2;
            return filter(
                R.propEq.apply(field, val),
                arg3
            );
        }
    }

    private class MapFunc extends Func {
        public MapFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            Func fn = toFunc(arg1);

            if(isListLike(arg2)) {
                List<Object> mList = toList(arg2);
                List<Object> newList = new List<Object>();
                for(Object obj: mList) {
                    newList.add(fn.run(obj));
                }
                return newList;
            }
            else if(isSetLike(arg2)) {
                Set<String> mSet = toSet(arg2);
                Set<String> newSet = new Set<String>();
                for(String obj: mSet) {
                    newSet.add(toString(fn.run(obj)));
                }
                return newSet;
            }
            else if(isMapLike(arg2)) {
                Map<String, Object> mMap = toMap(arg2);
                Map<String, Object> newMap = new Map<String, Object>();
                for(String key: mMap.keySet()) {
                    Object val = mMap.get(key);
                    newMap.put(key, fn.run(val, key));
                }
                return newMap;
            }
            else if(isStringLike(arg2)) {
                List<String> mList = toCharList(arg2);
                List<String> newList = new List<String>();
                for(String obj: mList) {
                    newList.add(toString(fn.run(obj)));
                }
                return String.join(newList, '');
            }
            else {
                return arg2;
            }
        }
    }

    private class BimapFunc extends Func {
        public override Object exec(Object arg1, Object arg2) {
            Func fnKey = toFunc(arg1);
            Map<String, Object> mMap = toMap(arg2);
            Map<String, Object> newMap = new Map<String, Object>();
            for(String key : mMap.keySet()) {
                Object val = mMap.get(key);
                String newKey = toString(fnKey.run(val, key));
                newMap.put(newKey, val);
            }

            return newMap;
        }

        public override Object exec(Object arg1, Object arg2, Object arg3) {
            Func fnKey = toFunc(arg1);
            Func fnValue = toFunc(arg2);
            Map<String, Object> mMap = toMap(arg3);
            Map<String, Object> newMap = new Map<String, Object>();
            for(String key : mMap.keySet()) {
                Object val = mMap.get(key);
                String newKey = toString(fnKey.run(val, key));
                Object newValue = fnValue.run(val, key);
                newMap.put(newKey, newValue);
            }

            return newMap;
        }
    }

    private class PluckFunc extends Func {
        public PluckFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            String field = toString(arg1);
            if(isListLike(arg2)) {
                List<Object> mList = toList(arg2);
                List<Object> newList = new List<Object>();
                for(Object obj: mList) {
                    newList.add(R.path.run(field, obj));
                }
                return newList;
            }
            else if(isMapLike(arg2)) {
                Map<String, Object> mMap = toMap(arg2);
                Map<String, Object> newMap = new Map<String, Object>();
                for(String key : mMap.keySet()) {
                    Object val = mMap.get(key);
                    newMap.put(key, R.path.run(field, val, key));
                }
                return newMap;
            }
            else {
                return arg2;
            }
        }
    }

    private class ReduceFunc extends Func {
        public ReduceFunc() {
            super(3);
        }

        public override Object exec(Object arg1, Object arg2, Object arg3) {
            Func reducer = toFunc(arg1);
            Object acc = arg2;
            if(isListLike(arg3)) {
                List<Object> mList = toList(arg3);
                for(Object obj: mList) {
                    acc = reducer.run(acc, obj);
                }
            }
            else if(isSetLike(arg3)) {
                Set<String> mSet = toSet(arg3);
                for(String obj: mSet) {
                    acc = reducer.run(acc, obj);
                }
            }
            else if(isMapLike(arg3)) {
                Map<String, Object> mMap = toMap(arg3);
                for(String key : mMap.keySet()) {
                    Object val = mMap.get(key);
                    acc = reducer.run(acc, new Pair(key, val));
                }
            }
            else if(isStringLike(arg3)) {
                List<String> mChars = toCharList(arg3);
                for(String mChar : mChars) {
                    acc = reducer.run(acc, mChar);
                }
            }

            return acc;
        }
    }

    private class SliceFunc extends Func {
        public SliceFunc() {
            super(-1);
        }

        public override Object exec(Object arg1, Object arg2) {
            Integer first = toInteger(arg1);
            Integer last = null;
            if(isListLike(arg2)) {
                List<Object> mList = toList(arg2);
                Integer size = mList.size();
                first = getIndexInRange(first, size);
                last = size;
                List<Object> newList = new List<Object>();
                if(first > last) {
                    return newList;
                }
                for(Integer i = first; i < last; i++) {
                    newList.add(mList.get(i));
                }
                return newList;
            }
            else if(isStringLike(arg2)) {
                List<String> mCharList = toCharList(arg2);
                Integer size = mCharList.size();
                first = getIndexInRange(first, size);
                last = size;
                List<String> newCharList = new List<String>();
                if(first > last) {
                    return '';
                }
                for(Integer i = first; i < last; i++) {
                    newCharList.add(mCharList.get(i));
                }
                return String.join(newCharList, '');
            }

            return arg2;
        }

        public override Object exec(Object arg1, Object arg2, Object arg3) {
            Integer first = toInteger(arg1);
            Integer last = toInteger(arg2);
            if(isListLike(arg3)) {
                List<Object> mList = toList(arg3);
                Integer size = mList.size();
                first = getIndexInRange(first, size);
                last = getIndexInRange(last, size);
                last = last > size ? size : last;
                List<Object> newList = new List<Object>();
                if(first > last) {
                    return newList;
                }
                for(Integer i = first; i < last; i++) {
                    newList.add(mList.get(i));
                }
                return newList;
            }
            else if(isStringLike(arg3)) {
                List<String> mCharList = toCharList(arg3);
                Integer size = mCharList.size();
                first = getIndexInRange(first, size);
                last = getIndexInRange(last, size);
                last = last > size ? size : last;
                List<String> newCharList = new List<String>();
                if(first > last) {
                    return '';
                }
                for(Integer i = first; i < last; i++) {
                    newCharList.add(mCharList.get(i));
                }
                return String.join(newCharList, '');
            }

            return arg3;
        }
    }

    private class TakeFunc extends Func {
        public TakeFunc() {
            super(3);
        }

        public override Object exec(Object arg1, Object arg2, Object arg3) {
            Boolean fromRight = toBoolean(arg1);
            if(isNumber(arg2)) {
                Integer num = toInteger(arg2);
                return fromRight ?
                    R.slice.run(-num, arg3):
                    R.slice.run(0, num, arg3);
            }
            else {
                Func pred = toFunc(arg2);
                if(isListLike(arg3)) {
                    List<Object> mList = toList(arg3);
                    List<Object> newList = new List<Object>();
                    if(fromRight) {
                        for(Integer i = mList.size() - 1 ; i >= 0; i--) {
                            Boolean pass = toBoolean(pred.run(mList.get(i)));
                            if(pass) {
                                newList.add(mList.get(i));
                            }
                            else {
                                newList = (List<Object>)R.reverse.run(newList);
                                break;
                            }
                        }
                    }
                    else {
                        for(Integer i = 0; i < mList.size(); i++) {
                            Boolean pass = toBoolean(pred.run(mList.get(i)));
                            if(pass) {
                                newList.add(mList.get(i));
                            }
                            else {
                                break;
                            }
                        }
                    }
                    return newList;
                }
                else if(isStringLike(arg3)) {
                    List<String> mCharList = toCharList(arg3);
                    List<String> newCharList = new List<String>();
                    if(fromRight) {
                        for(Integer i = mCharList.size() - 1 ; i >= 0; i--) {
                            Boolean pass = toBoolean(pred.run(mCharList.get(i)));
                            if(pass) {
                                newCharList.add(mCharList.get(i));
                            }
                            else {
                                newCharList = toStringList(R.reverse.run(newCharList));
                                break;
                            }
                        }
                    }
                    else {
                        for(Integer i = 0; i < mCharList.size(); i++) {
                            Boolean pass = toBoolean(pred.run(mCharList.get(i)));
                            if(pass) {
                                newCharList.add(mCharList.get(i));
                            }
                            else {
                                break;
                            }
                        }
                    }
                    return String.join(newCharList, '');
                }
            }

            return arg3;
        }
    }

    private class DropFunc extends Func {
        public DropFunc() {
            super(3);
        }

        public override Object exec(Object arg1, Object arg2, Object arg3) {
            Boolean fromRight = toBoolean(arg1);
            if(isNumber(arg2)) {
                Integer num = toInteger(arg2);
                return fromRight ?
                    R.slice.run(0, -num, arg3):
                    R.slice.run(num, arg3);
            }
            else {
                Func pred = toFunc(arg2);
                if(isListLike(arg3)) {
                    List<Object> mList = toList(arg3);
                    List<Object> newList = new List<Object>();
                    if(fromRight) {
                        Integer i = mList.size() - 1;
                        for( ; i >= 0; i--) {
                            Boolean pass = toBoolean(pred.run(mList.get(i)));
                            if(!pass) {
                                break;
                            }
                        }
                        for( ; i >= 0; i-- ) {
                            newList.add(mList.get(i));
                        }

                        newList = (List<Object>)R.reverse.run(newList);
                    }
                    else {
                        Integer i = 0;
                        for( ; i < mList.size(); i++) {
                            Boolean pass = toBoolean(pred.run(mList.get(i)));
                            if(!pass) {
                                break;
                            }
                        }
                        for( ; i < mList.size(); i++) {
                            newList.add(mList.get(i));
                        }
                    }
                    return newList;
                }
                else if(isStringLike(arg3)) {
                    List<String> mCharList = toCharList(arg3);
                    List<String> newCharList = new List<String>();
                    if(fromRight) {
                        Integer i = mCharList.size() - 1;
                        for( ; i >= 0; i--) {
                            Boolean pass = toBoolean(pred.run(mCharList.get(i)));
                            if(!pass) {
                                break;
                            }
                        }
                        for( ; i >= 0; i-- ) {
                            newCharList.add(mCharList.get(i));
                        }

                        newCharList = toStringList(R.reverse.run(newCharList));
                    }
                    else {
                        Integer i = 0;
                        for( ; i < mCharList.size(); i++) {
                            Boolean pass = toBoolean(pred.run(mCharList.get(i)));
                            if(!pass) {
                                break;
                            }
                        }
                        for( ; i < mCharList.size(); i++) {
                            newCharList.add(mCharList.get(i));
                        }
                    }
                    return String.join(newCharList, '');
                }
            }

            return arg3;
        }
    }

    private class ReverseFunc extends Func {
        public ReverseFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            if(isListLike(arg)) {
                List<Object> mList = toList(arg);
                List<Object> newList = new List<Object>();
                for(Integer i = mList.size() - 1; i >= 0; i--) {
                    newList.add(mList.get(i));
                }
                return newList;
            }
            else if(isStringLike(arg)) {
                List<String> mCharList = toCharList(arg);
                List<String> newCharList = new List<String>();
                for(Integer i = mCharList.size() - 1; i >= 0; i--) {
                    newCharList.add(mCharList.get(i));
                }
                return String.join(newCharList, '');
            }

            return arg;
        }
    }

    private class SortFunc extends Func {
        public SortFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            Func comparator = toFunc(arg1);
            if(isListLike(arg2)) {
                List<Object> mList = toList(arg2);
                List<ComparableWrapper> wrappers = new List<ComparableWrapper>();
                for(Object obj : mList) {
                    wrappers.add(new ComparableWrapper(obj, comparator));
                }
                wrappers.sort();
                List<Object> newList = new List<Object>();
                for(ComparableWrapper wrapper : wrappers) {
                    newList.add(wrapper.getVal());
                }
                return newList;
            }
            else if(isStringLike(arg2)) {
                List<String> mCharList = toCharList(arg2);
                List<ComparableWrapper> wrappers = new List<ComparableWrapper>();
                for(String obj : mCharList) {
                    wrappers.add(new ComparableWrapper(obj, comparator));
                }
                wrappers.sort();
                List<String> newCharList = new List<String>();
                for(ComparableWrapper wrapper : wrappers) {
                    newCharList.add(toString(wrapper.getVal()));
                }
                return String.join(newCharList, '');
            }

            return arg2;
        }
    }

    private class SortDefaultFunc extends Func {
        public SortDefaultFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            if(isListLike(arg)) {
                List<Object> mList = toList(arg);
                List<Object> newList = new List<Object>(mList);
                newList.sort();
                return newList;
            }
            else if(isStringLike(arg)) {
                List<String> mCharList = toCharList(arg);
                List<String> newCharList = new List<String>(mCharList);
                newCharList.sort();
                return String.join(newCharList, '');
            }

            return arg;
        }
    }

    private class ContainsFunc extends Func {
        public ContainsFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            Object target = arg1;
            if(isListLike(arg2)) {
                List<Object> mList = toList(arg2);
                for(Object obj : mList) {
                    Boolean matches = toBoolean(equals(obj, target));
                    if(matches) {
                        return true;
                    }
                }
            }
            else if(isSetLike(arg2)) {
                Set<String> mSet = toSet(arg2);
                for(String obj : mSet) {
                    Boolean matches = toBoolean(equals(obj, target));
                    if(matches) {
                        return true;
                    }
                }
            }
            else if(isMapLike(arg2)) {
                Map<String, Object> mMap = toMap(arg2);
                for(String key : mMap.keySet()) {
                    Object val = mMap.get(key);
                    Boolean matches = toBoolean(equals(val, target));
                    if(matches) {
                        return true;
                    }
                }
            }
            else if(isStringLike(arg2)) {
                List<String> mChars = toCharList(arg2);
                for(String mChar : mChars) {
                    Boolean matches = toBoolean(equals(mChar, target));
                    if(matches) {
                        return true;
                    }
                }
            }

            return false;
        }
    }

    private class ContainsByFunc extends Func {
        public ContainsByFunc() {
            super(3);
        }

        public override Object exec(Object arg1, Object arg2, Object arg3) {
            Func pred = toFunc(arg1);
            Object target = arg2;
            if(isListLike(arg3)) {
                List<Object> mList = toList(arg3);
                for(Object obj : mList) {
                    Boolean matches = toBoolean(pred.run(obj, target));
                    if(matches) {
                        return true;
                    }
                }
            }
            else if(isSetLike(arg3)) {
                Set<String> mSet = toSet(arg3);
                for(String obj : mSet) {
                    Boolean matches = toBoolean(pred.run(obj, target));
                    if(matches) {
                        return true;
                    }
                }
            }
            else if(isMapLike(arg3)) {
                Map<String, Object> mMap = toMap(arg3);
                for(String key : mMap.keySet()) {
                    Object val = mMap.get(key);
                    Boolean matches = toBoolean(pred.run(val, target));
                    if(matches) {
                        return true;
                    }
                }
            }
            else if(isStringLike(arg3)) {
                List<String> mChars = toCharList(arg3);
                for(String mChar : mChars) {
                    Boolean matches = toBoolean(pred.run(mChar, target));
                    if(matches) {
                        return true;
                    }
                }
            }

            return false;
        }
    }

    private class ContainsKeyFunc extends Func {
        public ContainsKeyFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            Object target = arg1;
            Map<String, Object> mMap = toMap(arg2);
            return mMap.containsKey(toString(target));
        }
    }

    private class TransformFunc extends Func {
        public TransformFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            Func fn = toFunc(arg1);

            return fn.run(arg2);
        }
    }

    private class UniqFunc extends Func {
        public UniqFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            List<Object> mList = toList(arg);
            Set<Object> mSet = new Set<Object>();
            List<Object> newList = new List<Object>();

            for(Object obj : mList) {
                Boolean exists = mSet.contains(obj);
                if(!exists) {
                    mSet.add(obj);
                    newList.add(obj);
                }
            }

            return newList;
        }
    }

    private class UnionFunc extends Func {
        public UnionFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            if(isListLike(arg1) && isListLike(arg2)) {
                List<Object> mList1 = toList(arg1);
                List<Object> mList2 = toList(arg2);
                List<Object> newList = new List<Object>();
                for(Object obj : mList2) {
                    Boolean exists = toBoolean(R.contains.run(obj, newList));
                    if(!exists) {
                        newList.add(obj);
                    }
                }
                for(Object obj : mList1) {
                    Boolean exists = toBoolean(R.contains.run(obj, newList));
                    if(!exists) {
                        newList.add(obj);
                    }
                }
                return newList;
            }
            else if(isSetLike(arg1) && isSetLike(arg2)) {
                Set<String> mSet1 = toSet(arg1);
                Set<String> mSet2 = toSet(arg2);
                Set<String> newSet = new Set<String>();
                for(String obj : mSet2) {
                    Boolean exists = toBoolean(R.contains.run(obj, newSet));
                    if(!exists) {
                        newSet.add(obj);
                    }
                }
                for(String obj : mSet1) {
                    Boolean exists = toBoolean(R.contains.run(obj, newSet));
                    if(!exists) {
                        newSet.add(obj);
                    }
                }
                return newSet;
            }
            else if(isStringLike(arg1) && isStringLike(arg2)) {
                List<String> mCharList1 = toCharList(arg1);
                List<String> mCharList2 = toCharList(arg2);
                List<String> newCharList = new List<String>();
                for(String obj : mCharList2) {
                    Boolean exists = toBoolean(R.contains.run(obj, newCharList));
                    if(!exists) {
                        newCharList.add(obj);
                    }
                }
                for(String obj : mCharList1) {
                    Boolean exists = toBoolean(R.contains.run(obj, newCharList));
                    if(!exists) {
                        newCharList.add(obj);
                    }
                }
                return String.join(newCharList, '');
            }

            return arg1;
        }
    }

    private class IntersectionFunc extends Func {
        public IntersectionFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            if(isListLike(arg1) && isListLike(arg2)) {
                List<Object> mList1 = toList(arg1);
                List<Object> mList2 = toList(arg2);
                List<Object> newList = new List<Object>();
                for(Object obj : mList2) {
                    Boolean exists = toBoolean(R.contains.run(obj, newList));
                    Boolean existsInOther = toBoolean(R.contains.run(obj, mList1));
                    if(!exists && existsInOther) {
                        newList.add(obj);
                    }
                }
                for(Object obj : mList1) {
                    Boolean exists = toBoolean(R.contains.run(obj, newList));
                    Boolean existsInOther = toBoolean(R.contains.run(obj, mList2));
                    if(!exists && existsInOther) {
                        newList.add(obj);
                    }
                }
                return newList;
            }
            else if(isSetLike(arg1) && isSetLike(arg2)) {
                Set<String> mSet1 = toSet(arg1);
                Set<String> mSet2 = toSet(arg2);
                Set<String> newSet = new Set<String>();
                for(String obj : mSet2) {
                    Boolean exists = toBoolean(R.contains.run(obj, newSet));
                    Boolean existsInOther = toBoolean(R.contains.run(obj, mSet1));
                    if(!exists && existsInOther) {
                        newSet.add(obj);
                    }
                }
                for(String obj : mSet1) {
                    Boolean exists = toBoolean(R.contains.run(obj, newSet));
                    Boolean existsInOther = toBoolean(R.contains.run(obj, mSet2));
                    if(!exists && existsInOther) {
                        newSet.add(obj);
                    }
                }
                return newSet;
            }
            else if(isStringLike(arg1) && isStringLike(arg2)) {
                List<String> mCharList1 = toCharList(arg1);
                List<String> mCharList2 = toCharList(arg2);
                List<String> newCharList = new List<String>();
                for(String obj : mCharList2) {
                    Boolean exists = toBoolean(R.contains.run(obj, newCharList));
                    Boolean existsInOther = toBoolean(R.contains.run(obj, mCharList1));
                    if(!exists && existsInOther) {
                        newCharList.add(obj);
                    }
                }
                for(String obj : mCharList1) {
                    Boolean exists = toBoolean(R.contains.run(obj, newCharList));
                    Boolean existsInOther = toBoolean(R.contains.run(obj, mCharList2));
                    if(!exists && existsInOther) {
                        newCharList.add(obj);
                    }
                }
                return String.join(newCharList, '');
            }

            return arg1;
        }
    }

    private class XorFunc extends Func {
        public XorFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            if(isListLike(arg1) && isListLike(arg2)) {
                List<Object> mList1 = toList(arg1);
                List<Object> mList2 = toList(arg2);
                List<Object> newList = new List<Object>();
                for(Object obj : mList2) {
                    Boolean exists = toBoolean(R.contains.run(obj, newList));
                    Boolean existsInOther = toBoolean(R.contains.run(obj, mList1));
                    if(!exists && !existsInOther) {
                        newList.add(obj);
                    }
                }
                for(Object obj : mList1) {
                    Boolean exists = toBoolean(R.contains.run(obj, newList));
                    Boolean existsInOther = toBoolean(R.contains.run(obj, mList2));
                    if(!exists && !existsInOther) {
                        newList.add(obj);
                    }
                }
                return newList;
            }
            else if(isSetLike(arg1) && isSetLike(arg2)) {
                Set<String> mSet1 = toSet(arg1);
                Set<String> mSet2 = toSet(arg2);
                Set<String> newSet = new Set<String>();
                for(String obj : mSet2) {
                    Boolean exists = toBoolean(R.contains.run(obj, newSet));
                    Boolean existsInOther = toBoolean(R.contains.run(obj, mSet1));
                    if(!exists && !existsInOther) {
                        newSet.add(obj);
                    }
                }
                for(String obj : mSet1) {
                    Boolean exists = toBoolean(R.contains.run(obj, newSet));
                    Boolean existsInOther = toBoolean(R.contains.run(obj, mSet2));
                    if(!exists && !existsInOther) {
                        newSet.add(obj);
                    }
                }
                return newSet;
            }
            else if(isStringLike(arg1) && isStringLike(arg2)) {
                List<String> mCharList1 = toCharList(arg1);
                List<String> mCharList2 = toCharList(arg2);
                List<String> newCharList = new List<String>();
                for(String obj : mCharList2) {
                    Boolean exists = toBoolean(R.contains.run(obj, newCharList));
                    Boolean existsInOther = toBoolean(R.contains.run(obj, mCharList1));
                    if(!exists && !existsInOther) {
                        newCharList.add(obj);
                    }
                }
                for(String obj : mCharList1) {
                    Boolean exists = toBoolean(R.contains.run(obj, newCharList));
                    Boolean existsInOther = toBoolean(R.contains.run(obj, mCharList2));
                    if(!exists && !existsInOther) {
                        newCharList.add(obj);
                    }
                }
                return String.join(newCharList, '');
            }

            return arg1;
        }
    }

    private class DifferenceFunc extends Func {
        public DifferenceFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            if(isListLike(arg1) && isListLike(arg2)) {
                List<Object> mList1 = toList(arg1);
                List<Object> mList2 = toList(arg2);
                List<Object> newList = new List<Object>();
                for(Object obj : mList2) {
                    Boolean exists = toBoolean(R.contains.run(obj, newList));
                    Boolean existsInOther = toBoolean(R.contains.run(obj, mList1));
                    if(!exists && !existsInOther) {
                        newList.add(obj);
                    }
                }
                return newList;
            }
            else if(isSetLike(arg1) && isSetLike(arg2)) {
                Set<String> mSet1 = toSet(arg1);
                Set<String> mSet2 = toSet(arg2);
                Set<String> newSet = new Set<String>();
                for(String obj : mSet2) {
                    Boolean exists = toBoolean(R.contains.run(obj, newSet));
                    Boolean existsInOther = toBoolean(R.contains.run(obj, mSet1));
                    if(!exists && !existsInOther) {
                        newSet.add(obj);
                    }
                }
                return newSet;
            }
            else if(isStringLike(arg1) && isStringLike(arg2)) {
                List<String> mCharList1 = toCharList(arg1);
                List<String> mCharList2 = toCharList(arg2);
                List<String> newCharList = new List<String>();
                for(String obj : mCharList2) {
                    Boolean exists = toBoolean(R.contains.run(obj, newCharList));
                    Boolean existsInOther = toBoolean(R.contains.run(obj, mCharList1));
                    if(!exists && !existsInOther) {
                        newCharList.add(obj);
                    }
                }
                return String.join(newCharList, '');
            }

            return arg1;
        }
    }

    private class AdjustFunc extends Func {
        public AdjustFunc() {
            super(3);
        }

        public override Object exec(Object arg1, Object arg2, Object arg3) {
            Func fn = toFunc(arg1);
            Integer index = toInteger(arg2);
            if(isListLike(arg3)) {
                List<Object> mList = toList(arg3);
                List<Object> newList = new List<Object>(mList);
                Object val = newList.get(index);
                newList.set(index, fn.run(val));
                return newList;
            }
            else if(isStringLike(arg3)) {
                List<String> mCharList = toCharList(arg3);
                List<String> newCharList = new List<String>(mCharList);
                String val = newCharList.get(index);
                newCharList.set(index, toString(fn.run(val)));
                return String.join(newCharList, '');
            }

            return arg3;
        }
    }

    private class AllFunc extends Func {
        public AllFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            Func pred = toFunc(arg1);
            if(isListLike(arg2)) {
                List<Object> mList = toList(arg2);
                for(Object obj : mList) {
                    Boolean pass = toBoolean(pred.run(obj));
                    if(!pass) {
                        return false;
                    }
                }
                return true;
            }
            else if(isSetLike(arg2)) {
                Set<String> mSet = toSet(arg2);
                for(String obj : mSet) {
                    Boolean pass = toBoolean(pred.run(obj));
                    if(!pass) {
                        return false;
                    }
                }
                return true;
            }
            else if(isMapLike(arg2)) {
                Map<String, Object> mMap = toMap(arg2);
                for(String key : mMap.keySet()) {
                    Object val = mMap.get(key);
                    Boolean pass = toBoolean(pred.run(val, key));
                    if(!pass) {
                        return false;
                    }
                }
                return true;
            }
            else if(isStringLike(arg2)) {
                List<String> mCharList = toCharList(arg2);
                for(String obj : mCharList) {
                    Boolean pass = toBoolean(pred.run(obj));
                    if(!pass) {
                        return false;
                    }
                }
                return true;
            }

            return false;
        }
    }

    private class AnyFunc extends Func {
        public AnyFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            Func pred = toFunc(arg1);
            if(isListLike(arg2)) {
                List<Object> mList = toList(arg2);
                for(Object obj : mList) {
                    Boolean pass = toBoolean(pred.run(obj));
                    if(pass) {
                        return true;
                    }
                }
                return false;
            }
            else if(isSetLike(arg2)) {
                Set<String> mSet = toSet(arg2);
                for(String obj : mSet) {
                    Boolean pass = toBoolean(pred.run(obj));
                    if(pass) {
                        return true;
                    }
                }
                return false;
            }
            else if(isMapLike(arg2)) {
                Map<String, Object> mMap = toMap(arg2);
                for(String key : mMap.keySet()) {
                    Object val = mMap.get(key);
                    Boolean pass = toBoolean(pred.run(val, key));
                    if(pass) {
                        return true;
                    }
                }
                return false;
            }
            else if(isStringLike(arg2)) {
                List<String> mCharList = toCharList(arg2);
                for(String obj : mCharList) {
                    Boolean pass = toBoolean(pred.run(obj));
                    if(pass) {
                        return true;
                    }
                }
                return false;
            }

            return false;
        }
    }

    private class NoneFunc extends Func {
        public NoneFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            Func pred = toFunc(arg1);
            if(isListLike(arg2)) {
                List<Object> mList = toList(arg2);
                for(Object obj : mList) {
                    Boolean pass = toBoolean(pred.run(obj));
                    if(pass) {
                        return false;
                    }
                }
                return true;
            }
            else if(isSetLike(arg2)) {
                Set<String> mSet = toSet(arg2);
                for(String obj : mSet) {
                    Boolean pass = toBoolean(pred.run(obj));
                    if(pass) {
                        return false;
                    }
                }
                return true;
            }
            else if(isMapLike(arg2)) {
                Map<String, Object> mMap = toMap(arg2);
                for(String key : mMap.keySet()) {
                    Object val = mMap.get(key);
                    Boolean pass = toBoolean(pred.run(val, key));
                    if(pass) {
                        return false;
                    }
                }
                return true;
            }
            else if(isStringLike(arg2)) {
                List<String> mCharList = toCharList(arg2);
                for(String obj : mCharList) {
                    Boolean pass = toBoolean(pred.run(obj));
                    if(pass) {
                        return false;
                    }
                }
                return true;
            }

            return false;
        }
    }

    private class AppendFunc extends Func {
        public AppendFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            if(isListLike(arg2)) {
                Object val = arg1;
                List<Object> mList = toList(arg2);
                List<Object> newList = new List<Object>(mList);
                newList.add(val);
                return newList;
            }
            else if(isStringLike(arg2)) {
                String val = toString(arg1);
                List<String> mCharList = toCharList(arg2);
                List<String> newCharList = new List<String>(mCharList);
                newCharList.add(val);
                return String.join(newCharList, '');
            }

            return arg2;
        }
    }

    private class PrependFunc extends Func {
        public PrependFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            if(isListLike(arg2)) {
                Object val = arg1;
                List<Object> mList = toList(arg2);
                List<Object> newList = new List<Object>();
                newList.add(val);
                newList.addAll(mList);
                return newList;
            }
            else if(isStringLike(arg2)) {
                String val = toString(arg1);
                List<String> mCharList = toCharList(arg2);
                List<String> newCharList = new List<String>();
                newCharList.add(val);
                newCharList.addAll(mCharList);
                return String.join(newCharList, '');
            }

            return arg2;
        }
    }

    private class ApplySpecFunc extends Func {
        private Map<String, Object> applySpec(Map<String, Object> spec, List<Object> args) {
            Map<String, Object> ret = new Map<String, Object>();
            for(String key : spec.keySet()) {
                Object specVal = spec.get(key);
                if(isFuncLike(specVal)) {
                    Func specFn = toFunc(specVal);
                    ret.put(key, specFn.runN(args));
                }
                else if(isMapLike(specVal)) {
                    ret.put(key, applySpec(toMap(specVal), args));
                }
                else {
                    ret.put(key, specVal);
                }
            }

            return ret;
        }

        public override Object execN(List<Object> args) {
            Map<String, Object> spec = toMap(args.get(0));
            List<Object> newArgs = slice(1, args);
            return applySpec(spec, newArgs);
        }
    }

    private class JuxtFunc extends Func {
        public override Object execN(List<Object> args) {
            List<Func> funcs = toFuncList(args.get(0));
            List<Object> newArgs = slice(1, args);
            List<Object> newList = new List<Object>();

            for(Func fn : funcs) {
                newList.add(fn.runN(newArgs));
            }

            return newList;
        }
    }

    private class AssocFunc extends Func {
        public AssocFunc() {
            super(3);
        }

        public override Object exec(Object arg1, Object arg2, Object arg3) {
            if(isListLike(arg3)) {
                Integer index = toInteger(arg1);
                Object val = arg2;
                List<Object> mList = toList(arg3);
                List<Object> newList = new List<Object>(mList);
                newList.set(index, val);
                return newList;
            }
            else if(isSObjectLike(arg3)) {
                String key = toString(arg1);
                Object val = arg2;
                SObject obj = toSObject(arg3);
                SObject newObj = (SObject)doClone(obj);
                newObj.put(key, val);
                return newObj;
            }
            else if(isMapLike(arg3)) {
                String key = toString(arg1);
                Object val = arg2;
                Map<String, Object> mMap = toMap(arg3);
                Map<String, Object> newMap = new Map<String, Object>(mMap);
                newMap.put(key, val);
                return newMap;
            }
            else if(isStringLike(arg3)) {
                Integer index = toInteger(arg1);
                String val = toString(arg2);
                List<String> mCharList = toCharList(arg3);
                List<String> newCharList = new List<String>(mCharList);
                newCharList.set(index, val);
                return String.join(newCharList, '');
            }

            return arg3;
        }
    }

    private class ClampFunc extends Func {
        public ClampFunc() {
            super(3);
        }

        public override Object exec(Object arg1, Object arg2, Object arg3) {
            if(compare(arg1, arg3) > 0) {
                return arg1;
            }
            else if(compare(arg3, arg2) > 0) {
                return arg2;
            }
            else {
                return arg3;
            }
        }
    }

    private class CloneFunc extends Func {
        public CloneFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            if(isListLike(arg)) {
                return new List<Object>(toList(arg));
            }
            else if(isSetLike(arg)) {
                return new Set<String>(toSet(arg));
            }
            else if(isSObjectLike(arg)) {
                return toSObject(arg).clone(true, true, true, true);
            }
            else if(isMapLike(arg)) {
                return new Map<String, Object>(toMap(arg));
            }
            else if(isStringLike(arg)) {
                return toString(arg);
            }
            else {
                return arg;
            }
        }
    }

    private class ConcatFunc extends Func {
        public ConcatFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            if(isListLike(arg1) && isListLike(arg2)) {
                List<Object> mList1 = toList(arg1);
                List<Object> mList2 = toList(arg2);
                List<Object> newList = new List<Object>(mList2);
                newList.addAll(mList1);
                return newList;
            }
            else if(isSetLike(arg1) && isSetLike(arg2)) {
                Set<String> mSet1 = toSet(arg1);
                Set<String> mSet2 = toSet(arg2);
                Set<String> newSet = new Set<String>(mSet2);
                newSet.addAll(mSet1);
                return newSet;
            }
            else if(isMapLike(arg1) && isMapLike(arg2)) {
                Map<String, Object> mMap1 = toMap(arg1);
                Map<String, Object> mMap2 = toMap(arg2);
                Map<String, Object> newMap = new Map<String, Object>(mMap2);
                newMap.putAll(mMap1);
                return newMap;
            }
            else if(isStringLike(arg1) && isStringLike(arg2)) {
                String s1 = toString(arg1);
                String s2 = toString(arg2);
                return s2 + s1;
            }

            return arg1;
        }
    }

    private class CountByFunc extends Func {
        public CountByFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            Func fn = toFunc(arg1);
            Map<String, Integer> countMap = new Map<String, Integer>();
            if(isListLike(arg2)) {
                List<Object> mList = toList(arg2);
                for(Object obj : mList) {
                    String key = toString(fn.run(obj));
                    Integer count = countMap.get(key);
                    if(count == null) {
                        count = 0;
                    }
                    count += 1;
                    countMap.put(key, count);
                }
            }
            else if(isSetLike(arg2)) {
                Set<String> mSet = toSet(arg2);
                for(String obj : mSet) {
                    String key = toString(fn.run(obj));
                    Integer count = countMap.get(key);
                    if(count == null) {
                        count = 0;
                    }
                    count += 1;
                    countMap.put(key, count);
                }
            }
            else if(isStringLike(arg2)) {
                List<String> mCharList = toCharList(arg2);
                for(String obj : mCharList) {
                    String key = toString(fn.run(obj));
                    Integer count = countMap.get(key);
                    if(count == null) {
                        count = 0;
                    }
                    count += 1;
                    countMap.put(key, count);
                }
            }

            return countMap;
        }
    }

    private class GroupByFunc extends Func {
        public GroupByFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            Func fn = toFunc(arg1);
            Map<String, List<Object>> groupMap = new Map<String, List<Object>>();
            if(isListLike(arg2)) {
                List<Object> mList = toList(arg2);
                for(Object obj : mList) {
                    String key = toString(fn.run(obj));
                    List<Object> mGroup = groupMap.get(key);
                    if(mGroup == null) {
                        mGroup = new List<Object>();
                    }
                    mGroup.add(obj);
                    groupMap.put(key, mGroup);
                }
            }
            else if(isSetLike(arg2)) {
                Set<String> mSet = toSet(arg2);
                for(String obj : mSet) {
                    String key = toString(fn.run(obj));
                    List<Object> mGroup = groupMap.get(key);
                    if(mGroup == null) {
                        mGroup = new List<Object>();
                    }
                    mGroup.add(obj);
                    groupMap.put(key, mGroup);
                }
            }
            else if(isStringLike(arg2)) {
                List<String> mCharList = toCharList(arg2);
                for(String obj : mCharList) {
                    String key = toString(fn.run(obj));
                    List<Object> mGroup = groupMap.get(key);
                    if(mGroup == null) {
                        mGroup = new List<Object>();
                    }
                    mGroup.add(obj);
                    groupMap.put(key, mGroup);
                }
            }

            return groupMap;
        }
    }

    private class IndexByFunc extends Func {
        public IndexByFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            Func fn = toFunc(arg1);
            Map<String, Object> indexMap = new Map<String, Object>();
            if(isListLike(arg2)) {
                List<Object> mList = toList(arg2);
                for(Object obj : mList) {
                    String key = toString(fn.run(obj));
                    indexMap.put(key, obj);
                }
            }
            else if(isSetLike(arg2)) {
                Set<String> mSet = toSet(arg2);
                for(String obj : mSet) {
                    String key = toString(fn.run(obj));
                    indexMap.put(key, obj);
                }
            }
            else if(isStringLike(arg2)) {
                List<String> mCharList = toCharList(arg2);
                for(String obj : mCharList) {
                    String key = toString(fn.run(obj));
                    indexMap.put(key, obj);
                }
            }

            return indexMap;
        }
    }

    private class DefaultToFunc extends Func {
        public DefaultToFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            return arg2 == null ? arg1 : arg2;
        }
    }

    private class DissocFunc extends Func {
        public DissocFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            if(isListLike(arg2)) {
                Integer index = toInteger(arg1);
                List<Object> mList = toList(arg2);
                List<Object> newList = new List<Object>(mList);
                newList.set(index, null);
                return newList;
            }
            else if(isSObjectLike(arg2)) {
                String key = toString(arg1);
                SObject obj = toSObject(arg2);
                SObject newObj = (SObject)doClone(obj);
                newObj.put(key, null);
                return newObj;
            }
            else if(isMapLike(arg2)) {
                String key = toString(arg1);
                Map<String, Object> mMap = toMap(arg2);
                Map<String, Object> newMap = new Map<String, Object>(mMap);
                newMap.remove(key);
                return newMap;
            }
            else if(isStringLike(arg2)) {
                Integer index = toInteger(arg1);
                List<String> mCharList = toCharList(arg2);
                List<String> newCharList = new List<String>(mCharList);
                newCharList.set(index, '');
                return String.join(newCharList, '');
            }

            return arg2;
        }
    }

    private class StartsWithFunc extends Func {
        public StartsWithFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            if(isListLike(arg1) && isListLike(arg2)) {
                List<Object> mList1 = toList(arg1);
                List<Object> mList2 = toList(arg2);
                if(mList1.size() > mList2.size()) {
                    return false;
                }
                for(Integer i = 0; i < mList1.size(); i++) {
                    if(!equals(mList1.get(i), mList2.get(i))) {
                        return false;
                    }
                }

                return true;
            }
            else if(isStringLike(arg1) && isStringLike(arg2)) {
                String s1 = toString(arg1);
                String s2 = toString(arg2);
                return s2.startsWith(s1);
            }

            return false;
        }
    }

    private class EndsWithFunc extends Func {
        public EndsWithFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            if(isListLike(arg1) && isListLike(arg2)) {
                List<Object> mList1 = toList(arg1);
                List<Object> mList2 = toList(arg2);
                if(mList1.size() > mList2.size()) {
                    return false;
                }
                for(Integer i = 0; i < mList1.size(); i++) {
                    if(!equals(mList1.get(mList1.size() - 1 - i), mList2.get(mList2.size() - 1 - i))) {
                        return false;
                    }
                }

                return true;
            }
            else if(isStringLike(arg1) && isStringLike(arg2)) {
                String s1 = toString(arg1);
                String s2 = toString(arg2);
                return s2.endsWith(s1);
            }

            return false;
        }
    }

    private class EvolveFunc extends Func {
        public EvolveFunc() {
            super(2);
        }

        private Map<String, Object> applySpec(Map<String, Object> spec, Map<String, Object> data) {
            Map<String, Object> ret = new Map<String, Object>();
            for(String key : data.keySet()) {
                Object val = data.get(key);
                Object specVal = spec.get(key);
                if(isFuncLike(specVal)) {
                    Func specFn = toFunc(specVal);
                    ret.put(key, specFn.run(val));
                }
                else if(isMapLike(specVal) && isMapLike(val)) {
                    Map<String, Object> specMap = toMap(specVal);
                    Map<String, Object> valMap = toMap(val);
                    ret.put(key, applySpec(specMap, valMap));
                }
                else {
                    ret.put(key, val);
                }
            }

            return ret;
        }

        public override Object exec(Object arg1, Object arg2) {
            Map<String, Object> spec = toMap(arg1);
            Map<String, Object> data = toMap(arg2);

            return applySpec(spec, data);
        }
    }

    private class FindFunc extends Func {
        private Boolean reverse;

        public FindFunc(Boolean reverse) {
            super(2);
            this.reverse = reverse;
        }

        public override Object exec(Object arg1, Object arg2) {
            Func pred = toFunc(arg1);
            if(isListLike(arg2)) {
                List<Object> mList = toList(arg2);
                mList = reverse ? (List<Object>)R.reverse.run(mList) : mList;
                for(Object obj : mList) {
                    Boolean pass = toBoolean(pred.run(obj));
                    if(pass) {
                        return obj;
                    }
                }

                return null;
            }
            else if(isSetLike(arg2)) {
                Set<String> mSet = toSet(arg2);
                for(String obj : mSet) {
                    Boolean pass = toBoolean(pred.run(obj));
                    if(pass) {
                        return obj;
                    }
                }

                return null;
            }
            else if(isMapLike(arg2)) {
                Map<String, Object> mMap = toMap(arg2);
                for(String key : mMap.keySet()) {
                    Object val = mMap.get(key);
                    Boolean pass = toBoolean(pred.run(val, key));
                    if(pass) {
                        return new Pair(key, val);
                    }
                }

                return null;
            }
            else if(isStringLike(arg2)) {
                List<Object> mCharList = toCharList(arg2);
                mCharList = reverse ? (List<Object>)R.reverse.run(mCharList) : mCharList;
                for(Object mChar : mCharList) {
                    Boolean pass = toBoolean(pred.run(mChar));
                    if(pass) {
                        return mChar;
                    }
                }

                return null;
            }

            return arg2;
        }
    }

    private class FindIndexFunc extends Func {
        private Boolean reverse;

        public FindIndexFunc(Boolean reverse) {
            super(2);
            this.reverse = reverse;
        }

        public override Object exec(Object arg1, Object arg2) {
            Func pred = toFunc(arg1);
            if(isListLike(arg2)) {
                List<Object> mList = toList(arg2);
                if(!reverse) {
                    for(Integer i = 0; i < mList.size(); i++) {
                        Boolean pass = toBoolean(pred.run(mList.get(i)));
                        if(pass) {
                            return i;
                        }
                    }
                }
                else {
                    for(Integer i = mList.size() - 1; i >= 0; i--) {
                        Boolean pass = toBoolean(pred.run(mList.get(i)));
                        if(pass) {
                            return i;
                        }
                    }
                }

                return -1;
            }
            else if(isMapLike(arg2)) {
                Map<String, Object> mMap = toMap(arg2);
                for(String key : mMap.keySet()) {
                    Object val = mMap.get(key);
                    Boolean pass = toBoolean(pred.run(val, key));
                    if(pass) {
                        return key;
                    }
                }

                return null;
            }
            else if(isStringLike(arg2)) {
                List<Object> mCharList = toCharList(arg2);
                if(!reverse) {
                    for(Integer i = 0; i < mCharList.size(); i++) {
                        Boolean pass = toBoolean(pred.run(mCharList.get(i)));
                        if(pass) {
                            return i;
                        }
                    }
                }
                else {
                    for(Integer i = mCharList.size() - 1; i >= 0; i--) {
                        Boolean pass = toBoolean(pred.run(mCharList.get(i)));
                        if(pass) {
                            return i;
                        }
                    }
                }

                return -1;
            }

            return arg2;
        }
    }

    private class UnnestFunc extends Func {
        public UnnestFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            List<Object> mList = toList(arg);
            List<Object> newList = new List<Object>();
            for(Object obj : mList) {
                if(isListLike(obj)) {
                    List<Object> subList = toList(obj);
                    newList.addAll(subList);
                }
                else {
                    newList.add(obj);
                }
            }

            return newList;
        }
    }

    private class FlattenFunc extends Func {
        public FlattenFunc() {
            super(1);
        }

        private Object flatten(Object target) {
            if(isListLike(target)) {
                List<Object> mList = toList(target);
                List<Object> newList = new List<Object>();
                for(Object obj : mList) {
                    Object flattened = flatten(obj);
                    if(isListLike(flattened)) {
                        newList.addAll(toList(flattened));
                    }
                    else {
                        newList.add(flattened);
                    }
                }

                return newList;
            }
            else {
                return target;
            }
        }

        public override Object exec(Object arg) {
            return flatten(arg);
        }
    }

    private class PairFunc extends Func {
        public override Object exec(Object arg) {
            return toPair(arg);
        }

        public override Object exec(Object arg1, Object arg2) {
            return new Pair(arg1, arg2);
        }
    }

    private class FromPairsFunc extends Func {
        public FromPairsFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            List<Pair> pairs = toPairList(arg);
            Map<String, Object> newMap = new Map<String, Object>();
            for(Pair p : pairs) {
                newMap.put(toString(p.fst), p.snd);
            }

            return newMap;
        }
    }

    private class ToPairsFunc extends Func {
        public ToPairsFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            Map<String, Object> mMap = toMap(arg);
            List<Object> newPairs = new List<Object>();
            for(String key : mMap.keySet()) {
                Object val = mMap.get(key);
                newPairs.add(new Pair(key, val));
            }

            return newPairs;
        }
    }

    private class FirstFunc extends Func {
        public FirstFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            if(isListLike(arg)) {
                List<Object> mList = toList(arg);
                return getNthElement(0, mList);
            }
            else if(isStringLike(arg)) {
                List<String> mCharList = toCharList(arg);
                return getNthElement(0, mCharList);
            }

            return arg;
        }
    }

    private class LastFunc extends Func {
        public LastFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            if(isListLike(arg)) {
                List<Object> mList = toList(arg);
                return getNthElement(mList.size() - 1, mList);
            }
            else if(isStringLike(arg)) {
                List<String> mCharList = toCharList(arg);
                return getNthElement(mCharList.size() - 1, mCharList);
            }

            return arg;
        }
    }

    private class InitFunc extends Func {
        public InitFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            if(isListLike(arg)) {
                List<Object> mList = toList(arg);
                return slice(0, mList.size() - 1, mList);
            }
            else if(isStringLike(arg)) {
                List<String> mCharList = toCharList(arg);
                return String.join(slice(0, mCharList.size() - 1, mCharList), '');
            }

            return arg;
        }
    }

    private class TailFunc extends Func {
        public TailFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            if(isListLike(arg)) {
                List<Object> mList = toList(arg);
                return slice(1, mList);
            }
            else if(isStringLike(arg)) {
                List<String> mCharList = toCharList(arg);
                return String.join(slice(1, mCharList), '');
            }

            return arg;
        }
    }

    private class IndexOfFunc extends Func {
        private Boolean reverse;

        public IndexOfFunc(Boolean reverse) {
            super(2);
            this.reverse = reverse;
        }

        public override Object exec(Object arg1, Object arg2) {
            Object target = arg1;

            if(isListLike(arg2)) {
                List<Object> mList = toList(arg2);
                if(!reverse) {
                    for(Integer i = 0; i < mList.size(); i++) {
                        if(equals(target, mList.get(i))) {
                            return i;
                        }
                    }

                    return -1;
                }
                else {
                    for(Integer i = mList.size() - 1; i >= 0; i--) {
                        if(equals(target, mList.get(i))) {
                            return i;
                        }
                    }

                    return -1;
                }
            }
            else if(isStringLike(arg2)) {
                String str = toString(arg2);
                return reverse ?
                    str.indexOf(toString(target)) :
                    str.lastIndexOf(toString(target));
            }

            return -1;
        }
    }

    private class InsertFunc extends Func {
        public InsertFunc() {
            super(3);
        }

        public override Object exec(Object arg1, Object arg2, Object arg3) {
            Integer index = toInteger(arg1);
            if(isListLike(arg3)) {
                Object val = arg2;
                List<Object> mList = toList(arg3);
                List<Object> newList = new List<Object>(mList);
                newList.add(index, val);
                return newList;
            }
            else if(isStringLike(arg3)) {
                String val = toString(arg2);
                List<String> mCharList = toCharList(arg3);
                List<String> newCharList = new List<String>(mCharList);
                newCharList.add(index, val);
                return String.join(newCharList, '');
            }

            return arg3;
        }
    }

    private class InsertAllFunc extends Func {
        public InsertAllFunc() {
            super(3);
        }

        public override Object exec(Object arg1, Object arg2, Object arg3) {
            Integer index = toInteger(arg1);
            if(isListLike(arg3) && isListLike(arg2)) {
                List<Object> targetList = toList(arg2);
                List<Object> mList = toList(arg3);
                List<Object> newList = new List<Object>(mList);
                for(Integer i = 0; i < targetList.size(); i++) {
                    newList.add(index + i, targetList.get(i));
                }
                return newList;
            }
            else if(isStringLike(arg3) && isStringLike(arg2)) {
                String val = toString(arg2);
                List<String> mCharList = toCharList(arg3);
                List<String> newCharList = new List<String>(mCharList);
                newCharList.add(index, val);
                return String.join(newCharList, '');
            }

            return arg3;
        }
    }

    private class InvertFunc extends Func {
        private Boolean overrideValue;

        public InvertFunc(Boolean overrideValue) {
            super(1);
            this.overrideValue = overrideValue;
        }

        public override Object exec(Object arg) {
            if(isMapLike(arg)) {
                Map<String, Object> mMap = toMap(arg);
                Map<String, Object> newMap = new Map<String, Object>();
                for(String key : mMap.keySet()) {
                    Object val = mMap.get(key);
                    if(overrideValue) {
                        if(val != null) {
                            newMap.put(toString(val), key);
                        }
                    }
                    else {
                        if(val != null) {
                            String newKey = toString(val);
                            List<Object> mList = (List<Object>)newMap.get(newKey);
                            if(mList == null) {
                                mList = new List<Object>();
                            }
                            mList.add(key);
                            newMap.put(newKey, mList);
                        }
                    }
                }

                return newMap;
            }

            return arg;
        }
    }

    private class JoinFunc extends Func {
        public JoinFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            String separator = toString(arg1);
            if(isListLike(arg2)) {
                List<Object> mList = toList(arg2);
                return String.join(mList, separator);
            }
            else if(isStringLike(arg2)) {
                List<String> mCharList = toCharList(arg2);
                return String.join(mCharList, separator);
            }

            return arg2;
        }
    }

    private class KeysFunc extends Func {
        public KeysFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            if(isMapLike(arg)) {
                Map<String, Object> mMap = toMap(arg);
                return mMap.keySet();
            }

            return new Set<String>();
        }
    }

    private class ValuesFunc extends Func {
        public ValuesFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            if(isMapLike(arg)) {
                Map<String, Object> mMap = toMap(arg);
                return mMap.values();
            }

            return new List<Object>();
        }
    }

    private class MatchFunc extends Func {
        public MatchFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            String regex = toString(arg1);
            String input = toString(arg2);
            if (input == null) {
                return null;
            }
            Pattern ptn = patternCache.get(regex);
            if(ptn == null) {
                ptn = Pattern.compile(regex);
                patternCache.put(regex, ptn);
            }
            Matcher matcher = ptn.matcher(input);
            List<String> groups = new List<String>();
            if(matcher.matches()) {
                groups.add(matcher.group(0));

                for(Integer i = 1; i <= matcher.groupCount(); i++) {
                    groups.add(matcher.group(i));
                }
            }

            return groups;
        }
    }

    private class MaxFunc extends Func {
        public MaxFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            return compare(arg1, arg2) < 0 ? arg2 : arg1;
        }
    }

    private class MinFunc extends Func {
        public MinFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            return compare(arg1, arg2) < 0 ? arg1 : arg2;
        }
    }

    private class MergeFunc extends Func {
        public MergeFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            Map<String, Object> mMap1 = toMap(arg1);
            Map<String, Object> mMap2 = toMap(arg2);
            Map<String, Object> newMap = new Map<String, Object>(mMap2);
            newMap.putAll(mMap1);
            return newMap;
        }
    }

    private class NthFunc extends Func {
        public NthFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            if(isListLike(arg2)) {
                List<Object> mList = toList(arg2);
                Integer index = toInteger(arg1);
                return index >= 0 && index < mList.size() ? mList.get(index) : null;
            }
            else if(isMapLike(arg2)) {
                Map<String, Object> mMap = toMap(arg2);
                String key = toString(arg1);
                return mMap.get(key);
            }
            else if(isStringLike(arg2)) {
                List<String> mCharList = toCharList(arg2);
                Integer index = toInteger(arg1);
                return index >= 0 && index < mCharList.size() ? mCharList.get(index) : null;
            }

            return null;
        }
    }

    private class PickFunc extends Func {
        public PickFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            List<Object> keyList = toList(arg1);
            if(isListLike(arg2)) {
                List<Object> mList = toList(arg2);
                List<Object> newList = new List<Object>();
                for(Object key : keyList) {
                    Integer index = toInteger(key);
                    if(index >= 0 && index < mList.size()) {
                        newList.add(mList.get(index));
                    }
                }

                return newList;
            }
            else if(isMapLike(arg2)) {
                Map<String, Object> mMap = toMap(arg2);
                Map<String, Object> newMap = new Map<String, Object>();
                for(Object key : keyList) {
                    String keyStr = toString(key);
                    newMap.put(keyStr, mMap.get(keyStr));
                }

                return newMap;
            }
            else if(isStringLike(arg2)) {
                List<String> mCharList = toCharList(arg2);
                List<String> newCharList = new List<String>();
                for(Object key : keyList) {
                    Integer index = toInteger(key);
                    if(index >= 0 && index < mCharList.size()) {
                        newCharList.add(mCharList.get(index));
                    }
                }

                return newCharList;
            }

            return arg2;
        }
    }

    private class OmitFunc extends Func {
        public OmitFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            List<Object> keyList = toList(arg1);
            if(isListLike(arg2)) {
                List<Object> mList = toList(arg2);
                List<Object> newList = new List<Object>();
                List<Integer> indexList = toIntegerList(keyList);
                for(Integer i = 0; i < mList.size(); i++) {
                    if(!indexList.contains(i)) {
                        newList.add(mList.get(i));
                    }
                }

                return newList;
            }
            else if(isMapLike(arg2)) {
                Map<String, Object> mMap = toMap(arg2);
                Map<String, Object> newMap = new Map<String, Object>();
                for(Object key : mMap.keySet()) {
                    String keyStr = toString(key);
                    if(!keyList.contains(key)) {
                        newMap.put(keyStr, mMap.get(keyStr));
                    }
                }

                return newMap;
            }
            else if(isStringLike(arg2)) {
                List<String> mCharList = toCharList(arg2);
                List<String> newCharList = new List<String>();
                List<Integer> indexList = toIntegerList(keyList);
                for(Integer i = 0; i < mCharList.size(); i++) {
                    if(!indexList.contains(i)) {
                        newCharList.add(mCharList.get(i));
                    }
                }

                return newCharList;
            }

            return arg2;
        }
    }

    private class PartitionFunc extends Func {
        public PartitionFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            Func pred = toFunc(arg1);
            if(isListLike(arg2)) {
                List<Object> mList = toList(arg2);
                List<Object> fstList = new List<Object>();
                List<Object> sndList = new List<Object>();
                for(Object obj : mList) {
                    Boolean pass = toBoolean(pred.run(obj));
                    if(pass) {
                        fstList.add(obj);
                    }
                    else {
                        sndList.add(obj);
                    }
                }

                return new Pair(fstList, sndList);
            }
            else if(isSetLike(arg2)) {
                Set<String> mSet = toSet(arg2);
                Set<String> fstSet = new Set<String>();
                Set<String> sndSet = new Set<String>();
                for(String obj : mSet) {
                    Boolean pass = toBoolean(pred.run(obj));
                    if(pass) {
                        fstSet.add(obj);
                    }
                    else {
                        sndSet.add(obj);
                    }
                }

                return new Pair(fstSet, sndSet);
            }
            else if(isMapLike(arg2)) {
                Map<String, Object> mMap = toMap(arg2);
                Map<String, Object> fstMap = new Map<String, Object>();
                Map<String, Object> sndMap = new Map<String, Object>();
                for(String key : mMap.keySet()) {
                    Object val = mMap.get(key);
                    Boolean pass = toBoolean(pred.run(val, key));
                    if(pass) {
                        fstMap.put(key, val);
                    }
                    else {
                        sndMap.put(key, val);
                    }
                }

                return new Pair(fstMap, sndMap);
            }
            else if(isStringLike(arg2)) {
                List<String> mCharList = toCharList(arg2);
                List<String> fstCharList = new List<String>();
                List<String> sndCharList = new List<String>();
                for(String obj : mCharList) {
                    Boolean pass = toBoolean(pred.run(obj));
                    if(pass) {
                        fstCharList.add(obj);
                    }
                    else {
                        sndCharList.add(obj);
                    }
                }

                return new Pair(String.join(fstCharList, ''), String.join(sndCharList, ''));
            }

            return arg2;
        }
    }

    private class ProductFunc extends Func {
        public override Object execN(List<Object> args) {
            List<Decimal> decimalList = toDecimalList(args);
            Decimal total = 1;
            for(Decimal num : decimalList) {
                total *= num;
            }

            return total;
        }
    }

    private class ProjectFunc extends Func {
        public ProjectFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            List<String> fields = toStringList(arg1);
            List<Object> mList = toList(arg2);
            List<Object> newList = new List<Object>();
            for(Object obj : mList) {
                newList.add(R.pick.run(fields, obj));
            }

            return newList;
        }
    }

    private class RangeFunc extends Func {
        public RangeFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            Decimal d1 = toDecimal(arg1);
            Decimal d2 = toDecimal(arg2);
            List<Decimal> newList = new List<Decimal>();
            if(d1 < d2) {
                for(Decimal i = d1; i < d2; i++) {
                    newList.add(i);
                }
            }

            return newList;
        }
    }

    private class RemoveFunc extends Func {
        public RemoveFunc() {
            super(3);
        }

        public override Object exec(Object arg1, Object arg2, Object arg3) {
            Integer first = toInteger(arg1);
            Integer count = toInteger(arg2);
            if(isListLike(arg3)) {
                List<Object> mList = toList(arg3);
                List<Object> newList = new List<Object>();
                for(Integer i = 0; i < mList.size(); i++) {
                    if(i < first || i >= first + count) {
                        newList.add(mList.get(i));
                    }
                }

                return newList;
            }
            else if(isStringLike(arg3)) {
                List<String> mCharList = toCharList(arg3);
                List<String> newCharList = new List<String>();
                for(Integer i = 0; i < mCharList.size(); i++) {
                    if(i < first || i >= first + count) {
                        newCharList.add(mCharList.get(i));
                    }
                }

                return String.join(newCharList, '');
            }

            return arg3;
        }
    }

    private class RepeatFunc extends Func {
        public RepeatFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            Integer count = toInteger(arg1);
            Object val = arg2;
            List<Object> newList = new List<Object>();
            for(Integer i = 0; i < count; i++) {
                newList.add(doClone(val));
            }

            return newList;
        }
    }

    private class TimesFunc extends Func {
        public TimesFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            Integer count = toInteger(arg1);
            Func fn = toFunc(arg2);
            List<Object> newList = new List<Object>();
            for(Integer i = 0; i < count; i++) {
                newList.add(fn.run(i));
            }

            return newList;
        }
    }

    private class ReplaceFunc extends Func {
        private Boolean isGlobal;

        public ReplaceFunc(Boolean isGlobal) {
            super(3);
            this.isGlobal = isGlobal;
        }

        public override Object exec(Object arg1, Object arg2, Object arg3) {
            String pattern = toString(arg1);
            String replacement = toString(arg2);
            String target = toString(arg3);

            if(isGlobal) {
                return target.replaceAll(pattern, replacement);
            }
            else {
                return target.replaceFirst(pattern, replacement);
            }
        }
    }

    private class SplitFunc extends Func {
        public SplitFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            String separator = toString(arg1);
            String source = toString(arg2);
            if (source == null)
                return null;
            return source.split(separator);
        }
    }

    private class TestFunc extends Func {
        public TestFunc() {
            super(2);
        }

        public override Object exec(Object arg1, Object arg2) {
            String ptn = toString(arg1);
            String target = toString(arg2);

            if (ptn == null || target == null) {
                return false;
            }
            return Pattern.matches(ptn, target);
        }
    }

    private class ToLowerFunc extends Func {
        public ToLowerFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            String str = toString(arg);
            return str.toLowerCase();
        }
    }

    private class ToUpperFunc extends Func {
        public ToUpperFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            String str = toString(arg);
            return str.toUpperCase();
        }
    }

    private class TrimFunc extends Func {
        public TrimFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            String str = toString(arg);
            return str.trim();
        }
    }

    private class UpdateFunc extends Func {
        public UpdateFunc() {
            super(3);
        }

        public override Object exec(Object arg1, Object arg2, Object arg3) {
            Integer index = toInteger(arg1);
            if(isListLike(arg3)) {
                Object val = arg2;
                List<Object> mList = toList(arg3);
                List<Object> newList = new List<Object>(mList);
                if(index >= 0 && index < mList.size()) {
                    newList.set(index, val);
                }

                return newList;
            }
            else if(isStringLike(arg3)) {
                String val = toString(arg2);
                List<String> mCharList = toCharList(arg3);
                List<String> newCharList = new List<String>(mCharList);
                if(index >= 0 && index < mCharList.size()) {
                    newCharList.set(index, val);
                }

                return String.join(newCharList, '');
            }

            return arg3;
        }
    }

    private class ZipFunc extends Func {
        private Boolean toObject;

        public ZipFunc(Boolean toObject) {
            super(2);
            this.toObject = toObject;
        }

        public override Object exec(Object arg1, Object arg2) {
            List<Object> mList1 = toList(arg1);
            List<Object> mList2 = toList(arg2);
            Integer length = mList1.size() < mList2.size() ? mList1.size() : mList2.size();
            if(toObject) {
                Map<String, Object> newMap = new Map<String, Object>();
                for(Integer i = 0; i < length; i++) {
                    Object obj1 = mList1.get(i);
                    Object obj2 = mList2.get(i);
                    newMap.put(toString(obj1), obj2);
                }

                return newMap;
            }
            else {
                List<Object> newList = new List<Object>();
                for(Integer i = 0; i < length; i++) {
                    Object obj1 = mList1.get(i);
                    Object obj2 = mList2.get(i);
                    newList.add(new Pair(obj1, obj2));
                }

                return newList;
            }
        }
    }

    private class ShuffleFunc extends Func {
        public ShuffleFunc() {
            super(1);
        }

        private Integer randomInt(Integer max) {
            return (Integer)(Math.random() * max);
        }

        private List<Object> shuffle(List<Object> mList) {
            List<Object> newList = new List<Object>(mList);
            for(Integer i = newList.size() - 1; i >= 1; i--) {
                Integer j = randomInt(i);
                Object val = newList.get(i);
                newList.set(i, newList.get(j));
                newList.set(j, val);
            }
            return newList;
        }

        public override Object exec(Object arg) {
            if(isListLike(arg)) {
                List<Object> mList = toList(arg);
                return shuffle(mList);
            }
            else if(isStringLike(arg)) {
                List<String> mCharList = toCharList(arg);
                return String.join(shuffle(mCharList), '');
            }

            return arg;
        }
    }

    private class SampleFunc extends Func {
        public SampleFunc() {
            super(2);
        }

        private List<Object> sample(Integer size, List<Object> mList) {
            List<Object> shuffledList = (List<Object>)R.shuffle.run(mList);
            List<Object> newList = new List<Object>();
            for(Integer i = 0; i < size && i < shuffledList.size(); i++) {
                newList.add(shuffledList.get(i));
            }

            return newList;
        }

        public override Object exec(Object arg1, Object arg2) {
            Integer size = toInteger(arg1);
            if(isListLike(arg2)) {
                List<Object> mList = toList(arg2);
                return sample(size, mList);
            }
            else if(isStringLike(arg2)) {
                List<String> mCharList = toCharList(arg2);
                return String.join(sample(size, mCharList), '');
            }

            return arg2;
        }
    }

    private class CapitalizeFunc extends Func {
        public CapitalizeFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            String str = toString(arg);
            return str.capitalize();
        }
    }

    private class PadFunc extends Func {
        private Padding pd;

        public PadFunc(Padding pd) {
            super(3);
            this.pd = pd;
        }

        public override Object exec(Object arg1, Object arg2, Object arg3) {
            Integer length = toInteger(arg1);
            String fill = toString(arg2);
            String target = toString(arg3);

            if(pd == Padding.Both) {
                return target.center(length, fill);
            }
            else if(pd == Padding.Left) {
                return target.leftPad(length, fill);
            }
            else if(pd == Padding.Right) {
                return target.rightPad(length, fill);
            }
            else {
                return arg3;
            }
        }
    }

    private class DbQueryFunc extends Func {
        public DbQueryFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            String query = toString(arg);

            return Database.query(query);
        }
    }

    private class DbInsertFunc extends Func {
        public DbInsertFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            if(arg instanceof SObject) {
                insert (SObject)arg;
            }
            else if(arg instanceof List<SObject>) {
                insert (List<SObject>)arg;
            }

            return arg;
        }
    }

    private class DbUpdateFunc extends Func {
        public DbUpdateFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            if(arg instanceof SObject) {
                update (SObject)arg;
            }
            else if(arg instanceof List<SObject>) {
                update (List<SObject>)arg;
            }

            return arg;
        }
    }

    private class DbDeleteFunc extends Func {
        public DbDeleteFunc() {
            super(1);
        }

        public override Object exec(Object arg) {
            if(arg instanceof SObject) {
                delete (SObject)arg;
            }
            else if(arg instanceof List<SObject>) {
                delete (List<SObject>)arg;
            }

            return arg;
        }
    }

    private class AssertFunc extends Func {
        public AssertFunc() {
            super(-1);
        }

        public override Object exec(Object arg) {
            Boolean condition = toBoolean(arg);

            System.assert(condition);

            return null;
        }

        public override Object exec(Object arg1, Object arg2) {
            Boolean condition = toBoolean(arg1);
            Object msg = arg2;

            System.assert(condition, arg2);

            return null;
        }
    }

    private class AssertEqualsFunc extends Func {
        public AssertEqualsFunc() {
            super(-1);
        }

        public override Object exec(Object arg1, Object arg2) {
            Object expected = arg1;
            Object actual = arg2;

            System.assertEquals(expected, actual);

            return null;
        }

        public override Object exec(Object arg1, Object arg2, Object arg3) {
            Object expected = arg1;
            Object actual = arg2;
            Object msg = arg3;

            System.assertEquals(expected, actual, msg);

            return null;
        }
    }

    private class AssertNotEqualsFunc extends Func {
        public AssertNotEqualsFunc() {
            super(-1);
        }

        public override Object exec(Object arg1, Object arg2) {
            Object expected = arg1;
            Object actual = arg2;

            System.assertNotEquals(expected, actual);

            return null;
        }

        public override Object exec(Object arg1, Object arg2, Object arg3) {
            Object expected = arg1;
            Object actual = arg2;
            Object msg = arg3;

            System.assertNotEquals(expected, actual, msg);

            return null;
        }
    }
}
