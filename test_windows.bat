@echo off
setlocal

set "ROOT_DIR=%~dp0"
set "OUTPUT_DIR=%ROOT_DIR%.build\smoke-test-windows"
if not defined JAI set "JAI=jai"

if not exist "%ROOT_DIR%bin\windows\box3d.lib" (
    echo Missing %ROOT_DIR%bin\windows\box3d.lib. Run build_windows.bat first.
    exit /b 1
)

if not exist "%ROOT_DIR%bin\windows\box3d.dll" (
    echo Missing %ROOT_DIR%bin\windows\box3d.dll. Run build_windows.bat first.
    exit /b 1
)

if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"
if errorlevel 1 exit /b 1

copy /Y "%ROOT_DIR%bin\windows\box3d.dll" "%OUTPUT_DIR%\box3d.dll" >nul
if errorlevel 1 exit /b 1

pushd "%ROOT_DIR%"
if errorlevel 1 exit /b 1

"%JAI%" smoke_test.jai -output_path "%OUTPUT_DIR%"
set "JAI_RESULT=%ERRORLEVEL%"
popd
if not "%JAI_RESULT%"=="0" exit /b %JAI_RESULT%

"%OUTPUT_DIR%\smoke_test.exe"
exit /b %ERRORLEVEL%
