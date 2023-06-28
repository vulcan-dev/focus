@echo off

if exist focus.exe goto check
goto compile

:check
for /F "tokens=*" %%# in ('del /Q "focus.exe" 2^>^&1 1^> nul') do (2> nul set =)
if errorlevel 1 goto locked

:compile
echo Compiling...
jai first.jai - release
goto:eof

:locked
echo Close Focus first!
