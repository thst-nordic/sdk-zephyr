@echo off

cd C:\jenkins

west init -l zephyr/
west update

cd C:\jenkins\zephyr

python scripts\sanitycheck --build-only -p nrf9160_pca10090 -p nrf52_pca10040 -p nrf52840_pca10056 --tag bluetooth --tag introduction --ninja --disable-size-report

if %ERRORLEVEL% neq 0 exit /b %ERRORLEVEL%
