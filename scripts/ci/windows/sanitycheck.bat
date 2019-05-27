@echo off

call .\zephyr-env.cmd
echo ZEPHYR_BASE=%ZEPHYR_BASE%
set ZEPHYR_TOOLCHAIN_VARIANT=gnuarmemb
set GNUARMEMB_TOOLCHAIN_PATH=C:\gnuarmemb
cd
cd C:\jenkins\zephyr\scripts

python sanitycheck --build-only --board nrf52_pca10040 --tag bluetooth --ninja --disable-size-report

