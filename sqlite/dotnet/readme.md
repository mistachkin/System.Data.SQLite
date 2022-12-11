ADO.NET SQLite Data Provider  
Version 1.0.117.0 - November 28, 2022  
Using [SQLite 3.40.0](https://www.sqlite.org/releaselog/3_40_0.html)  
Originally written by Robert Simpson  
Released to the public domain, use at your own risk!  
Official provider website: [https://system.data.sqlite.org/](https://system.data.sqlite.org/)  
Legacy versions: [https://sourceforge.net/projects/sqlite-dotnet2/](https://sourceforge.net/projects/sqlite-dotnet2/)  
  
The current development version can be downloaded from [https://system.data.sqlite.org/index.html/timeline?y=ci](https://system.data.sqlite.org/index.html/timeline?y=ci)  
  

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

<configuration>
    <system.data>
        <DbProviderFactories>
            <remove invariant="System.Data.SQLite" />
            <add name="SQLite Data Provider" invariant="System.Data.SQLite" description=".NET Framework Data Provider for SQLite"
                 type="System.Data.SQLite.SQLiteFactory, System.Data.SQLite, Version=1.0.117.0, Culture=neutral, PublicKeyToken=db937bc2d44ff139" />
        </DbProviderFactories>
    </system.data>
</configuration>

See the help documentation for further details on implementing both version-specific (GAC enabled) and version independent DBProviderFactories support.

Compiling for the .NET Compact Framework
----------------------------------------

Just change the target platform from Win32 to Compact Framework and recompile.  **The Compact Framework has no support for enumerating attributes in an assembly, therefore all user-defined collating sequences and functions must be explicitly registered.**  See the **testce** sample application for an example of how to explicitly register user-defined collating sequences and functions.

**Distributing or Deploying System.Data.SQLite**
------------------------------------------------

On the desktop, when using the statically linked mixed-mode assembly, only the **System.Data.SQLite.dll** file needs to be distributed with your application(s). This dynamic link library contains both the managed provider and the SQLite native library. For other build configurations, including those for the .NET Compact Framework, you will need to distribute both the managed provider **System.Data.SQLite.dll**, as well as the associated native library **SQLite.Interop.dll** (or **SQLite.Interop.XXX.dll** for the .NET Compact Framework). For the .NET Compact Framework edition, this is a breaking change as of 1.0.59.0. The recent versions of the .NET Compact Framework do not appear to properly support mixed-mode assemblies. All builds of System.Data.SQLite, except those explicitly marked as "static" in their package name, will also require the associated [Microsoft Visual C++ Runtime Library](https://support.microsoft.com/kb/2019667) to be installed on the target machine. For further details on distributing and/or deploying System.Data.SQLite, please refer to the [System.Data.SQLite Downloads](https://system.data.sqlite.org/index.html/doc/trunk/www/downloads.wiki) web page.

**Development Notes Regarding the SQLite Native Library Source Code**
---------------------------------------------------------------------

The included SQLite native library is compiled directly from the official source code releases available from the [sqlite.org](https://www.sqlite.org/) website.

In addition, there are several relatively small extensions included within the System.Data.SQLite "interop assembly" and some of these extensions are specific to the System.Data.SQLite project itself; however, the included SQLite native library source code itself is compiled verbatim, using a set of fully supported [compile-time options](https://www.sqlite.org/compile.html) designed for robustness and maximum backward compatibility with previously released versions of System.Data.SQLite.

**Version History**
-------------------

**1.0.117.0 - November 28, 2022**

*   Updated to [SQLite 3.40.0](https://www.sqlite.org/releaselog/3_40_0.html).
*   Add support for creating custom window functions. Pursuant to forum post \[21de219031\].
*   Suppress finalizer calls for SQLite3 objects that are closed. Fix for \[ce4d70ea6f\].
*   Improvements to object disposal diagnostics. Pursuant to \[ce4d70ea6f\].
*   Add MaximumSleepTime property to the SQLiteCommand class and DefaultMaximumSleepTime connection string property.
*   Add experimental support for running the test suite using .NET 5 and .NET 6.
*   Add experimental support for native sha3 extension.

**1.0.116.0 - June 1, 2022**

*   Updated to [SQLite 3.38.5](https://www.sqlite.org/releaselog/3_38_5.html).
*   More flexible connection pooling via the new ISQLiteConnectionPool2 interface.
*   Add SQLite\_StrongConnectionPool environment variable to prevent pooled connections from being garbage collected.
*   Improvements to object disposal handling for database connections.

**1.0.115.5 - November 2, 2021**

*   Updated to [SQLite trunk](https://www.sqlite.org/src/info/ca2703c339f76101).
*   Add Busy event to the SQLiteConnection class. Pursuant to forum post \[08a52f61fc\].
*   Fix metadata UTF-16 string length calculations on Linux. Fix for forum post \[eeaefb84ec\].

**1.0.115.0 - August 25, 2021**

*   Updated to [SQLite 3.36.0](https://www.sqlite.org/releaselog/3_36_0.html).

**1.0.114.0 - May 22, 2021**

*   Updated to [SQLite 3.35.5](https://www.sqlite.org/releaselog/3_35_5.html).
*   Updated to [Entity Framework 6.4.4](https://www.nuget.org/packages/EntityFramework/6.4.4).
*   Add preliminary support for the .NET Framework 4.8.
*   Add support for math functions now provided by the SQLite core library.
*   Add support for [ORDER BY and LIMIT for UPDATE and DELETE](https://www.sqlite.org/compile.html#enable_update_delete_limit).
*   Add TextPassword connection string property for use with [SEE](https://www.sqlite.org/see).

**1.0.113.0 - June 1, 2020**

*   Updated to [SQLite 3.32.1](https://www.sqlite.org/releaselog/3_32_1.html).
*   Add SQLite\_ForceLogLifecycle environment variable to force logging of calls into key members pertaining to the lifecycle of connections and their associated classes (e.g. LINQ, EF6, etc).
*   Support automatic value conversions for columns with a declared type of MEDIUMINT or MEDIUMUINT. Pursuant to \[515cb60b10\].

**1.0.112.3 - Xxxx XX, 2020**

*   When using the (unsupported) legacy CryptoAPI based codec, skip encrypting page #1 because that can lead to database corruption and other malfunctions.
*   Add SQLite\_ForceLogLifecycle environment variable to force logging of calls into key members pertaining to the lifecycle of connections and their associated classes (e.g. LINQ, EF6, etc).
*   Support automatic value conversions for columns with a declared type of MEDIUMINT or MEDIUMUINT. Pursuant to \[515cb60b10\].

**1.0.112.2 - April 27, 2020**

*   Fix NuGet packaging for .NET Standard 2.1. Fix for \[7c73262e6f\].

**1.0.112.1 - April 6, 2020**

*   Updated to [SQLite 3.31.1](https://www.sqlite.org/releaselog/3_31_1.html).
*   Include the "LINQ" partial classes in the primary managed assembly for .NET Standard 2.1. Fix for \[ad28d8e026\].

**1.0.112.0 - October 28, 2019**

*   Updated to [SQLite 3.30.1](https://www.sqlite.org/releaselog/3_30_1.html).
*   Add preliminary support for .NET Core 3.0 and the .NET Standard 2.1. Pursuant to \[ce75d320d0\].
*   Updated to [Entity Framework 6.3.0](https://www.nuget.org/packages/EntityFramework/6.3.0).
*   Add support for new DBCONFIG options from the SQLite core library. Pursuant to \[03b6b0edd7\].
*   Add SetLimitOption method to the SQLiteConnection class.

**1.0.111.0 - June 10, 2019**

*   Updated to [SQLite 3.28.0](https://www.sqlite.org/releaselog/3_28_0.html).
*   Add No\_SQLiteLog environment variable.

**1.0.110.0 - March 4, 2019**

*   Updated to [SQLite 3.27.2](https://www.sqlite.org/releaselog/3_27_2.html).
*   Add HidePassword connection flag to remove the password from the connection string once the database is opened. Pursuant to \[23d8d6171e\].
*   Add experimental StrictConformance connection flag to force strict compliance to the ADO.NET standard. Pursuant to \[e36e05e299\].
*   Add support for the [sqlite3changeset\_start\_v2()](https://www.sqlite.org/session/c_changesetstart_invert.html) and [sqlite3changeset\_start\_v2\_strm()](https://www.sqlite.org/session/c_changesetstart_invert.html) interfaces.

**1.0.109.0 - August 15, 2018**

*   Updated to [SQLite 3.24.0](https://www.sqlite.org/releaselog/3_24_0.html).
*   Updated to [Entity Framework 6.2.0](https://www.nuget.org/packages/EntityFramework/6.2.0).
*   Do not attempt to initialize the logging subsystem more than once. **\*\* Potentially Incompatible Change \*\***
*   Prevent GetSchemaTable from throwing InvalidCastException. Fix for \[baf42ee135\].
*   Add preliminary support for the .NET Framework 4.7.2.
*   Add preliminary support for .NET Core 2.0 and the .NET Standard 2.0. Pursuant to \[5c89cecd1b\].
*   Add simpler overload for the SQLiteBlob.Create method. Pursuant to \[dfc8133ba2\].
*   Add GetFieldAffinity method to the SQLiteDataReader class.

**1.0.108.0 - March 2, 2018**

*   Support extended result codes when messages are looked up without the SQLite core library.
*   Override System.Object members for the SQLiteException class to improve its ToString return value. Pursuant to \[53962f9eff\].
*   More database connection configuration options for the [sqlite3\_db\_config()](https://www.sqlite.org/c3ref/db_config.html) interface. **\*\* Potentially Incompatible Change \*\***
*   Set HResult property of SQLiteException based on the SQLite core library error code. **\*\* Potentially Incompatible Change \*\***
*   Modify experimental WaitForEnlistmentReset method to require a nullable boolean parameter for the value to return when the connection is disposed. **\*\* Potentially Incompatible Change \*\***

**1.0.107.0 - January 30, 2018**

*   Updated to [SQLite 3.22.0](https://www.sqlite.org/releaselog/3_22_0.html).
*   Improve performance of type name lookups by removing superfluous locking and string creation.
*   Support asynchronous completion of distributed transactions. Fix for \[5cee5409f8\].
*   Add experimental WaitForEnlistmentReset method to the SQLiteConnection class. Pursuant to \[7e1dd697dc\].
*   Fix some internal memory accounting present only in the debug build.
*   Make sure inbound native delegates are unhooked before adding a connection to the pool. Fix for \[0e48e80333\].
*   Add preliminary support for the .NET Framework 4.7.1.
*   Updates to internal DbType mapping related lookup tables. Pursuant to \[a799e3978f\].

**1.0.106.0 - November 2, 2017**

*   Updated to [SQLite 3.21.0](https://www.sqlite.org/releaselog/3_21_0.html).
*   Add full support for the native [session](https://www.sqlite.org/sessionintro.html) extension.
*   Add BindDecimalAsText and GetDecimalAsText connection flags to force binding and returning of decimal values as text. Pursuant to \[b167206ad3\].
*   Add BindInvariantDecimal and GetInvariantDecimal connection flags, enabled by default, to force binding and returning of decimal values using the invariant culture. Pursuant to \[b167206ad3\]. **\*\* Potentially Incompatible Change \*\***
*   Add preliminary support for Visual Studio 2017 and the .NET Framework 4.7. This does **not** include support for the design-time components for Visual Studio, see \[8292431f51\].

**1.0.105.2 - June 12, 2017**

*   Updated to [SQLite 3.19.3](https://www.sqlite.org/releaselog/3_19_3.html).
*   Fix issues that prevented SQLiteBlob creation from succeeding for tables that did not have an integer primary key.

**1.0.105.1 - May 15, 2017**

*   Prevent culture settings from negatively impacting integer connection string defaults.
*   Make sure the "No\_SQLiteConnectionNewParser" and "DefaultFlags\_SQLiteConnection" setting values end up being cached.
*   Cache the XML file name and assembly directory used by the configuration subsystem.

**1.0.105.0 - April 9, 2017**

*   Updated to [SQLite 3.18.0](https://www.sqlite.org/releaselog/3_18_0.html).
*   Add experimental support for native sha1 extension.

**1.0.104.0 - December 16, 2016**

*   Updated to [SQLite 3.15.2](https://www.sqlite.org/releaselog/3_15_2.html).
*   Add the "%PreLoadSQLite\_AssemblyDirectory%", "%PreLoadSQLite\_TargetFramework%", and "%PreLoadSQLite\_XmlConfigDirectory%" [replacement tokens](https://system.data.sqlite.org/index.html/artifact?ci=trunk&filename=Doc/Extra/Provider/environment.html) for use in configuration setting values. Pursuant to \[d4728aecb7\].
*   Prevent the GetByte, GetChar, and GetInt16 methods of the SQLiteDataReader class from throwing exceptions for large integer values. Pursuant to \[5535448538\]. **\*\* Potentially Incompatible Change \*\***
*   Use [SAVEPOINTs](https://www.sqlite.org/lang_savepoint.html) to properly implement nested transactions when the new AllowNestedTransactions connection flag is used. Pursuant to \[1f7bfff467\].
*   When converting a Julian Day value to an integer, round to the nearest millisecond first. Pursuant to \[69cf6e5dc8\]. **\*\* Potentially Incompatible Change \*\***

**1.0.103.0 - September 15, 2016**

*   Updated to [SQLite 3.14.2](https://www.sqlite.org/releaselog/3_14_2.html).
*   Add preliminary support for the .NET Framework 4.6.2.
*   Change the SQLiteReadValueCallback delegate "eventArgs" parameter to be of type SQLiteReadEventArgs. **\*\* Potentially Incompatible Change \*\***
*   Make SQLiteReadValueEventArgs and SQLiteReadArrayEventArgs derive from SQLiteReadEventArgs. **\*\* Potentially Incompatible Change \*\***
*   Rename SQLiteReadValueEventArgs.ArrayEventArgs property to ExtraEventArgs. **\*\* Potentially Incompatible Change \*\***
*   Add No\_SQLiteGetSettingValue and No\_SQLiteXmlConfigFile environment variables.
*   Reduce the number of calls to GetSettingValue from SQLiteConnection. Pursuant to \[25d53b48f6\]. **\*\* Potentially Incompatible Change \*\***
*   Add NoVerifyTypeAffinity connection flag to disable all type affinity checking.
*   Add support for [incremental blob I/O](https://www.sqlite.org/c3ref/blob_open.html).
*   Improve support for the [sqlite3\_db\_config()](https://www.sqlite.org/c3ref/db_config.html) interface. Pursuant to \[f64f4aee95\].

**1.0.102.0 - June 23, 2016**

*   Updated to [SQLite 3.13.0](https://www.sqlite.org/releaselog/3_13_0.html).
*   Update the SQLiteConnection.EnableExtensions method to make use of the new SQLITE\_DBCONFIG\_ENABLE\_LOAD\_EXTENSION option, when available. **\*\* Potentially Incompatible Change \*\***
*   Prevent the SQLiteCommand.ExecuteScalar method from throwing an exception when there are no result columns. **\*\* Potentially Incompatible Change \*\***
*   Support per-connection customization for binding parameters and reading values, based on the database type name.
*   Add TypeName property to the SQLiteParameter class.
*   Add VerifyOnly method to the SQLiteCommand class.
*   Add IsReadOnly method to the SQLiteConnection class.

**1.0.101.0 - April 19, 2016**

*   Updated to [SQLite 3.12.2](https://www.sqlite.org/releaselog/3_12_2.html).
*   Add binary package release for Mono on POSIX.

**1.0.100.0 - April 15, 2016**

*   Updated to [SQLite 3.12.1](https://www.sqlite.org/releaselog/3_12_1.html).
*   Support compiling and using the interop assembly on Linux and Mac OS X.
*   Support running the test suite under Mono on Linux and Mac OS X.
*   Properly handle NULL values in the "name" column of the results returned by PRAGMA index\_info(). Fix for \[5251bd0878\].
*   For column types that resolve to boolean, recognize case-insensitive prefixes of "True" and "False". Fix for \[dbd65441a5\].
*   Add NoVerifyTextAffinity connection flag to skip type affinity checking when fetching a column value as a string. Pursuant to \[dbd65441a5\].
*   The UnixEpoch DateTime format should use Int64 internally, not Int32. **\*\* Potentially Incompatible Change \*\***
*   Avoid using Path.Combine with null values in the native library pre-loader. Fix for \[da685c0bac\].
*   Fix the (unsupported) legacy CryptoAPI based codec so that it no longer prevents page size changes.

**1.0.99.1 - March 31, 2016**

*   Updated to [SQLite 3.9.3](https://www.sqlite.org/releaselog/3_9_3.html).

**1.0.99.0 - December 9, 2015**

*   Updated to [SQLite 3.9.2](https://www.sqlite.org/releaselog/3_9_2.html).
*   Add preliminary support for the .NET Framework 4.6.1.
*   Fix handling of sqlite3\_index\_info members not available with older versions of the SQLite core library. **\*\* Potentially Incompatible Change \*\***
*   Update and improve documentation comments for the native virtual table methods.
*   Permit an existing registered function to be replaced. Fix for \[2556655d1b\].
*   Make GetValue work for boolean columns with textual "True" and "False" values. Fix for \[7714b60d61\]. **\*\* Potentially Incompatible Change \*\***
*   Add Reset method to the SQLiteCommand class.
*   Add FileName property to the SQLiteConnection class.
*   Add experimental support for the native json1 and fts5 extensions.
*   Add GetDatabaseName, GetTableName, and GetOriginalName methods to the SQLiteDataReader class.

**1.0.98.0 - August 19, 2015**

*   Updated to [SQLite 3.8.11.1](https://www.sqlite.org/releaselog/3_8_11_1.html).
*   Add full support for Visual Studio 2015 and the .NET Framework 4.6.
*   Add support for creating custom SQL functions using delegates.
*   Implement the Substring method for LINQ using the "substr" core SQL function. **\*\* Potentially Incompatible Change \*\***
*   Prevent encrypted connections from being used with the connection pool. Pursuant to \[89d3a159f1\]. **\*\* Potentially Incompatible Change \*\***
*   Honor the second argument to Math.Round when using LINQ. **\*\* Potentially Incompatible Change \*\***
*   Honor the pre-existing flags for connections during the Open method. Fix for \[964063da16\]. **\*\* Potentially Incompatible Change \*\***
*   Remove errant semi-colons from the SQL used by LINQ to INSERT and then SELECT rows with composite primary keys. Fix for \[9d353b0bd8\].
*   Refactor INSERT/UPDATE handling (in the LINQ assembly) so it can handle composite and non-integer primary keys. Fix for \[41aea496e0\].
*   Change the base type for the SQLiteConnectionFlags enumeration to long integer. **\*\* Potentially Incompatible Change \*\***
*   Add extended return codes to the SQLiteErrorCode enumeration. Pursuant to \[71bedaca19\]. **\*\* Potentially Incompatible Change \*\***
*   Improve exception handling in all native callbacks implemented in the SQLiteConnection class.
*   Add Progress event and ProgressOps connection string property to enable raising progress events during long-running queries.
*   Add "Recursive Triggers" connection string property to enable or disable the recursive trigger capability. Pursuant to \[3a82ee635b\].
*   Add NoDefaultFlags connection string property to prevent the default connection flags from being used. Pursuant to \[964063da16\].
*   Add VfsName connection string property to allow a non-default VFS to be used by the SQLite core library.
*   Add BusyTimeout connection string property to set the busy timeout to be used by the SQLite core library.
*   Add UnbindFunction and UnbindAllFunctions methods to the SQLiteConnection class.
*   Enable integration with the [ZipVFS](http://www.hwaci.com/sw/sqlite/zipvfs.html) extension.

**1.0.97.0 - May 26, 2015**

*   Updated to [SQLite 3.8.10.2](https://www.sqlite.org/releaselog/3_8_10_2.html).
*   Updated to [Entity Framework 6.1.3](https://www.nuget.org/packages/EntityFramework/6.1.3).
*   Improve ADO.NET conformance of the SQLiteDataReader.RecordsAffected property. Fix for \[74542e702e\]. **\*\* Potentially Incompatible Change \*\***
*   Prevent the IDataReader.GetDataTypeName method from throwing "No current row" exceptions. Fix for \[94252b9059\].
*   When BinaryGUID handling is off, transform the LINQ parameter types as well. Fix for \[a4d9c7ee94\]. **\*\* Potentially Incompatible Change \*\***
*   The IDataReader.GetDataTypeName method should always return the declared type name. **\*\* Potentially Incompatible Change \*\***
*   Add DefaultFlags\_SQLiteConnection environment variable to enable customization of the default connection flags.
*   Prevent calls to sqlite3\_step() and sqlite3\_interrupt() from being interrupted via ThreadAbortException.
*   Make sure enabling UseUTF16Encoding sets the schema encoding to UTF-16. Fix for \[7c151a2f0e\].

**1.0.96.0 - March 5, 2015**

*   Prevent the IDataReader.GetOrdinal method from throwing "No current row" exceptions. Fix for \[c28d7fe915\].
*   When counting the number of tables in the GetSchemaTable method, do not include those that have a null or empty name. Fix for \[92dbf1229a\].

**1.0.95.0 - March 2, 2015**

*   Updated to [SQLite 3.8.8.3](https://www.sqlite.org/releaselog/3_8_8_3.html).
*   Updated to [Entity Framework 6.1.2](https://www.nuget.org/packages/EntityFramework/6.1.2).
*   Modify configuration file transforms performed by the NuGet packages to allow Entity Framework 6 design-time integration to work automatically. Fix for \[2be4298631\], \[abad7c577d\], and \[417d669435\].
*   The "System.Data.SQLite.EF6\*" and "System.Data.SQLite.Linq\*" NuGet packages no longer depend on the "System.Data.SQLite.Core\*" packages. **\*\* Potentially Incompatible Change \*\***
*   The "System.Data.SQLite.MSIL\*" NuGet packages no longer directly include any files; they are now meta-packages. **\*\* Potentially Incompatible Change \*\***
*   The "System.Data.SQLite.x86\*" and "System.Data.SQLite.x64\*" NuGet packages now depend on the "System.Data.SQLite.Linq" and "System.Data.SQLite.EF6" NuGet packages. **\*\* Potentially Incompatible Change \*\***
*   Make sure SQL statements generated for DbUpdateCommandTree objects are properly delimited.
*   Make sure SQLiteIndexOutputs.ConstraintUsages instances are created prior to calling ISQLiteManagedModule.BestIndex. Fix for \[56f511d268\].
*   Correct marshalling of strings and blobs in the SQLiteValue class. Fix for \[85b824b736\].
*   Various minor performance enhancements to the SQLiteDataReader class. Pursuant to \[e122d26e70\].
*   Defer disposing of connections created by the static SQLiteCommand.Execute method when a data reader is returned. Fix for \[daeaf3150a\].
*   Wrap SELECT statements in parenthesis if they have an ORDER BY, LIMIT, or OFFSET clause and a compound operator is involved. Fix for \[0a32885109\].
*   In the SQLiteDataReader.VerifyType method, remove duplicate "if" statement for the DbType.SByte value and move the remaining "if" to the Int64 affinity. Fix for \[c5cc2fb334\]. **\*\* Potentially Incompatible Change \*\***
*   Handle Julian Day values that fall outside of the supported range for OLE Automation dates. Fix for \[3e783eecbe\]. **\*\* Potentially Incompatible Change \*\***
*   Make sure the interop files are copied when publishing a project that refers to a NuGet package containing them. Fix for \[e796ac82c1\]. **\*\* Potentially Incompatible Change \*\***
*   Make sure the interop files are copied before the PostBuildEvent. Fix for \[f16c93a932\]. **\*\* Potentially Incompatible Change \*\***
*   Modify GetSchemaTable method to avoid setting SchemaTableColumn.IsKey column to true when more than one table is referenced. Fix for \[47c6fa04d3\]. **\*\* Potentially Incompatible Change \*\***
*   Add AppendManifestToken\_SQLiteProviderManifest environment variable to enable better integration between LINQ and the underlying store connection.
*   Add SQLite\_ForceLogPrepare environment variable to force logging of all prepared SQL regardless of the flags for the associated connection.
*   Honor the DateTimeFormat, DateTimeKind, DateTimeFormatString, BinaryGUID connection string and/or provider manifest token properties from within the LINQ assembly. Fix for \[8d928c3e88\]. **\*\* Potentially Incompatible Change \*\***
*   Add PrepareRetries connection string property to allow the maximum number of retries when preparing a query to be overridden. Fix for \[647d282d11\].
*   Add BindDateTimeWithKind connection flag to force DateTime parameter values to match the DateTimeKind associated with the connection, if applicable. Fix for \[a7d04fb111\].

**1.0.94.0 - September 9, 2014**

*   Updated to [SQLite 3.8.6](https://www.sqlite.org/releaselog/3_8_6.html).
*   Updated to [Entity Framework 6.1.1](https://www.nuget.org/packages/EntityFramework/6.1.1).
*   Refactor and simplify NuGet packages in order to support per-solution SQLite interop assembly files. **\*\* Potentially Incompatible Change \*\***
*   Add RefreshFlags method to the SQLiteDataReader class to forcibly refresh its connection flags.
*   Improve automatic detection and handling of the Entity Framework 6 assembly by the design-time components installer. Pursuant to \[e634e330a6\]. **\*\* Potentially Incompatible Change \*\***
*   Improve SQLiteDataReader performance slightly by caching the connection flags. **\*\* Potentially Incompatible Change \*\***
*   Add ClearCachedSettings method to the SQLiteConnection class.
*   Add NoConvertSettings connection flag to disable querying of runtime configuration settings from within the SQLiteConvert class. Pursuant to \[58ed318f2f\].
*   Minimize usage of the "Use\_SQLiteConvert\_DefaultDbType" and "Use\_SQLiteConvert\_DefaultTypeName" settings. Fix for \[58ed318f2f\]. **\*\* Potentially Incompatible Change \*\***

**1.0.93.0 - June 23, 2014**

*   Updated to [SQLite 3.8.5](https://www.sqlite.org/releaselog/3_8_5.html).
*   Updated to [Entity Framework 6.1](https://www.nuget.org/packages/EntityFramework/6.1).
*   Add support for mapping transaction isolation levels to their legacy default values. Pursuant to \[56b42d99c1\].
*   Add support for setting the default DbType and type name used for mappings on a per-connection basis. Pursuant to \[3c00ec5b52\].
*   Add DetectTextAffinity and DetectStringType connection flags to enable automatic detection of column types, when necessary. Pursuant to \[3c00ec5b52\].
*   Add SetChunkSize method to the SQLiteConnection class. Pursuant to \[d1c008fa0a\].
*   Add SharedFlags static property to the SQLiteConnection class.
*   Make the ISQLiteSchemaExtensions interface public. **\*\* Potentially Incompatible Change \*\***
*   Have the SQLiteProviderFactory class (in the System.Data.SQLite.Linq assembly) implement the IServiceProvider interface.
*   Fix bug in documentation generator automation that prevented some internal documentation links from working.
*   Fix DateTime constant handling in the LINQ assembly. Fix for \[da9f18d039\]. **\*\* Potentially Incompatible Change \*\***

**1.0.92.0 - March 19, 2014**

*   Updated to [SQLite 3.8.4.1](https://www.sqlite.org/releaselog/3_8_4_1.html).
*   Update the list of keywords returned by SQLiteConnection.GetSchema("ReservedWords"). **\*\* Potentially Incompatible Change \*\***
*   Raise the static SQLiteConnection.Changed event when any SQLiteCommand or SQLiteDataReader object is closed or disposed.
*   Add the SQLiteDataReader.StepCount property to return the number of rows seen so far.
*   Add StickyHasRows connection flag to cause the SQLiteDataReader.HasRows property to return non-zero if there were ever any rows in the associated result sets.
*   When the TraceWarning connection flag is set, issue warnings about possibly malformed UNC paths. Pursuant to \[283344397b\].
*   Convert the primary NuGet package, "System.Data.SQLite", into a meta-package.
*   Enhancements to the NuGet packages, including the new "modular" packages.

**1.0.91.0 - February 12, 2014**

*   Updated to [SQLite 3.8.3.1](https://www.sqlite.org/releaselog/3_8_3_1.html).
*   Refresh all included SQLite core library documentation (e.g. SQL syntax).
*   Add support for [Entity Framework 6](https://entityframework.codeplex.com/).
*   Add support for per-connection mappings between type names and DbType values. Pursuant to \[e87af1d06a\].
*   Modify the namespace used for all internal classes in the System.Data.SQLite.Linq assembly. **\*\* Potentially Incompatible Change \*\***
*   Add SQLiteCompileOptions and InteropCompileOptions properties to the SQLiteConnection class to return the compile-time options for the SQLite core library and interop assembly, respectively.
*   Add BindInvariantText and ConvertInvariantText connection flags to force the invariant culture to be used when converting parameter values to/from strings.
*   Add NoConnectionPool and UseConnectionPool connection flags to disable or enable connection pooling by default.
*   Modify handling of the design-time components installer to run Visual Studio **devenv.exe /setup** after installing the package. This appears to be necessary in some circumstances for Visual Studio 2013. Pursuant to \[a47eff2c71\].
*   Modify the native library pre-loader to support reading settings from an XML configuration file and to be capable of checking more than one directory. Persuant to \[f0246d1817\].
*   Support detecting when the native library pre-loader should use the CodeBase property instead of the Location property as the basis for locating the interop assembly.
*   Change the default behavior for the native library pre-loader so it first searches the executing (i.e. System.Data.SQLite) assembly directory and then the application domain directory. Pursuant to \[f0246d1817\]. **\*\* Potentially Incompatible Change \*\***
*   Include DbType.AnsiString in the list of types that need special ColumnSize handling. Fix for \[0550f0326e\].

**1.0.90.0 - December 23, 2013**

*   Updated to [SQLite 3.8.2](https://www.sqlite.org/releaselog/3_8_2.html).
*   Add Visual Studio 2013 support to all the applicable solution/project files, their associated supporting files, and the test suite.
*   Add Visual Studio 2013 support to the redesigned designer support installer.
*   Add support for Windows Embedded Compact 2013.
*   Add experimental support for the native regexp extension.
*   Never create a new connection wrapper in the SQLiteConnection.Shutdown method. **\*\* Potentially Incompatible Change \*\***
*   Add experimental GetMemoryStatistics, ReleaseMemory, and Shutdown methods to the SQLiteConnection class.
*   Add memory leak detection to the test project for the .NET Compact Framework.
*   Add SQLITE\_ENABLE\_MEMORY\_MANAGEMENT compile-time option to the interop assembly.
*   Use current isolation level when enlisting into an existing transaction. Fix for \[56b42d99c1\].
*   Better handling of non-error log messages from the SQLite core library. Pursuant to \[44df10ea90\].
*   Add TraceWarning connection flag to enable tracing of type mapping failures and disable tracing of them by default. Pursuant to \[6d45c782e4\].
*   Use 32-bit values to keep track of numeric precision and scale when building the schema table for a query. Fix for \[ef2216192d\].

**1.0.89.0 - October 28, 2013**

*   Updated to [SQLite 3.8.1](https://www.sqlite.org/releaselog/3_8_1.html).
*   Add AutoCommit property to the SQLiteConnection class. Fix for \[9ba9346f75\].
*   Use declared column sizes for the AnsiStringFixedLength and StringFixedLength mapped database types. Fix for \[3113734605\].
*   Check the result of sqlite3\_column\_name function against NULL.
*   Return false for the SQLiteParameterCollection.IsSynchronized property because it is not thread-safe.
*   Raise the static SQLiteConnection.Changed event when any SQLiteCommand, SQLiteDataReader, or CriticalHandle derived object instance is created. Fix for \[aba4549801\].
*   Add SQLiteCommand.Execute, SQLiteCommand.ExecuteNonQuery, and SQLiteCommand.ExecuteScalar method overloads that take a CommandBehavior parameter.
*   Revise how the extra object data is passed to the static SQLiteConnection.Changed event. **\*\* Potentially Incompatible Change \*\***
*   Make sure the database cannot be changed by a query when the CommandBehavior.SchemaOnly flag is used. Fix for \[f8dbab8baf\]. **\*\* Potentially Incompatible Change \*\***
*   Fix bug in [NDoc3](https://sourceforge.net/projects/ndoc3/) that was preventing some of the MSDN documentation links from working.
*   Include the XML documentation files in the NuGet packages. Fix for \[5970d5b0a6\].
*   Add InteropVersion, InteropSourceId, ProviderVersion, and ProviderSourceId properties to the SQLiteConnection class.
*   Add experimental support for interfacing with the authorizer callback in the SQLite core library.
*   Add experimental support for the native totype extension.

**1.0.88.0 - August 7, 2013**

*   Various fixes to managed virtual table integration infrastructure.
*   Implement workaround for an incorrect PROCESSOR\_ARCHITECTURE being reported. Fix for \[9ac9862611\].
*   Modify classes that implement the IDisposable pattern to set the disposed flag after their base classes have been disposed.
*   When automatically registering custom functions, use the executing assembly (i.e. System.Data.SQLite) for reference detection. Fix for \[4e49a58c4c\].

**1.0.87.0 - July 8, 2013**

*   Add all the necessary infrastructure to allow virtual tables to be implemented in managed code. Fix for \[9a544991be\].
*   The DbType to type name translation needs to prioritize the Entity Framework type names. Fix for \[47f4bac575\].
*   Add DateTimeFormatString connection string property to allow the DateTime format string used for all parsing and formatting to be overridden.
*   Add NoFunctions connection flag to skip binding functions registered in the application domain.
*   Add several data-types for compatibility purposes. Fix for \[fe50b8c2e8\].
*   Add SQLiteConnection.BindFunction method to facilitate adding custom functions on a per-connection basis.
*   When reading a DateTime value, avoid unnecessary string conversions. Fix for \[4d87fbc742\].
*   Modify the index introspection code so that it does not treat PRAGMA table\_info "pk" column values as boolean. Fix for \[f2c47a01eb\].
*   Disable use of the new connection string parsing algorithm when the No\_SQLiteConnectionNewParser environment variable is set. Pursuant to \[bbdda6eae2\].
*   Rename the ReturnCode property of the SQLiteException class to ResultCode. **\*\* Potentially Incompatible Change \*\***

**1.0.86.0 - May 23, 2013**

*   Updated to [SQLite 3.7.17](https://www.sqlite.org/releaselog/3_7_17.html).
*   Disable use of the AllowPartiallyTrustedCallers attribute when compiled for the .NET Framework 4.0/4.5. **\*\* Potentially Incompatible Change \*\***
*   Allow semi-colons in the data source file name. Fix for \[e47b3d8346\]. **\*\* Potentially Incompatible Change \*\***
*   NULL values should be reported as type "object", not "DBNull". Fix for \[48a6b8e4ca\].

**1.0.85.0 - April 18, 2013**

*   Updated to [SQLite 3.7.16.2](https://www.sqlite.org/releaselog/3_7_16_2.html).
*   Properly handle embedded NUL characters in parameter and column values. Fix for \[3567020edf\].
*   Make use of the sqlite3\_prepare\_v2 function when applicable.
*   Check for a valid row in the SQLiteDataReader.GetValue method.
*   Implement processor architecture detection when running on the .NET Compact Framework (via P/Invoke).
*   Support automated testing when running on the .NET Compact Framework 2.0.
*   Skip checking loaded assemblies for types tagged with the SQLiteFunction attribute when the No\_SQLiteFunctions environment variable is set. Pursuant to \[e4c8121f7b\].
*   Add HexPassword connection string property to work around the inability to include a literal semicolon in a connection string property value. Pursuant to \[1c456ae75f\].
*   Add static Execute method to the SQLiteCommand class.
*   Support custom connection pool implementations by adding the ISQLiteConnectionPool interface, the static SQLiteConnection.ConnectionPool property, and the static CreateHandle method in addition to modifying the SQLiteConnectionPool class. Pursuant to \[393d954be0\].
*   Add public constructor to the SQLiteDataAdapter class that allows passing the parseViaFramework parameter to the SQLiteConnection constructor.
*   When built with the CHECK\_STATE compile-time option, skip throwing exceptions from the SQLiteDataReader class when the object is being disposed.
*   Support automatic value conversions for columns with a declared type of BIGUINT, INTEGER8, INTEGER16, INTEGER32, INTEGER64, SMALLUINT, TINYSINT, UNSIGNEDINTEGER, UNSIGNEDINTEGER8, UNSIGNEDINTEGER16, UNSIGNEDINTEGER32, UNSIGNEDINTEGER64, INT8, INT16, INT32, INT64, UINT, UINT8, UINT16, UINT32, UINT64, or ULONG.
*   Add BindUInt32AsInt64 connection flag to force binding of UInt32 values as Int64 instead. Pursuant to \[c010fa6584\].
*   Add BindAllAsText and GetAllAsText connection flags to force binding and returning of all values as text.
*   Remove AUTOINCREMENT from the column type name map. **\*\* Potentially Incompatible Change \*\***
*   Avoid throwing overflow exceptions from the SQLite3.GetValue method for integral column types. Partial fix for \[c010fa6584\]. **\*\* Potentially Incompatible Change \*\***
*   Use the legacy connection closing algorithm when built with the INTEROP\_LEGACY\_CLOSE compile-time option.
*   Support using the directory containing the primary managed-only assembly as the basis for native library pre-loading.
*   Still further enhancements to the build and test automation.

**1.0.84.0 - January 9, 2013**

*   Updated to [SQLite 3.7.15.2](https://www.sqlite.org/releaselog/3_7_15_2.html).
*   Explicitly dispose of all SQLiteCommand objects managed by the DbDataAdapter class. Fix for \[6434e23a0f\].
*   Add Cancel method to the SQLiteConnection class to interrupt a long running query.
*   Improve thread safety of the SQLiteLog.LogMessage method.

**1.0.83.0 - December 29, 2012**

*   Updated to [SQLite 3.7.15.1](https://www.sqlite.org/releaselog/3_7_15_1.html).
*   Add Visual Studio 2012 support to all the applicable solution/project files, their associated supporting files, and the test suite.
*   Add Visual Studio 2012 support to the redesigned designer support installer.
*   Allow opened connections to skip adding the extension functions included in the interop assembly via the new NoExtensionFunctions connection flag.
*   Support loading of SQLite extensions via the new EnableExtensions and LoadExtension methods of the SQLiteConnection class. Pursuant to \[17045010df\].
*   Remove one set of surrounding single or double quotes from property names and values parsed from the connection string. Fix for \[b4cc611998\].
*   Modify parsing of connection strings to allow property names and values to be quoted. **\*\* Potentially Incompatible Change \*\***
*   Add ParseViaFramework property to the SQLiteConnection class to allow the built-in (i.e. framework provided) connection string parser to be used when opening a connection. Pursuant to \[b4cc611998\].
*   Add notifications before and after any connection is opened and closed, as well as other related notifications, via the new static Changed event.
*   Add an overload of the SQLiteLog.LogMessage method that takes a single string parameter.
*   Add an overload of the SQLiteConnection.LogMessage method that takes a SQLiteErrorCode parameter.
*   All applicable calls into the SQLite core library now return a SQLiteErrorCode instead of an integer error code.
*   Make sure the error code of the SQLiteException class gets serialized.
*   Make the test project for the .NET Compact Framework more flexible.
*   When available, the new sqlite3\_errstr function from the core library is used to get the error message for a specific return code.
*   The SetMemoryStatus, Shutdown, ResultCode, ExtendedResultCode, and SetAvRetry methods of the SQLiteConnection class now return a SQLiteErrorCode instead of an integer error code. **\*\* Potentially Incompatible Change \*\***
*   The public constructor for the SQLiteException now takes a SQLiteErrorCode instead of an integer error code. **\*\* Potentially Incompatible Change \*\***
*   The ErrorCode property of the SQLiteException is now an Int32, to allow the property inherited from the base class to be properly overridden. **\*\* Potentially Incompatible Change \*\***
*   The ErrorCode field of the LogEventArgs is now an object instead of an integer. **\*\* Potentially Incompatible Change \*\***
*   The names and messages associated with the SQLiteErrorCode enumeration values have been normalized to match those in the SQLite core library. **\*\* Potentially Incompatible Change \*\***
*   Implement more robust locking semantics for the CriticalHandle derived classes when compiled for the .NET Compact Framework.
*   Cache column indexes as they are looked up when using the SQLiteDataReader to improve performance.
*   Prevent the SQLiteConnection.Close method from throwing non-fatal exceptions during its disposal.
*   Rename the interop assembly functions sqlite3\_cursor\_rowid, sqlite3\_context\_collcompare, sqlite3\_context\_collseq, sqlite3\_cursor\_rowid, and sqlite3\_table\_cursor to include an "\_interop" suffix. **\*\* Potentially Incompatible Change \*\***
*   Prevent the LastInsertRowId, MemoryUsed, and MemoryHighwater connection properties from throwing NotSupportedException when running on the .NET Compact Framework. Fix for \[dd45aba387\].
*   Improve automatic detection of the sqlite3\_close\_v2 function when compiled to use the standard SQLite library.
*   Add protection against ThreadAbortException asynchronously interrupting native resource initialization and finalization.
*   Add native logging callback for use with the sqlite3\_log function to the interop assembly, enabled via the INTEROP\_LOG preprocessor definition.
*   Add various diagnostic messages to the interop assembly, enabled via flags in the INTEROP\_DEBUG preprocessor definition.
*   Further enhancements to the build and test automation.
*   Add test automation for the Windows CE binaries.

**1.0.82.0 - September 3, 2012**

*   Updated to [SQLite 3.7.14](https://www.sqlite.org/releaselog/3_7_14.html).
*   Properly handle quoted data source values in the connection string. Fix for \[8c3bee31c8\].
*   The [primary NuGet package](https://www.nuget.org/packages/System.Data.SQLite) now supports x86 / x64 and the .NET Framework 2.0 / 4.0 (i.e. in a single package).
*   Change the default value for the Synchronous connection string property to Full to match the default used by the SQLite core library itself. **\*\* Potentially Incompatible Change \*\***
*   Add the ability to skip applying default connection settings to opened databases via the new SetDefaults connection string property.
*   Add the ability to skip expanding data source file names to their fully qualified paths via the new ToFullPath connection string property.
*   Fix the database cleanup ordering in the tests for ticket \[343d392b51\].
*   Add support for the sqlite3\_close\_v2 function from the SQLite core library.
*   Add support for [URI file names](https://www.sqlite.org/uri.html) via the new FullUri connection string property.
*   Improve support for the standard SQLite core library in the LINQ assembly and the test suite.
*   Add SetMemoryStatus static method to the SQLiteConnection class.
*   Improve threaded handling of the delegate used by the SQLiteLog class.
*   Add define constants to support enabling or disabling individual groups of trace statements.

**1.0.81.0 - May 27, 2012**

*   Updated to [SQLite 3.7.12.1](https://www.sqlite.org/releaselog/3_7_12_1.html).
*   Support compiling the interop assembly without support for the custom extension functions and the CryptoAPI based codec.
*   Add DefineConstants property to the SQLiteConnection class to return the list of define constants used when compiling the core managed assembly.
*   Add release archive verification tool to the release automation.
*   Fix NullReferenceException when calling the SQLiteDataAdapter.FillSchema method on a query that returns multiple result sets. Fix for \[3aa50d8413\].
*   Fix subtle race condition between threads fetching connection handles from the connection pool and any garbage collection (GC) threads that may be running. Fix for \[996d13cd87\].
*   Add missing call to SetTimeout in the SQLite3\_UTF16.Open method.
*   Add checks to prevent the SQLiteConnectionPool.Remove method from returning any connection handles that are closed or invalid.
*   Modify static SQLiteBase helper methods to prevent them from passing IntPtr.Zero to the SQLite native library.
*   Remove static locks from the static helper methods in the SQLiteBase class, replacing them with a lock on the connection handle instance being operated upon.
*   Revise CriticalHandle derived classes to make them more thread-safe.
*   Add connection pool related diagnostic messages when compiled with the DEBUG define constant.
*   Add PoolCount property to the SQLiteConnection class to return the number of pool entries for the file name associated with the connection.
*   Rename internal SQLiteLastError methods to GetLastError.
*   Add assembly file test constraints to all tests that execute the "test.exe" or "testlinq.exe" files.

**1.0.80.0 - April 1, 2012**

*   Updated to [SQLite 3.7.11](https://www.sqlite.org/releaselog/3_7_11.html).
*   In the SQLiteFunction class, when calling user-provided methods from a delegate called by native code, avoid throwing exceptions, optionally tracing the caught exceptions. Fix for \[8a426d12eb\].
*   Add Visual Studio 2005 support to all the applicable solution/project files, their associated supporting files, and the test suite.
*   Add Visual Studio 2005 support to the redesigned designer support installer.
*   Add experimental support for "pre-loading" the native SQLite library based on the processor architecture of the current process. This feature is now enabled by default at compile-time.
*   Add support for the native [SQLite Online Backup API](https://www.sqlite.org/backup.html). Fix for \[c71846ed57\].
*   Acquire and hold a static data lock while checking if the native SQLite library has been initialized to prevent a subtle race condition that can result in superfluous error messages. Fix for \[72905c9a77\].
*   Support tracing of all parameter binding activity and use the connection flags to control what is traced.
*   When converting a DateTime instance of an "Unspecified" kind to a string, use the same kind as the connection, if available.
*   Add overload of the SQLiteDataReader.GetValues method that returns a NameValueCollection.
*   Add static ToUnixEpoch method to the SQLiteConvert class to convert a DateTime value to the number of whole seconds since the Unix epoch.
*   In the implicit conversion operators (to IntPtr) for both the SQLiteConnectionHandle and SQLiteStatementHandle classes, return IntPtr.Zero if the instance being converted is null.
*   Write warning message to the active trace listeners (for the Debug build configuration only) if a column type or type name cannot be mapped properly. See \[4bbf851fa5\].
*   When tracing SQL statements to be prepared, bypass the internal length limit of the sqlite3\_log function by using the SQLiteLog class directly instead. Also, detect null and/or empty strings and emit a special message in that case.
*   For the setup, the Visual Studio task should only be initially checked if the GAC task is available and vice-versa.
*   Improve compatibility with custom command processors by using \_\_ECHO instead of \_ECHO in batch tools.
*   Add OpenAndReturn method to the SQLiteConnection class to open a connection and return it.
*   Add missing CheckDisposed calls to the SQLiteConnection class.
*   Add missing throw statement to the SQLiteConnection class.
*   Make sure the interop project uses /fp:precise for Windows CE.
*   Regenerate package load key to support loading the designer package into Visual Studio 2008 without having the matching SDK installed.
*   Modify transaction object disposal so that it can never cause an exception to be thrown.

**1.0.79.0 - January 28, 2012**

*   Use the WoW64 registry keys when installing the VS designer components on 64-bit Windows. Fix for \[d8491abd0b\].
*   Correct resource name used by the LINQ assembly to locate several key string resources. Fix for \[fbebb30da9\].

**1.0.78.0 - January 27, 2012**

*   Updated to [SQLite 3.7.10](https://www.sqlite.org/releaselog/3_7_10.html).
*   Redesign the VS designer support installer and integrate it into the setup packages.
*   When emitting SQL for foreign keys in the VS designer, be sure to take all returned schema rows into account. Remainder of fix for \[b226147b37\].
*   Add Flags connection string property to control extra behavioral flags for the connection.
*   Refactor all IDisposable implementations to conform to best practices, potentially eliminating leaks in certain circumstances.
*   Even more enhancements to the build and test automation.
*   Support parameter binding to more primitive types, including unsigned integer types.
*   Recognize the TIMESTAMP column data type as the DateTime type. Fix for \[bb4b04d457\].
*   Prevent logging superfluous messages having to do with library initialization checking. Fix for \[3fc172d1be\].
*   Support the DateTimeKind and BaseSchemaName connection string properties in the SQLiteConnectionStringBuilder class. Fix for \[f3ec1e0066\].
*   Overloads of the SQLiteConvert.ToDateTime and SQLiteConvert.ToJulianDay methods that do not require an instance should be static. Partial fix for \[4bbf851fa5\]. **\*\* Potentially Incompatible Change \*\***

**1.0.77.0 - November 28, 2011**

*   Updated to [SQLite 3.7.9](https://www.sqlite.org/releaselog/3_7_9.html).
*   More enhancements to the build and test automation.
*   Plug native memory leak when closing a database connection containing a statement that cannot be finalized for some reason.
*   The SQLite3 class should always attempt to dispose the contained SQLiteConnectionHandle, even when called via the finalizer.
*   When compiled with DEBUG defined, emit diagnostic information related to resource cleanup to any TraceListener objects that may be registered.
*   Stop characterizing all log messages as errors. From now on, if the errorCode is zero, the message will not be considered an error.
*   Never attempt to configure the native logging interface if the SQLite core library has already been initialized for the process. Fix for \[2ce0870fad\].
*   Allow the SQLiteLog class to be used for logging messages without having an open connection.
*   Support building the core System.Data.SQLite assemblies using the .NET Framework 4.0 Client Profile. Fix for \[566f1ad1e4\].
*   When generating the schema based on the contents of a SQLiteDataReader, skip flagging columns as unique if the data reader is holding the result of some kind of multi-table construct (e.g. a cross join) because we must allow duplicate values in that case. Fix for \[7e3fa93744\].
*   When returning schema information that may be used by the .NET Framework to construct dynamic SQL, use a fake schema name (instead of null) so that the table names will be properly qualified with the catalog name (i.e. the attached database name). Partial fix for \[343d392b51\].
*   Add SQLiteSourceId property to the SQLiteConnection class to return the SQLite source identifier.
*   Add MemoryUsed and MemoryHighwater properties to the SQLiteConnection class to help determine the memory usage of SQLite.
*   Add DateTimeKind connection string property to control the DateTimeKind of parsed DateTime values. Partial fix for \[343d392b51\]. **\*\* Potentially Incompatible Change \*\***
*   Improve the robustness of the SQLiteLog class when it will be initialized and unloaded multiple times.
*   Fix the name of the interop assembly for Windows CE. Add unit tests to prevent this type of issue from happening again. Fix for \[737ca4ff74\].
*   Formally support the SQL type name BOOLEAN in addition to BOOL. Fix for \[544dba0a2f\].
*   Make sure the SQLiteConvert.TypeNameToDbType method is thread-safe. Fix for \[84718e79fa\].

**1.0.76.0 - October 4, 2011**

*   Prevent the domain unload event handler in SQLiteLog from being registered multiple times. Fix for \[0d5b1ef362\].
*   Stop allowing non-default application domains to initialize the SQLiteLog class. Fix for \[ac47dd230a\].

**1.0.75.0 - October 3, 2011**

*   Updated to [SQLite 3.7.8](https://www.sqlite.org/releaselog/3_7_8.html).
*   More enhancements to the build system.
*   Add official [NuGet](https://www.nuget.org/) packages for x86 and x64.
*   Add Changes and LastInsertRowId properties to the connection class.
*   Support more formats when converting data from/to the DateTime type.
*   Make all the assembly versioning attributes consistent.
*   Add unit testing infrastructure using [Eagle](http://eagle.to/).
*   Integrate all legacy unit tests, including the "testlinq" project, into the new test suite.
*   Add projects to build the interop assembly statically linked to the Visual C++ runtime. Fix for \[53f0c5cbf6\].
*   Add SQLITE\_ENABLE\_STAT2 compile-time option to the interop assembly. Fix for \[74807fbf27\].
*   Fix mutex issues exposed when running the test suite with the debug version of SQLite.
*   Fix transaction enlistment when repeated attempts are made to enlist in the same transaction. Fix for \[ccfa69fc32\].
*   Support the SQLITE\_FCNTL\_WIN32\_AV\_RETRY file control to mitigate the impact of file sharing violations caused by external processes.
*   Refactor the logging interface to be thread-safe and self-initializing.
*   Shutdown the SQLite native interface when the AppDomain is being unloaded. Fix for \[b4a7ddc83f\].
*   Support Skip operation for LINQ using OFFSET. Fix for \[8b7d179c3c\].
*   Support EndsWith operation for LINQ using SUBSTR. Fix for \[59edc1018b\].
*   Support all SQLite journal modes. Fix for \[448d663d11\].
*   Do not throw exceptions when disposing SQLiteDataReader. Fix for \[e1b2e0f769\].
*   The REAL type should be mapped to System.Double. Fix for \[2c630bffa7\] and \[b0a5990f48\].
*   Minor optimization to GetParamValueBytes(). Fix for \[201128cc88\].
*   Support the ON UPDATE, ON DELETE, and MATCH clause information when generating schema metadata for foreign keys. Partial fix for \[b226147b37\]. VS designer changes are not yet tested.
*   Fix incorrect resource name for SR.resx in the mixed-mode assembly.
*   Reduce the number of String.Compare() calls in the hot path for SQLiteCommand.ExecuteReader().

**1.0.74.0 - July 4, 2011**

*   Updated to [SQLite 3.7.7.1](https://www.sqlite.org/releaselog/3_7_7_1.html).
*   Fix incorrect hard-coded .NET Framework version information SQLiteFactory\_Linq.cs that was causing IServiceProvider.GetService to fail when running against the .NET Framework 3.5.
*   Fix all XML documentation warnings.
*   Restore support for the mixed-mode assembly (i.e. the one that can be registered in the Global Assembly Cache).
*   Restore support for the Compact Framework.
*   Remove unused "using" statements from the System.Data.SQLite and System.Data.SQLite.Linq projects.
*   Remove hard-coded System.Data.SQLite.Linq version from SQLiteFactory\_Linq.cs
*   Modify the setup to support bundled packages (i.e. with the mixed-mode assembly) and standard packages (i.e. with the managed assembly separate from the native interop library).
*   Disable the ability to register with the Global Assembly Cache in the standard setup package (i.e. it is available in the bundled setup only).
*   Remove PATH modification from the setup.
*   Modify the naming scheme for the source, setup, and binary packages to allow for the necessary variants.
*   In the build automation, attempt to automatically detect if Visual Studio 2008 and/or 2010 are installed and support building binaries for both at once, when available.
*   Add release automation to build the source, setup, and binary packages in all supported build variants.
*   Add the testlinq project to the new build system and make it work properly with Visual Studio 2008 and 2010.

**1.0.73.0 - June 2, 2011**

*   Updated to [SQLite 3.7.6.3](https://www.sqlite.org/releaselog/3_7_6_3.html).
*   Minor optimization to GetBytes(). Fix for \[8c1650482e\].
*   Update various assembly information settings.
*   Correct System.Data.SQLite.Linq version and resource information. Fix for \[6489c5a396\] and \[133daf50d6\].
*   Moved log handler from SQLiteConnection object to SQLiteFactory object to prevent if from being prematurely GCed.
*   We should block x64 installs on x86 and we should install native only if the setup package itself is native. Fix for \[e058ce156e\].

**1.0.72.0 - May 1, 2011**

*   Add the correct directory to the path. Fix for \[50515a0c8e\].

**1.0.71.0 - April 27, 2011**

*   Updated to SQLite 3.7.6+ [\[1bd1484cd7\]](https://www.sqlite.org/src/info/1bd1484cd7) to get additional Windows error logging.
*   Updated setup to optionally add install directory to PATH if GAC option selected.

**1.0.70.0 - April 22, 2011**

*   Added support for sqlite3\_extended\_result\_codes(), sqlite3\_errcode(), and sqlite3\_extended\_errcode() via SetExtendedResultCodes(), ResultCode(), and ExtendedResultCode().
*   Added support for SQLITE\_CONFIG\_LOG via SQLiteLogEventHandler().

**1.0.69.0 - April 12, 2011**

*   Code merge with [SQLite 3.7.6](https://www.sqlite.org/releaselog/3_7_6.html).
*   New VS2008 and VS2010 solution files.
*   Build and packaging automation.
*   New Inno Setup files.
*   Designer support currently not ready for release.

**1.0.68.0 - February 2011**

*   Code merge with [SQLite 3.7.5](https://www.sqlite.org/releaselog/3_7_5.html).
*   Continuing work on supporting Visual Studio 2010.

**1.0.67.0 - January 3, 2011**

*   Code merge with [SQLite 3.7.4](https://www.sqlite.org/releaselog/3_7_4.html).
*   Continuing work on supporting Visual Studio 2010.

**1.0.66.1 - August 1, 2010**

*   Code merge with SQLite 3.7.0.1
*   Re-enabled VS2005 designer support, broken in previous versions during the 2008 transition
*   Implemented new forms of Take/Skip in the EF framework courtesy jlsantiago
*   Added "Foreign Keys" to the connection string parameters
*   Added the Truncate option to the Journal Modes enumeration

**1.0.66.0 - April 18, 2010**

*   Code merge with SQLite 3.6.23.1
*   Fixed a bug in the installer that accidentally modified the machine.config on .NET versions prior to 2.0, invaliding the config file.
*   Fixed INTERSECT and EXCEPT union query generation in EF
*   Fixed an out of memory error in the trigger designer in cases where a WHEN clause is used in the trigger

**1.0.65.0 - July 26, 2009**

*   Fixed a bug in the encryption module to prevent a double free() when rekeying a database.
*   Fixed a bug in the encryption module when ATTACHing an encrypted database.
*   Incorporated the WinCE locking fix from ticket [#3991](https://www.sqlite.org/cvstrac/tktview?tn=3991)
*   Added "bigint" to the dropdown in the table designer, plus other minor table designer bugfixes.

**1.0.64.0 - July 9, 2009**

*   Fixed the missing resources problem from the 63 release.
*   Added preliminary support for the Visual Studio 2010 beta.
*   Fixed a bug in SQLiteCommand that threw a null reference exception when setting the Transaction object to null.
*   If SQLiteConnection.EnlistTransaction is called multiple times for the same transaction scope, just return without throwing an error.

**1.0.63.0 - June 29, 2009**

*   Code merge with SQLite 3.6.16
*   Check the autocommit mode of the connection to which a transaction is bound during the disposal of the transaction.  If autocommit is enabled, then the database has already rolled back the transaction and we don't need to do it during dispose, and can quietly ignore the step without throwing an error.
*   Eliminated the mergebin step altogether.  It was developed primarily to merge the Compact Framework binaries together, but since we're not doing that anymore, its use is limited.  Its non-standard method of merging a binary on the desktop framework is redundant as well.  The desktop binary now hard-links to MSCOREE, but as of Windows XP, this was redundant as well since XP and beyond automatically attempt to load MSCOREE on startup when a DLL has a .NET header.
*   More improvements to the test.exe program for running the tests against Sql Server for comparison purposes.

**1.0.62.0 - June 19, 2009**

*   Code merge with SQLite 3.6.15
*   Fixed the decimal reading bug in the SQLiteDataReader
*   Changed Join()'s to Sleep()'s in the statement retry code to prevent message pumping
*   Fixed a bad pointer conversion when retrieving blobs using GetBytes() in 64-bit land
*   Several changes to the Test program that comes with the provider.  Tests can now be individually disabled, and the test program can run against several provider back-ends

**1.0.61.0 - April 28, 2009**

*   Code merge with SQLite 3.6.13. The new backup features are as yet unimplemented in the provider, but will be forthcoming in a subsequent release
*   Fixed the default-value lookups in SQLiteConnectionStringBuilder when accessing properties
*   Lock the SQLiteTransaction object during dispose to avoid potential race condition during cleanup
*   Fixed SQLiteDataReader.GetDecimal() processing and parsing of decimal values for cases when SQLite returns things like "1.0e-05" instead of "0.0001"

**1.0.60.0 - October 3, 2008**

*   Throw a NotSupported exception in the EF Sql Gen code instead of parsing illegal SQL during an update/insert/delete where no primary key is defined.
*   Fixed the Compact Framework interop library.  Since the linker flag /subsystem had no version specified, it was causing a problem for many CE-based platforms.
*   Incorporated SQLite patch for ticket [#3387](https://www.sqlite.org/cvstrac/tktview?tn=3387) and reverted out the vfs override code I added in build 59 to work around this problem.
*   Fixed a designer issue when creating a new table from the Server Explorer.  After initially saving it, if you then continued to edit it and tried to save it again, it would generate the change SQL using the old temporary table name rather than the new name.

**1.0.59.0 - September 22, 2008**

*   Code merge with SQLite 3.6.3.  Solves a couple different EF issues that were either giving inconsistent results or crashing the engine.
*   Fixed the parsing of literal binaries in the EF SqlGen code.  SQLite now passes nearly all the testcases in [Microsoft's EF Query Samples](http://sqlite.phxsoftware.com/forums/p/1377/5921.aspx#5921) application -- the exception being the _datetimeoffset_ and _time_ constants tests, and tests that use the _APPLY_ keyword which are unsupported for now.
*   Revamped the Compact Framework mixed-mode assembly.  Tired of playing cat and mouse with the Compact Framework's support for mixed-mode assemblies.  The CF build now requires that you distribute both the System.Data.SQLite library and the paired SQLite.Interop.XXX library.   The XXX denotes the build number of the library.
*   Implemented a workaround for Vista's overzealous caching by turning off FILE\_FLAG\_RANDOM\_ACCESS for OS versions above XP.  This is implemented as a custom (default override) VFS in the interop.c file, so no changes are made to the SQLite source code.
*   Fixed some registry issues in the designer install.exe, which prevented some design-time stuff from working on the Compact Framework when .NET 3.5 was installed.

**1.0.58.0 - August 30, 2008**

*   Code merge with SQLite 3.6.2.  If only I'd waited one more day to release 57!  Several LINQ issues have been resolved with this engine release relating to deeply-nested subqueries that the EF SqlGen creates.
*   The Rollback SQLiteConnection event no longer requires an open connection in order to subscribe to it.  Missed this one in the 57 release.

**1.0.57.0 - August 29, 2008**

*   Compiled against 3.6.1 with checkin [#3300](https://www.sqlite.org/cvstrac/tktview?tn=3300) resolved, which fixes an Entity Framework bug I was seeing.  I currently have 3 other tickets out on the engine, which are not yet resolved and relate to EF.
*   Fixed decimal types to store and fetch using InvariantCulture.  If you're using decimal datatypes in your database and were affected by the 56 release, please issue an UPDATE <table> SET <column> = REPLACE(<column>, ',', '.');  to fix the decimal separators.  Apologies for not testing that more thoroughly before releasing 56.
*   Too many LINQ fixes to list.  Fixed views so they generate, fixed the LIMIT clause, implemented additional functionality and removed unnecessary code.
*   Fixed foreign key names in the designer so viewing the SQL script on a new unsaved table after renaming it in the properties toolwindow will reflect in the script properly.
*   Fixed the Update and Commit events on SQLiteConnection so they don't require the connection to be opened first.
*   Fixed userdef aggregate functions so they play nice with each other when appearing multiple times in the same statement.
*   Fixed the editing and saving of default values in the table designer.
*   Fixed ForeignKeys schema to support multi-column foreign keys.  Also hacked support for them in the table designer, provided two foreign keys in the designer have the same name and reference the same foreign table and different columns.  Will implement first-class support for this in the next release.

**1.0.56.0 - August 11, 2008**

*   Fixed a bug in the table designer when designing new tables, wherein you had to save the table first before being able to create indexes and foreign keys.
*   Tweaks to decimal type handling.  The 'decimal' type can't be represented by Int64 or Double (without loss of precision) in SQLite, so we have to fudge it by treating it like a string and converting it back and forth in the provider.  Unfortunately backing it to the db as a string causes sorting problems.  See [this post](http://sqlite.phxsoftware.com/forums/p/1296/5595.aspx#5595) for details on using a custom collation sequence to overcome the sorting issue arising from this patch.
*   Minor tweaks and bugfixes to the test program and the provider.
*   More adjustments to make the managed-only version of the provider run and pass all tests on Mono.
*   LINQ to Entities bits heavily updated and compiled against VS2008 SP1 RTM.  SQLite LINQ support is still considered beta.

**1.0.55.0 - August 6, 2008**

*   Code merge with SQLite 3.6.1
*   Added support for the user-contributed extension-functions at [https://www.sqlite.org/contrib](https://www.sqlite.org/contrib).  Feel free to override any of them with your own implementation.  The new functions are: _acos, asin, atan, atn2, atan2, acosh, asinh, atanh, difference, degrees, radians, cos, sin, tan, cot, cosh, sinh, tanh, coth, exp, log, log10, power, sign, sqrt, square, ceil, floor, pi, replicate, charindex, leftstr, rightstr, reverse, proper, padl, padr, padc, strfilter,_ and aggregates _stdev, variance, mode, median, lower\_quartile, upper\_quartile._
*   Moved the last\_rows\_affected() function to the C extension library.
*   Added a new class, SQLiteFunctionEx which extends SQLiteFunction and adds the ability for a user-defined function to get the collating sequence during the Invoke/Step methods.  User-defined functions can use the collating sequence as a helper to compare values.
*   When registering user-defined collation sequences and functions, the provider will now register both a UTF8 and a UTF16 version instead of just UTF8.
*   Revamped connection pooling and added static ClearPool() and ClearAllPools() functions to SQLiteConnection.  Behavior of the pool and its clearing mechanics match SqlClient.
*   Fixed connections going to the pool so that any unfinalized lingering commands from un-collected datareaders are automatically reset and any lurking transactions made on the connection are rolled back.
*   Transaction isolation levels are now partially supported.  Serializable is the default, which obtains read/write locks immediately -- this is compatible with previous releases of the provider.  Unspecified will default to whatever the default isolation mode is set to, and ReadCommitted will cause a deferred lock to be obtained.  No other values are legal.
*   Revamped the test.exe program.  It's now an interactive GUI application.  Easier for me to add tests now.
*   Tweaks to the VS designer package and installer.
*   More adjustments to the internal SQLite3.Prepare() method to account for both kinds of lock errors when retrying.
*   Stripped a lot of unnecessary interop() calls and replaced with base sqlite calls.  Revamped most of UnsafeNativeMethods to make it easier to port the code.
*   Rerigged internal callbacks for userdef functions and other native to managed callbacks.  More portable this way.
*   Source can now can be compiled with the SQLITE\_STANDARD preprocessor symbol to force the wrapper to use the stock sqlite3 library.  Some functionality is missing, but its minimal.  None of the precompiled binaries are compiled using this setting, but its useful for testing portability.
*   Added "boolean" and a couple other missing datatypes to the "DataTypes" schema xml file.  Used by the VS designer when displaying tables and querying.
*   Added a new connection string option "Read Only".  When set to True, the database will be opened in read-only mode.
*   Added a new connection string option "Max Pool Size" to set the maximum size of the connection pool for a given db file connection.
*   Added a new connection string option "Default IsolationLevel" to set the default isolation level of transactions.  Possible values are Serializable and ReadCommitted.
*   Added a new connection string option "URI" as an optional parameter for compatibility with other ports of the provider.

**1.0.54.0 - July 25, 2008**

*   Fixed the setup project, which somehow "forgot" to include all the binaries in the 53 release.
*   Fixed a crash in the table designer when creating a new table and tabbing past the "Allow Nulls" cell in the grid while creating a new column.
*   Fixed a mostly-benign bug in SQLiteDataReader's GetEnumerator, which failed to pass along a flag to the underyling DbEnumerator it creates.  This one's been around since day 1 and nobody's noticed it in all these years.
*   Added a new connection string parameter "Journal Mode" that allows you to set the SQLite journal mode to Delete, Persist or Off.

**1.0.53.0 - July 24, 2008**

*   Enabled sqlite\_load\_extension
*   Added retry/timeout code to SQLite3.Prepare() when preparing statements for execution and a SQLITE\_BUSY error occurs.
*   Added a new schema to SQLiteConnection.GetSchema() called _Triggers_.  Used to retrieve the trigger(s) associated with a database and/or table/view.
*   Extensive updates to table/view editing capabilities inside Visual Studio's Server Explorer.  The program now parses and lets you edit CHECK constraints and triggers on a table, as well as define triggers on views.  Experimental still, so e-mail me if you have issues.
*   Minor bugfix to the ViewColumns schema to return the proper base column name for a view that aliases a column.
*   Fixed the insert/update/delete DML support in the Linq module.
*   Changed the behavior of SQLiteCommand to allow a transaction to be set even if the command hasn't been associated with a connection yet.

**1.0.52.0 - July 16, 2008**

*   Code merge with SQLite 3.6.0
*   Added a lot of previously-missing exports to the DEF file for the native library.
*   Fixed SQLiteDataReader to check for an invalid connection before operating on an open cursor.
*   Implemented the Cancel() function of SQLiteCommand to cancel an active reader.
*   Added beta table and view designers to the Visual Studio Server Explorer.  You can now edit/create tables and views, manage indexes and foreign keys from Visual Studio.  This feature is still undergoing testing so use at your own risk!
*   Fixed the Server Explorer so VS2005 users can once again right-click tables and views and open the table data.
*   Added some new interop code to assist in returning more metadata not normally available through the SQLite API.  Specifically, index column sort modes and collating sequences.  Also added code to detect (but not parse) CHECK constraints, so the table designer can pop up a warning when editing a table with these constraints.  Since I can't currently parse them.
*   Lots of LINQ SQL generation improvements and fixes.
*   Made some progress cleaning up and fixing up the schema definitions and manifests for EdmGen.
*   Added a built-in SQLiteFunction called last\_rows\_affected() which can be called from SQL to get the number of rows affected by the last update/insert operation on the connection.  This is roughly equivalent to Sql Server's @@ROWCOUNT variable.

**1.0.51.0 - July 1, 2008**

*   **VS2008 SP1 Beta1 LINQ Support**
*   Added experimental Entity Framework support in a new library, System.Data.SQLite.Linq.  Some things work, some don't.  I haven't finished rigging everything up yet.  The core library remains stable.  All LINQ-specific code is completely separate from the core.
*   Added some columns to several existing schemas to support some of the EDM framework stuff.
*   Minor tweaks to the factory to better support dynamic loading of the Linq extension library for SQLite.
*   SQLite's busy handler was interfering with the provider's busy handling mechanism, so its been disabled.

**1.0.50.0 - June 27, 2008**

*   Fixed some lingering dispose issues and race conditions when some objects were finalized.
*   Fixed the SQLiteConvert.Split() routine to be a little smarter when splitting strings, which solves the quoted data source filename problem.
*   Enhanced the mergebin utility to work around the strong name validation bug on the Compact Framework.  The old workaround kludged the DLL and caused WM6.1 to fail to load it.  This new solution is permanent and no longer kludges the DLL.

**1.0.49.0 - May 28, 2008**

*   Code merge with SQLite 3.5.9
*   Fixed schema problems when querying the TEMP catalog.
*   Changed BLOB datatype schema to return IsLong = False instead of True.  This was preventing DbCommandBuilder from using GUID's and BLOB's as primary keys.
*   Fix rollover issue with SQLite3.Reset() using TickCount.
*   Fixed SQLiteDataReader to dispose of its command (if called for) before closing the connection (when flagged to do so) instead of the other way around.
*   Fixed a DbNull error when retrieving items not backed by a table schema.
*   Fixed foreign key constraint parsing bug.
*   Added FailIfMissing property to the SQLiteConnectionStringBuilder.
*   Converted the source projects to Visual Studio 2008.

**1.0.48.0 - December 28, 2007**

*   Code merge with SQLite 3.5.4
*   Calling SQLiteDataReader.GetFieldType() on a column with no schema information and whos first row is initially NULL now returns type Object instead of type DbNull.
*   Added support for a new DateTime type, JulianDay.  SQLite uses Julian dates internally.
*   Added a new connection string parameter "Default Timeout" and a corresponding method on the SQLiteConnection object to change the default command timeout.  This is especially useful for changing the timeout on transactions, which use SQLiteCommand objects internally and have no ADO.NET-friendly way to adjust the command timeout on those commands.
*   FTS1 and FTS2 modules were removed from the codebase.  Please upgrade all full-text indexes to use the FTS3 module. 

**1.0.47.2 - December 10, 2007**

*   Fixed yet one more bug when closing a database with unfinalized command objects
*   Fixed the DataReader's GetFieldType function when dealing with untyped SQLite affinities

**1.0.47.1 - December 5, 2007**

*   Fixed a leftover bug from the codemerge with SQLite 3.5.3 that failed to close a database.
*   Fixed the broken Compact Framework distribution binary.
*   SQLite 3.5.x changed some internal infrastructure pieces in the encryption interface which I didn't catch initially.  Fixed. 

**1.0.47.0 - December 4, 2007**

*   Code merge with SQLite 3.5.3
*   Added installer support for Visual Studio 2008.  Code is still using the VS2005 SDK so one or two bells and whistles are missing, but nothing significant.
*   This is the last version that the FTS1 and FTS2 extensions will appear.  Everyone should rebuild their fulltext indexes using the new FTS3 module.  FTS1 and FTS2 suffer from a design flaw that could cause database corruption with certain vacuum operations.
*   Fixed pooled connections so they rollback any outstanding transactions before going to the pool. 
*   Fixed the unintended breaking of the TYPES keyword, and mis-typing of untyped or indeterminate column types.
*   Assert a FileIOPermission() requirement in the static SQLiteFunction constructor.
*   The CE-only SQLiteFunction.RegisterFunction() is now available on the desktop platform for dynamic registration of functions.  You must still close and re-open a connection in order for the new function to be seen by a connection.
*   Fixed the "database is locked" errors by implementing behavioral changes in the interop.c file for SQLite.  Closing a database force-finalizes any prepared statements on the database to ensure the connection is fully closed.  This was rather tricky because the GC thread could still be finalizing statements itself.  
*   Modifed the mergebin utility to help circumvent a long-standing strong name verification bug in the Compact Framework.

**1.0.46.0 - September 30, 2007**

*   Fixed faulty logic in type discovery code when using SQLiteDataReader.GetValue().
*   Fixed Connection.Open() bug when dealing with :memory: databases.
*   Fixed SQLiteCommand.ExecuteScalar() to return a properly-typed value.
*   Added support for SQLiteParameter.ResetDbType().
*   Added test cases for rigid and flexible type testing.

**1.0.45.0 - September 25, 2007**

*   **Breaking change in GetSchema("Indexes")** \-- MetaDataCollections restrictions and identifier parts counts were wrong for this schema and I was using the wrong final parameter as the final restriction.  Meaning, if you use the Indexes schema and are querying for a specific index the array should now be {catalog, null, table, index } instead of {catalog, null, table, null, index}
*   Code merge with SQLite 3.4.2
*   Fixed some errors in the encryption module, most notably when a non-default page size is specified in the connection string.
*   Fixed SQLiteDataReader to better handle type-less usage scenarios, which also fixes problems with null values and datetimes.
*   Fixed the leftover temp files problem on WinCE
*   Added connection pooling.  The default is disabled for now, but may change in the future.  Set "Pooling=True" in the connection string to enable it.
*   Sped up SQLiteConnection.Open() considerably.
*   Added some more robust cleanup code regarding SQLiteFunctions.
*   Minor additions to the code to allow for future LINQ integration into the main codebase.
*   Fixed a long-standing bug in the Open() command of SQLiteConnection which failed to honor the documented default behavior of the SQLite.NET provider to open the database in "Synchronous=Normal" mode.  The default was "Full".
*   If Open() fails, it no longer sets the connection state to Broken.  It instead reverts back to Closed, and cleans up after itself.
*   Added several new parameters to the ConnectionString for setting max page count, legacy file format, and another called FailIfMissing to raise an error rather than create the database file automatically if it does not already exist.
*   Fixed some designer toolbox references to the wrong version of the SQLite.Designer
*   Fixed a bug in the mergebin utility with regards to COR20 metadata rowsize computations. 
*   Minor documentation corrections   

**1.0.44.0 - July 21, 2007**

*   Code merge with SQLite 3.4.1
*   Fixed a bug in SQLiteConnection.Open() which threw the wrong kind of error in the wrong kind of way when a database file could not be opened or created. 
*   Small enhancements to the TYPES keyword, and added documentation for it in the help file.
*   Hopefully fixed the occasional SQLITE\_BUSY errors that cropped up when starting a transaction.  Usually occurred in high-contention scenarios, and the underlying SQLite engine bypasses the busy handler in this scenario to return immediately.

**1.0.43.0 - June 21, 2007**

*   Code merge with SQLite 3.4.0
*   Fixed a reuse bug in the SQLiteDataAdapter in conjunction with the SQLiteCommandBuilder.  It's been there unnoticed for more than a year, so it looks like most folks never encountered it.
*   Fixed an event handler bug in SQLiteCommandBuilder in which it could fail to unlatch from the DataAdapter when reused.  Relates to the previous bugfix.
*   Fixed a double-dispose bug in SQLiteStatement that triggered a SQLiteException. 

**1.0.42.0 - June 1, 2007**

*   Code merge with SQLite 3.3.17
*   Changed the SQLiteFunction static constructor so it only enumerates loaded modules that have referenced the SQLite assembly, which hopefully should cut down dramatically the time it takes for that function to execute. 
*   Added the FTS2 full-text search extension to the project.  Look for FTS1 to disappear within the next couple of revisions. 
*   Fixed a bug introduced with the finalizers that triggered an error when statements ended with a semi-colon or had other non-parsable comments at the end of a statement 
*   Fixed an intermittent multi-threaded race condition between the garbage collector thread and the main application thread which lead to an occasional SQLITE\_MISUSE error.
*   Fixed another issue relating to SQLite's inherent typelessness when dealing with aggregate functions which could return Int64 or Double or even String for a given row depending on what was aggregated.
*   Remembered to recompile the DDEX portion of the engine this time, so Compact Framework users can once again use the design-time functionality

**1.0.41.0 - April 23, 2007**

*   Code merge with SQLite 3.3.16
*   Second go at implementing proper finalizers to cleanup after folks who've forgotten to Dispose() of the SQLite objects
*   Enhanced GetSchema(IndexColumns) to provide numeric scale and precision values
*   Fixed the column ordinals in GetSchema(IndexColumns) to report the ordinal of the column in the index, not the table
*   Fixed a bug whereby parameters named with an empty string (such as String.Empty) were treated like a named parameter instead of an unnamed parameter

**1.0.40.0 - January 31, 2007**

*   Code merge with SQLite 3.3.12
*   Lots of new code to handle misuse of the library.  Implemented finalizers where it made sense, fixed numerous garbage collector issues when objects are not disposed properly,  fixed some object lifetime issues, etc.
*   A failed Commit() on a transaction no longer leaves the transaction in an unusable state.

**1.0.39.1 - January 11, 2007**

*   Fixed a really dumb mistake that for some reason didn't trigger any errors in the testcases, whereby commands when associated with a connection were not adding or removing themselves from an internal list of commands for that connection -- causing a "database is locked" error when trying to close the connection.

**1.0.39.0 - January 10, 2007**

*   Code merge with SQLite 3.3.10
*   Fixed a multi-threaded race condition bug in the garbage collector when commands and/or connections are not properly disposed by the user.
*   Switched the encryption's internal deallocation code to use sqlite's built-in aux functions instead of modifying the pager.c source to free the crypt block.  This eliminates the last of the code changes the provider makes to the original SQLite engine sources.  Props to Ralf Junker for pointing that out.

**1.0.38.0 - November 22, 2006**

*   Fixed a bug when using CommandBehavior.KeyInfo whereby integer primary key columns may be duplicated in the results.
*   Enhanced the CommandBuilder so that update/delete statements are optimized when the affected table contains unique constraints and a primary key is present.
*   Fixed a bug in the DataReader when used in conjunction with CommandBehavior.CloseConnection.

**1.0.37.0 - November 19, 2006**

*   Added support for CommandBehavior.KeyInfo.  When specified in a query, additional column(s) will be returned describing the key(s) defined for the table(s) selected in the query.  This is optimized when INTEGER PRIMARY KEY is set for the given tables, but does additional work for other kinds of primary keys.
*   Removed the default values from SQLiteDataReader.GetTableSchema(), to better follow Sql Server's pattern and suppress schema errors when loading the records into a dataset/datatable.
*   Allow integers to implicitly convert to double/decimal/single.

**1.0.36.1 - October 25, 2006**

*   Added support for LONGVARCHAR, SMALLDATE and SMALLDATETIME. These were actually added in 1.0.36.0 but were undocumented.
*   Fixed the embedded helpfile which was accidentally built from old sources.
*   Fixed an unfortunate re-entry of a bug in the .36 codebase that caused the provider to "forget" about commands on a connection under certain circumstances.

**1.0.36.0 - October 23, 2006**

*   Code merge with SQLite 3.3.8, including support for full-text search via the FTS1 extension. 
*   Fixed a bug retrieving data types when UseUtf16Encoding is true. Side-effect of further merging the common code between the two base classes.
*   Fixed a bug with System.Transactions whereby a connection closed/disposed within a transaction scope is rolled back and cannot be committed.
*   Added more error checking and reporting to transactions to help user's isolate the source of transaction failures.
*   Implemented a workaround for a Compact Framework issue regarding strong-named assemblies containing a PE section with a raw size less than the virtual size. 

**1.0.35.1 - September 12, 2006**

*   Fixed the TYPES keyword to work when UseUTF16Encoding is true.
*   Fix another bug revealed in 1.0.35.0 regarding infinite loops when the 2nd or subsequent statements of a semi-colon separated command cannot be parsed.
*   Updated the help documentation. 

**1.0.35.0 - September 10, 2006**

*   Fixed an infinite loop bug in SQLiteCommand caused when multiple semi-colon separated statements in a single command are executed via datareader and one of the statements contains a syntax error preventing it from being prepared. 
*   Added the TYPES preparser keyword to be placed before a SELECT statement to aid the wrapper in converting expressions in a subsequent select clause into more robust types.  Documentation yet to be integrated, but available on the forums.
*   Added a new connectionstring parameter "BinaryGUID=true/false" (default is "true").  When true, guid types are stored in the database as binary blobs to save space.  Binary has been the default format since 1.0.32.0 but this parameter eases backward compatibility.

**1.0.34.0 - September 4, 2006**

*   Fixed a bug in SQLiteParameterCollection.RemoveAt(namedparam)
*   Fixed a bug in SQLiteDataReader introduced in 1.0.30 that broke DateTimes using the Ticks option in the connection string.
*   Fixed a bug in the recent changes to guid behavior wherein using a datareader's indexer to fetch a guid from a column containing both binary and text guids would sometimes return a byte array instead of a guid.
*   Enacted a workaround involving typed datasets in Compact Framework projects in which it took an excessive amount of time to open a form and generated a lot of temporary files in the user's Local Settings\\Application Data\\Microsoft\\VisualStudio\\8.0\\Assembly References folder.

**1.0.33.0 - August 21, 2006**

*   Code merge with SQLite 3.3.7
*   Fixed a bug in SQLiteConnection that caused it to "forget" about commands bound to it and occasionally throw an error when a database is closed and opened repeatedly. 

**1.0.32.0 - August 6, 2006**

*   Added AllowPartiallyTrustedCallers attribute to the assembly
*   Added the missing "nchar" type
*   Added support for binary Guid's.  Guids are now stored as binary by default when using parameterized queries.  Text guids are still fully supported.
*   Fixed a TransactionScope() error that caused the transaction not to be completed.
*   Enhanced parameter names so that if they are added to the Parameters collection without their prefix character (@ : or $) they are still properly mapped. 

**1.0.31.0 - July 16, 2006**

*   Re-applied the view parsing bugfix in 1.0.29.0 that was accidentally reverted out of the 30 build.
*   Fixed SQLiteCommand.ExecuteScalar() to return null instead of DbNull.Value when no rows were returned.
*   Design-time installer now installs the package-based designer on full Visual Studio versions.  Express editions continue to use the packageless designer.
*   In Visual Studio (not Express), you can now right-click a SQLite connection in the Server Explorer and vacuum the database and change the encryption password.

**1.0.30.1 - July 2, 2006**

*   Code merge with SQLite 3.3.6
*   Added support for the |DataDirectory| keyword in the Data Source filename string. 
*   Added hook notification support to SQLiteConnection.  Specifically, there are three new events on the SQLiteConnection object which are raised when an update/insert/delete occurs and when transactions are committed and rolled back.
*   Changed SQLiteTransaction to default to BEGIN IMMEDIATE instead of just BEGIN, which solves a multithreaded race condition. 
*   Changed SQLiteDataReader to better support SQLite's typelessness.  The data reader no longer caches column affinity, but re-evaluates it for each column/row.
*   Fixed a bug in Prepare() which caused an intermittant fault due to the code accessing the memory of an unpinned variable. 
*   Fixed a multithreaded lock-retry bug in in SQLiteConnection.Open() and in SQLiteTransaction, which failed to use a command timeout before giving up.

**1.0.29.0 - May 16, 2006**

*   Fixed a bug in the Views schema information which caused multi-line view definition statements not to be parsed
*   Fixed a parsing bug in SQLiteDataReader.GetSchemaTable() to account for numeric(x,y) datatypes with specified precision and scale
*   Fixed a bug in SQLiteConnection.Open() which tried to automatically enlist in an ambient transaction but had not yet set the state of the database to Opened, thereby causing a transaction fault
*   Changed SQLiteException to inherit from DbException on the full framework

**1.0.28.0 - April 14, 2006**

*   Code merge with SQLite 3.3.5
*   You can now specify a relative path in the Compact Framework's "Data Source" by prefixing the file with ".\\".  i.e. "Data Source=.\\\\mydb.db3"
*   Several more changes and enhancements to schemas for better compatibility.
*   Fixed several bugs with the 64-bit builds of the provider.  The x64 binary is now optimized.
*   Design-time installer now tries to install the 64-bit builds into the GAC along with the 32-bit build.
*   Fixed a bug in the SQLiteDataReader.GetSchemaTable() function when used with tables containing apostrophes.
*   Fixed an XSD-related bug whereby the XSD utility was unable to locate the provider and could not generate typed datasets.
*   Added NTEXT and STRING datatypes to the list of recognized keywords (used for schema retrieval).
*   Due to the XSD bug and other potential problems related to external build utilities, changes to the installation of the designer have had to be made.  The installer used to write the DbProviderFactories XML into the devenv.exe.config file and its express cousins, but now has to write instead to the machine.config.
*   Installer writes to both the 32-bit machine.config and the 64-bit machine.config if it exists. 

**1.0.27.1 - February 28, 2006**

*   Fixed a bug when doing data binding in Compact Framework projects that prevented you from assigning a typed dataset to a bindingsource.  It turns out, the CF version of the SQLite provider needs to be flagged as retargetable so it'll work in the design-time desktop environment.  No changes were made to the desktop build, but the revision was bumped on all libraries anyway in order to keep them sync'd. 

**1.0.27.0 - February 27, 2006**

*   Many optimizations and a few more minor adjustments to schemas and schema retrieval performance.
*   Lots of design-time attributes added to the code.  The DbDataAdapter, DbCommand, and DbConnection objects now have greatly enhanced design-time capabilities when added to the toolbox and dropped on a form.
*   Lots of Server Explorer enhancements.
*   Binaries are now distributed in a setup program for easier administration and configuration of the provider.

**1.0.26.2 - February 15, 2006**

*   Yet another bugfix to index schemas, which was incorrectly marking most indexes as primary key indexes.
*   Fixed GetSchema() to accept a null string array.
*   Fixed a misspelled export in the core C library that prevented databases opened with UTF16Encoding from getting schema information and would likely cause an error if attempted.

**1.0.26.1 - February 14, 2006**

*   Fixed even more minor schema bugs having to do with indexes.
*   Added two missing pieces in the SQLite designer which were preventing it from being used from within VS Express editions. 
*   Several bugfixes to the design-time installer program, including supporting 64-bit environments.

**1.0.26.0 - February 11, 2006**

*   Code merge with SQLite 3.3.4
*   Fixed an encryption bug when changing the password of databases over 1gb in size. 
*   Fixed various designer issues related to construction of named parameters.
*   Retooled the GetSchema() method of SQLiteDataReader to use the new 3.3.4 API functions, and made several enhancements and fixes to schemas. 
*   Implemented the SourceColumnNullMapping property of SQLiteParameter to fix a DbCommandBuilder code generation bug. 
*   Removed the runtime dependency on msvcr80.dll.  File size is somewhat larger for the varying desktop versions.
*   Created an install program to manage installation and uninstallation of the SQLite design-time support.
*   Designer support now works for all Visual Studio editions, including all Express Editions.
*   Design-time installer will now remove (if present) the machine.config SQLite entries in favor of installing the xml code into the devenv.exe.config file (or any of the variations for express editions).  The officially-accepted behavior of using DbProviderFactories is to add the code to your app.config file, and the machine.config file should not be touched.

**1.0.25.0 - January 31, 2006**

*   Code merge with SQLite 3.3.3
*   Added automatic distributed transaction enlistment and implemented the DbConnection.EnlistTransaction method for manual enlistment.
*   Nested transactions are now supported.
*   Rearranged the timing of SetPassword(), which now must be called before the database is opened instead of afterwards.  Optionally, the password can be supplied in the ConnectionString.
*   Fixed a bug in SQLiteFunction that caused a failure when an empty resultset was returned and a custom user aggregate function was used in the query.
*   The designer has had another round of cleanup applied, in preparation for moving to a VS package.
*   Added SQLiteMetaDataCollectionNames class.

**1.0.24.6 beta - January 23, 2006**

*   This beta is built from sqlite.org's 3.3.2 beta.
*   Eliminated the static linking of mscoree from all binaries.  Native projects can now use the library without any dependencies on the .NET framework, while managed projects continue to be able to use the library normally.

**1.0.24.5 beta - January 20, 2006**

*   This beta is built from sqlite.org's 3.3.1 alpha and contains development-in-progress code.  Therefore no guarantees can be made regarding its suitability for production use.
*   **You no longer need to distribute 2 files on the CompactFramework.  You can delete SQLite.Interop.dll entirely.**  I wrote a custom tool called "mergebin" (available in the source zip file) which combines the two libraries and gets around a glaring defect in the VS2005 linker for ARM processors which doesn't allow you to link netmodules.
*   **x64 and ia64 builds now use the same strong name as the x86 build.**  This means breaking backward compatibility, but it was necessary in order to allow you to drop any of those 3 builds onto a PC and have your .NET program run properly.  Prior to this, you'd get an error if you built your program using the x86 build, and then installed the x64 version on a target machine and tried to run your program against it.
*   The entire source project has been gone over top to bottom.  A debug build no longer combines the binaries into a single module, which was preventing proper debugging.

**1.0.24.4 beta - January 16, 2006**

*   This beta is built from sqlite.org's 3.3.1 alpha and contains development-in-progress code.  Therefore no guarantees can be made regarding its suitability for production use.
*   Fixed a bug in the UTF-16 handling code for preparing statements due to a behavioral change in SQLite 3.3.0.
*   Added pager.c code necessary to cleanup after an encrypted file is closed.
*   Fixed an encryption bug that caused a fault when an encrypted file was rolled back.
*   Modified the testcase code to take advantage of optimizations regarding the use of a DbCommandBuilder.  DataAdapter insert speed increased dramatically as a result.

**1.0.24.3 beta - January 10, 2006**

*   This beta is built from sqlite.org's 3.3.0 alpha and contains development-in-progress code.  Therefore no guarantees can be made regarding its suitability for production use.
*   Added support for database encryption at the pager level.  Databases are encrypted using a 128-bit RC4 stream algorithm.  To open an existing encrypted database, you may now specify a "Password={password}" text in the ConnectionString, or you may call the SQLiteConnection.SetPassword() function to set the password on an open connection.  To encrypt existing non-encrypted databases or to change the password on an encrypted database, you must use the SQLiteConnection.ChangePassword() function.  If you use SetPassword() instead of specifying a password in the connection string, or call ChangePassword() you may use a binary byte array or a text string as the password.
*   Rewrote the locking implementation for the Compact Framework.  It is now more robust and incorporates into the SQLite codebase more efficiently than the previous CE adaptation.
*   Moved some of the embedded schema XML data into a resource file to ease code readability.
*   Automated the fixup of the original SQLite codebase's source prior to compiling, to ease merging with sqlite.org's source.
*   Fixed a memory leak in SQLiteCommand due to it not removing an internal reference to itself in SQLiteConnection. 

**1.0.24.2 - December 30, 2005**

*   Fixed the SQLiteDataReader.HasRows property to return the proper value.
*   Implemented the inadvertently neglected RecordsAffected property on SQLiteDataReader.
*   SQLiteFunction static constructor was changed to pre-filter classes with only the SQLiteFunctionAttribute.  The code was throwing an exception when certain assemblies were referenced in a project.
*   Fixed the SQLiteDataAdapter OnRowUpdated event, which was using the wrong variable to find the attached event handler and subsequently not raising the event.
*   Small optimizations and fixes to SQLiteDataReader.NextResult(). 

**1.0.24.1 - December 19, 2005**

*   Update core SQLite engine to 3.2.8 

**1.0.24 - December 9, 2005**

*   Fixed the _Catalogs_ schema bug that caused attached databases not to be re-attached to a cloned connection
*   Enhanced transactions to allow for a deferred or immediate writelock.  SQLiteConnection.BeginTransaction() now has an additional overload to support it 
*   Commands are now prepared as they are executed instead of beforehand.  This fixes a bug whereby a multi-statement command that alters the database and subsequently references the altered data would fail during Prepare().
*   Tightened up the SQLiteDataReader to prevent reading columns before calling the first Read() and to prevent reading columns after the last Read().
*   A more descriptive error is thrown if there aren't enough parameters in the command to satisfy the parameters required by the statement(s). 

**1.0.23 - November 21, 2005**

*   Named parameters may now begin with **@** to ease portability of the provider. SQLite's named parameters are ordinarily prefixed with a **:** or **$**.  The designer will still use the **$** prefix however, since its more compatible with the default SQLite engine.
*   Added several alternate ISO8601 date/time formats to SQLiteConvert.cs to increase compatibility.
*   Relaxed coersion restrictions to work better with SQLite's inherent typelessness. 

**1.0.22 - November 11, 2005**

*   Fixed some globalization issues which resulted in incorrect case-insensitive comparisons
*   Fixed a bug in the routine that finds all user-defined functions in a loaded assembly.  It would throw an exception if any of the types in the assembly could not be loaded.  The exception is now caught and handled appropriately.

**1.0.21 - November 4, 2005**

*   Fixed a designer bug when creating typed datasets with parameterized queries.
*   The above fix then exposed another bug in the datareader's ability to query schema information on parameterized commands, which was also fixed.
*   Compiled against the RTM version of VS2005.
*   Rewrote the design-time install script to use the XML DOM objects when writing to the machine.config and to automatically register the DLL in the GAC.
*   Made changes to the app.config descriptions and help file to improve version-independent factory support.

**1.0.20 - October 19, 2005**

*   Fixed a shortcut in SQLiteBase.GetValue which was insufficient for international environments.  The shortcut was removed and the "proper" procedure put in.

**1.0.19 - October 5, 2005**

*   Code merge with SQLite 3.2.7
*   Fixed bugs in the CE port code (os\_wince.c) which were brought to light by recent changes in the SQLite engine.
*   Recompiled and modified to be compatible with the September VS2005 Release Candidate.  
    Beta 2 users should continue to use 1.0.18.1

**1.0.18.1 - September 19, 2005**

*   Code merge with SQLite 3.2.6

**1.0.18 - September 1, 2005**

*   Added type-specific method calls when using the various SQLite classes that would've normally returned a a generic Db base class, which aligns the code better with the Microsoft-supplied data providers.

**1.0.17 - August 26, 2005**

*   Code merge with SQLite 3.2.5
*   Added Itanium and x64 build settings to the project (needs testing)
*   Bugfixes and enhancements to several schema types
*   Additional design-time support to include index and foreign key enumerations.  Requires re-registering the designer using INSTALL.CMD.  The new designer code now allows the VS query designer and typed datasets to automatically link up foreign keys, use indexes, and automatically generate relationships from the schema.
*   Additional static methods on SQLiteConnection to create a database file, encrypt a file using the Encrypted File System (EFS) on NTFS (requires NT 2K or above) and NTFS file compression

**1.0.16 - August 24, 2005**

*   Code merge with SQLite 3.2.4 with the large delete bugfix in CVS (which will become 3.2.5 soon)
*   Added new GetSchema() types: IndexColumns, ViewColumns, ForeignKeys

**1.0.15 - August 22, 2005**  

*   Code merge with SQLite 3.2.3
*   Minor updates for better design-time experience. More design-time code to follow in subsequent releases.

**1.0.14 - August 16, 2005**  

*   Fixed a bug in the SQLiteDataAdapter due to insufficient implementation of the class.  The RowUpdating and RowUpdated events are now properly implemented, but unfortunately inserting and updating data in a DataTable or DataSet is now much slower.  This is the proper design however, so the changes are here to stay.
*   Lots of schema changes to support Visual Studio's Data Designer architecture.
*   Added Designer support for the provider.  It's not 100%, but you can design queries, add typed datasets and perform quite a number of tasks all within Visual Studio now.

**1.0.13 - August 8, 2005**  

*   Fixed a named parameter bug in the base SQLite\_UTF16 class, which of course only showed up when a database connection was opened using the UseUTF16Encoding=True parameter.
*   Fixed a performance issue in SQLite\_UTF16 involving string marshaling.

**1.0.12 - August 5, 2005**  

*   Full support for the Compact Framework.  Each build (Debug/Release) now has a platform, either Win32 or Compact Framework.  The correct projects are built accordingly.  See the [Distributing SQLite](#redist) section for information on what files need to be distributed for each platform. 
*   Modified SQLite3.Reset() and Step() functions to transparently handle timeouts while waiting on the database to become available (typically when a writer is waiting on a reader to finish, or a reader is waiting on a writer to finish).
*   Lots of code cleanup as suggested by the Code Analyzer (FxCop).
*   Lots of updates to the helpfile (as you can see).
*   Statements were already prepared lazily in a SQLiteCommand, but now its even more lazy.  Statements are now only prepared if the statements haven't been previously prepared and a Prepare() function is called (and the command is associated with a connection) or just prior to the command being executed. 

**1.0.11 - August 1, 2005**  

*   **For everything except the Compact Framework, System.Data.SQLite.dll is now the _only_ DLL required to use this provider!**  The assembly is now a multi-module assembly, containing both the native SQLite3 codebase and the C# classes built on top of it.  The Compact Framework version (when completed) will not be able to support this feature, so backwards compatibility with the Compact Framework has been preserved for the future.
*   Fixed a bug in SQLiteCommand.ExecuteScalar() that caused it to stop executing commands once it obtained the first column of the first row-returning resultset.  Any remaining statements after the row-returning statement was ignored.

**1.0.10 - June 10, 2005**  

*   Fixed a bug in the SQLite3.cs Prepare() function that created a statement even when the SQLite engine returned a NULL pointer. Typically this occurs when multiple statements are processed and there are trailing comments at the end of the statement.
*   Fixed a bug in SQLiteStatement.cs that retrieved parameter names for a parameterized query.  SQLite's parameters are 1-based, and the function was starting at 0.  This was fine when all parameters were unnamed, but for named parameters it caused the parameters to be out of whack.

**1.0.09a - May 25, 2005**  

*   Fixed a broken helpfile and corrected some obsolete help remarks in SQLiteFunction.cs
*   Added a version resource to the SQLite.Interop.dll. 

**1.0.09 - May 24, 2005**  

*   Code merge with the latest 3.21 version of SQLite.
*   Removed obsolete methods and properties for Whidbey Beta 2

**1.0.08 Refresh - Mar 24, 2005  
**

*   Code merge with the latest 3.20 version of SQLite.
*   Recompiled the help file to fix a build error in it.

**1.0.08 - Mar 11, 2005  
**

*   Added additional #if statements to support the old beta 1 edition of VS2005.
*   Code merged the SQLite 3.14 source.

**1.0.07 - Mar 5, 2005**  

*   Made more optimizations to frequently-called functions, resulting in significant performance gains in all tests.
*   Recompiled the binaries using the latest VS2005 February CTP, resulting in yet more significant speed gains.  The 100k insert test used to take 3.5 seconds and the insertwithidentity took almost 8 seconds.  With the above two changes, those tests are now executing in 1.9 and 4.9 seconds respectively.

**1.0.06 - Mar 1, 2005  
**

*   Speed-ups to SQLiteDataReader.  It was interop'ing unnecessarily every time it tried to fetch a field due to a logic error.
*   Changed/Added some code to SQLiteConvert's internal DbType, Type and TypeAffinity functions.
*   Fixed the SQLiteDataReader to obey the flags set in the optional CommandBehavior flag from SQLiteCommand.ExecuteReader().
*   Changed the default page size to 1024 to reflect the defaults of SQLite.  Ignores the "Page Size" connection string option for memory databases, as tests revealed that changing it resulted in memory corruption errors.
*   Performance enhancements to the SQLiteCommand and SQLiteStatement classes which reduced the 100,000 row insert execution time as well as the various Function execution times significantly.

**1.0.05 - Feb 25, 2005**

*   Fixed the SQLite3 C# class step/reset functions to accomodate schema changes that invalidate a prepared statement.  Statements are recompiled transparently.
*   Moved all native DLL declarations to an UnsafeNativeMethods class.
*   Split several classes into their own modules for readability.
*   Renamed many internal variables, reviewed access to variables marked as internal and altered their protection levels accordingly.
*   Due to the presence of the altered sqlite3 codebase and so many added interop functions, I decided to rename the sqlite3 C project and the DLL to SQLite.Interop.dll.  This is the same core sqlite3 codebase but designed specifically for this ADO.NET provider.  This eliminates any possibility of someone dropping another build of sqlite3.dll into the system and rendering the provider inoperable.  In the future if the folks at sqlite.org finally introduce a method of retrieving column usage for an arbitrary prepared statement, I'll retool this library to be a lightweight function call wrapper around the core binary distribution.
*   Added \[SuppressUnmanagedCodeSecurity\] attribute to the UnsafeNativeMethods class which brings VS2005 November CTP execution speeds inline with the December CTP.
*   Added a **bin** directory to the project root where pre-compiled binaries can be found.
*   Added a **doc** directory where preliminary documentation on the class library can be found.
*   Documented a lot more of the classes internally.

**1.0.04 - Feb 24, 2005**

*   Removed the SQLiteContext class and revamped the way UserFunctions work to simplify the imlementation.
*   Fixed a counting bug in the TestCases class, specifically in the function tests where I wasn't resetting the counter and it was consequently reporting intrinsic and raw select calls as being much much faster than they actually were.  The numbers are now much closer to what I expected for performance, with .NET user-functions still being the slowest, but only by a small margin.
*   Small performance tweaks to SQLiteDataReader.
*   Added PageSize to the SQLiteConnectionStringBuilder and subsequently to the SQLiteConnection
*   Added a PRAGMA encoding=XXX execution statement to the SQLiteConnection after opening a connection.

**1.0.03 - Feb 23, 2005**

*   Fixed up SQLiteCommandBuilder to correct implementation errors, which resulted in an enormous performance boost in the InsertMany test.   10,000 row insert that executed in 1500ms now executes in 500ms.
*   Fixed several errors in the SQLite3\_UTF16 class.  ToString() was working incorrectly and the Open() method failed to register user defined functions and collations.
*   Fixed a bug in SQLiteCommand.ClearCommands() whereby only the first statement was being properly cleaned up.
*   Fixed a bug in SQLiteDataReader whereby calling NextResult() would not properly reset the previously-executed command in the sequence.
*   Added an InsertManyWithIdentityFetch test, which appends a select clause to populate the ID of the last inserted row into the InsertCommand, demonstrating ADO.NET's ability to auto-fetch identity columns on insert.

**1.0.02 - Feb 21, 2005**

*   Tweaks to the xxx\_interop functions that return char \*'s, so they also return the length.  Saves an interop call to get the UTF-8 string length during conversion to a .NET string.
*   Reworked the whole interop.c thing into interop.h and reduced the code required to merge the main sqlite3 codebase.
*   Added support for user-defined collations.
