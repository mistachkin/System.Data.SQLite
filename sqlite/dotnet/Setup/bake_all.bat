@ECHO OFF

::
:: bake_all.bat --
::
:: Multi-Setup Preparation & Baking Tool
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

%_AECHO% Running %0 %*

SET DUMMY2=%1

IF DEFINED DUMMY2 (
  GOTO usage
)

SET TOOLS=%~dp0
SET TOOLS=%TOOLS:~0,-1%

%_VECHO% Tools = '%TOOLS%'

CALL :fn_ResetErrorLevel

%_CECHO3% CALL "%TOOLS%\vsSp.bat"
%__ECHO3% CALL "%TOOLS%\vsSp.bat"

IF ERRORLEVEL 1 (
  ECHO Could not detect Visual Studio.
  GOTO errors
)

REM
REM NOTE: There are no setup packages for .NET Standard 2.0 and
REM       .NET Standard 2.1.
REM
SET NONETSTANDARD20=1
SET NONETSTANDARD21=1

%_CECHO3% CALL "%TOOLS%\set_common.bat"
%__ECHO3% CALL "%TOOLS%\set_common.bat"

IF ERRORLEVEL 1 (
  ECHO Could not set common variables.
  GOTO errors
)

IF NOT DEFINED BAKE_CONFIGURATIONS (
  SET BAKE_CONFIGURATIONS=Release
)

%_VECHO% BakeConfigurations = '%BAKE_CONFIGURATIONS%'

IF NOT DEFINED PROCESSORS (
  SET PROCESSORS=x86
)

%_VECHO% Processors = '%PROCESSORS%'

IF NOT DEFINED YEARS (
  SET YEARS=2008
)

%_VECHO% Years = '%YEARS%'

FOR %%C IN (%BAKE_CONFIGURATIONS%) DO (
  FOR %%P IN (%PROCESSORS%) DO (
    FOR %%Y IN (%YEARS%) DO (
      %_CECHO3% CALL "%TOOLS%\set_%%C_%%P_%%Y.bat"
      %__ECHO3% CALL "%TOOLS%\set_%%C_%%P_%%Y.bat"

      IF ERRORLEVEL 1 (
        ECHO Could not set variables for %%C/%%P/%%Y.
        GOTO errors
      )

      %_CECHO3% CALL "%TOOLS%\bake.bat"
      %__ECHO3% CALL "%TOOLS%\bake.bat"

      IF ERRORLEVEL 1 (
        ECHO Could not bake setup for %%C/%%P/%%Y.
        GOTO errors
      )
    )
  )
)

GOTO no_errors

:fn_ResetErrorLevel
  VERIFY > NUL
  GOTO :EOF

:fn_SetErrorLevel
  VERIFY MAYBE 2> NUL
  GOTO :EOF

:usage
  ECHO.
  ECHO Usage: %~nx0
  ECHO.
  GOTO errors

:errors
  CALL :fn_SetErrorLevel
  ENDLOCAL
  ECHO.
  ECHO Failure, errors were encountered.
  GOTO end_of_file

:no_errors
  CALL :fn_ResetErrorLevel
  ENDLOCAL
  ECHO.
  ECHO Success, no errors were encountered.
  GOTO end_of_file

:end_of_file
%__ECHO% EXIT /B %ERRORLEVEL%
