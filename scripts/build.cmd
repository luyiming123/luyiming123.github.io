@echo off
rem Build the site into public\. Usage: double-click this file, or run scripts\build.cmd
rem (Bypasses PowerShell execution policy by calling hugo directly.)
setlocal EnableExtensions
cd /d "%~dp0.."

set "HUGO="
for %%I in (hugo.exe) do if not "%%~$PATH:I"=="" set "HUGO=%%~$PATH:I"
if not defined HUGO if exist "%LOCALAPPDATA%\Microsoft\WinGet\Links\hugo.exe" set "HUGO=%LOCALAPPDATA%\Microsoft\WinGet\Links\hugo.exe"
if not defined HUGO if exist "%CD%\tools\hugo.exe" set "HUGO=%CD%\tools\hugo.exe"

if not defined HUGO goto nohugo

echo Using Hugo: %HUGO%
"%HUGO%" --gc --minify
if errorlevel 1 goto failed
echo.
echo [OK] Build finished. Output: public\
goto done

:nohugo
echo [ERROR] hugo.exe not found.
echo   Install it with:  winget install Hugo.Hugo.Extended
echo   Or put hugo.exe into: blog\tools\
goto done

:failed
echo.
echo [FAILED] Build error, see the log above.

:done
pause
endlocal
