@ECHO OFF

::
:: test_ce_200x.bat --
::
:: WinCE Testing Tool
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

CALL :fn_UnsetVariable BREAK

%_AECHO% Running %0 %*

SET DUMMY2=%1

IF DEFINED DUMMY2 (
  GOTO usage
)

SET ROOT=%~dp0\..
SET ROOT=%ROOT:\\=\%

%_VECHO% Root = '%ROOT%'

SET TOOLS=%~dp0
SET TOOLS=%TOOLS:~0,-1%

%_VECHO% Tools = '%TOOLS%'

SET EAGLEBINDIR=%ROOT%\Externals\Eagle\bin\netFramework40

CALL :fn_PrependToPath EAGLEBINDIR

%_VECHO% EagleBinDir = '%EAGLEBINDIR%'
%_VECHO% Path = '%PATH%'

%_CECHO3% CALL "%TOOLS%\vsSp.bat"
%__ECHO3% CALL "%TOOLS%\vsSp.bat"

IF ERRORLEVEL 1 (
  ECHO Could not detect Visual Studio.
  GOTO errors
)

%_CECHO3% CALL "%TOOLS%\set_common.bat"
%__ECHO3% CALL "%TOOLS%\set_common.bat"

IF ERRORLEVEL 1 (
  ECHO Could not set common variables.
  GOTO errors
)

IF NOT DEFINED TEST_CONFIGURATIONS (
  SET TEST_CONFIGURATIONS=Release
)

%_VECHO% TestConfigurations = '%TEST_CONFIGURATIONS%'

REM
REM NOTE: Reset the PLATFORMS variable to reflect the devices supported by the
REM       projects being tested.
REM
SET PLATFORMS="Pocket PC 2003 (ARMV4)"

%_VECHO% Platforms = '%PLATFORMS%'

REM
REM NOTE: The .NET Compact Framework is only supported by Visual Studio 2005
REM       and 2008, regardless of which versions of Visual Studio are installed
REM       on this machine; therefore, override the YEARS variable limiting it
REM       to 2005 and 2008 only.
REM
CALL :fn_UnsetVariable YEARS

IF NOT DEFINED NOVS2005 (
  IF DEFINED VS2005SP (
    CALL :fn_AppendVariable YEARS " 2005"
  )
)

IF NOT DEFINED NOVS2008 (
  IF DEFINED VS2008SP (
    CALL :fn_AppendVariable YEARS " 2008"
  )
)

%_VECHO% Years = '%YEARS%'

IF NOT DEFINED 32BITONLY (
  SET EAGLESHELL=EagleShell.exe
) ELSE (
  SET EAGLESHELL=EagleShell32.exe
)

%_VECHO% EagleShell = '%EAGLESHELL%'

FOR %%C IN (%TEST_CONFIGURATIONS%) DO (
  FOR %%P IN (%PLATFORMS%) DO (
    FOR %%Y IN (%YEARS%) DO (
      %_CECHO% "%EAGLESHELL%" -file "%TOOLS%\deployAndTestCe200x.eagle" %%Y %%P %%C
      %__ECHO% "%EAGLESHELL%" -file "%TOOLS%\deployAndTestCe200x.eagle" %%Y %%P %%C

      CALL :fn_FixErrorLevel

      IF ERRORLEVEL 1 (
        ECHO Tests failed for %%C/%%P/%%Y binaries.
        GOTO errors
      )
    )
  )
)

GOTO no_errors

:fn_AppendVariable
  SET __ECHO_CMD=ECHO %%%1%%
  IF DEFINED %1 (
    FOR /F "delims=" %%V IN ('%__ECHO_CMD%') DO (
      SET %1=%%V%~2
    )
  ) ELSE (
    SET %1=%~2
  )
  SET __ECHO_CMD=
  CALL :fn_ResetErrorLevel
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

:fn_PrependToPath
  IF NOT DEFINED %1 GOTO :EOF
  SETLOCAL
  SET __ECHO_CMD=ECHO %%%1%%
  FOR /F "delims=" %%V IN ('%__ECHO_CMD%') DO (
    SET VALUE=%%V
  )
  SET VALUE=%VALUE:"=%
  REM "
  ENDLOCAL && SET PATH=%VALUE%;%PATH%
  GOTO :EOF

:fn_ResetErrorLevel
  VERIFY > NUL
  GOTO :EOF

:fn_SetErrorLevel
  VERIFY MAYBE 2> NUL
  GOTO :EOF

:fn_FixErrorLevel
  IF %ERRORLEVEL% NEQ 0 (
    CALL :fn_SetErrorLevel
    GOTO :EOF
  )
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
  ECHO Test failure, errors were encountered.
  GOTO end_of_file

:no_errors
  CALL :fn_ResetErrorLevel
  ENDLOCAL
  ECHO.
  ECHO Test success, no errors were encountered.
  GOTO end_of_file

:end_of_file
%__ECHO% EXIT /B %ERRORLEVEL%
