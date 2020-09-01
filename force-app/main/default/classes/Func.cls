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
 * Base class for Func Object
 *
 * A Func object represents a function, namely a block of business logic
 * Users can create new functions by composing smaller functions, or extend from this
 * class to create any custom functions
 *
 * Here is a sample custom function:
 *
 * class CustomFunc extends Func {
 *     public CustomFunc() {
 *         super(2);
 *     }
 *
 *     public override Object exec(Object arg1, Object arg2) {
 *         // TODO
 *         return null;
 *     }
 * }
 *
 * In the constructor, we may specify the length of the Func by calling 'super(2)',
 * or we can skip this to allow a variadic argument function
 *
 * There are a few 'exec' methods from Func that we can override to provide our own
 * implementations
 *
 * Extend 'exec()' if our Func does not accept any argument
 * Extend 'exec(Object)' if our Func accepts one argument
 * Extend 'exec(Object, Object)' if our Func accepts two arguments
 * Extend 'exec(Object, Object, Object)' if our Func accepts three arguments
 * Extend 'execMore(List<Object>)' if our Func accepts more than three arguments
 * Extend 'execN(List<Object>)' if our Func accepts variadic arguments
 *
 * Here is the guide to help us decide which one is invoked
 *
 * If Func length is not specified, the 'exec' method is invoked according to the
 * actual number of arguments
 *
 * If Func length is 0, only the 'exec()' method is invoked
 *
 * If Func length is 1, only the 'exec(Object)' method is invoked
 *
 * If Func length is 2, only the 'exec(Object, Object)' method is invoked
 *
 * If Func length is 3, only the 'exec(Object, Object, Object)' method is invoked
 *
 * If Func length is more than 3, only the 'execMore(List<Object>)' method is invoked
 *
 * There are two stages when invoking a Func:
 * a) Applying (optional)
 * Applying is the stage where the Func receives some arguments and stores them for
 * invocation in the future
 *
 * Here is how we apply a Func:
 *
 * Func f = R.equals.apply(1);
 *
 * If we want to apply more than 3 arguments, we have to use:
 *
 * Func f = SomeFunc.applyN(a, b, c, d, ...);
 *
 * Each applying will in fact create a new Func, which means that the original Func will
 * not get affected
 *
 * b) Running
 * Running is the stage where the Func uses all the arguments it has collected and produces
 * the final result
 *
 * Here is how we run a Func:
 *
 * Object result = f.run(1);
 *
 * If we want to run the func with more than 3 arguments, we have to use:
 *
 * Object result = f.runN(a, b, c, d, ...);
 *
 * Suppose Func f takes three arugments, the following cases are equivalent:
 * f.apply(a, b, c).run() ===
 * f.run(a, b, c) ===
 * f.apply(a).apply(b).apply(c).run() ===
 * f.apply(a).apply(b, c).run() ===
 * f.apply(a, b).apply(c)
 * */
public virtual class Func {
    // The length of the function
    private Integer length = -1;

    // The applied arguments
    private List<Object> args;

    protected Func() {
        this(-1, new List<Object>());
    }

    protected Func(Integer length) {
        this(length, new List<Object>());
    }

    protected Func(List<Object> args) {
        this(-1, args);
    }

    protected Func(Integer length, List<Object> args) {
        this.length = length;
        this.args = args;
    }

    private Object getNthArg(List<Object> args, Integer index) {
        return index < args.size() && index >= 0 ? args.get(index) : null;
    }

    private void setAppliedArguments(List<Object> args) {
        this.args = args;
    }

    public List<Object> getAppliedArguments() {
        return this.args;
    }

    /**
     *  Apply one argument
     * */
    public Func apply(Object arg1) {
        return this.applyN(new List<Object>{ arg1 });
    }

    /**
     * Apply two arguments
     * */
    public Func apply(Object arg1, Object arg2) {
        return this.applyN(new List<Object>{ arg1, arg2 });
    }

    /**
     * Apply three arguments
     * */
    public Func apply(Object arg1, Object arg2, Object arg3) {
        return this.applyN(new List<Object>{ arg1, arg2, arg3 });
    }

    private List<Object> concatArgs(List<Object> oldArgs, List<Object> newArgs) {
        List<Object> newList = new List<Object>();
        List<Object> newArgsCopy = new List<Object>(newArgs);

        for(Object oldArg : oldArgs) {
            if(oldArg == R.placeholder && !newArgsCopy.isEmpty()) {
                newList.add(newArgsCopy.remove(0));
            }
            else {
                newList.add(oldArg);
            }
        }

        if(!newArgsCopy.isEmpty()) {
            newList.addAll(newArgsCopy);
        }

        return newList;
    }

    /**
     * Apply N arguments
     * */
    public Func applyN(List<Object> args) {
        List<Object> newList = this.concatArgs(this.args, args);

        Func newFunc = this.clone();
        newFunc.setAppliedArguments(newList);
        return newFunc;
    }

    /**
     * Execute with no argument
     * */
    protected virtual Object exec() {
        throw new Func.FuncException('Function with no argument is not implemented');
    }

    /**
     * Execute with one argument
     * */
    protected virtual Object exec(Object arg1) {
        throw new Func.FuncException('Function with one argument is not implemented');
    }

    /**
     * Execute with two arguments
     * */
    protected virtual Object exec(Object arg1, Object arg2) {
        throw new Func.FuncException('Function with two arguments is not implemented');
    }

    /**
     * Execute with three arguments
     * */
    protected virtual Object exec(Object arg1, Object arg2, Object arg3) {
        throw new Func.FuncException('Function with three arguments is not implemented');
    }

    /**
     * Execute with more than three arguments
     * */
    protected virtual Object execMore(List<Object> args) {
        throw new Func.FuncException('Function with more than three arguments is not implemented');
    }

    /**
     * Execute with various arguments
     * */
    protected virtual Object execN(List<Object> args) {
        if(args.size() == 0) {
            return this.exec();
        }
        else if(args.size() == 1) {
            return this.exec(args.get(0));
        }
        else if(args.size() == 2) {
            return this.exec(args.get(0), args.get(1));
        }
        else if(args.size() == 3) {
            return this.exec(args.get(0), args.get(1), args.get(2));
        }
        else {
            return this.execMore(args);
        }
    }

    public Object run(Object arg1) {
        return this.runN(new List<Object>{ arg1 });
    }

    public Object run(Object arg1, Object arg2) {
        return this.runN(new List<Object>{ arg1, arg2 });
    }

    public Object run(Object arg1, Object arg2, Object arg3) {
        return this.runN(new List<Object>{ arg1, arg2, arg3 });
    }

    public Object runN(List<Object> args) {
        List<Object> allArgs = this.concatArgs(this.args, args);
        if(this.length < 0) {
            return this.execN(allArgs);
        }
        else if(this.length == 0) {
            return this.exec();
        }
        else if(this.length == 1) {
            return this.exec(getNthArg(allArgs, 0));
        }
        else if(this.length == 2) {
            return this.exec(getNthArg(allArgs, 0), getNthArg(allArgs, 1));
        }
        else if(this.length == 3) {
            return this.exec(getNthArg(allArgs, 0), getNthArg(allArgs, 1), getNthArg(allArgs, 2));
        }
        else {
            return this.execMore(allArgs);
        }
    }

    public Object run() {
        return this.runN(new List<Object>());
    }

    public virtual override String toString() {
        String className = 'Func';
        List<String> params = new List<String>();
        if(this.length < 0) {
            params.add('Object...');
        }
        else {
            for(Integer i = 0; i < this.length; i++) {
                params.add('Object');
            }
        }

        return className + ':: (' + String.join(params, ', ') + ') => Object';
    }

    // All Installed Func Packages
    private static Map<String, IPackage> packages = null;

    private static void loadPackages() {
        Func.packages = new Map<String, IPackage>();

        List<ApexClass> cList = [ SELECT Id, Name, NamespacePrefix FROM ApexClass WHERE Name LIKE '%Package' OR Name = 'R' ];

        for(ApexClass c : cList) {
            String name = c.Name;
            String prefix = c.NamespacePrefix;
            String qName = name;
            if(prefix != null) {
                qName = prefix + '.' + name;
            }

            try {
                Type pkgType = Type.forName(qName);
                if (pkgType == null) {
                    throw new FuncException('Failed to load class ' + qName);
                }
                IPackage pkg = (IPackage)pkgType.newInstance();

                Func.packages.put(Func.getPackageName(name), pkg);
                Func.packages.put(Func.getPackageName(qName), pkg);
            }
            catch(Exception e) {
                System.debug('Failed to load package: ' + e.getStackTraceString());
            }
        }
    }

    private static String getPackageName(String name) {
        return name == null ? null : name.removeEndIgnoreCase('Package');
    }

    /**
     * List all installed packages names
     *
     * Example:
     * System.debug(Func.listPackages());
     *
     * @return Set<String>
     * */
    public static Set<String> listPackages() {
        return Func.packages.keySet();
    }

    /**
     * List all Function names in the package
     *
     * Example:
     * System.debug(Func.showPackage('R'));
     *
     * @param packageName The package name
     * @return Set<String>
     * */
    public static Set<String> showPackage(String packageName) {
        IPackage pkg = Func.packages.get(packageName);

        return pkg == null ? new Set<String>() : pkg.export().keySet();
    }

    /**
     * Require the Function by the qualified name
     * The qualified name is something like 'prpt__pkgName.funcName'
     *
     * Example:
     * Func f = Func.require('R.add');
     *
     * @param qualifiedName The qualified name of the function
     * @return Func
     * */
    public static Func require(String qualifiedName) {
        Func defaultFn = null;
        return Func.require(qualifiedName, defaultFn);
    }

    /**
     * Require the Function by the qualified name
     * The qualified name is something like 'prpt__pkgName.funcName'
     *
     * Example:
     * Func f = Func.require('R.add', R.noop);
     *
     * @param qualifiedName The qualified name of the function
     * @param defaultFn The default Func
     * @return Func
     * */
    public static Func require(String qualifiedName, Func defaultFn) {
        if(!String.isBlank(qualifiedName)) {
            Integer pos = qualifiedName.indexOf('.');
            if(pos > 0) {
                String packageName = qualifiedName.substring(0, pos);
                String funcName = qualifiedName.substring(pos + 1);

                return Func.require(packageName, funcName, defaultFn);
            }
        }

        return defaultFn;
    }

    /**
     * Require the Func from the package and the name
     *
     * Example:
     * Func f = Func.require('R', 'add');
     *
     * @param packageName The name of the package
     * @param funcName The name of the Func
     * @return Func
     * */
    public static Func require(String packageName, String funcName) {
        return Func.require(packageName, funcName, null);
    }

    /**
     * Require the Func from the package and the name, with the fallback Func
     *
     * Example:
     * Func f = Func.require('R', 'add', R.noop);
     *
     * @param packageName The name of the package
     * @param funcName The name of the Func
     * @param defaultFn The default Func
     * @return Func
     * */
    public static Func require(String packageName, String funcName, Func defaultFn) {
        if(Func.packages == null) {
            Func.loadPackages();
        }

        IPackage pkg = Func.packages.get(packageName);

        Func f = defaultFn;

        if(pkg != null) {
            f = pkg.require(funcName);

            if(f == null) {
                f = defaultFn;
            }
        }

        return f;
    }

    /**
     * The Func Package
     *
     * Generally speaking, this package is used to export functions from one library
     * so that they can be used by other libraries without having direct dependency
     * on the classes
     *
     * The best practice is to have a top level apex class extending the Func package, so that
     * this file can be included if the Func package feature is enabled, or discarded otherwise
     *
     * Most of the time, use 'Func.DefaultPackage' instead
     *
     * */
    public interface IPackage {
        /**
         * Export all the Funcs defined within this package
         *
         * @return Map<String, Func>
         * */
        Map<String, Func> export();

        /**
         * Require the Func by the name
         *
         * @param funcName The name of the Func
         * @return Func
         * */
        Func require(String funcName);
    }

    /**
     * The default package to be extended
     *
     * Example:
     * public class MyPackage extends Func.DefaultPackage {
     *     public override void init() {
     *         this.export('test', new TestFunc());
     *     }
     * }
     * */
    public virtual class DefaultPackage implements IPackage {
        private Map<String, Func> funcs = new Map<String, Func>();

        /**
         * Default constructor
         * */
        public DefaultPackage() {
            this.init();
        }

        /**
         * Override this method to provide your own Funcs
         * */
        public virtual void init() {
        }

        /**
         * Export all the defined Funcs
         *
         * @return Map<String, Func>
         * */
        public Map<String, Func> export() {
            return this.funcs;
        }

        /**
         * Require a Func by the name
         *
         * @param funcName The name of the Func
         * @return Func
         * */
        public Func require(String funcName) {
            return this.funcs.get(funcName);
        }

        /**
         * Use this method to define your Func to be exported
         *
         * @param name The name of the Func
         * @param f The Func
         * */
        protected void export(String name, Func f) {
            this.funcs.put(name, f);
        }
    }

    public class FuncException extends Exception {
    }
}
