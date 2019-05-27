@echo off

cd C:\jenkins

west init -l zephyr/
west  update

echo ZEPHYR_BASE=%ZEPHYR_BASE%
set ZEPHYR_TOOLCHAIN_VARIANT=gnuarmemb
set GNUARMEMB_TOOLCHAIN_PATH=C:\gnuarmemb

cd C:\jenkins\zephyr
call .\zephyr-env.cmd

python scripts\sanitycheck --build-only --platform nrf52_pca10040 --tag bluetooth --ninja --disable-size-report

echo ERROR_LEVEL = %ERROR_LEVEL%
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
