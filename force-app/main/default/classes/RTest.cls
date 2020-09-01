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
@IsTest
private class RTest {
    @IsTest
    private static void padLeftTest() {
        System.assertEquals(
            '001',
            R.of('1')
                .padLeft(3, '0')
                .toString()
        );
    }

    @IsTest
    private static void capitalizeTest() {
        System.assertEquals(
            'Abc',
            R.of('abc')
                .capitalize()
                .toString()
        );
    }

    @IsTest
    private static void shuffleTest() {
        System.assertEquals(
            3,
            R.with(1, 2, 3)
                .shuffle()
                .size()
                .toInteger()
        );
    }

    @IsTest
    private static void compactTest() {
        System.assertEquals(
            new List<Object>{ 1, 2 },
            R.with(1, 2, null)
                .compact()
                .toList()
        );
    }

    @IsTest
    private static void zipObjTest() {
        Map<String, Object> testM = R.with(1, 2)
            .zipObj(new List<Object>{ 'a', 'b' })
            .toMap();
        System.assertEquals(testM.get('a'), 1);
    }

    @IsTest
    private static void zipTest() {
        List<R.Pair> pairs = R.with(1, 2)
            .zip(new List<Object>{ 'a', 'b' })
            .toPairList();
        System.assertEquals(pairs.get(0).fst, 'a');
    }

    @IsTest
    private static void updateTest() {
        System.assertEquals(
            'abd',
            R.of('abc')
                .doUpdate(2, 'd')
                .toString()
        );
    }

    @IsTest
    private static void trimTest() {
        System.assertEquals(
            'abc',
            R.of(' abc ')
                .trim()
                .toString()
        );
    }

    @IsTest
    private static void toLowerTest() {
        System.assertEquals(
            'abc',
            R.of('ABC')
                .toLower()
                .toString()
        );
    }

    @IsTest
    private static void toUpperTest() {
        System.assertEquals(
            'ABC',
            R.of('abc')
                .toUpper()
                .toString()
        );
    }

    @IsTest
    private static void testTest() {
        System.assert(
            R.of('cat')
                .test('.*a.*')
                .toBoolean()
        );
    }

    @IsTest
    private static void splitTest() {
        System.assertEquals(
            new List<String>{ 'a', 'b' },
            R.of('a-b')
                .split('-')
                .toList()
        );
    }

    @IsTest
    private static void replaceAllTest() {
        System.assertEquals(
            'dog dog',
            R.of('cat cat')
                .replaceAll('cat', 'dog')
                .toString()
        );
    }

    @IsTest
    private static void replaceTest() {
        System.assertEquals(
            'dog',
            R.of('cat')
                .replace('cat', 'dog')
                .toString()
        );
    }

    @IsTest
    private static void timesTest() {
        System.assertEquals(
            new List<Integer>{ 0, 1, 2, 3, 4, 5 },
            R.times.run(6, R.identity)
        );
    }

    @IsTest
    private static void repeatTest() {
        System.assertEquals(
            'aaa',
            R.of('a')
                .repeat(3)
                .doJoin('')
                .toString()
        );
    }

    @IsTest
    private static void removeTest() {
        System.assertEquals(
            'adef',
            R.of('abcdef')
                .remove(1, 2)
                .toString()
        );
    }

    @IsTest
    private static void rejectTest() {
        System.assertEquals(
            'bc',
            R.of('abc')
                .reject(R.equals.apply('a'))
                .toString()
        );
    }

    @IsTest
    private static void rangeTest() {
        System.assertEquals(
            6,
            R.range(1, 4)
                .sum()
                .toInteger()
        );
    }

    @IsTest
    private static void projectTest() {
        System.assertEquals(
            new List<Object>{ new Map<String, Object>{ 'a' => 1 } },
            R.of(new List<Object>{ new Map<String, Object>{ 'a' => 1, 'b' => 2 } })
                .project(new List<String>{ 'a' })
                .toList()
        );
    }

    @IsTest
    private static void productTest() {
        System.assertEquals(6, R.product.run(1, 2, 3));
    }

    @IsTest
    private static void partitionTest() {
        R.Pair pair = R.of('aba')
            .partition(R.equals.apply('a'))
            .toPair();
        System.assertEquals('aa', pair.fst);
    }

    @IsTest
    private static void propSatisfiesTest() {
        System.assert(
            (Boolean)R.propSatisfies.run('name', R.isNotNull, new Map<String, Object>{ 'name' => 1 })
        );
    }

    @IsTest
    private static void propOrTest() {
        System.assertEquals(
            'abc',
            R.propOr.run('name', 'abc', new Map<String, Object>())
        );
    }

    @IsTest
    private static void omitTest() {
        System.assertEquals(
            new Map<String, Object>{ 'b' => 2 },
            R.of(new Map<String, Object>{ 'a' => 1, 'b' => 2 })
                .omit(new List<String>{ 'a' })
                .toMap()
        );
    }

    @IsTest
    private static void pickTest() {
        System.assertEquals(
            new Map<String, Object>{ 'a' => 1 },
            R.of(new Map<String, Object>{ 'a' => 1, 'b' => 2 })
                .pick(new List<String>{ 'a' })
                .toMap()
        );
    }

    @IsTest
    private static void nthTest() {
        System.assertEquals(
            2,
            R.with(1, 2, 3)
                .nth(1)
                .toInteger()
        );
    }

    @IsTest
    private static void mergeTest() {
        System.assertEquals(
            new Map<String, Object>{ 'a' => 2 },
            R.of(new Map<String, Object>{ 'a' => 1 })
                .doMerge(new Map<String, Object>{ 'a' => 2 })
                .toMap()
        );
    }

    @IsTest
    private static void minTest() {
        System.assertEquals(
            1,
            R.min.run(1, 2)
        );
    }

    @IsTest
    private static void maxTest() {
        System.assertEquals(
            2,
            R.max.run(1, 2)
        );
    }

    @IsTest
    private static void matchTest() {
        System.assertEquals(
            2,
            R.of('abc')
                .match('(a)bc')
                .size()
                .toInteger()
        );
    }

    @IsTest
    private static void valuesTest() {
        System.assertEquals(
            new List<Object>{ 1, 2 },
            R.of(new Map<String, Object>{ 'a' => 1, 'b' => 2 })
                .values()
                .toList()
        );
    }

    @IsTest
    private static void keysTest() {
        System.assertEquals(
            new Set<String>{ 'a', 'b' },
            R.of(new Map<String, Object>{ 'a' => 1, 'b' => 2 })
                .keys()
                .toSet()
        );
    }

    @IsTest
    private static void typeCheckTest() {
        System.assert(R.with(1, 2, 3).isList());

        System.assert(R.of(new Set<String>{ 'a' }).isSet());

        System.assert(R.withObj('a', 'b').isMap());
    }

    @IsTest
    private static void emptyTest() {
        System.assertEquals(
            new List<Object>(),
            R.emptyList().debug().toList()
        );

        System.assertEquals(
            new Set<String>(),
            R.emptySet().toSet()
        );

        System.assertEquals(
            new Map<String, Object>(),
            R.emptyMap().toMap()
        );

        System.assertEquals(
            '',
            R.emptyString().toString()
        );
    }

    @IsTest
    private static void withObjTest() {
        System.assertEquals(
            new Map<String, Object>{ 'a' => 'b' },
            R.withObj('a', 'b').toMap()
        );
    }

    @IsTest
    private static void toTest() {
        Long l = 1;
        System.assertEquals(l, R.of(l).toLong());

        Decimal dec = 1;
        System.assertEquals(dec, R.of(dec).toDecimal());

        Double d = 1;
        System.assertEquals(d, R.of(d).toDouble());

        Date mDate = Date.newInstance(2018, 1, 1);
        System.assertEquals(mDate, R.of(mDate).toDate());

        Time mTime = Time.newInstance(10, 0, 0, 0);
        System.assertEquals(mTime, R.of(mTime).toTime());

        Datetime mDatetime = Datetime.newInstance(2018, 1, 1);
        System.assertEquals(mDatetime, R.of(mDatetime).toDatetime());

        System.assertEquals(mDatetime, R.of(mDate).toDatetime());

        Func f = R.equals;
        System.assertEquals(f, R.of(f).toFunc());
    }

    @IsTest
    private static void toListTest() {
        List<Long> listLong = new List<Long>{ 1 };
        System.assertEquals(listLong, R.of(listLong).toLongList());

        List<Decimal> listDecimal = new List<Decimal>{ 1 };
        System.assertEquals(listDecimal, R.of(listDecimal).toDecimalList());

        List<Double> listDouble = new List<Double>{ 1 };
        System.assertEquals(listDouble, R.of(listDouble).toDoubleList());

        List<Boolean> listBoolean = new List<Boolean>{ true };
        System.assertEquals(listBoolean, R.of(listBoolean).toBooleanList());

        List<Date> listDate = new List<Date>{ Date.newInstance(2018, 1, 1) };
        System.assertEquals(listDate, R.of(listDate).toDateList());

        List<Time> listTime = new List<Time>{ Time.newInstance(10, 0, 0, 0) };
        System.assertEquals(listTime, R.of(listTime).toTimeList());

        List<Datetime> listDatetime = new List<Datetime>{ Datetime.newInstance(2018, 1, 1) };
        System.assertEquals(listDatetime, R.of(listDatetime).toDatetimeList());

        List<Func> listFunc = new List<Func>{ R.equals };
        System.assertEquals(listFunc, R.of(listFunc).toFuncList());
    }

    @IsTest
    private static void toSetTest() {
        Set<String> sString = new Set<String>{ 'a', 'b' };
        System.assertEquals(sString, R.of(sSTring).toSet());

        Set<Id> sId = new Set<Id>{ '001000000000000000', '001000000000000001' };
        System.assertEquals(sString, R.of(sSTring).toSet());
    }

    @IsTest
    private static void toMapTest() {
        Map<String, SObject> mSObject = new Map<String, SObject>{ 'a' => new Account() };
        System.assertEquals(mSObject, R.of(mSObject).toSObjectMap());

        Map<String, Long> mLong = new Map<String, Long>{ 'a' => 1 };
        System.assertEquals(mLong, R.of(mLong).toLongMap());

        Map<String, Decimal> mDecimal = new Map<String, Decimal>{ 'a' => 1 };
        System.assertEquals(mDecimal, R.of(mDecimal).toDecimalMap());

        Map<String, Double> mDouble = new Map<String, Double>{ 'a' => 1 };
        System.assertEquals(mDouble, R.of(mDouble).toDoubleMap());

        Map<String, String> mString = new Map<String, String>{ 'a' => '1' };
        System.assertEquals(mString, R.of(mString).toStringMap());

        Map<String, Boolean> mBoolean = new Map<String, Boolean>{ 'a' => true };
        System.assertEquals(mBoolean, R.of(mBoolean).toBooleanMap());

        Map<String, Date> mDate = new Map<String, Date>{ 'a' => Date.newInstance(2018, 0, 0) };
        System.assertEquals(mDate, R.of(mDate).toDateMap());

        Map<String, Time> mTime = new Map<String, Time>{ 'a' => Time.newInstance(10, 0, 0, 0) };
        System.assertEquals(mTime, R.of(mTime).toTimeMap());

        Map<String, Datetime> mDatetime = new Map<String, Datetime>{ 'a' => Datetime.newInstance(2018, 0, 0) };
        System.assertEquals(mDatetime, R.of(mDatetime).toDatetimeMap());

        Map<String, Func> mFunc = new Map<String, Func>{ 'a' => R.equals };
        System.assertEquals(mFunc, R.of(mFunc).toFuncMap());
    }

    @IsTest
    private static void withTest() {
        System.assertEquals(
            'a b c',
            R.with('a', 'b', 'c')
                .doJoin(' ')
                .toString()
        );

        System.assertEquals(
            'a',
            R.with('a')
                .doJoin(' ')
                .toString()
        );
    }

    @IsTest
    private static void joinTest() {
        System.assertEquals(
            'a b c',
            R.of('abc')
                .doJoin(' ')
                .toString()
        );
    }

    @IsTest
    private static void invertTest() {
        System.assertEquals(
            new Map<String, Object>{ 'a' => new List<Object>{ 'b' } },
            R.of(new Map<String, Object>{ 'b' => 'a' })
                .invert()
                .toMap()
        );
    }

    @IsTest
    private static void invertObjTest() {
        System.assertEquals(
            new Map<String, Object>{ 'a' => 'b' },
            R.of(new Map<String, Object>{ 'b' => 'a' })
                .invertObj()
                .toMap()
        );
    }

    @IsTest
    private static void insertAllTest() {
        String msg = 'aba';

        System.assertEquals(
            'abcda',
            R.of(msg)
                .doInsertAll(2, 'cd')
                .toString()
        );
    }

    @IsTest
    private static void insertTest() {
        String msg = 'aba';

        System.assertEquals(
            'abca',
            R.of(msg)
                .doInsert(2, 'c')
                .toString()
        );
    }

    @IsTest
    private static void containsByTest() {
        String msg = 'aba';

        System.assert(
            R.of(msg)
                .containsBy(R.equals, 'a')
                .toBoolean()
        );
    }

    @IsTest
    private static void lastIndexOfTest() {
        String msg = 'aba';

        System.assertEquals(1, R.of(msg).lastIndexOf('b').toInteger());
    }

    @IsTest
    private static void indexOfTest() {
        String msg = 'aba';

        System.assertEquals(1, R.of(msg).indexOf('b').toInteger());
    }

    @IsTest
    private static void indexByTest() {
        String msg = 'aba';

        Map<String, Object> indexMap
            = R.of(msg)
                .indexBy(R.identity)
                .toMap();

        System.assertEquals(
            'a',
            indexMap.get('a')
        );
    }

    @IsTest
    private static void tailTest() {
        String msg = 'aba';

        System.assertEquals('ba', R.of(msg).tail().toString());
    }

    @IsTest
    private static void initTest() {
        String msg = 'aba';

        System.assertEquals('ab', R.of(msg).init().toString());
    }

    @IsTest
    private static void lastTest() {
        String msg = 'aba';

        System.assertEquals('a', R.of(msg).last().toString());
    }

    @IsTest
    private static void firstTest() {
        String msg = 'aba';

        System.assertEquals('a', R.of(msg).first().toString());
    }

    @IsTest
    private static void groupByTest() {
        String msg = 'aba';

        Map<String, Object> groupMap
            = R.of(msg)
                .groupBy(R.identity)
                .toMap();

        List<Object> mList = (List<Object>)groupMap.get('a');

        System.assertEquals(
            new List<Object>{ 'a', 'a' },
            mList
        );
    }

    @IsTest
    private static void toPairsTest() {
        Map<String, Object> source = new Map<String, Object>{
            'name' => 'abc'
        };
        List<R.Pair> pairs =
            R.of(source)
                .toPairs()
                .toPairList();
        System.assertEquals('abc', pairs.get(0).snd);
    }

    @IsTest
    private static void fromPairsTest() {
        List<Object> source = new List<Object>{
            new R.Pair('name', 'wilson'),
            new R.Pair('test', 'aa')
        };
        Map<String, Object> newMap =
            R.of(source)
                .fromPairs()
                .toMap();
        System.assertEquals('wilson', newMap.get('name'));
    }

    @IsTest
    private static void pairTest() {
        R.Pair testP = (R.Pair)R.pair.run(1, 2);
        System.assertEquals(1, testP.fst);
    }

    @IsTest
    private static void flattenTest() {
        List<Object> mList = new List<Object>{ 1, 2 };
        mList.add(new List<Object>{ 3, new List<Object>{ 4 } });
        System.assertEquals(
            new List<Object>{ 1, 2, 3, 4 },
            R.of(mList)
                .flatten()
                .toList()
        );
    }

    @IsTest
    private static void unnestTest() {
        List<Object> mList = new List<Object>{ 1, 2 };
        mList.add(new List<Object>{ 3 });
        System.assertEquals(
            new List<Object>{ 1, 2, 3 },
            R.of(mList)
                .unnest()
                .toList()
        );
    }

    @IsTest
    private static void findIndexTest() {
        List<Integer> ints = new List<Integer>{ 1, 2, 3 };
        System.assertEquals(
            2,
            R.of(ints)
                .findIndex(R.gt.apply(R.placeholder, 2))
                .toInteger()
        );
    }

    @IsTest
    private static void findLastTest() {
        List<Integer> ints = new List<Integer>{ 1, 2, 3 };
        System.assertEquals(
            3,
            R.of(ints)
                .findLast(R.gt.apply(R.placeholder, 2))
                .toInteger()
        );
    }

    @IsTest
    private static void findTest() {
        Map<String, Object> data = new Map<String, Object>{ 'name' => 'wilson' };
        R.Pair pair = (R.Pair)R.of(data)
            .find((Func)R.unary.run(R.equals.apply('wilson')))
            .toObject();
        System.assertEquals('name', pair.fst);
    }

    @IsTest
    private static void evolveTest() {
        Map<String, Object> data
            = R.of(new Map<String, Object>{ 'name' => 'wilson' })
                .evolve(new Map<String, Object>{ 'name' => R.always.run('adam') })
                .toMap();
        System.assertEquals('adam', data.get('name'));
    }

    @IsTest
    private static void endsWithTest() {
        System.assert(
            R.of(new List<Integer>{ 1, 2, 3 })
                .endsWith(new List<Integer>{ 2, 3 })
                .toBoolean()
        );
    }

    @IsTest
    private static void startsWithTest() {
        System.assert(
            R.of(new List<Integer>{ 1, 2, 3 })
                .startsWith(new List<Integer>{ 1, 2 })
                .toBoolean()
        );
    }

    @IsTest
    private static void dissocTest() {
        Map<String, Object> testM = new Map<String, Object>{ 'name' => 'wilson' };
        System.assertEquals(
            new Map<String, Object>(),
            R.of(testM)
                .dissoc('name')
                .toMap()
        );
    }

    @IsTest
    private static void defaultToTest() {
        System.assertEquals(
            3,
            R.of(null)
                .defaultTo(3)
                .toInteger()
        );
    }

    @IsTest
    private static void countByTest() {
        String msg = 'aba';

        Map<String, Integer> countMap
            = R.of(msg)
                .countBy(R.identity)
                .toIntegerMap();

        System.assertEquals(2, countMap.get('a'));
    }

    @IsTest
    private static void concatTest() {
        System.assertEquals(
            'abcd',
            R.of('ab')
                .concat('cd')
                .toString()
        );
    }

    @IsTest
    private static void cloneTest() {
        System.assertEquals(
            'abc',
            R.of('abc')
                .doClone()
                .toString()
        );
    }

    @IsTest
    private static void clampTest() {
        System.assertEquals(
            3,
            R.of(1)
                .clamp(3, 5)
                .toInteger()
        );
    }

    @IsTest
    private static void assocTest() {
        Map<String, Object> testM = new Map<String, Object>{ 'name' => 'wilson' };
        System.assertEquals(
            new Map<String, Object>{ 'name' => 'adam' },
            R.of(testM)
                .assoc('name', 'adam')
                .toMap()
        );

        Account acc = new Account();
        acc.Description = 'test';
        System.assertEquals(
            'abc',
            R.of(acc)
                .assoc('Description', 'abc')
                .toSObject()
                .get('Description')
        );
    }

    @IsTest
    private static void transformTest() {
        List<Integer> ints = new List<Integer>{ 1, 2, 3 };
        System.assertEquals(
            3,
            R.of(ints)
                .transform(R.size)
                .toInteger()
        );

        System.assertEquals(
            'abc',
            R.of('bc')
                .prepend('a')
                .toString()
        );
    }

    @IsTest
    private static void appendTest() {
        List<Integer> ints = new List<Integer>{ 1, 2, 3 };
        System.assertEquals(
            new List<Integer>{ 1, 2, 3, 4 },
            R.of(ints)
                .append(4)
                .toIntegerList()
        );

        System.assertEquals(
            'abc',
            R.of('ab')
                .append('c')
                .toString()
        );
    }

    @IsTest
    private static void prependTest() {
        List<Integer> ints = new List<Integer>{ 1, 2, 3 };
        System.assertEquals(
            new List<Integer>{ 4, 1, 2, 3 },
            R.of(ints)
                .prepend(4)
                .toIntegerList()
        );
    }

    @IsTest
    private static void someTest() {
        List<Integer> ints = new List<Integer>{ 1, 2, 3 };
        System.assert(
            R.of(ints)
                .some(R.gt.apply(R.placeholder, 2))
                .toBoolean()
        );

        System.assert(
            R.of('abc')
                .some(R.equals.apply('b'))
                .toBoolean()
        );
    }

    @IsTest
    private static void noneTest() {
        List<Integer> ints = new List<Integer>{ 1, 2, 3 };
        System.assert(
            R.of(ints)
                .none(R.gt.apply(R.placeholder, 4))
                .toBoolean()
        );

        System.assert(
            R.of('abc')
                .none(R.equals.apply('d'))
                .toBoolean()
        );
    }

    @IsTest
    private static void allTest() {
        List<Integer> ints = new List<Integer>{ 1, 2, 3 };
        System.assert(
            R.of(ints)
                .all(R.gt.apply(R.placeholder, 0))
                .toBoolean()
        );

        System.assert(
            R.of('abc')
                .all((Func)R.complement.run(R.isNil))
                .toBoolean()
        );
    }

    @IsTest
    private static void adjustTest() {
        List<Integer> ints = new List<Integer>{ 1, 2, 3 };
        System.assertEquals(
            new List<Integer>{ 1, 12, 3 },
            R.of(ints)
                .adjust(R.add.apply(10), 1)
                .toIntegerList()
        );

        System.assertEquals(
            'abd',
            R.of('abc')
                .adjust((Func)R.always.run('d'), 2)
                .toString()
        );
    }

    @IsTest
    private static void unionTest() {
        List<Integer> ints1 = new List<Integer>{ 1, 2, 3 };
        List<Integer> ints2 = new List<Integer>{ 2, 3, 4 };
        System.assertEquals(
            new List<Integer>{ 1, 2, 3, 4 },
            R.of(ints1)
                .union(ints2)
                .toIntegerList()
        );

        String s1 = 'abc';
        String s2 = 'cde';
        System.assertEquals(
            'abcde',
            R.of(s1)
                .union(s2)
                .toString()
        );
    }

    @IsTest
    private static void intersectionTest() {
        List<Integer> ints1 = new List<Integer>{ 1, 2, 3 };
        List<Integer> ints2 = new List<Integer>{ 2, 3, 4 };
        System.assertEquals(
            new List<Integer>{ 2, 3 },
            R.of(ints1)
                .intersection(ints2)
                .toIntegerList()
        );

        String s1 = 'abc';
        String s2 = 'cde';
        System.assertEquals(
            'c',
            R.of(s1)
                .intersection(s2)
                .toString()
        );
    }

    @IsTest
    private static void xorTest() {
        List<Integer> ints1 = new List<Integer>{ 1, 2, 3 };
        List<Integer> ints2 = new List<Integer>{ 2, 3, 4 };
        System.assertEquals(
            new List<Integer>{ 1, 4 },
            R.of(ints1)
                .xor(ints2)
                .toIntegerList()
        );

        String s1 = 'abc';
        String s2 = 'cde';
        System.assertEquals(
            'abde',
            R.of(s1)
                .xor(s2)
                .toString()
        );
    }

    @IsTest
    private static void differenceTest() {
        List<Integer> ints1 = new List<Integer>{ 1, 2, 3 };
        List<Integer> ints2 = new List<Integer>{ 2, 3, 4 };
        System.assertEquals(
            new List<Integer>{ 1 },
            R.of(ints1)
                .difference(ints2)
                .toIntegerList()
        );

        String s1 = 'abc';
        String s2 = 'cde';
        System.assertEquals(
            'ab',
            R.of(s1)
                .difference(s2)
                .toString()
        );
    }

    @IsTest
    private static void uniqTest() {
        List<Integer> ints = new List<Integer>{ 1, 2, 3, 2 };
        System.assertEquals(
            new List<Integer>{ 1, 2, 3 },
            R.of(ints)
                .uniq()
                .toIntegerList()
        );
    }

    @IsTest
    private static void containsTest() {
        List<Integer> ints = new List<Integer>{ 1, 2, 3 };
        System.assert(
            R.of(ints)
                .contains(2)
                .toBoolean()
        );

        String msg = 'abc';
        System.assert(
            R.of(msg)
                .contains('b')
                .toBoolean()
        );
    }

    @IsTest
    private static void containsKeyTest() {
        Map<String, Object> testM = new Map<String, Object>{ 'name' => 'wilson' };
        System.assert(
            R.of(testM)
                .containsKey('name')
                .toBoolean()
        );
    }

    @IsTest
    private static void cascadeTest() {
        List<Account> accList = getAccountList3();
        List<Account> newList = (List<Account>)R.of(accList)
            .sortBy((Func)R.cascade.run(
                (Func)R.ascend.run(R.prop.apply('Name')),
                (Func)R.ascend.run(R.prop.apply('Description'))
            ))
            .toSObjectList();
        System.assertEquals('a', newList.get(0).Name);
        System.assertEquals('a', newList.get(0).Description);
    }

    @IsTest
    private static void ascendTest() {
        List<Account> accList = getAccountList2();
        List<Account> newList = (List<Account>)R.of(accList)
            .sortBy((Func)R.ascend.run(R.prop.apply('Description')))
            .toSObjectList();
        System.assertEquals('a', newList.get(0).Description);
    }

    @IsTest
    private static void descendTest() {
        List<Account> accList = getAccountList2();
        List<Account> newList = (List<Account>)R.of(accList)
            .sortBy((Func)R.descend.run(R.prop.apply('Description')))
            .toSObjectList();
        System.assertEquals('b', newList.get(0).Description);
    }

    @IsTest
    private static void sortAndReverseTest() {
        List<Integer> ints = new List<Integer>{ 2, 1, 3 };
        System.assertEquals(
            R.of(ints)
                .sortDefault()
                .reverse(),
            R.of(ints)
                .sortBy((Func)R.flip.run(R.subtract))
        );
    }

    @IsTest
    private static void sortDefaultTest() {
        List<Integer> ints = new List<Integer>{ 3, 2, 1 };
        System.assertEquals(
            new List<Integer> { 1, 2, 3 },
            R.of(ints)
                .sortDefault()
                .toIntegerList()
        );

        System.assertEquals(
            'abc',
            R.of('cba')
                .sortDefault()
                .toString()
        );
    }

    @IsTest
    private static void sortTest() {
        List<Integer> ints = new List<Integer>{ 3, 2, 1 };
        System.assertEquals(
            new List<Integer> { 1, 2, 3 },
            R.of(ints)
                .sortBy(new TestComparator1())
                .toIntegerList()
        );
    }

    private class TestComparator1 extends Func {
        public override Object exec(Object arg1, Object arg2) {
            return (Integer)arg1 - (Integer)arg2;
        }
    }

    @IsTest
    private static void reverseTest() {
        List<Integer> ints = new List<Integer>{ 1, 2, 3 };
        System.assertEquals(
            new List<Integer> { 3, 2, 1 },
            R.of(ints)
                .reverse()
                .toIntegerList()
        );

        System.assertEquals(
            'cba',
            R.of('abc')
                .reverse()
                .toString()
        );
    }

    @IsTest
    private static void dropTest() {
        List<Integer> ints = new List<Integer>{ 1, 2, 3 };
        System.assertEquals(
            new List<Integer> { 3 },
            R.of(ints)
                .drop(2)
                .toIntegerList()
        );
    }

    @IsTest
    private static void dropRightTest() {
        List<Integer> ints = new List<Integer>{ 1, 2, 3 };
        System.assertEquals(
            new List<Integer> { 1 },
            R.of(ints)
                .dropRight(2)
                .toIntegerList()
        );
    }

    @IsTest
    private static void dropWhileTest() {
        List<Integer> ints = new List<Integer>{ 1, 2, 3 };
        System.assertEquals(
            new List<Integer> { 3 },
            R.of(ints)
                .dropWhile(R.lt.apply(R.placeholder, 3))
                .toIntegerList()
        );
    }

    @IsTest
    private static void dropRightWhileTest() {
        List<Integer> ints = new List<Integer>{ 1, 2, 3 };
        System.assertEquals(
            new List<Integer> { 1 },
            R.of(ints)
                .dropRightWhile(R.gt.apply(R.placeholder, 1))
                .toIntegerList()
        );
    }

    @IsTest
    private static void takeTest() {
        List<Integer> ints = new List<Integer>{ 1, 2, 3 };
        System.assertEquals(
            new List<Integer> { 1, 2 },
            R.of(ints)
                .take(2)
                .toIntegerList()
        );

        System.assertEquals(
            'ab',
            R.of('abc')
                .take(2)
                .toString()
        );
    }

    @IsTest
    private static void takeRightTest() {
        List<Integer> ints = new List<Integer>{ 1, 2, 3 };
        System.assertEquals(
            new List<Integer> { 2, 3 },
            R.of(ints)
                .takeRight(2)
                .toIntegerList()
        );

        System.assertEquals(
            'bc',
            R.of('abc')
                .takeRight(2)
                .toString()
        );
    }

    @IsTest
    private static void takeWhileTest() {
        List<Integer> ints = new List<Integer>{ 1, 2, 3 };
        System.assertEquals(
            new List<Integer> { 1, 2 },
            R.of(ints)
                .takeWhile(R.lt.apply(R.placeholder, 3))
                .toIntegerList()
        );

        System.assertEquals(
            'a',
            R.of('abc')
                .takeWhile(R.equals.apply('a'))
                .toString()
        );
    }

    @IsTest
    private static void takeRightWhileTest() {
        List<Integer> ints = new List<Integer>{ 1, 2, 3 };
        System.assertEquals(
            new List<Integer> { 2, 3 },
            R.of(ints)
                .takeRightWhile(R.gt.apply(R.placeholder, 1))
                .toIntegerList()
        );

        System.assertEquals(
            '',
            R.of('abc')
                .takeRightWhile(R.equals.apply('a'))
                .toString()
        );
    }

    @IsTest
    private static void sliceTest() {
        List<Integer> ints = new List<Integer>{ 1, 2, 3 };
        System.assertEquals(
            new List<Integer> { 2 },
            R.of(ints)
                .slice(1, 2)
                .toIntegerList()
        );

        System.assertEquals(
            'b',
            R.of('abc')
                .slice(1, 2)
                .toString()
        );
    }

    @IsTest
    private static void sumTest() {
        List<Integer> ints = new List<Integer>{ 1, 2, 3 };
        System.assertEquals(
            6,
            R.of(ints)
                .sum()
                .toInteger()
        );
    }

    @IsTest
    private static void isEmptyTest() {
        List<Integer> ints = new List<Integer>{ 1, 2, 3 };
        System.assertEquals(
            false,
            R.of(ints)
                .isEmpty()
                .toBoolean()
        );
    }

    @IsTest
    private static void isNotEmptyTest() {
        List<Integer> ints = new List<Integer>{ 1, 2, 3 };
        System.assertEquals(
            true,
            R.of(ints)
                .isNotEmpty()
                .toBoolean()
        );
    }

    @IsTest
    private static void lengthTest() {
        List<Integer> ints = new List<Integer>{ 1, 2, 3 };
        System.assertEquals(
            3,
            R.of(ints)
                .length()
                .toInteger()
        );
    }

    @IsTest
    private static void reduceTest() {
        List<Integer> ints = new List<Integer>{ 1, 2, 3 };
        System.assertEquals(
            6,
            R.of(ints)
                .reduce(R.add, 0)
                .toInteger()
        );

        String msg = 'abc';
        System.assertEquals(
            'a',
            R.of(msg)
                .reduce((Func)R.always.run('a'), null)
                .toString()
        );
    }

    @IsTest
    private static void pluckTest() {
        List<Account> accList = getAccountList();
        System.assertEquals(
            new List<String>{ 'desc' },
            R.of(accList)
                .pluck('Description')
                .toStringList()
        );
    }

    @IsTest
    private static void doMapTest() {
        List<Account> accList = getAccountList();
        System.assertEquals(
            new List<String>{ 'desc' },
            R.of(accList)
                .doMap(R.prop.apply('Description'))
                .toStringList()
        );
    }

    @IsTest
    private static void filterFieldsTest() {
        List<Account> accList = getAccountList();
        System.assert(
            R.of(accList)
                .filter(new Map<String, Object>{
                    'Description' => 'desc'
                })
                .toSObjectList()
                .size() == 1
        );
    }

    @IsTest
    private static void filterFieldValueTest() {
        List<Account> accList = getAccountList();
        System.assert(
            R.of(accList)
                .filter('Description', 'desc')
                .toSObjectList()
                .size() == 1
        );
    }

    @IsTest
    private static void filterFieldTest() {
        List<Account> accList = getAccountList();
        System.assert(
            R.of(accList)
                .filter('Description')
                .toSObjectList()
                .size() == 1
        );
    }

    @IsTest
    private static void filterPredTest() {
        List<Integer> ints = new List<Integer>{ 1, 2, 3 };
        System.assertEquals(
            new List<Integer>{ 1 },
            R.of(ints).filter(
                (Func)R.lt.apply(R.placeholder, 2)
            ).toIntegerList()
        );
    }

    @IsTest
    private static void toArrayTest() {
        List<Integer> ints = new List<Integer>{ 1, 2, 3 };
        R.of(ints).forEach(R.debug);
        System.assertEquals(ints, R.of(ints).toIntegerList());
    }

    private static List<Account> getAccountList() {
        Account acc = new Account();
        acc.Description = 'desc';
        List<Account> accList = new List<Account>{ acc };
        return accList;
    }

    private static List<Account> getAccountList2() {
        Account acc1 = new Account();
        acc1.Description = 'a';
        Account acc2 = new Account();
        acc2.Description = 'b';
        List<Account> accList = new List<Account>{ acc1, acc2 };
        return accList;
    }

    private static List<Account> getAccountList3() {
        Account acc1 = new Account();
        acc1.Name = 'b';
        acc1.Description = 'b';
        Account acc2 = new Account();
        acc2.Name = 'a';
        acc2.Description = 'b';
        Account acc3 = new Account();
        acc3.Name = 'a';
        acc3.Description = 'a';
        List<Account> accList = new List<Account>{ acc1, acc2, acc3 };
        return accList;
    }

    @IsTest
    private static void juxtTest() {
        List<Func> fns = new List<Func>{ R.add, R.subtract };
        List<Object> data = (List<Object>)R.juxt.run(fns, 1, 2);
        System.assertEquals(3, data.get(0));
        System.assertEquals(-1, data.get(1));
    }

    @IsTest
    private static void applySpecTest() {
        Map<String, Object> spec = new Map<String, Object>{
            'add' => R.add,
            'subtract' => R.subtract
        };

        Map<String, Object> data = (Map<String, Object>)R.applySpec.run(spec, 1, 2);
        System.assertEquals(3, data.get('add'));
        System.assertEquals(-1, data.get('subtract'));
    }

    @IsTest
    private static void bimapTest() {
        Map<String, Object> m1 = new Map<String, Object>{ 'name' => 2 };
        System.assertEquals(
            new Map<String, Object>{ 'new_name' => 3 },
            (Map<String, Object>)R.bimap.run(R.always.run('new_name'), R.nAry.run(
                1,
                R.pipe.run(
                    R.inc,
                    R.toInteger
                )
            ), m1)
        );
    }

    @IsTest
    private static void compareTest() {
        System.assert((Integer)R.compare.run(1, 2) < 0);
    }

    @IsTest
    private static void comparatorTest() {
        Func testF = (Func)R.comparator.run(new TestComparator2());
        System.assertEquals(1, testF.run(2, 1));
    }

    private class TestComparator2 extends Func {
        public override Object exec(Object arg1, Object arg2) {
            Integer num1 = (Integer)arg1;
            Integer num2 = (Integer)arg2;
            return num1 < num2;
        }
    }

    @IsTest
    private static void whereSatisfiesTest() {
        Account acc = new Account();
        acc.Description = 'desc';
        System.assert((Boolean)R.whereSatisfies.run(
            new Map<String, Func> {
                'Description' => (Func)R.complement.run(R.isNil)
            },
            acc
        ));
    }

    @IsTest
    private static void whereEqTest() {
        Account acc = new Account();
        acc.Description = 'desc';
        System.assert((Boolean)R.whereEq.run(
            new Map<String, Object> {
                'Description' => 'desc'
            },
            acc
        ));
    }

    @IsTest
    private static void propEqTest() {
        Account acc = new Account();
        acc.Description = 'desc';
        System.assert((Boolean)R.propEq.run('Description', 'desc', acc));
    }

    @IsTest
    private static void propTest() {
        Account acc = new Account();
        acc.Description = 'desc';
        System.assertEquals('desc', R.prop.run('Description', acc));
    }

    @IsTest
    private static void pathTest() {
        Account acc = new Account();
        acc.Name = 'Name';
        acc.Description = 'desc';
        insert acc;

        acc = [ SELECT Id, Owner.Id FROM Account WHERE ID = :acc.Id ];
        System.assert(R.path.run('Owner.Id', acc) != null);
    }

    @IsTest
    private static void hasTest() {
        Account acc = new Account();
        acc.Description = 'desc';
        System.assert((Boolean)R.has.run('Description', acc));
    }

    @IsTest
    private static void memoizeTest() {
        Func testF = (Func)R.memoize.run(
            R.add.apply(1),
            'testF',
            R.toString
        );

        System.assertEquals(2, testF.run(1));
        System.assertEquals(2, testF.run(1));
    }

    @IsTest
    private static void onceTest() {
        Func testF = (Func)R.once.run(R.add.apply(1), 'testF');

        System.assertEquals(2, testF.run(1));
        System.assertEquals(2, testF.run(3));
    }

    @IsTest
    private static void useWithTest() {
        Func testF = (Func)R.useWith.run(
            R.multiply,
            R.add.apply(1),
            R.subtract.apply(1)
        );

        System.assertEquals(-4, testF.run(1, 3));
    }

    @IsTest
    private static void convergeTest() {
        Func testF = (Func)R.converge.run(
            R.multiply,
            R.add,
            R.subtract
        );

        System.assertEquals(-8, testF.run(1, 3));
    }

    @IsTest
    private static void flipTest() {
        Func testF = (Func)R.flip.run(R.divide);
        System.assertEquals(2, testF.run(2, 4));
    }

    @IsTest
    private static void unlessTest() {
        Func testF = (Func)R.unless.run(
            R.lt.apply(0),
            R.always.run(0)
        );
        System.assertEquals(0, testF.run(-3));
        System.assertEquals(new List<Object>{ 3 }, testF.run(3));
    }

    @IsTest
    private static void doWhenTest() {
        Func testF = (Func)R.doWhen.run(
            R.lt.apply(0),
            R.always.run(1)
        );
        System.assertEquals(1, testF.run(3));
        System.assertEquals(new List<Object>{ -3 }, testF.run(-3));
    }

    @IsTest
    private static void ifElseTest() {
        Func testF = (Func)R.ifElse.run(
            R.lt.apply(0),
            R.always.run(1),
            R.always.run(0)
        );
        System.assertEquals(1, testF.run(3));
        System.assertEquals(0, testF.run(-3));
        System.assertEquals(0, testF.run(0));
    }

    @IsTest
    private static void condTest() {
        Func testF = (Func)R.cond.runN(new List<Object>{
            R.lt.apply(0), R.always.run(1),
            R.gt.apply(0), R.always.run(-1),
            R.equals.apply(0), R.always.run(0)
        });
        System.assertEquals(1, testF.run(3));
        System.assertEquals(-1, testF.run(-3));
        System.assertEquals(0, testF.run(0));
    }

    @IsTest
    private static void placeholderTest() {
        Func divideBy2 = R.divide.apply(R.placeholder, 2);
        System.assertEquals(3, divideBy2.run(6));
    }

    @IsTest
    private static void identityTest() {
        System.assertEquals(1, R.identity.run(1));
    }

    @IsTest
    private static void noopTest() {
        System.assertEquals(null, R.noop.run(1));
    }

    @IsTest
    private static void gtTest() {
        System.assert((Boolean)R.gt.run(
            3,
            2
        ));
    }

    @IsTest
    private static void gteTest() {
        System.assert((Boolean)R.gte.run(
            3,
            2
        ));
    }

    @IsTest
    private static void lteTest() {
        System.assert((Boolean)R.lt.run(
            1,
            2
        ));
    }

    @IsTest
    private static void ltTest() {
        System.assert((Boolean)R.lt.run(
            1,
            2
        ));
    }

    @IsTest
    private static void equalsTest() {
        System.assert((Boolean)R.equals.run(
            'abc',
            'abc'
        ));
    }

    @IsTest
    private static void andTest() {
        System.assert((Boolean)R.doAnd.run(
            true,
            true,
            true
        ));
    }

    @IsTest
    private static void orTest() {
        System.assert((Boolean)R.doOr.run(
            false,
            false,
            true
        ));
    }

    @IsTest
    private static void notTest() {
        System.assert((Boolean)R.doNot.run(
            false
        ));
    }

    @IsTest
    private static void complementTest() {
        Func cf = (Func)R.complement.run(
            R.isNil
        );
        System.assert((Boolean)cf.run(1));
    }

    @IsTest
    private static void anyPassTest() {
        Func anyF = (Func)R.anyPass.run(
            R.isNil,
            R.isNil
        );
        System.assert((Boolean)anyF.run(null));
    }

    @IsTest
    private static void allPassTest() {
        Func allF = (Func)R.allPass.run(
            R.isNil,
            R.isNil
        );
        System.assert((Boolean)allF.run(null));
    }

    @IsTest
    private static void isNilTest() {
        System.assert((Boolean)R.isNil.run(null));
    }

    @IsTest
    private static void composeTest() {
        Func myF = (Func)R.compose.run(
            R.multiply.apply(2),
            R.add.apply(1),
            R.multiply.apply(3)
        );
        R.debug.run('test debug');
        System.assertEquals(8, myF.run(1));
    }

    @IsTest
    private static void pipeTest() {
        Func myF = (Func)R.pipe.run(
            R.multiply.apply(2),
            R.add.apply(1),
            R.multiply.apply(3)
        );
        System.assertEquals(9, myF.run(1));
    }

    @IsTest
    private static void addTest() {
        System.assertEquals(3, R.add.run(1, 2));
    }

    @IsTest
    private static void subtractTest() {
        System.assertEquals(-1, R.subtract.run(1, 2));
    }

    @IsTest
    private static void multiplyTest() {
        System.assertEquals(2, R.multiply.run(1, 2));
    }

    @IsTest
    private static void divideTest() {
        System.assertEquals(0.5, R.divide.run(1, 2));
    }

    @IsTest
    private static void modTest() {
        System.assertEquals(1, R.mod.run(1, 2));
    }

    @IsTest
	private static void okTest() {
        Func increment = R.add.apply(1);

        Object ret = increment.apply(2).run();

        System.assertEquals(3, ret);
	}

    @IsTest
    private static void constantTest() {
        Func f = R.constant.apply(1);
        System.assertEquals(1, f.run(2));
    }

    @IsTest
    private static void throwExceptionTest() {
        try {
            R.throwException.run(new Func.FuncException('test'));
            System.assertEquals(true, false);
        }
        catch(Exception e) {
            System.assertEquals(true, true);
        }
    }

    @IsTest
    private static void dbQueryTest() {
        R.dbInsert.run(new Account(Name='test'));

        List<SObject> result = (List<SObject>)R.dbQuery.run('SELECT Id FROM Account WHERE Name = \'test\'');

        System.assert(result != null && !result.isEmpty());
    }

    @IsTest
    private static void dbInsertTest() {
        R.dbInsert.run(new Account(Name='test'));

        Account acc = [ SELECT Id FROM Account WHERE Name = 'test' ];

        System.assert(acc != null);
    }

    @IsTest
    private static void dbUpdateTest() {
        R.dbInsert.run(new Account(Name='test'));

        Account acc = [ SELECT Id FROM Account WHERE Name = 'test' ];

        acc.Description = 'test';

        R.dbUpdate.run(acc);

        acc = [ SELECT Id, Description FROM Account WHERE Name = 'test' ];

        System.assertEquals('test', acc.Description);
    }

    @IsTest
    private static void dbDeleteTest() {
        R.dbInsert.run(new Account(Name='test'));

        Account acc = [ SELECT Id FROM Account WHERE Name = 'test' ];

        System.assert(acc != null);

        R.dbDelete.run(acc);

        List<Account> accList = [ SELECT Id FROM Account WHERE Name = 'test' ];

        System.assert(accList.isEmpty());
    }

    @IsTest
    private static void requireTest() {
        Func add = Func.require('R.add');
        System.assertEquals(3, add.run(1, 2));

        Func nonsense = Func.require('R.nonsense', R.noop);
        System.assert(nonsense.run() == null);
    }

    private class AddFunc extends Func {
        public override Object exec(Object a, Object b) {
            return (Integer)a + (Integer)b;
        }
    }
}
