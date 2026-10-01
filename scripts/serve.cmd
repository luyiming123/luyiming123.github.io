@echo off
rem Local preview. Usage: double-click this file, or run scripts\serve.cmd
rem (Bypasses PowerShell execution policy by calling hugo directly.)
setlocal EnableExtensions
cd /d "%~dp0.."

set "HUGO="
for %%I in (hugo.exe) do if not "%%~$PATH:I"=="" set "HUGO=%%~$PATH:I"
if not defined HUGO if exist "%LOCALAPPDATA%\Microsoft\WinGet\Links\hugo.exe" set "HUGO=%LOCALAPPDATA%\Microsoft\WinGet\Links\hugo.exe"
if not defined HUGO if exist "%CD%\tools\hugo.exe" set "HUGO=%CD%\tools\hugo.exe"

if not defined HUGO goto nohugo

echo Using Hugo: %HUGO%
echo Preview URL: http://localhost:1313/    (Ctrl+C to stop)
echo.
"%HUGO%" server --buildDrafts --buildFuture --disableFastRender --navigateToChanged
goto end

:nohugo
echo [ERROR] hugo.exe not found.
echo   Install it with:  winget install Hugo.Hugo.Extended
echo   Or put hugo.exe into: blog\tools\
pause

:end
endlocal
