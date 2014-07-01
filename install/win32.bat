@echo off
rem LaTeX package install script
rem Author: Xu Cheng

cd /d "%~dp0"
cd ..

if not defined TEXMFLOCAL (
    for /f "delims=" %%I in ('kpsewhich --var-value=TEXMFLOCAL') do @set TEXMFLOCAL=%%I
)

if /i "%1" == "install"      goto :install
if /i "%1" == "uninstall"    goto :uninstall
goto :help

:install
echo. Install hustproposal.cls template into local.
mkdir "%TEXMFLOCAL%\tex\latex\hustproposal\"
xcopy /q /y .\hustproposal\hustproposal.cls "%TEXMFLOCAL%\tex\latex\hustproposal\" > nul
mkdir "%TEXMFLOCAL%\doc\latex\hustproposal\"
xcopy /q /y .\hustproposal\hustproposal.pdf "%TEXMFLOCAL%\doc\latex\hustproposal\" > nul
mkdir "%TEXMFLOCAL%\doc\latex\hustproposal\example\"
xcopy /q /y .\hustproposal\hustproposal-zh-example.pdf "%TEXMFLOCAL%\doc\latex\hustproposal\example\" > nul
xcopy /q /y .\hustproposal\hustproposal-zh-example.tex "%TEXMFLOCAL%\doc\latex\hustproposal\example\" > nul
xcopy /q /y .\hustproposal\hustproposal-en-example.pdf "%TEXMFLOCAL%\doc\latex\hustproposal\example\" > nul
xcopy /q /y .\hustproposal\hustproposal-en-example.tex "%TEXMFLOCAL%\doc\latex\hustproposal\example\" > nul
xcopy /q /y .\hustproposal\ref-example.bib "%TEXMFLOCAL%\doc\latex\hustproposal\example\" > nul
goto :hash

:uninstall
echo. Uninstall hustproposal.cls template.
rd /q /s "%TEXMFLOCAL%\tex\latex\hustproposal\"
rd /q /s "%TEXMFLOCAL%\doc\latex\hustproposal\"
goto :hash

:hash
echo. Refresh TeX hash database.
texhash
goto :exit

:help
echo Usage:
echo. %~nx0 install          - install hustproposal.cls template into local.
echo. %~nx0 uninstall        - uninstall hustproposal.cls template.
echo.
goto :exit

:exit