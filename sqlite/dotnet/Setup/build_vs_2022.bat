@ECHO OFF

::
:: build_vs_2022.bat --
::
:: Wrapper Tool for MSBuild for Visual Studio 2022
::
:: Written by Joe Mistachkin.
:: Released to the public domain, use at your own risk!
::

SETLOCAL

REM SET __ECHO=ECHO
REM SET __ECHO2=ECHO
REM SET __ECHO3=ECHO
IF NOT DEFINED _AECHO (SET _AECHO=REM)
IF NOT DEFINED _CECHO (SET _CECHO=REM)
IF NOT DEFINED _CECHO2 (SET _CECHO2=REM)
IF NOT DEFINED _CECHO3 (SET _CECHO3=REM)
IF NOT DEFINED _VECHO (SET _VECHO=REM)

SET ROOT=%~dp0\..
SET ROOT=%ROOT:\\=\%

%_VECHO% Root = '%ROOT%'

SET TOOLS=%~dp0
SET TOOLS=%TOOLS:~0,-1%

%_VECHO% Tools = '%TOOLS%'

IF DEFINED CONFIGURATION (
  CALL :fn_UnquoteVariable CONFIGURATION
) ELSE (
  %_AECHO% No configuration specified, using default...
  SET CONFIGURATION=Release
)

%_VECHO% Configuration = '%CONFIGURATION%'

CALL :fn_CopyVariable CONFIGURATION BASE_CONFIGURATION

SET BASE_CONFIGURATION=%BASE_CONFIGURATION:All=%
SET BASE_CONFIGURATION=%BASE_CONFIGURATION:Dll=%
SET BASE_CONFIGURATION=%BASE_CONFIGURATION:ManagedOnly=%
SET BASE_CONFIGURATION=%BASE_CONFIGURATION:NativeOnly=%
SET BASE_CONFIGURATION=%BASE_CONFIGURATION:Static=%

%_VECHO% BaseConfiguration = '%BASE_CONFIGURATION%'

REM
REM NOTE: Possible values for the platform toolset:
REM
REM       Visual Studio 2015: v140
REM       Visual Studio 2017: v141
REM       Visual Studio 2019: v142
REM       Visual Studio 2022: v143
REM
IF NOT DEFINED PLATFORM_TOOLSET (
  SET PLATFORM_TOOLSET=v143
)

%_VECHO% PlatformToolset = '%PLATFORM_TOOLSET%'

REM
REM HACK: Force use of the baseline version of the .NET Framework, which
REM       is currently 4.0.
REM
SET NETFX40ONLY=1

REM
REM HACK: Prevent errors from the NuGet restore process from breaking the
REM       build.
REM
SET NOUSEPACKAGERESTORE=1

%_VECHO% NoUsePackageRestore = '%NOUSEPACKAGERESTORE%'
%_AECHO% WARNING: FORCIBLY DISABLED NUGET PACKAGE RESTORATION.

REM
REM HACK: Forcibly change the platform toolset for the native projects so
REM       it can build with Visual Studio 2022.
REM
%_CECHO% "%ROOT%\Externals\Eagle\bin\netFramework40\EagleShell.exe" -preInitialize "set whatIf false" -file "%TOOLS%\changePlatformToolset.eagle" "%PLATFORM_TOOLSET%"
%__ECHO% "%ROOT%\Externals\Eagle\bin\netFramework40\EagleShell.exe" -preInitialize "set whatIf false" -file "%TOOLS%\changePlatformToolset.eagle" "%PLATFORM_TOOLSET%"

IF ERRORLEVEL 1 (
  ECHO Failed to change platform toolsets.
  GOTO errors
)

%_CECHO% CALL "%TOOLS%\build.bat" "%BASE_CONFIGURATION%ManagedOnly" %*
%__ECHO% CALL "%TOOLS%\build.bat" "%BASE_CONFIGURATION%ManagedOnly" %*

IF ERRORLEVEL 1 (
  ECHO Failed to build managed binaries.
  GOTO errors
)

CALL :fn_UnsetVariable NETFX40ONLY

%_CECHO% CALL "%TOOLS%\build.bat" "%BASE_CONFIGURATION%NativeOnly" Win32 %*
%__ECHO% CALL "%TOOLS%\build.bat" "%BASE_CONFIGURATION%NativeOnly" Win32 %*

IF ERRORLEVEL 1 (
  ECHO Failed to build native binaries for Win32.
  GOTO errors
)

%_CECHO% CALL "%TOOLS%\build.bat" "%BASE_CONFIGURATION%NativeOnly" x64 %*
%__ECHO% CALL "%TOOLS%\build.bat" "%BASE_CONFIGURATION%NativeOnly" x64 %*

IF ERRORLEVEL 1 (
  ECHO Failed to build native binaries for x64.
  GOTO errors
)

GOTO no_errors

:fn_UnquoteVariable
  IF NOT DEFINED %1 GOTO :EOF
  SETLOCAL
  SET __ECHO_CMD=ECHO %%%1%%
  FOR /F "delims=" %%V IN ('%__ECHO_CMD%') DO (
    SET VALUE=%%V
  )
  SET VALUE=%VALUE:"=%
  REM "
  ENDLOCAL && SET %1=%VALUE%
  GOTO :EOF

:fn_CopyVariable
  IF NOT DEFINED %1 GOTO :EOF
  IF "%2" == "" GOTO :EOF
  SETLOCAL
  SET __ECHO_CMD=ECHO %%%1%%
  FOR /F "delims=" %%V IN ('%__ECHO_CMD%') DO (
    SET VALUE=%%V
  )
  ENDLOCAL && SET %2=%VALUE%
  GOTO :EOF

:fn_UnsetVariable
  SETLOCAL
  SET VALUE=%1
  IF DEFINED VALUE (
    SET VALUE=
    ENDLOCAL
    SET %VALUE%=
  ) ELSE (
    ENDLOCAL
  )
  CALL :fn_ResetErrorLevel
  GOTO :EOF

:fn_ResetErrorLevel
  VERIFY > NUL
  GOTO :EOF

:fn_SetErrorLevel
  VERIFY MAYBE 2> NUL
  GOTO :EOF

:usage
  ECHO.
  ECHO Usage: %~nx0 [...]
  ECHO.
  GOTO errors

:errors
  CALL :fn_SetErrorLevel
  ENDLOCAL
  ECHO.
  ECHO Build failure, errors were encountered.
  GOTO end_of_file

:no_errors
  CALL :fn_ResetErrorLevel
  ENDLOCAL
  ECHO.
  ECHO Build success, no errors were encountered.
  GOTO end_of_file

:end_of_file
%__ECHO% EXIT /B %ERRORLEVEL%
