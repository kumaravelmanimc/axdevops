@echo off
setlocal EnableExtensions
cd /d "%~dp0"
set "GIT_EXE=%UserProfile%\.cache\codex-runtimes\codex-primary-runtime\dependencies\native\git\cmd\git.exe"
if not exist "%GIT_EXE%" set "GIT_EXE=git.exe"
"%GIT_EXE%" rev-parse --is-inside-work-tree >nul 2>nul || (echo This folder is not a Git repository.& pause & exit /b 1)
"%GIT_EXE%" status --short
set /p "CONFIRM=Stage, commit, and push all changes? Type YES: "
if /I not "%CONFIRM%"=="YES" exit /b 0
set /p "MESSAGE=Commit message: "
if "%MESSAGE%"=="" set "MESSAGE=Update Axpert DevOps site"
"%GIT_EXE%" add -A || exit /b 1
"%GIT_EXE%" commit -m "%MESSAGE%" || exit /b 1
"%GIT_EXE%" push || exit /b 1
echo Published successfully.
pause
