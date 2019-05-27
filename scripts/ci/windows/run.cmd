@echo off

cd C:\jenkins

cd

rem Initialize west
west init -l zephyr/

echo west init complete

rem Checkout
west  update

echo west update complete

echo ZEPHYR_BASE=%ZEPHYR_BASE%
set ZEPHYR_TOOLCHAIN_VARIANT=gnuarmemb
set GNUARMEMB_TOOLCHAIN_PATH=C:\gnuarmemb
cd

cd C:\jenkins\zephyr

call .\zephyr-env.cmd

cd C:\jenkins\zephyr\scripts

python sanitycheck --build-only --platform nrf52_pca10040 --tag bluetooth --ninja --disable-size-report

echo ERROR_LEVEL = %ERROR_LEVEL%
if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
