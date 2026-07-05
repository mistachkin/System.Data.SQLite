/*
 * AssemblyInfo.cpp -
 *
 * Written by Joe Mistachkin.
 * Released to the public domain, use at your own risk!
 */

using namespace System::Reflection;
using namespace System::Resources;
using namespace System::Runtime::InteropServices;

#include "../generic/interop.h"

[assembly:AssemblyTitleAttribute("SQLite.Interop")];
[assembly:AssemblyCompanyAttribute("https://www.mistachkin.com/")];
[assembly:AssemblyDescriptionAttribute("System.Data.SQLite Interop Assembly")];
[assembly:AssemblyProductAttribute("System.Data.SQLite")];
[assembly:AssemblyCopyrightAttribute("Copyright © 2007-2012 by Joe Mistachkin.  All rights reserved.")];
[assembly:AssemblyVersionAttribute(INTEROP_VERSION)];
[assembly:AssemblyFileVersionAttribute(INTEROP_VERSION)];

#if DEBUG
[assembly:AssemblyConfiguration("Debug")];
#else
[assembly:AssemblyConfiguration("Release")];
#endif

[assembly:NeutralResourcesLanguage("en-US")];
[assembly:ComVisible(false)];
