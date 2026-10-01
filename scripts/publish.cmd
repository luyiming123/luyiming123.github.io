@echo off
rem One-click publish: commit all changes and push to GitHub.
rem GitHub Actions will rebuild the site in about a minute.
setlocal EnableExtensions EnableDelayedExpansion
cd /d "%~dp0.."

where git >nul 2>nul
if errorlevel 1 goto nogit

git rev-parse --is-inside-work-tree >nul 2>nul
if errorlevel 1 goto norepo

echo Checking for changes...
set "CHANGES="
for /f "delims=" %%A in ('git status --porcelain') do set "CHANGES=1"
if not defined CHANGES goto nochanges

echo.
echo Files to publish:
git status --short
echo.

for /f "tokens=1-4 delims=/: " %%a in ("%DATE%") do set "D=%%a-%%b-%%c"
set "MSG=post: update %D% %TIME:~0,5%"

git add -A
git -c core.pager=cat commit -q -m "%MSG%"
if errorlevel 1 goto commitfail

echo Pushing to GitHub...
git push origin main
if errorlevel 1 goto pushfail

echo.
echo [OK] Pushed. The site will update in about 1 minute:
echo      https://luyiming123.github.io/
goto done

:nochanges
echo [SKIP] Nothing to publish - no file changes.
goto done

:nogit
echo [ERROR] git not found. Install Git for Windows first.
goto done

:norepo
echo [ERROR] This folder is not a git repository: %CD%
goto done

:commitfail
echo [ERROR] Commit failed. See the message above.
goto done

:pushfail
echo [ERROR] Push failed. Usually a network issue to GitHub.
echo   - Check your network / proxy, then run this script again.
echo   - Or try: git push origin main
goto done

:done
echo.
pause
endlocal
