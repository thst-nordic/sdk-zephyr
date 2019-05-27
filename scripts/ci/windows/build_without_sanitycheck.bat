@echo off

call .\zephyr-env.cmd
echo ZEPHYR_BASE=%ZEPHYR_BASE%
set ZEPHYR_TOOLCHAIN_VARIANT=gnuarmemb
set GNUARMEMB_TOOLCHAIN_PATH=C:\gnuarmemb

rem Cleanup root build folder
rmdir /Q /S %ZEPHYR_BASE%\build > nul 2> nul
mkdir %ZEPHYR_BASE%\build

rem Samples to Compile

CALL :compile  samples\hello_world
CALL :compile  samples\basic\threads
CALL :compile  samples\bluetooth\beacon

EXIT /B 0 


:compile
cd %ZEPHYR_BASE%\%~1
rem Cleanup Build Folder if it exists
rmdir /Q /S build > nul 2> nul
mkdir build & cd build 
cmake -GNinja -DBOARD=nrf52_pca10040 ..
ninja
set RTN=%ERRORLEVEL% 
cd %ZEPHYR_BASE%
mkdir build\%~1
robocopy /e %ZEPHYR_BASE%\%~1\build %ZEPHYR_BASE%\build\%~1 /NFL /NDL /NJH /NJS /nc /ns /np
if %RTN% neq 0 exit /b %RTN%
EXIT /B %RTN% 
