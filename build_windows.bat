@echo off
setlocal

set "ROOT_DIR=%~dp0"
set "BUILD_DIR=%ROOT_DIR%.build\windows-x64"
set "OUTPUT_DIR=%ROOT_DIR%bin\windows"

cmake ^
    -S "%ROOT_DIR%..\box3d" ^
    -B "%BUILD_DIR%" ^
    -A x64 ^
    -DCMAKE_CONFIGURATION_TYPES=Release ^
    -DBUILD_SHARED_LIBS=ON ^
    -DBOX3D_SAMPLES=OFF ^
    -DBOX3D_UNIT_TESTS=OFF ^
    -DBOX3D_BENCHMARKS=OFF ^
    -DBOX3D_DOCS=OFF ^
    -DBOX3D_BUILD_SHADERS=OFF ^
    -DBOX3D_PROFILE=OFF ^
    -DBOX3D_VALIDATE=OFF ^
    -DBOX3D_SANITIZE=OFF ^
    -DBOX3D_DOUBLE_PRECISION=OFF
if errorlevel 1 exit /b 1

cmake --build "%BUILD_DIR%" --config Release --target box3d --parallel
if errorlevel 1 exit /b 1

if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"
if errorlevel 1 exit /b 1

copy /Y "%BUILD_DIR%\src\Release\box3d.lib" "%OUTPUT_DIR%\box3d.lib" >nul
if errorlevel 1 exit /b 1

copy /Y "%BUILD_DIR%\bin\Release\box3d.dll" "%OUTPUT_DIR%\box3d.dll" >nul
if errorlevel 1 exit /b 1

echo Staged %OUTPUT_DIR%\box3d.lib
echo Staged %OUTPUT_DIR%\box3d.dll
