# ADO.NET SQLite Data Provider
## Version 1.0.117.0 - November 28, 2022
## Using [SQLite 3.40.0](https://www.sqlite.org/releaselog/3_40_0.html)
### Originally written by Robert Simpson
### Released to the public domain, use at your own risk!
### Official provider website:[https://system.data.sqlite.org/](https://system.data.sqlite.org/)
### Legacy versions:[https://sourceforge.net/projects/sqlite-dotnet2/](https://sourceforge.net/projects/sqlite-dotnet2/)

----

This is the official GitHub mirror for the [System.Data.SQLite project](https://system.data.sqlite.org/).

The current development version can be downloaded from [https://system.data.sqlite.org/index.html/timeline?y=ci](https://system.data.sqlite.org/index.html/timeline?y=ci)

----

**Features**
------------

*   Written from scratch on Visual Studio 2008 specifically for ADO.NET, implementing all the base classes and features recently introduced in the framework, including automatic transaction enlistment.
*   Supports the Full and Compact .NET Framework, and native C/C++ development. 100% binary compatible with the original sqlite3.dll.
*   Full support for Mono via a "managed only" provider that runs against the official SQLite 3.6.1 or higher library.
*   Full Entity Framework support (ADO.NET 3.5 SP1).
*   On the Compact Framework, it is faster than SQL Server Mobile. SQLite's installed size is a fraction of SQL Mobile's. It uses less memory at runtime, runs queries faster, and has a smaller database file size as well.
*   Encrypted database support. Encrypted databases are fully encrypted and support both binary and cleartext password types.
*   Visual Studio design-time Support, works with all versions of Visual Studio 2005/2008/2010/2012/2013/2015. You can add a SQLite database to the Servers list, design queries with the Query Designer, drag-and-drop tables onto a Typed DataSet, etc.
    Due to Visual Studio licensing restrictions, the Express Editions can no longer be supported.
*   Full SQLite schema editing inside Visual Studio. You can create/edit tables, views, triggers, indexes, check constraints and foreign keys.
*   Single file redistributable (except on Compact Framework). The core SQLite native code and the ADO.NET managed wrapper are combined into one mixed-mode assembly.
*   Binaries included for x86, x64, Itanium, and ARM processors.
    Itanium processor support not currently included.
*   DbProviderFactory support.
*   Full support for ATTACH'ed databases. Exposed as _Catalogs_ in the schema. When cloning a connection, all attached databases are automatically re-attached to the new connection.
*   DbConnection.GetSchema(...) support includes _ReservedWords_, _MetaDataCollections_, _DataSourceInformation_, _DataTypes_, _Columns_, _Tables_, _Views_, _ViewColumns_, _Catalogs_, _Indexes_, _IndexColumns_, _ForeignKeys_ and _Triggers_.
*   Enhanced DbDataReader.GetSchemaTable() functionality returns catalog, namespace and detailed schema information even for complex queries.
*   Named and unnamed parameters.
*   Full UTF-8 and UTF-16 support, each with optimized pipelines into the native database core.
*   Multiple simultaneous DataReaders (one DataReader per Command however).
*   Full support for user-defined scalar and aggregate functions, encapsulated into an easy-to-use base class in which only a couple of overrides are necessary to implement new SQL functions.
*   Full support for user-defined collating sequences, every bit as simple to implement as user-defined functions and uses the same base class.
*   Full source for the entire engine and wrapper. No copyrights. Public Domain. 100% free for commercial and non-commercial use.

**Design-Time Support**
-----------------------

Download and run one of the setup packages and then select the "**Install the designer components for Visual Studio 20XX.**" option when prompted.

**DbFactory Support (Desktop Framework)**
-----------------------------------------

In order to use the SQLiteFactory and have the SQLite data provider enumerated in the DbProviderFactories methods, you must add the following segment into your application's app.config file:

```
<configuration>
    <system.data>
        <DbProviderFactories>
            <remove invariant="System.Data.SQLite" />
            <add name="SQLite Data Provider" invariant="System.Data.SQLite" description=".NET Framework Data Provider for SQLite"
                 type="System.Data.SQLite.SQLiteFactory, System.Data.SQLite, Version=1.0.117.0, Culture=neutral, PublicKeyToken=db937bc2d44ff139" />
        </DbProviderFactories>
    </system.data>
</configuration>
```

See the help documentation for further details on implementing both version-specific (GAC enabled) and version independent DBProviderFactories support.

Compiling for the .NET Compact Framework
----------------------------------------

Just change the target platform from Win32 to Compact Framework and recompile. **The Compact Framework has no support for enumerating attributes in an assembly, therefore all user-defined collating sequences and functions must be explicitly registered.** See the **testce** sample application for an example of how to explicitly register user-defined collating sequences and functions.

**Distributing or Deploying System.Data.SQLite**
------------------------------------------------

On the desktop, when using the statically linked mixed-mode assembly, only the **System.Data.SQLite.dll** file needs to be distributed with your application(s). This dynamic link library contains both the managed provider and the SQLite native library. For other build configurations, including those for the .NET Compact Framework, you will need to distribute both the managed provider **System.Data.SQLite.dll**, as well as the associated native library **SQLite.Interop.dll** (or **SQLite.Interop.XXX.dll** for the .NET Compact Framework). For the .NET Compact Framework edition, this is a breaking change as of 1.0.59.0. The recent versions of the .NET Compact Framework do not appear to properly support mixed-mode assemblies. All builds of System.Data.SQLite, except those explicitly marked as "static" in their package name, will also require the associated [Microsoft Visual C++ Runtime Library](https://support.microsoft.com/kb/2019667) to be installed on the target machine. For further details on distributing and/or deploying System.Data.SQLite, please refer to the [System.Data.SQLite Downloads](https://system.data.sqlite.org/index.html/doc/trunk/www/downloads.wiki) web page.

**Development Notes Regarding the SQLite Native Library Source Code**
---------------------------------------------------------------------

The included SQLite native library is compiled directly from the official source code releases available from the [sqlite.org](https://www.sqlite.org/) website.

In addition, there are several relatively small extensions included within the System.Data.SQLite "interop assembly" and some of these extensions are specific to the System.Data.SQLite project itself; however, the included SQLite native library source code itself is compiled verbatim, using a set of fully supported [compile-time options](https://www.sqlite.org/compile.html) designed for robustness and maximum backward compatibility with previously released versions of System.Data.SQLite.
