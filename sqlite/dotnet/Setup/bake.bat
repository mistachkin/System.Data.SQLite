@ECHO OFF

::
:: bake.bat --
::
:: Setup Preparation & Baking Tool
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

IF NOT DEFINED FRAMEWORK (
  IF DEFINED YEAR (
    CALL :fn_SetVariable FRAMEWORK FRAMEWORK%YEAR%
  ) ELSE (
    SET FRAMEWORK=netFx20
  )
)

%_VECHO% Framework = '%FRAMEWORK%'

IF "%PROCESSOR_ARCHITECTURE%" == "x86" GOTO set_path_x86

SET INNOSETUPPATH=%ProgramFiles(x86)%\Inno Setup 5
GOTO set_path_done

:set_path_x86

SET INNOSETUPPATH=%ProgramFiles%\Inno Setup 5

:set_path_done

CALL :fn_PrependToPath INNOSETUPPATH

%_VECHO% InnoSetupPath = '%INNOSETUPPATH%'
%_VECHO% Path = '%PATH%'

%__ECHO% ISCC.exe "%TOOLS%\data\SQLite.iss" "/dAppId=%APPID%" "/dAppPublicKey=%PUBLICKEY%" "/dAppURL=%URL%" "/dIsNetFx2=%ISNETFX2%" "/dVcRuntime=%VCRUNTIME%" "/dAppConfiguration=%CONFIGURATION%" "/dAppPlatform=%PLATFORM%" "/dAppProcessor=%PROCESSOR%" "/dFramework=%FRAMEWORK%" "/dYear=%YEAR%"

IF %ERRORLEVEL% NEQ 0 (
  ECHO Failed to compile setup.
  GOTO errors
)

GOTO no_errors

:fn_SetVariable
  SETLOCAL
  SET __ECHO_CMD=ECHO %%%2%%
  FOR /F "delims=" %%V IN ('%__ECHO_CMD%') DO (
    SET VALUE=%%V
  )
  ENDLOCAL && (
    SET %1=%VALUE%
  )
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

:usage
  ECHO.
  ECHO Usage: %~nx0
  ECHO.
  GOTO errors

:errors
  CALL :fn_SetErrorLevel
  ENDLOCAL
  ECHO.
  ECHO Bake failure, errors were encountered.
  GOTO end_of_file

:no_errors
  CALL :fn_ResetErrorLevel
  ENDLOCAL
  ECHO.
  ECHO Bake success, no errors were encountered.
  GOTO end_of_file

:end_of_file
%__ECHO% EXIT /B %ERRORLEVEL%
