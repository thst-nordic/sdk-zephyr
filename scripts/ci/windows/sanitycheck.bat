@echo off

echo ZEPHYR_BASE=%ZEPHYR_BASE%
set ZEPHYR_TOOLCHAIN_VARIANT=gnuarmemb
set GNUARMEMB_TOOLCHAIN_PATH=C:\gnuarmemb
cd

cd C:\jenkins\zephyr

call .\zephyr-env.cmd

cd C:\jenkins\zephyr\scripts

choco install make

python sanitycheck --build-only --board nrf52_pca10040 --tag bluetooth --ninja --disable-size-report

